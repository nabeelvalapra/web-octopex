defmodule Fetchr.Application do
  @moduledoc """
    Starts the Fetchr.Supervisor(Dynamic Supervisor)
  """

  use Application

  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: Fetchr.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
