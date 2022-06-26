defmodule Todophx.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :text
      add :done, :boolean, default: false, null: false
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:project_id])
  end
end
