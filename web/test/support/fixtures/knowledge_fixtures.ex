defmodule Detetive.KnowledgeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Detetive.Knowledge` context.
  """

  @doc """
  Generate a politician.
  """
  def politician_fixture(attrs \\ %{}) do
    {:ok, politician} =
      attrs
      |> Enum.into(%{
        birth_at: "some birth_at",
        birth_date: ~D[2025-09-25],
        gender: "some gender",
        name: "some name",
        party: "some party",
        photo_url: "some photo_url",
        social_media: "some social_media",
        web_site: "some web_site"
      })
      |> Detetive.Knowledge.create_politician()

    politician
  end
end
