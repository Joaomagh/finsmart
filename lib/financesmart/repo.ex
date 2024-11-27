defmodule Financesmart.Repo do
  use Ecto.Repo,
    otp_app: :financesmart,
    adapter: Ecto.Adapters.Postgres
end
