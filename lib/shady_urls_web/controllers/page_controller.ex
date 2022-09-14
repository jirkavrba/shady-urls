defmodule ShadyUrlsWeb.PageController do
  use ShadyUrlsWeb, :controller

  alias ShadyUrls.Database
  alias ShadyUrls.Generator

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec handle(Plug.Conn.t(), map) :: Plug.Conn.t()
  def handle(conn, %{ "path" => path }) do
    case Database.lookup_redirect(path) do
      :not_found -> redirect(conn, to: Routes.page_path(ShadyUrlsWeb.Endpoint, :index))
      {:ok, url, true} -> redirect(conn, external: url)
      {:ok, url, false} ->
        conn
        |> put_root_layout({ ShadyUrlsWeb.LayoutView, "redirect.html"})
        |> assign(:redirect, url)
        |> render("redirect.html")
    end
  end

  @spec generate(Plug.Conn.t(), map) :: Plug.Conn.t()
  def generate(conn, %{ "url" => url, "preview" => preview }) do
    url = Generator.normalize_url(url)
    path = Generator.generate_shady_url(url)
    link = Routes.page_url(ShadyUrlsWeb.Endpoint, :handle, path)
    preview = (preview == "true")

    Database.insert_redirect(path, url, preview)

    conn
    |> assign(:original, url)
    |> assign(:generated, link)
    |> render("result.html")
  end
end
