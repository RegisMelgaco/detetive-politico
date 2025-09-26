defmodule DetetiveWeb.PoliticianLiveTest do
  use DetetiveWeb.ConnCase

  import Phoenix.LiveViewTest
  import Detetive.KnowledgeFixtures

  @create_attrs %{name: "some name", gender: "some gender", social_media: "some social_media", web_site: "some web_site", birth_date: "2025-09-25", birth_at: "some birth_at", photo_url: "some photo_url", party: "some party"}
  @update_attrs %{name: "some updated name", gender: "some updated gender", social_media: "some updated social_media", web_site: "some updated web_site", birth_date: "2025-09-26", birth_at: "some updated birth_at", photo_url: "some updated photo_url", party: "some updated party"}
  @invalid_attrs %{name: nil, gender: nil, social_media: nil, web_site: nil, birth_date: nil, birth_at: nil, photo_url: nil, party: nil}

  defp create_politician(_) do
    politician = politician_fixture()
    %{politician: politician}
  end

  describe "Index" do
    setup [:create_politician]

    test "lists all politicians", %{conn: conn, politician: politician} do
      {:ok, _index_live, html} = live(conn, ~p"/politicians")

      assert html =~ "Listing Politicians"
      assert html =~ politician.name
    end

    test "saves new politician", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/politicians")

      assert index_live |> element("a", "New Politician") |> render_click() =~
               "New Politician"

      assert_patch(index_live, ~p"/politicians/new")

      assert index_live
             |> form("#politician-form", politician: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#politician-form", politician: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/politicians")

      html = render(index_live)
      assert html =~ "Politician created successfully"
      assert html =~ "some name"
    end

    test "updates politician in listing", %{conn: conn, politician: politician} do
      {:ok, index_live, _html} = live(conn, ~p"/politicians")

      assert index_live |> element("#politicians-#{politician.id} a", "Edit") |> render_click() =~
               "Edit Politician"

      assert_patch(index_live, ~p"/politicians/#{politician}/edit")

      assert index_live
             |> form("#politician-form", politician: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#politician-form", politician: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/politicians")

      html = render(index_live)
      assert html =~ "Politician updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes politician in listing", %{conn: conn, politician: politician} do
      {:ok, index_live, _html} = live(conn, ~p"/politicians")

      assert index_live |> element("#politicians-#{politician.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#politicians-#{politician.id}")
    end
  end

  describe "Show" do
    setup [:create_politician]

    test "displays politician", %{conn: conn, politician: politician} do
      {:ok, _show_live, html} = live(conn, ~p"/politicians/#{politician}")

      assert html =~ "Show Politician"
      assert html =~ politician.name
    end

    test "updates politician within modal", %{conn: conn, politician: politician} do
      {:ok, show_live, _html} = live(conn, ~p"/politicians/#{politician}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Politician"

      assert_patch(show_live, ~p"/politicians/#{politician}/show/edit")

      assert show_live
             |> form("#politician-form", politician: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#politician-form", politician: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/politicians/#{politician}")

      html = render(show_live)
      assert html =~ "Politician updated successfully"
      assert html =~ "some updated name"
    end
  end
end
