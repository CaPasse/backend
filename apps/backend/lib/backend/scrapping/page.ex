defmodule Backend.Scrapping.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Scrapping.Page

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pages" do
    field :url, :string
    field :domain, :string

    timestamps()
  end

  @doc false
  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:url, :domain,])
    |> unique_constraint(:unique_url_domain_constraint, name: :unique_url_domain_index)
    |> validate_required([:url, :domain,])
  end
end
