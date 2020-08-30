defmodule Fetchr.QueueAgent do
    @moduledoc """
    An Agent that keeps the state of URLs to be / already fetched.
    Also provides API of the state for other processes.

    State stuct:
    [
        %{url: "www.sample.example.com", has_fetched: true/false},
        ...
    ]
    """
    use Agent

    defmodule Item do
        defstruct [:url, :has_fetched]
    end

    def start_link(initial_queue) do
        Agent.start_link(fn -> initial_queue end, name: __MODULE__)
    end

    def add_to_queue(url) do
        Agent.update(__MODULE__, fn queue -> get_or_append(queue, url) end)
    end

    def inspect_queue do
        Agent.get(__MODULE__, fn state -> state end)
    end

    defp get_or_append(queue, url_to_add) do
        case Enum.filter(queue, fn item -> item.url == url_to_add end) do
            [] -> queue ++ [%{url: url_to_add, has_fetched: false}]
            _ -> queue
        end
    end
end