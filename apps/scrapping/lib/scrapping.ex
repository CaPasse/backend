defmodule Scrapping.Server do
  require Logger

  # API

  def get_next_listing(domain) do
    GenServer.call(name(), {:get_next_listing, domain})
  end

  def get_next_page(domain) do
    GenServer.call(name(), {:get_next_page, domain})
  end

  def found_page(domain, url) do
    GenServer.cast(name(), {:found_page, domain, url})
  end

  def ping_page(id, data) do
    GenServer.cast(name(), {:ping_page, id, data})
  end

  # private

  defp name(), do: {:global, :scrapping_server}

end
