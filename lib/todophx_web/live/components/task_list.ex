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
      <div class="flex mb-2" id={"task-"<>to_string(task.id)}>
        <.form let={f} for={Work.change_task(task)} phx-change="update-task-state" class="flex justify-between w-full">
          <label class="flex items-center w-4/5 gap-2">
            <%= hidden_input f, :id ,id: "hidden-input" <> to_string(task.id), value: task.id %>
            <%= checkbox f, :done, class: "w-4 h-4 rounded", id: "task-checkbox-" <> to_string(task.id) %>
            <div class={Css.get_strike_css(task.done) <> " w-4/5"}><%= task.name %></div>
            <div class={Css.get_strike_css(task.done)}>
              <div class="flex items-center text-sm text-right text-gray-400">
                <i class="ri-calendar-2-line"></i>
                <%= date_input f, :due_date, id: "task-due-date-"<>to_string(task.id) ,value: task.due_date, placeholder: task.due_date, class: "border-none" %>
              </div>
            </div>
          </label>
          <!-- Delete task -->
          <div phx-hook="TaskAction" id={"task-delete-" <> to_string(task.id)} data-task_id={task.id}>
          <i class="text-gray-300 transition ease-in-out hover:text-red-600 ri-delete-bin-3-line"></i>
          </div>
        </.form>
      </div>
    <% end %>
    """
  end
end
