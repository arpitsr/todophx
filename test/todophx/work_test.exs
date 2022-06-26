defmodule Todophx.WorkTest do
  use Todophx.DataCase

  alias Todophx.Work

  describe "projects" do
    alias Todophx.Work.Project

    import Todophx.WorkFixtures

    @invalid_attrs %{is_archived: nil, name: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Work.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Work.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{is_archived: true, name: "some name"}

      assert {:ok, %Project{} = project} = Work.create_project(valid_attrs)
      assert project.is_archived == true
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{is_archived: false, name: "some updated name"}

      assert {:ok, %Project{} = project} = Work.update_project(project, update_attrs)
      assert project.is_archived == false
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_project(project, @invalid_attrs)
      assert project == Work.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Work.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Work.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Work.change_project(project)
    end
  end

  describe "tasks" do
    alias Todophx.Work.Task

    import Todophx.WorkFixtures

    @invalid_attrs %{done: nil, name: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Work.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Work.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{done: true, name: "some name"}

      assert {:ok, %Task{} = task} = Work.create_task(valid_attrs)
      assert task.done == true
      assert task.name == "some name"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{done: false, name: "some updated name"}

      assert {:ok, %Task{} = task} = Work.update_task(task, update_attrs)
      assert task.done == false
      assert task.name == "some updated name"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_task(task, @invalid_attrs)
      assert task == Work.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Work.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Work.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Work.change_task(task)
    end
  end
end
