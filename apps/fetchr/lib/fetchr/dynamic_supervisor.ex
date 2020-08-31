defmodule Fetchr.DynamicSupervisor do
  @moduledoc """
  A dynamic supervisor that loads up Fetchr.QueueAgent & Fetchr.Worker.Supervisor.
  """

  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_fetchr(name) do
    spec = {Fetchr.QueueWorkerSupervisor, name}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
