defmodule Mix.Tasks.Memento do
  @moduledoc "The memento mix task: `mix help memento`"
  use Mix.Task
  require Logger

  alias ShadyUrls.Database.Redirect

  @shortdoc "Create the mnesia database schema"
  def run(_) do
    # Create the DB directory (if custom path given)
    if path = Application.get_env(:mnesia, :dir) do
      :ok = File.mkdir_p!(path)
    end

    nodes = [node()]

    Logger.info("Creating the database schema")

    IO.inspect(Memento.stop())
    IO.inspect(Memento.Schema.create(nodes))
    IO.inspect(Memento.start())
    IO.inspect(Memento.Table.create(Redirect, disc_copies: nodes))

    Logger.info("Database created")
  end
end
