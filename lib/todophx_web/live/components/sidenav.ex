defmodule TodophxWeb.SidenavComponent do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def render(assigns) do
    ~H"""
    <div class="h-screen px-8 py-10">
      <section class="flex flex-col gap-3">
        <div class="flex gap-4">
          <i class="ri-calendar-2-line"></i>
          <a href="/today">Today</a>
        </div>
        <div class="flex gap-4">
          <i class="ri-notification-badge-line"></i>
          <a href="/upcoming">Upcoming</a>
        </div>
      </section>
      <section class="flex flex-col gap-8 mt-10">
        <div class="flex justify-between gap-2 text-xl font-bold">
          <div>Projects</div>
          <a href="#" phx-click={JS.remove_class("hidden", to: "#new_project", transition: "fade-in")}>+</a>
        </div>

        <div id="projects" phx-update="append" class="flex flex-col gap-3">
          <%= for project <- @projects do %>
            <div id={"project-" <> to_string(project.id)} class="flex justify-between">
            <a href={"/projects/" <> to_string(project.id)}>
              <div class="flex gap-2">
                <i class="text-sm text-gray-500 pt-0.5 ri-checkbox-blank-circle-fill hover:cursor-pointer"></i>
                <div class="flex justify-between w-full">
                  <div><%= project.name %></div>
                </div>
              </div>
            </a>
            <div phx-hook="ProjectAction" id={"project-delete-" <> to_string(project.id)} data-project_id={project.id}>
              <i class="text-gray-300 transition ease-in-out hover:text-red-600 ri-delete-bin-3-line hover:cursor-pointer"></i>
            </div>
            </div>
          <% end %>
        </div>
      </section>
      <TodophxWeb.ProjectModal.render id="new_project" />
    </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
