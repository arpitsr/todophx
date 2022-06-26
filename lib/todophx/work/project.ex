defmodule Todophx.Work.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :is_archived, :boolean, default: false
    field :name, :string
    has_many :tasks, Todophx.Work.Task, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :is_archived])
    |> validate_required([:name, :is_archived])
  end
end
