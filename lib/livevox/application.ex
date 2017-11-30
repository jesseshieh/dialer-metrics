defmodule Livevox.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(LivevoxWeb.Endpoint, []),
      supervisor(Phoenix.PubSub.PG2, [:livevox, []]),
      # supervisor(Livevox.Repo, []),

      worker(Livevox.Session, []),
      worker(Livevox.ServiceInfo, [])
      # worker(Livevox.AirtableCache, [])

      # worker(Livevox.ServiceFeed, []),
      # worker(Livevox.AgentEventFeed, []),
      # worker(Livevox.CallEventFeed, []),

      # worker(Livevox.Metrics.Cip, [])
      # worker(Livevox.Metrics.WaitTime, []),
      # worker(Livevox.CallState, [])
      # worker(Livevox.Recorder.Agent, []),
      # worker(Livevox.Recorder.Call, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Livevox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LivevoxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
