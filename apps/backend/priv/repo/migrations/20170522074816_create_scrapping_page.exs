defmodule Backend.Repo.Migrations.CreateBackend.Scrapping.Page do
  use Ecto.Migration

  def change do
    create table(:pages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :domain, :string

      timestamps()
    end

  end
end
