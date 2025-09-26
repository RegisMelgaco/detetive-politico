defmodule Detetive.Knowledge.Politician do
  use Ecto.Schema
  import Ecto.Changeset

  schema "politicians" do
    field :name, :string
    field :gender, :string
    field :social_media, :string
    field :web_site, :string
    field :birth_date, :date
    field :birth_at, :string
    field :photo_url, :string
    field :party, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(politician, attrs) do
    politician
    |> cast(attrs, [:name, :gender, :social_media, :web_site, :birth_date, :birth_at, :photo_url, :party])
    |> validate_required([:name, :gender, :social_media, :web_site, :birth_date, :birth_at, :photo_url, :party])
  end
end
