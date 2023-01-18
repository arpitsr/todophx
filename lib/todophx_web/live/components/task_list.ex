defmodule TodophxWeb.TaskListComponent do
  use Phoenix.Component

  use Phoenix.HTML
  alias Todophx.Work

  # Optionally also bring the HTML helpers
  # use Phoenix.HTML

  def show(assigns) do
    ~H"""
    <%= for task <- @tasks do %>
      <div class="flex justify-between mb-6" id={"task-"<>to_string(task.id)}>
        <.form let={f} for={Work.change_task(task)} phx-change="update-task-state" class="flex flex-col w-2/3">
          <div class="flex items-start w-full gap-4">
            <%= hidden_input f, :id ,id: "hidden-input" <> to_string(task.id), value: task.id %>
            <div><%= checkbox f, :done, class: "w-4 h-4 rounded-full", id: "task-checkbox-" <> to_string(task.id) %></div>
            <div class={task.done && "line-through w-4/5" || "w-4/5"}><%= task.name %></div>
          </div>
          <div class="flex items-center inline my-2 text-sm text-gray-400 text-red-600">
            <div class="flex items-center px-1 ml-8 border rounded-lg bg-gray-50 border-red-50">
              <div class="pr-1 text-red-600"><i class="ri-calendar-2-line bg-gray-50"></i></div>
              <%= if task.due_date != nil do %>
                <% {:ok, formatted_time} = Timex.format(task.due_date, "{Mshort} {D} {YYYY}") %>
                <div class="text-sm text-right text-red-600"><%= formatted_time %></div>
              <% else %>
                <div class="hover:cursor-pointer">due date</div>
              <% end %>
              <%= date_input f, :due_date, id: "task-due-date-"<>to_string(task.id), placeholder: task.due_date, class: "absolute opacity-0 hover:cursor-pointer border-none bg-gray-50 text-xs p-0 focus:ring-transparent placeholder:text-red-50" %>
            </div>
            <%= if task.due_date < Timex.today() do %>
              <div class="ml-2 text-sm text-right text-white bg-red-600 rounded-lg px-1">delayed</div>
            <% end %>
          </div>
        </.form>
        <!-- Delete task -->
        <div class="flex flex-col">
          <div phx-hook="TaskAction" id={"task-delete-" <> to_string(task.id)} data-task_id={task.id}>
            <i class="float-right text-gray-300 transition ease-in-out hover:text-red-600 ri-delete-bin-3-line"></i>
          </div>
          <%= if Map.has_key?(assigns, :today) do %>
            <div class="flex items-center px-1 my-2 ml-auto text-sm text-teal-600 border border-teal-100 rounded-lg bg-gray-50">
              <div class="pr-1"><i class="ri-folder-5-line"></i></div>
              <%= task.project.name %>
            </div>
          <% end %>
        </div>
      </div>
    <% end %>
    """
  end
end
