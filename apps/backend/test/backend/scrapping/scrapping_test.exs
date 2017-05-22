defmodule Backend.ScrappingTest do
  use Backend.DataCase

  alias Backend.Scrapping

  describe "pages" do
    alias Backend.Scrapping.Page

    @valid_attrs %{data: %{}, url: "some url", website: "some website"}
    @update_attrs %{data: %{}, url: "some updated url", website: "some updated website"}
    @invalid_attrs %{data: nil, url: nil, website: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scrapping.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Scrapping.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Scrapping.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Scrapping.create_page(@valid_attrs)
      assert page.data == %{}
      assert page.url == "some url"
      assert page.website == "some website"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scrapping.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = Scrapping.update_page(page, @update_attrs)
      assert %Page{} = page
      assert page.data == %{}
      assert page.url == "some updated url"
      assert page.website == "some updated website"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Scrapping.update_page(page, @invalid_attrs)
      assert page == Scrapping.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Scrapping.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Scrapping.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Scrapping.change_page(page)
    end
  end
end
