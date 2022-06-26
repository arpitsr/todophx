defmodule TodophxWeb.SidenavComponent do
  use Phoenix.Component

  def get_href_project_path(project) do
    "/projects/#{project.id}"
  end

  def render(assigns) do
    ~H"""
    <div class="h-screen p-8">
      <section class="flex flex-col gap-3">
        <div class="flex gap-4">
          <i class="ri-calendar-2-line"></i>
          <div>Today</div>
        </div>
        <div class="flex gap-4">
          <i class="ri-notification-badge-line"></i>
          <div>Upcoming</div>
        </div>
      </section>
      <section class="flex flex-col gap-3 mt-16">
        <div class="text-xl font-bold flex gap-2 justify-between">
          <div>Projects</div>
          <a href="#" phx-click="new_project">+</a>
        </div>

        <div id="projects" phx-update="append">
          <%= for project <- @projects do %>
            <div id={"project-" <> to_string(project.id)} class="flex justify-between">
            <a href={get_href_project_path(project)}>
              <div class="flex gap-4">
                <i class="text-sm text-gray-500 pt-0.5 ri-checkbox-blank-circle-fill hover:cursor-pointer"></i>
                <div class="flex justify-between w-full">
                  <div><%= project.name %></div>
                </div>
              </div>
            </a>
            <div phx-hook="ProjectAction" id={"project-delete-" <> to_string(project.id)} data-project_id={project.id}>
              <i class="transition ease-in-out text-gray-300 hover:text-red-600 ri-delete-bin-3-line  hover:cursor-pointer"></i>
            </div>
            </div>
          <% end %>
        </div>
      </section>
      <%= if @show_modal do %>
        <TodophxWeb.ProjectModal.render id="new_project" />
      <% end %>
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

  # def handle_info(
  #       {TodophxWeb.LiveComponent.ModalLive, :button_clicked, %{action: "wonder"}},
  #       socket
  #     ) do
  #   IO.inspect("called button clicked")
  #   {:noreply, socket}
  # end

  # def handle_event("new_project", _, socket) do
  #   {:noreply, socket |> assign(:show_modal, true)}
  # end
end
