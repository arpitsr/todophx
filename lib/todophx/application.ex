defmodule Todophx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def config_dir() do
    Path.join([Desktop.OS.home(), ".config", "todophx"])
  end

  @impl true
  def start(_type, _args) do
    File.mkdir_p!(config_dir())

    Application.put_env(:todophx, Todophx.Repo, database: Path.join(config_dir(), "/database.sq3"))

    children = [
      # Start the Ecto repository
      Todophx.Repo,
      # Start the Telemetry supervisor
      TodophxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Todophx.PubSub},
      # Start the Endpoint (http/https)
      TodophxWeb.Endpoint,
      # Start a worker by calling: Todophx.Worker.start_link(arg)
      # {Todophx.Worker, arg}
      {Desktop.Window,
       [
         app: :todophx,
         id: Todophx,
         size: {600, 500},
         title: "Todophx",
         icon: "icon.png",
         url: &TodophxWeb.Endpoint.url/0
       ]}
    ]

    :session = :ets.new(:session, [:named_table, :public, read_concurrency: true])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todophx.Supervisor, max_restarts: 0]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodophxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
