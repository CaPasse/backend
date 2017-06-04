defmodule LeroyMerlin.Page do
  require Logger

  use Hound.Helpers

  def fetch_pages do
    Hound.start_session()
    navigate_to("https://www.leroymerlin.fr/v3/p/produits/terrasse-jardin/fontaine-bassin-et-poterie/pot-de-fleurs-jardiniere-poterie-decorative-l1400853841?resultOffset=0&resultLimit=99")
    tc_vars = execute_script("return tc_vars")
    report_products(tc_vars["list_products"])
    Hound.end_session()
  end

  defp report_products([]) do end
  defp report_products([product | products]) do
    Logger.info(product["list_product_url_page"])
    Backend.Scrapping.create_page(%{url: product["list_product_url_page"], domain: "www.leroymerlin.fr"})
    report_products(products)
  end

end
