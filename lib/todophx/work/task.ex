defmodule Todophx.Work.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :done, :boolean, default: false
    field :name, :string
    field :due_date, :utc_datetime
    belongs_to :project, Todophx.Work.Project

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :done, :project_id])
    |> validate_required([:name, :done, :project_id])
    |> put_change(
      :due_date,
      DateTime.truncate(DateTime.add(DateTime.utc_now(), 24 * 60 * 60, :second), :second)
    )
  end
end
