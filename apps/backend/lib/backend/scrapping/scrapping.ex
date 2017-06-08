defmodule Backend.Scrapping do
  @moduledoc """
  The boundary for the Scrapping system.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Scrapping.Listing

  def list_listings, do: Repo.all(Listing)
  def get_listing!(id), do: Repo.get!(Listing, id)
  def get_next_listing(domain), do: (from l in Listing, where: l.domain == ^domain) |> first(:updated_at) |> Repo.one!
  def create_listing(attrs \\ %{}), do: %Listing{} |> Listing.changeset(attrs) |> Repo.insert()
  def update_listing(%Listing{} = listing, attrs), do: listing |> Listing.changeset(attrs) |> Repo.update()
  def delete_listing(%Listing{} = listing), do: Repo.delete(listing)
  def change_listing(%Listing{} = listing), do: Listing.changeset(listing, %{})


  alias Backend.Scrapping.Page

  def list_pages, do: Repo.all(Page)
  def get_page!(id), do: Repo.get!(Page, id)
  def get_page(domain, url), do: (from l in Page, where: l.domain == ^domain, where: l.url == ^url) |> Repo.one
  def get_next_page(domain), do: (from l in Page, where: l.domain == ^domain) |> first(:updated_at) |> Repo.one!
  def create_page(attrs \\ %{}), do: %Page{} |> Page.changeset(attrs) |> Repo.insert
  def update_page(%Page{} = page, attrs), do: page |> Page.changeset(attrs) |> Repo.update
  def delete_page(%Page{} = page), do: Repo.delete(page)
  def change_page(%Page{} = page), do: Page.changeset(page, %{})

  def found_page(domain, url) do
    if !get_page(domain, url) do
      create_page(%{url: url, domain: domain})
    end
  end

end
