defmodule Gastronokids do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Gastronokids.Endpoint, []),
      # Start the Ecto repository
      worker(Gastronokids.Repo, []),
      # Presence tracker: // HL
      supervisor(Gastronokids.Presence, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gastronokids.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Gastronokids.Endpoint.config_change(changed, removed)
    :ok
  end
end
