defmodule Fetchr.Application do
  @moduledoc """
    Fetchr Application. Starts,
    - Fetchr.Superviosr
    - Fetchr.Registry
  """

  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Fetchr.Supervisor},
      {Registry, keys: :unique, name: Fetchr.Registry}
    ]

    opts = [strategy: :one_for_one, name: Fetchr.Application]
    Supervisor.start_link(children, opts)
  end
end
