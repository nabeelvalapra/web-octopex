defmodule Fetchr.Site.Worker do
  @moduledoc """
  A `Task` worker that
  - Picks up URL from Fetchr, process it, and saves it to DB.
  - If unique links and found then it updates the Fetchr.
  """
  use Task

  def start_link(_) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    Enum.each(
      0..10,
      fn(x) ->
        Process.sleep(1000)
        IO.puts "#{x} hello, world!"
      end
    )
  end
end
