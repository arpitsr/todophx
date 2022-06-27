defmodule TodophxWeb.TodayLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  alias TodophxWeb.NavbarComponent
  alias TodophxWeb.SidenavComponent
  use Phoenix.HTML
  alias Todophx.Work

  def mount(_params, %{}, socket) do
    tasks = Work.all_tasks()

    {:ok,
     socket
     |> assign(:show_modal, false)
     |> assign(:projects, Work.list_projects())
     |> assign(:tasks, tasks)}
  end

  def get_strike_css(state) do
    if state == true do
      "line-through"
    else
      ""
    end
  end

  def render(assigns) do
    ~H"""
    <NavbarComponent.render />
    <div class="flex">
      <div class="w-1/4 bg-gray-50">
        <SidenavComponent.render show_modal={@show_modal} projects={@projects}/>
      </div>
      <div class="w-3/4">
        <div class="w-4/5 py-8 mx-auto">
          <div class="mb-8 text-xl font-bold">Today</div>
          <%= for task <- @tasks do %>
                <div class="flex mb-2" id={"task-"<>to_string(task.id)}>
                  <.form let={f} for={Work.change_task(task)} phx-change="update-task-state" class="flex justify-between w-full">
                    <label class="flex items-center w-4/5 gap-2">
                      <%= hidden_input f, :id ,id: "hidden-input" <> to_string(task.id), value: task.id %>
                      <%= checkbox f, :done, class: "w-4 h-4 rounded", id: "task-checkbox-" <> to_string(task.id) %>
                      <div class={get_strike_css(task.done) <> " w-3/5 flex gap-4 items-center"}>
                        <%= task.name %>

                      </div>
                      <div class="w-1/5 text-sm text-p1 opacity-90"><%= Todophx.Repo.preload(task, :project).project.name %></div>
                      <div class={get_strike_css(task.done) <> " w-1/5"}>
                        <% {:ok, formatted_time} = Timex.format(task.due_date, "{Mshort} {D} {YYYY}") %>
                        <div class="text-sm text-right text-gray-400">Due: <%= formatted_time %></div>
                      </div>
                    </label>
                    <!-- Delete task -->
                    <div phx-hook="TaskAction" id={"task-delete-" <> to_string(task.id)} data-task_id={task.id}>
                    <i class="text-gray-300 transition ease-in-out hover:text-red-600 ri-delete-bin-3-line"></i>
                    </div>
                  </.form>
                </div>
              <% end %>
        </div>
      </div>
    </div>
    """
  end
end
