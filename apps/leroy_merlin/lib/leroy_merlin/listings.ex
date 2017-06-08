defmodule LeroyMerlin.Listings do
  require Logger

  use Hound.Helpers

  def start_link do
    Task.start_link(fn -> loop() end)
  end

  defp loop do
    Logger.info("Scrapping Leroy Merlin")
    crawl_listing()
    sleep()
    loop()
  end

  defp crawl_listing do
    Hound.start_session()
    listing = Scrapping.Server.get_next_listing("www.leroymerlin.fr")
    navigate_to("https://www.leroymerlin.fr#{listing.url}")
    Logger.info("Listing: #{listing.url}")
    tc_vars = execute_script("return tc_vars")
    Logger.info("#{length(tc_vars["list_products"])} products listed");
    Enum.each(tc_vars["list_products"], &Scrapping.Server.found_page("www.leroymerlin.fr", &1["list_product_url_page"]))
    Hound.end_session()
  end

  # Private

  defp sleep do
    s = 30000 + :rand.uniform(30000)
    Logger.info("Sleeping #{s}ms")
    :timer.sleep(s)
  end

end
