defmodule DetetiveWeb.PoliticianLive.Index do
  use DetetiveWeb, :live_view

  alias Detetive.Knowledge

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :politicians, Knowledge.list_politicians())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Politicians")
    |> assign(:politician, nil)
  end

  @impl true
  def handle_info({DetetiveWeb.PoliticianLive.FormComponent, {:saved, politician}}, socket) do
    {:noreply, stream_insert(socket, :politicians, politician)}
  end
end
