defmodule CardCollection.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CardCollectionWeb.Telemetry,
      # Start the Ecto repository
      CardCollection.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CardCollection.PubSub},
      # Start Finch
      {Finch, name: CardCollection.Finch},
      # Start the Endpoint (http/https)
      CardCollectionWeb.Endpoint
      # Start a worker by calling: CardCollection.Worker.start_link(arg)
      # {CardCollection.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CardCollection.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CardCollectionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
