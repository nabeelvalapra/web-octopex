defmodule Fetchr.QueueWorkerSupervisor do
  use Supervisor

  def start_link(name) do
    Supervisor.start_link(__MODULE__, name, name: name)
  end

  @impl true
  def init(_name) do
    children = [
      {Fetchr.QueueAgent, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
