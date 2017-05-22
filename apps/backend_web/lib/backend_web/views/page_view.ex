defmodule CP.Web.PageView do
  use CP.Web, :view
  alias CP.Web.PageView

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, PageView, "page.json")}
  end

  def render("show.json", %{page: page}) do
    %{data: render_one(page, PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{id: page.id,
      url: page.url,
      website: page.website,
      data: page.data}
  end
end
