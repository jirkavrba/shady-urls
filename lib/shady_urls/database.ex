defmodule ShadyUrls.Database do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec insert_redirect(String.t(), String.t(), boolean()) :: no_return()
  def insert_redirect(path, redirect, preview) when is_binary(path) and is_binary(redirect) and is_boolean(preview) do
    IO.inspect(preview)
    Agent.update(__MODULE__, fn db -> Map.put(db, path, {redirect, preview}) end)
  end

  @spec lookup_redirect(String.t()) :: {:ok, String.t(), boolean()} | :not_found
  def lookup_redirect(path) when is_binary(path) do
    result = Agent.get(__MODULE__, fn db -> db[path] end)

    case result do
      nil -> :not_found
      {redirect, preview} -> {:ok, redirect, preview}
    end
  end
end
