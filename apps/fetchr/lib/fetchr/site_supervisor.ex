defmodule Fetchr.Site.Supervisor do
  @moduledoc """
  A supervisor that spwans Fetchr.Queue and Fetchr.Site.Worker.Supervisor,
  """
  use Supervisor

  def start_link([website_name, domain]) do
    Supervisor.start_link(__MODULE__, [website_name, domain], name: website_name)
  end

  @impl true
  def init([website_name, domain]) do
    Supervisor.init([
      {Fetchr.Site.Worker.Supervisor, strategy: :one_for_one, name: website_name},
      {Fetchr.Queue, {website_name, domain}},
    ], strategy: :one_for_one)
  end
end
