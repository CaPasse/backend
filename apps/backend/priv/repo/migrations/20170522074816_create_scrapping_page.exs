defmodule Backend.Repo.Migrations.CreateBackend.Scrapping.Page do
  use Ecto.Migration

  def change do
    create table(:pages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :domain, :string
      add :n_views, :integer

      timestamps()
    end
    create unique_index(:pages, [:url, :domain], name: :unique_url_domain_index)
  end
end
