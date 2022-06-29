defmodule TodophxWeb.ProjectModal do
  use Phoenix.Component
  use Phoenix.HTML
  alias Phoenix.LiveView.JS

  def render(assigns) do
    ~H"""
      <!-- Modal Background -->
      <div class="flex hidden modal-container" id={@id}
          phx-hook="ScrollLock">
        <div class="w-1/3 bg-white rounded modal-inner-container">
          <div>
            <div class="pb-2">
              <!-- Title -->
              <div class="flex justify-between px-4 py-2 text-lg bg-gray-100 rounded">
                <div>Create new project</div>
                <button class="text-p4" type="button" phx-click={JS.add_class("hidden", to: "#new_project", transition: "fade-out")}>
                  <div>&times;</div>
                </button>
              </div>

              <!-- Body -->
              <div class="px-4 py-2">
                <.form let={f} for={:project} phx-submit="create-new-project">
                  <div class="flex flex-col gap-2 mt-2">
                    <%= label f, :name, class: "uppercase text-sm" %>
                    <%= text_input f, :name,  class: "border-gray-300 rounded focus:border-gray-200 focus:ring-transparent" , phx_hook: "AutoFocus" %>
                  </div>
                  <div class="flex justify-end mt-8">
                    <!-- Right Button -->
                    <button class="px-2 py-1 bg-red-100 rounded text-p1"
                            type="submit" phx-click={JS.add_class("hidden", to: "#new_project", transition: "fade-out")}>
                        Create Project
                    </button>
                  </div>
                </.form>
              </div>
            </div>
          </div>
        </div>
      </div>
    """
  end
end
