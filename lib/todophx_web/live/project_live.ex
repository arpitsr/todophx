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

  def handle_event("update-task-state", %{"task" => task_params}, socket) do
    %{"id" => task_id} = task_params
    task = Work.get_task!(task_id)
    {:ok, task} = Work.update_task(task, task_params)
    {:noreply, update(socket, :tasks, fn tasks -> [task | tasks] end)}
  end

  # Project Modal
  def handle_event(
        "new_project",
        _params,
        socket
      ) do
    {:noreply, socket |> assign(:show_modal, true)}
  end

  def handle_event(
        "cancel-modal",
        _params,
        socket
      ) do
    {:noreply, assign(socket, :show_modal, false)}
  end

  # Project CUD
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

  def handle_event("delete-project", %{"project_id" => project_id}, socket) do
    Work.delete_project(Work.get_project!(project_id))
    # {:reply, %{hello: "world"}, socket}

    {:noreply, push_redirect(socket, to: TodophxWeb.Router.Helpers.today_path(socket, :index))}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end
end
