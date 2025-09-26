defmodule Detetive.Repo.Migrations.CreatePoliticians do
  use Ecto.Migration

  def change do
    create table(:politicians) do
      add :name, :string
      add :gender, :string
      add :social_media, :string
      add :web_site, :string
      add :birth_date, :date
      add :birth_at, :string
      add :photo_url, :string
      add :party, :string

      timestamps(type: :utc_datetime)
    end
  end
end
