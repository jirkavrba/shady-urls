defmodule ShadyUrls.Database do
  defmodule Redirect do
    use Memento.Table,
      attributes: [:path, :redirect],
      type: :ordered_set
  end

  @spec insert_redirect(String.t(), String.t()) :: no_return()
  def insert_redirect(path, redirect) when is_binary(path) and is_binary(redirect) do
    Memento.transaction!(fn -> Memento.Query.write(%Redirect{path: path, redirect: redirect}) end)
  end

  @spec lookup_redirect(String.t()) :: {:ok, String.t()} | :not_found
  def lookup_redirect(path) when is_binary(path) do
    result = Memento.transaction!(fn -> Memento.Query.read(Redirect, path) end)

    case result do
      %Redirect{} = entry -> {:ok, entry.redirect}
      _ -> :not_found
    end
  end
end
