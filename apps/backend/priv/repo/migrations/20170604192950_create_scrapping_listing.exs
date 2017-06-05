defmodule Backend.Repo.Migrations.CreateBackend.Scrapping.Listing do
  use Ecto.Migration

  def change do
    create table(:listings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :domain, :string

      timestamps()
    end

  end
end
