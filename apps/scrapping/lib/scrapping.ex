defmodule Scrapping.Server do
  require Logger

  # API

  def get_next_listing(domain) do
    case :rpc.call(backend_node(), Backend.Scrapping, :get_next_listing, [domain]) do
      {:badrpc, _reason} ->
        raise "FAILED: get_next_listing"
      ret -> ret
    end
  end

  def get_next_page(domain) do
    case :rpc.call(backend_node(), Backend.Scrapping, :get_next_page, [domain]) do
      {:badrpc, _reason} ->
        raise "FAILED: get_next_page"
      ret -> ret
    end

  end

  def found_page(domain, url) do
    :rpc.cast(backend_node(), Backend.Scrapping, :found_page, [domain, url])
  end

  def ping_page(id, data) do
    :rpc.cast(backend_node(), Backend.Search, :index_product, [id, data])
  end

  # private

  defp backend_node(), do: Application.fetch_env!(:leroy_merlin, :node)

end
