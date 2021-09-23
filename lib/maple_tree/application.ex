defmodule MapleTree.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MapleTree.Repo,
      # Start the Telemetry supervisor
      MapleTreeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MapleTree.PubSub},
      # Start the Endpoint (http/https)
      MapleTreeWeb.Endpoint,
      # Start Quantum
      MapleTree.Scheduler
      # Start a worker by calling: MapleTree.Worker.start_link(arg)
      # {MapleTree.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MapleTree.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MapleTreeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
