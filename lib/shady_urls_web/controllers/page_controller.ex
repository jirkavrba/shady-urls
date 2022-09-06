defmodule ShadyUrlsWeb.PageController do
  use ShadyUrlsWeb, :controller

  def index(conn, _params) do
    IO.inspect(ShadyUrls.Generator.generate_shady_url("https://vse.cz"))
    render(conn, "index.html")
  end
end
