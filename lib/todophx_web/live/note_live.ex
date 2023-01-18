defmodule TodophxWeb.Live.NoteLive do
  use Phoenix.LiveView
  alias TodophxWeb.NavbarComponent
  alias TodophxWeb.SidenavComponent
  use Phoenix.HTML
  alias Todophx.Work

  def mount(_params, %{}, socket) do
    projects = Work.list_projects()
    {:ok, socket |> assign(:projects, projects)}
  end

  def render(assigns) do
    ~H"""
    <NavbarComponent.render />
    <div class="flex">
    <div class="w-1/4 bg-gray-50">
    <SidenavComponent.render projects={@projects} />
    </div>
    <div class="w-3/4">
    <div class="w-4/5 py-10 mx-auto">
      <div class="mb-6 text-xl font-bold">
        Notes
      </div>
      <hr class="mb-12" />
      <div class="w-full">
        <form class="w-full h-screen border-gray-50" phx-update="ignore" id="trix-editor">
          <input id="x" type="hidden" name="content" class="placeholder:italic placeholder:text-gray-100 focus:outline-none" >
          <trix-editor input="x" class="placeholder:italic placeholder:text-gray-100 focus:outline-none" placeholder="Start writing your note here..."></trix-editor>
        </form>
      </div>
    </div>
    </div>
    </div>
    """
  end
end
