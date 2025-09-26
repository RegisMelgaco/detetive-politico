defmodule DetetiveWeb.PoliticianLive.Show do
  use DetetiveWeb, :live_view

  alias Detetive.Knowledge

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:politician, Knowledge.get_politician!(id))}
  end

  defp page_title(:show), do: "Show Politician"
end
