defmodule Fetchr.Application do
  @moduledoc """
    Starts the Fetchr.Supervisor(Dynamic Supervisor)
  """

  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Fetchr.DynamicSupervisor},
    ]

    opts = [strategy: :one_for_one, name: Fetchr.Application]
    Supervisor.start_link(children, opts)
  end
end
