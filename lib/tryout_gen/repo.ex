defmodule TryoutGen.Repo do
  use Ecto.Repo,
    otp_app: :tryout_gen,
    adapter: Ecto.Adapters.Postgres
end
