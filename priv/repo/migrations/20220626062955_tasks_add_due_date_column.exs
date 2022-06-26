defmodule Todophx.Repo.Migrations.TasksAddDueDateColumn do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :due_date, :utc_datetime
    end
  end
end
