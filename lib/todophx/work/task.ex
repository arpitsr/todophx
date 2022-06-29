defmodule Todophx.Work.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :done, :boolean, default: false
    field :name, :string
    field :due_date, :date
    belongs_to :project, Todophx.Work.Project

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :done, :project_id, :due_date])
    |> validate_required([:name, :done, :project_id])
  end
end
