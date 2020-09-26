defmodule Fetchr.Supervisor do
  @moduledoc """
  A dynamic supervisor that spwans child Fetchr.Site.Supervisor,
  also starts a Fetchr.Site.Worker(child) under Fetchr.Site.Worker.Supervisor
  """

  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_fetchr(website_name, domain) do
    DynamicSupervisor.start_child(__MODULE__, {Fetchr.Site.Supervisor, [website_name, domain]})
    worker_sup_pid = Fetchr.Site.Worker.Supervisor.get_supervisor_pid(website_name)
    DynamicSupervisor.start_child(worker_sup_pid, {Fetchr.Site.Worker, []})
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
