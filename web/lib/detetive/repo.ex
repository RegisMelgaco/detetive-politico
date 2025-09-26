defmodule Detetive.Repo do
  use Ecto.Repo,
    otp_app: :detetive,
    adapter: Ecto.Adapters.SQLite3
end
