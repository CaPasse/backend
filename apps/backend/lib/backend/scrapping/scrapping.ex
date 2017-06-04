defmodule Backend.Scrapping do
  @moduledoc """
  The boundary for the Scrapping system.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Scrapping.Listing

  def list_listings do
    Repo.all(Listing)
  end

  def get_listing!(id), do: Repo.get!(Listing, id)

  def create_listing(attrs \\ %{}) do
    %Listing{}
    |> Listing.changeset(attrs)
    |> Repo.insert()
  end

  def update_listing(%Listing{} = listing, attrs) do
    listing
    |> Listing.changeset(attrs)
    |> Repo.update()
  end

  def delete_listing(%Listing{} = listing) do
    Repo.delete(listing)
  end

  def change_listing(%Listing{} = listing) do
    Listing.changeset(listing, %{})
  end


  alias Backend.Scrapping.Page

  def list_pages do
    Repo.all(Page)
  end

  def get_page!(id), do: Repo.get!(Page, id)

  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end


end
