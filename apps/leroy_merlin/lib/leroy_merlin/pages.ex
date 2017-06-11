defmodule LeroyMerlin.Pages do
  require Logger

  use Hound.Helpers

  def start_link do
    Task.start_link(fn -> loop() end)
  end

  defp loop do
    Logger.info("LeroyMerlin.Pages.loop")
    scrap_page()

    sleep()
    loop()
  end

  defp scrap_page() do

    with {:ok, page} <- Scrapping.Server.get_next_page("www.leroymerlin.fr") do
      url = "https://www.leroymerlin.fr#{page.url}"

      Hound.start_session()

      Logger.info("Page: #{page.url}")
      navigate_to(url)

      %{}
      |> get_description()
      |> get_images()
      |> get_attributes()
      |> get_rating()
      |> get_reviews()
      |> send_page(page.id)

      Hound.end_session()
    end

  end

  defp get_description(data) do
    with {:ok, desc_elem} <- search_element(:class, "desc") do
      Map.put(data, "description", inner_text(desc_elem))
    else
      _ -> data
    end
  end

  defp get_images(data) do
    links = find_all_elements(:css, ".content-carousel > a")
    unless length(links) == 0 do
      Map.put(data, "images", Enum.map(links, &attribute_value(&1, "data-zoom-image")))
    else
      img = find_element(:css, ".zoomWrapper > img")
      Map.put(data, "images", [attribute_value(img, "data-zoom-image")])
    end
  end

  defp get_attributes(data) do
    attribute_rows = find_all_elements(:css, ".tech-desc tr")
    Map.put(data, "attributes", Enum.reduce(attribute_rows, %{}, &get_attribute_row/2))
  end

  defp get_attribute_row(attribute_row, attributes) do
    key_elem = find_within_element(attribute_row, :css, "th")
    value_elem = find_within_element(attribute_row, :css, "td")
    Map.put(attributes, inner_text(key_elem), inner_text(value_elem))
  end

  defp get_rating(data) do
    Map.put(data, "rating", inner_text(find_element(:css, ".reviews-synthesis-score > strong")))
  end

  defp get_reviews(data) do
    review_elems = find_all_elements(:class, "review-content")
    Map.put(data, "reviews", Enum.map(review_elems, &get_review/1))
  end

  defp get_review(review_elem) do
    %{
      "title": inner_text(find_within_element(review_elem, :css, ".review-content-title-group > h3")),
      "content": inner_text(find_within_element(review_elem, :css, ".review-text > span")),
      "rating": inner_text(find_within_element(review_elem, :css, ".review-star-snippets > span[itemprop=\"ratingValue\"]")),
    }
  end

  defp send_page(data, id) do
    Scrapping.Server.ping_page(id, data)
  end

  defp sleep do
    s = 1000 + :rand.uniform(5000)
    Logger.info("Sleeping #{s}ms")
    :timer.sleep(s)
  end

end
