defmodule Bureau.Repo do
  use Ecto.Repo,
    otp_app: :bureau,
    adapter: Ecto.Adapters.SQLite3
end
