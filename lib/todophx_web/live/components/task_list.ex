defmodule TodophxWeb.TaskListComponent do
  use Phoenix.Component

  use Phoenix.HTML
  alias Todophx.Work
  alias TodophxWeb.Live.Utils.Css

  # Optionally also bring the HTML helpers
  # use Phoenix.HTML

  def show(assigns) do
    ~H"""
    <%= for task <- @tasks do %>
      <div class="flex mb-4" id={"task-"<>to_string(task.id)}>
        <.form let={f} for={Work.change_task(task)} phx-change="update-task-state" class="flex flex-col w-full">
          <div class="flex items-center w-full gap-2">
            <%= hidden_input f, :id ,id: "hidden-input" <> to_string(task.id), value: task.id %>
            <%= checkbox f, :done, class: "w-4 h-4 rounded", id: "task-checkbox-" <> to_string(task.id) %>
            <div class={Css.get_strike_css(task.done) <> " w-4/5"}><%= task.name %></div>
          </div>
          <div class="flex items-center inline my-2 text-sm text-gray-400 text-red-300">
            <div class="flex items-center px-1 border rounded-lg bg-gray-50 border-red-50">
              <i class="mr-2 ri-calendar-2-line bg-gray-50"></i>
              <%= date_input f, :due_date, id: "task-due-date-"<>to_string(task.id) ,value: task.due_date, placeholder: task.due_date, class: "border-none bg-gray-50 text-xs p-0 focus:ring-transparent" %>
            </div>
            <%= if Map.has_key?(assigns, :today) do %>
                <div class="px-1 py-0.5 ml-2 text-xs text-teal-600 border border-teal-100 rounded-lg bg-gray-50"><%= Todophx.Work.get_project!(task.project_id).name %></div>
              <% end %>
          </div>
        </.form>
        <!-- Delete task -->
        <div phx-hook="TaskAction" id={"task-delete-" <> to_string(task.id)} data-task_id={task.id}>
        <i class="text-gray-300 transition ease-in-out hover:text-red-600 ri-delete-bin-3-line"></i>
        </div>
      </div>
    <% end %>
    """
  end
end
