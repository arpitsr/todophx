defmodule TodophxWeb.ProjectModal do
  use Phoenix.Component
  use Phoenix.HTML

  def render(assigns) do
    ~H"""
    <div>
      <!-- Modal Background -->
      <div class="modal-container" id={@id}
          phx-hook="ScrollLock">
        <div class="modal-inner-container rounded bg-white w-1/3">
          <div>
            <div class="pb-2">
              <!-- Title -->
              <div class="text-lg bg-gray-100 rounded px-4 py-2 justify-between flex">
                <div>Create new project</div>
                <button class="text-p4" type="button" phx-click="cancel-modal">
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
                    <button class="text-p1 bg-red-100 px-2 py-1 rounded"
                            type="submit">
                        Create Project
                    </button>
                  </div>
                </.form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
