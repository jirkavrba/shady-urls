defmodule ShadyUrls.Database do
  use Agent

  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  @spec insert_redirect(String.t(), String.t()) :: no_return()
  def insert_redirect(path, redirect) when is_binary(path) and is_binary(redirect) do
    Agent.update(__MODULE__, fn entries -> Map.put(entries, path, redirect) |> IO.inspect() end)
  end

  @spec lookup_redirect(String.t()) :: {:ok, String.t()} | :not_found
  def lookup_redirect(path) when is_binary(path) do
    case Agent.get(__MODULE__, fn entries -> entries[path] end) do
      nil -> :not_found
      redirect -> {:ok, redirect}
    end
  end
end
