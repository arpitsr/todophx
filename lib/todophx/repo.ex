defmodule Todophx.Repo do
  use Ecto.Repo,
    otp_app: :todophx,
    adapter: Ecto.Adapters.SQLite3
end
