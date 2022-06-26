defmodule TodophxWeb.ProjectLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  alias TodophxWeb.NavbarComponent
  alias TodophxWeb.SidenavComponent
  use Phoenix.HTML
  alias Todophx.Work

  def mount(%{"id" => project_id}, %{}, socket) do
    IO.inspect(project_id)
    project = Todophx.Work.get_project!(project_id)
    tasks = Todophx.Work.list_tasks(project_id)
    projects = Todophx.Work.list_projects()

    {:ok,
     socket
     |> assign(:project_id, project_id)
     |> assign(:show_modal, false)
     |> assign(:tasks, tasks)
     |> assign(:project, project)
     |> assign(:projects, projects), temporary_assigns: [tasks: []]}
  end

  def handle_event(
        "new-task",
        %{"task" => task_params},
        socket
      ) do
    {:ok, task} = Todophx.Work.create_task(task_params)
    {:noreply, update(socket, :tasks, fn tasks -> [task | tasks] end)}
  end

  def handle_event(
        "delete-task",
        %{"task_id" => task_id},
        socket
      ) do
    task = Todophx.Work.get_task!(task_id)
    Work.delete_task(task)
    {:noreply, socket}
  end

  def handle_event(
        "new_project",
        _params,
        socket
      ) do
    {:noreply, socket |> assign(:show_modal, true)}
  end

  def handle_event("delete-project", %{"project_id" => project_id}, socket) do
    Work.delete_project(Work.get_project!(project_id))
    # {:reply, %{hello: "world"}, socket}

    {:noreply, push_redirect(socket, to: TodophxWeb.Router.Helpers.home_path(socket, :index))}
  end

  def handle_event(
        "cancel-modal",
        _params,
        socket
      ) do
    {:noreply, assign(socket, :show_modal, false)}
  end

  def handle_event("update-task-state", %{"task" => task_params}, socket) do
    %{"id" => task_id} = task_params
    task = Work.get_task!(task_id)
    {:ok, task} = Work.update_task(task, task_params)
    {:noreply, update(socket, :tasks, fn tasks -> [task | tasks] end)}
  end

  def handle_event(
        "create-new-project",
        %{"project" => project_params},
        socket
      ) do
    {:ok, project} = Work.create_project(project_params)
    socket = socket |> assign(:show_modal, false)

    {:noreply,
     push_patch(update(socket, :projects, fn projects -> [project | projects] end),
       to: TodophxWeb.Router.Helpers.live_path(socket, __MODULE__, project.id)
     )}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def get_strike_css(state) do
    if state == true do
      "line-through"
    else
      ""
    end
  end

  def render(assigns) do
    ~H"""
    <NavbarComponent.render />
    <div class="flex">
      <div class="w-1/4 bg-gray-50">
        <SidenavComponent.render show_modal={@show_modal} projects={@projects}/>
      </div>
      <div class="w-3/4">
        <div class="w-4/5 mx-auto py-8">
          <div class="text-xl font-bold mb-8"><%= @project.name %></div>
            <div id="tasks" phx-update="append">
              <%= for task <- @tasks do %>
                <div x-data="" class="flex mb-2" id={"task-"<>to_string(task.id)}>
                  <.form let={f} for={Work.change_task(task)} phx-change="update-task-state" class="flex justify-between w-full">
                    <label class="w-4/5 flex gap-2 items-center">
                      <%= hidden_input f, :id ,id: "hidden-input" <> to_string(task.id), value: task.id %>
                      <%= checkbox f, :done, class: "w-4 h-4 rounded", id: "task-checkbox-" <> to_string(task.id) %>
                      <div class={get_strike_css(task.done) <> "w-4/5"}><%= task.name %></div>
                      <div class={get_strike_css(task.done)}>
                        <% {:ok, formatted_time} = Timex.format(task.due_date, "{Mshort} {D} {YYYY}") %>
                        <div class="text-gray-400 text-right text-sm">Due: <%= formatted_time %></div>
                      </div>
                    </label>
                    <!-- Delete task -->
                    <div phx-hook="TaskAction" id={"task-delete-" <> to_string(task.id)} data-task_id={task.id}>
                    <i class="transition ease-in-out text-gray-300  hover:text-red-600 ri-delete-bin-3-line"></i>
                    </div>
                  </.form>
                </div>
              <% end %>
            </div>
            <div>
              <.form let={f} for={Todophx.Work.change_task(%Todophx.Work.Task{})} phx-submit="new-task" class="flex mt-8">
                <%= hidden_input f, :project_id, value: @project_id %>
                <span class="text-p1">+ </span>
                <%= text_input f, :name, placeholder: " Add task", class: "border border-none p-0 focus:ring-transparent placeholder-p1 opacity-70 pl-2 focus:placeholder-transparent w-full" %>
              </.form>
            </div>
          </div>
      </div>
    </div>
    """
  end
end
