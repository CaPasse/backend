defmodule Scrapping.Server do
  require Logger

  # API

  def get_next_listing(domain) do
    :rpc.call(backend_node(), Backend.Scrapping, :get_next_listing, [domain])
  end

  def get_next_page(domain) do
    :rpc.call(backend_node(), Backend.Scrapping, :get_next_page, [domain])
  end

  def found_page(domain, url) do
    :rpc.call(backend_node(), Backend.Scrapping, :found_page, [domain, url])
  end

  def ping_page(id, data) do
    :rpc.call(backend_node(), Backend.Scrapping, :ping_page, [id, data])
  end

  # private

  defp backend_node(), do: Application.fetch_env!(:leroy_merlin, :node)

end
