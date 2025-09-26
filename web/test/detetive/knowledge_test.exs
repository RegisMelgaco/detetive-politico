defmodule Detetive.KnowledgeTest do
  use Detetive.DataCase

  alias Detetive.Knowledge

  describe "politicians" do
    alias Detetive.Knowledge.Politician

    import Detetive.KnowledgeFixtures

    @invalid_attrs %{name: nil, gender: nil, social_media: nil, web_site: nil, birth_date: nil, birth_at: nil, photo_url: nil, party: nil}

    test "list_politicians/0 returns all politicians" do
      politician = politician_fixture()
      assert Knowledge.list_politicians() == [politician]
    end

    test "get_politician!/1 returns the politician with given id" do
      politician = politician_fixture()
      assert Knowledge.get_politician!(politician.id) == politician
    end

    test "create_politician/1 with valid data creates a politician" do
      valid_attrs = %{name: "some name", gender: "some gender", social_media: "some social_media", web_site: "some web_site", birth_date: ~D[2025-09-25], birth_at: "some birth_at", photo_url: "some photo_url", party: "some party"}

      assert {:ok, %Politician{} = politician} = Knowledge.create_politician(valid_attrs)
      assert politician.name == "some name"
      assert politician.gender == "some gender"
      assert politician.social_media == "some social_media"
      assert politician.web_site == "some web_site"
      assert politician.birth_date == ~D[2025-09-25]
      assert politician.birth_at == "some birth_at"
      assert politician.photo_url == "some photo_url"
      assert politician.party == "some party"
    end

    test "create_politician/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_politician(@invalid_attrs)
    end

    test "update_politician/2 with valid data updates the politician" do
      politician = politician_fixture()
      update_attrs = %{name: "some updated name", gender: "some updated gender", social_media: "some updated social_media", web_site: "some updated web_site", birth_date: ~D[2025-09-26], birth_at: "some updated birth_at", photo_url: "some updated photo_url", party: "some updated party"}

      assert {:ok, %Politician{} = politician} = Knowledge.update_politician(politician, update_attrs)
      assert politician.name == "some updated name"
      assert politician.gender == "some updated gender"
      assert politician.social_media == "some updated social_media"
      assert politician.web_site == "some updated web_site"
      assert politician.birth_date == ~D[2025-09-26]
      assert politician.birth_at == "some updated birth_at"
      assert politician.photo_url == "some updated photo_url"
      assert politician.party == "some updated party"
    end

    test "update_politician/2 with invalid data returns error changeset" do
      politician = politician_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_politician(politician, @invalid_attrs)
      assert politician == Knowledge.get_politician!(politician.id)
    end

    test "delete_politician/1 deletes the politician" do
      politician = politician_fixture()
      assert {:ok, %Politician{}} = Knowledge.delete_politician(politician)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_politician!(politician.id) end
    end

    test "change_politician/1 returns a politician changeset" do
      politician = politician_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_politician(politician)
    end
  end
end
