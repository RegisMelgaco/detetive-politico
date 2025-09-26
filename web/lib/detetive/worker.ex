defmodule Detetive.Worker do
  require Logger

  alias Detetive.Knowledge.Politician
  alias Detetive.Repo

  def start_link() do
    pid = Kernel.spawn(&update/0)

    {:ok, pid}
  end

  defp update() do
    timestamp =
      DateTime.now!("Etc/UTC")
      |> DateTime.truncate(:second)

    placeholders = %{timestamp: timestamp}

    get_politicians()
    |> Stream.each(fn ps -> Repo.insert_all(Politician, ps, placeholders: placeholders, on_conflict: :replace_all) end)
    |> Stream.run()

    Process.sleep(60_000)

    update()
  end

  defp get_politicians() do
    Stream.unfold(1, &request_politicians/1)
  end

  defp request_politicians(page) do
    url = "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome&pagina=#{page}&itens=10"

    Logger.debug("Requesting deputados: page #{page}")

    ps = Req.get!(url).body["dados"]
    |> Enum.map(fn d -> d["id"] end)
    |> Enum.map(fn id -> 
      Logger.debug("Requesting deputado info: id #{id}")
      Req.get!("https://dadosabertos.camara.leg.br/api/v2/deputados/#{id}").body["dados"]
    end)
    |> Enum.map(fn d -> %{
      id: d["id"],
      name: d["nomeCivil"],
      gender: d["sexo"],
      birth_date: Date.from_iso8601!(d["dataNascimento"]),
      birth_at: "#{d["municipioNascimento"]}/#{d["ufNascimento"]}",
      photo_url: d["ultimoStatus"]["urlFoto"],
      party: d["ultimoStatus"]["siglaPartido"],

      inserted_at: {:placeholder, :timestamp},
      updated_at: {:placeholder, :timestamp}
    } end)

    Logger.debug("Deputados receaved: count #{length(ps)}")

    if length(ps) > 0 do
      {ps, page+1}
    else
      nil
    end

  end

  def child_spec(_opts) do
    %{
      id: Detetive.Worker,
      start: {Detetive.Worker, :start_link, []},
      type: :worker,
    }
  end
end
