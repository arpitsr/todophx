defmodule TodophxWeb.TodayLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  alias TodophxWeb.NavbarComponent
  alias TodophxWeb.SidenavComponent
  use Phoenix.HTML
  alias Todophx.Work

  @impl true
  def mount(_params, %{}, socket) do
    {:ok,
     socket
     |> assign(:uri_path, "")
     |> assign(:projects, Work.list_projects())
     |> assign(:tasks, []), temporary_assigns: [tasks: []]}
  end

  @impl true
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

  def handle_event(
        "delete-task",
        %{"task_id" => task_id},
        socket
      ) do
    task = Todophx.Work.get_task!(task_id)
    Work.delete_task(task)
    {:noreply, socket}
  end

  @impl true
  def handle_params(_unsigned_params, uri, socket) do
    tasks =
      case URI.parse(uri).path do
        "/upcoming" -> Work.upcoming_tasks()
        _ -> Work.today_tasks()
      end

    {:noreply,
     socket
     |> assign(:projects, Work.list_projects())
     |> assign(:tasks, tasks)
     |> assign(:uri_path, URI.parse(uri).path)}
  end
end
