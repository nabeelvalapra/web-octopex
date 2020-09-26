defmodule Fetchr.Queue do
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

    def start_link({website_name, domain}) do
        Agent.start_link(fn -> [domain] end, name: process_name(website_name))
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

    defp process_name(name) do
        {:via, Registry, {Fetchr.Registry, "#{name}-queue"}}
    end

    def get_supervisor_pid(name) do
        [{pid, nil}] = Registry.lookup(Fetchr.Registry, "#{name}-queue")
        pid
    end
end
