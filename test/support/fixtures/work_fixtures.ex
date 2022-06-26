defmodule Todophx.WorkFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todophx.Work` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        is_archived: true,
        name: "some name"
      })
      |> Todophx.Work.create_project()

    project
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        done: true,
        name: "some name"
      })
      |> Todophx.Work.create_task()

    task
  end
end
