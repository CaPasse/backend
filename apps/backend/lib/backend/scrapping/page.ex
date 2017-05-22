defmodule Backend.Scrapping.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Scrapping.Page


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "scrapping_pages" do
    field :data, :map
    field :url, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:url, :website, :data])
    |> validate_required([:url, :website, :data])
  end
end
