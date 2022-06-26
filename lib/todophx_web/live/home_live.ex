defmodule TodophxWeb.HomeLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  alias TodophxWeb.NavbarComponent
  alias TodophxWeb.SidenavComponent

  alias Todophx.Work

  def render(assigns) do
    ~H"""
    <NavbarComponent.render />
    <div class="w-1/4 bg-gray-50">
      <SidenavComponent.render show_modal={@show_modal} projects={@projects}/>
    </div>
    """
  end

  def mount(_params, %{}, socket) do
    {:ok, socket |> assign(:show_modal, false) |> assign(:projects, Work.list_projects())}
  end

  def handle_event("delete-project", %{"project_id" => project_id}, socket) do
    Work.delete_project(Work.get_project!(project_id))
    {:reply, %{hello: "world"}, socket}
  end

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

  def handle_event(
        "create-new-project",
        %{"project" => project_params},
        socket
      ) do
    {:ok, project} = Work.create_project(project_params)
    socket = socket |> assign(:show_modal, false)
    # socket = update(socket, :projects, fn projects -> [project | projects] end)
    {:noreply, update(socket, :projects, fn projects -> [project | projects] end)}
  end
end
