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

alias Backend.Scrapping

leroy_merlin_listings = [
  "/v3/p/produits/salle-de-bains/rangement-de-salle-de-bains/panier-malle-et-boite-de-rangement-l1401451898",
  "/v3/p/produits/salle-de-bains/rangement-de-salle-de-bains/organiseur-de-salle-de-bains-l1400102326",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/salon-de-jardin-l1308217777",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/table-de-jardin-l1308217778",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/chaise-et-fauteuil-de-jardin-l1308217775",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/salon-bas-de-jardin-canape-et-fauteuil-bas-l1308217772",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/bain-de-soleil-transat-et-hamac-l1308217768",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/coussin-et-pouf-d-exterieur-l1308217767",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/banc-bar-et-desserte-de-jardin-l1308217774",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/produits-d-entretien-et-housse-de-protection-pour-salon-de-jardin-l1308217771",
  "/v3/p/produits/terrasse-jardin/salon-de-jardin-table-et-chaise/salon-de-jardin-pour-enfants-l1308217776",
  "/v3/p/produits/terrasse-jardin/fontaine-bassin-et-poterie/pot-de-fleurs-jardiniere-poterie-decorative-l1400853841",
  "/v3/p/produits/decoration-eclairage/luminaire-interieur/lampadaire-et-liseuse-l1308218701",
  "/v3/p/produits/decoration-eclairage/luminaire-interieur/lampe-l1308218726",
  "/v3/p/produits/decoration-eclairage/luminaire-interieur/abat-jour-l1308218727",
  "/v3/p/produits/carrelage-parquet-sol-souple/tapis-et-paillasson/tapis-de-decoration-l1308217291",
  "/v3/p/produits/carrelage-parquet-sol-souple/tapis-et-paillasson/paillasson-et-tapis-de-cuisine-l1308217304",
  "/v3/p/produits/carrelage-parquet-sol-souple/tapis-et-paillasson/tapis-de-couloir-et-escaliers-l1308217298",
  "/v3/p/produits/decoration-eclairage/coussin-plaid-et-pouf/coussin-et-housse-l1308218639",
  "/v3/p/produits/decoration-eclairage/coussin-plaid-et-pouf/coussin-de-sol-l1308218659",
  "/v3/p/produits/decoration-eclairage/coussin-plaid-et-pouf/pouf-et-poire-l1308218663",
  "/v3/p/produits/decoration-eclairage/coussin-plaid-et-pouf/galette-de-chaise-l1308218658",
  "/v3/p/produits/decoration-eclairage/coussin-plaid-et-pouf/plaid-l1308218670",
  "/v3/p/produits/rangement-dressing/amenagement-placard-dressing-et-meuble-de-rangement/dressing-meuble-de-rangement-et-amenagements-spaceo-home-l1500259434",
  "/v3/p/produits/rangement-dressing/amenagement-placard-dressing-et-meuble-de-rangement/etagere-et-meuble-de-rangement-multikaz-l1400106579",
  "/v3/p/produits/rangement-dressing/amenagement-placard-dressing-et-meuble-de-rangement/dressing-metal-l1400106217",
  "/v3/p/produits/rangement-dressing/amenagement-placard-dressing-et-meuble-de-rangement/kit-dressing-l1308217940",
  "/v3/p/produits/rangement-dressing/accessoires-de-rangement/accessoires-de-dressing-l1400106073",
  "/v3/p/produits/rangement-dressing/accessoires-de-rangement/accessoires-de-dressing/range-chaussures-l1400106090",
  "/v3/p/produits/rangement-dressing/accessoires-de-rangement/panier-malle-boite-et-rangement-sous-vide-l1400104993",
  "/v3/p/produits/rangement-dressing/accessoires-de-rangement/barre-de-penderie-et-support-l1400106109",
  "/v3/p/produits/materiaux-menuiserie/panneau-bois-tablette-tasseau-moulure-et-plinthe/tablette-bois-tablette-melamine-l1308218545",
  "/v3/p/produits/quincaillerie-securite/etagere-et-rangement-utilitaire/console-et-cremaillere-l1308218163",
  "/v3/p/produits/outillage/materiel-et-amenagement-de-l-atelier/amenagement-d-atelier-l1308218999",
  "/v3/p/produits/quincaillerie-securite/etagere-et-rangement-utilitaire/range-bouteilles-et-accessoires-l1308218188",
  "/v3/p/produits/quincaillerie-securite/etagere-et-rangement-utilitaire/etagere-et-armoire-utilitaire-l1308218182",
  "/v3/p/produits/quincaillerie-securite/etagere-et-rangement-utilitaire/porte-manteau-patere-et-crochet-l1308218186",
  "/v3/p/produits/rangement-dressing/accessoires-de-rangement/panier-malle-boite-et-rangement-sous-vide-l1400104993",
  "/v3/p/produits/rangement-dressing/accessoires-de-rangement/portant-l1400105191",
  "/v3/p/produits/cuisine/poubelle-tabouret-et-accessoires-de-cuisine/poubelle-de-cuisine-l1308218100",
  "/v3/p/produits/cuisine/poubelle-tabouret-et-accessoires-de-cuisine/tabouret-de-cuisine-l1308218105",
  "/v3/p/produits/cuisine/poubelle-tabouret-et-accessoires-de-cuisine/accessoires-d-evier-l1400282282",
  "/v3/p/produits/cuisine/poubelle-tabouret-et-accessoires-de-cuisine/crochet-et-porte-torchons-l1400994991",
  "/v3/p/produits/cuisine/poubelle-tabouret-et-accessoires-de-cuisine/accessoires-muraux-de-credence-l1400282280",
]

Enum.each(leroy_merlin_listings, &%{
  "domain": "www.leroymerlin.fr",
  "url": &1,
} |> Scrapping.create_listing)
