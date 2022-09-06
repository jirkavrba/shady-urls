defmodule ShadyUrlsWeb.PageController do
  use ShadyUrlsWeb, :controller
  alias ShadyUrls.Generator

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec handle(Plug.Conn.t(), map) :: Plug.Conn.t()
  def handle(conn, %{ "path" => path }) do
    redirect(conn, external: "https://google.com/search?q=" <> path)
  end

  @spec generate(Plug.Conn.t(), map) :: Plug.Conn.t()
  def generate(conn, %{ "url" => url }) do
    path = Generator.generate_shady_url(url)
    link = Routes.page_url(ShadyUrlsWeb.Endpoint, :handle, path)

    json(conn, %{
      original: url,
      shady: link
    })
  end
end
