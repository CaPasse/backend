defmodule LeroyMerlin.Listings do
  require Logger

  use Hound.Helpers

  @n_per_page 99

  def start_link do
    Task.start_link(fn -> loop() end)
  end

  defp loop() do
    Logger.info("LeroyMerlin.Listings.loop")
    total = crawl_listing(0)
    Logger.info("LeroyMerlin: Found #{total} pages")

    sleep()
    loop()
  end

  defp crawl_listing(offset, total \\ 0) do

    with {:ok, listing} <- Scrapping.Server.get_next_listing("www.leroymerlin.fr") do
      url = listing_url(listing, offset)

      Hound.start_session()

      Logger.info("Listing: #{url}")
      navigate_to("https://www.leroymerlin.fr#{url}")

      tc_vars = execute_script("return tc_vars")

      Hound.end_session()

      send_listing(tc_vars["list_products"], offset, total)
    else
      _ -> total
    end

  end

  defp send_listing([], _offset, total), do: total
  defp send_listing(products, offset, total) do
    Enum.each(products, &Scrapping.Server.found_page("www.leroymerlin.fr", &1["list_product_url_page"]))
    crawl_listing(offset+@n_per_page, total+length(products))
  end

  # Utils
  
  defp listing_url(listing, offset), do: "#{listing.url}?resultOffset=#{offset}&resultLimit=#{@n_per_page}"

  defp sleep do
    s = 30000 + :rand.uniform(30000)
    Logger.info("Sleeping #{s}ms")
    :timer.sleep(s)
  end

end
