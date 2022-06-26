defmodule Todophx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Desktop.Window,
       [
         app: :todophx,
         id: Todophx,
         url: &TodophxWeb.Endpoint.url/0
       ]},
      # Start the Ecto repository
      Todophx.Repo,
      # Start the Telemetry supervisor
      TodophxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Todophx.PubSub},
      # Start the Endpoint (http/https)
      TodophxWeb.Endpoint
      # Start a worker by calling: Todophx.Worker.start_link(arg)
      # {Todophx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todophx.Supervisor]
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
