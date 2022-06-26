defmodule Todophx.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :is_archived, :boolean, default: false, null: false

      timestamps()
    end
  end
end
