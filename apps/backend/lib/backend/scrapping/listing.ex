defmodule Backend.Scrapping.Listing do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Scrapping.Listing

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "listings" do
    field :domain, :string
    field :url, :string
    field :n_views, :integer

    timestamps()
  end

  @doc false
  def changeset(%Listing{} = listing, attrs) do
    listing
    |> cast(attrs, [:url, :domain])
    |> validate_required([:url, :domain])
  end
end
