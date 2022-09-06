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

    # Create the Schema
    Logger.info("Stopping mnesia")
    Memento.stop()

    Logger.info("Creating the database schema")
    Memento.Schema.create(nodes)

    Logger.info("Starting mnesia again")
    Memento.start()

    Logger.info("Creating the Redirect table")
    Memento.Table.create!(Redirect, disc_copies: nodes)

    Logger.info("Database created")

  end
end
