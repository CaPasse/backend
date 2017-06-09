defmodule LeroyMerlin.Listings do
  require Logger

  use Hound.Helpers

  @n_per_page 99

  def start_link do
    Task.start_link(fn -> loop() end)
  end

  defp loop() do
    Logger.info("Scrapping Leroy Merlin")

    Hound.start_session()
    total = crawl_listing(0)
    Logger.info("LeroyMerlin: Found #{total} pages")
    Hound.end_session()

    sleep()
    loop()
  end

  defp crawl_listing(offset, total \\ 0) do
    listing = Scrapping.Server.get_next_listing("www.leroymerlin.fr")
    url = listing_url(listing, offset)
    Logger.info("Listing: #{url}")
    navigate_to("https://www.leroymerlin.fr#{url}")
    tc_vars = execute_script("return tc_vars")
    n_listed = length(tc_vars["list_products"])
    Logger.info("#{n_listed} products listed");
    unless n_listed == 0 do
      Enum.each(tc_vars["list_products"], &Scrapping.Server.found_page("www.leroymerlin.fr", &1["list_product_url_page"]))
      crawl_listing(offset+@n_per_page, total+n_listed)
    end
    total
  end

  # Private
  
  defp listing_url(listing, offset), do: listing.url |> String.replace("[n_offset]", Integer.to_string(offset)) |> String.replace("[n_per_page]", Integer.to_string(@n_per_page))

  defp sleep do
    s = 30000 + :rand.uniform(30000)
    Logger.info("Sleeping #{s}ms")
    :timer.sleep(s)
  end

end
