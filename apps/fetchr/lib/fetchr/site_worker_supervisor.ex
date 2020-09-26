defmodule Fetchr.Site.Worker.Supervisor do
  @moduledoc """
  A dynamic supervisor that managers Fetchr.Site.Worker
  """

  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(
      __MODULE__, [args[:strategy]], name: process_name(args[:name])
    )
  end

  def start_worker(name) do
    DynamicSupervisor.start_child(process_name(name), {Fetchr.Worker, []})
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  defp process_name(name) do
    {:via, Registry, {Fetchr.Registry, "#{name}-worker-supervisor"}}
  end

  def get_supervisor_pid(name) do
    [{pid, nil}] = Registry.lookup(Fetchr.Registry, "#{name}-worker-supervisor")
    pid
  end
end
