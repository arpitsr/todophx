defmodule TodophxWeb.TodayLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  alias TodophxWeb.NavbarComponent
  alias TodophxWeb.SidenavComponent
  use Phoenix.HTML
  alias Todophx.Work

  def mount(_params, %{}, socket) do
    tasks = Work.all_tasks()

    {:ok,
     socket
     |> assign(:projects, Work.list_projects())
     |> assign(:tasks, tasks), temporary_assigns: [tasks: []]}
  end

  def handle_event(
        "create-new-project",
        %{"project" => project_params},
        socket
      ) do
    {:ok, project} = Work.create_project(project_params)

    {:noreply,
     push_redirect(update(socket, :projects, fn projects -> [project | projects] end),
       to: TodophxWeb.Router.Helpers.live_path(socket, TodophxWeb.ProjectLive, project.id)
     )}
  end

  def handle_event("update-task-state", %{"task" => task_params}, socket) do
    %{"id" => task_id} = task_params
    task = Work.get_task!(task_id)
    {:ok, task} = Work.update_task(task, task_params)
    {:noreply, update(socket, :tasks, fn tasks -> [task | tasks] end)}
  end

  def handle_event("delete-project", %{"project_id" => project_id}, socket) do
    Work.delete_project(Work.get_project!(project_id))

    {:noreply, push_redirect(socket, to: TodophxWeb.Router.Helpers.today_path(socket, :index))}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <NavbarComponent.render />
    <div class="flex">
      <div class="w-1/4 bg-gray-50">
        <SidenavComponent.render projects={@projects}/>
      </div>
      <div class="w-3/4">
        <div class="w-4/5 py-8 mx-auto">
          <div class="mb-8 text-xl font-bold">Today</div>
          <div id="tasks" phx-update="append">
            <TodophxWeb.TaskListComponent.show tasks={@tasks} />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
