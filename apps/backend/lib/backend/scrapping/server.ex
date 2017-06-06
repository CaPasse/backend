defmodule Backend.Scrapping.Server do
  require Logger

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: name())
  end

  # calls handlers

  def handle_call({:get_next_listing, domain}, _from, state) do
    listing = Backend.Scrapping.get_next_listing(domain)
    {:reply, listing, state}
  end

  def handle_call({:get_next_page, domain}, _from, state) do
    page = Backend.Scrapping.get_next_page(domain)
    {:reply, page, state}
  end

  # cast handlers
  
  def handle_cast({:found_page, domain, url}, state) do
    if !Backend.Scrapping.get_page(domain, url) do
      Backend.Scrapping.create_page(%{url: url, domain: domain})
    end
    {:noreply, state}
  end

  def handle_cast({:ping_page, id, data}, state) do
    Logger.info("Ping page #{id}")
    Backend.Search.index_product(id, data)
    {:noreply, state}
  end

  # private

  defp name(), do: {:global, :scrapping_server}

end
