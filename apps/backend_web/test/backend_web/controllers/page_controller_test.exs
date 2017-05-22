defmodule CP.Web.PageControllerTest do
  use CP.Web.ConnCase

  alias Backend.Scrapping
  alias Backend.Scrapping.Page

  @create_attrs %{data: %{}, url: "some url", website: "some website"}
  @update_attrs %{data: %{}, url: "some updated url", website: "some updated website"}
  @invalid_attrs %{data: nil, url: nil, website: nil}

  def fixture(:page) do
    {:ok, page} = Scrapping.create_page(@create_attrs)
    page
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates page and renders page when data is valid", %{conn: conn} do
    conn = post conn, page_path(conn, :create), page: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, page_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "data" => %{},
      "url" => "some url",
      "website" => "some website"}
  end

  test "does not create page and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, page_path(conn, :create), page: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen page and renders page when data is valid", %{conn: conn} do
    %Page{id: id} = page = fixture(:page)
    conn = put conn, page_path(conn, :update, page), page: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, page_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "data" => %{},
      "url" => "some updated url",
      "website" => "some updated website"}
  end

  test "does not update chosen page and renders errors when data is invalid", %{conn: conn} do
    page = fixture(:page)
    conn = put conn, page_path(conn, :update, page), page: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen page", %{conn: conn} do
    page = fixture(:page)
    conn = delete conn, page_path(conn, :delete, page)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, page_path(conn, :show, page)
    end
  end
end
