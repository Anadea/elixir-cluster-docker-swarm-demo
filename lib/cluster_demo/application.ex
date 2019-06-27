defmodule ClusterDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ClusterDemo.Worker.start_link(arg)
      # {ClusterDemo.Worker, arg}
      {Cluster.Supervisor,
       [
         [
           swarm_dns_poll: [
             strategy: Cluster.Strategy.DNSPoll,
             config: [query: "tasks.t_cluster_demo", node_basename: "cluster_demo"]
           ]
         ]
       ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClusterDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
