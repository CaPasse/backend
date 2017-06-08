# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Backend.Scrapping.Listing

%Listing{
  "domain": "www.leroymerlin.fr",
  "url": "/v3/p/produits/terrasse-jardin/fontaine-bassin-et-poterie/pot-de-fleurs-jardiniere-poterie-decorative-l1400853841?resultOffset=0&resultLimit=9999"
} |> Backend.Repo.insert!
