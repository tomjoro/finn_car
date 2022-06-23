defmodule FinnCar.Repo do
  use Ecto.Repo,
    otp_app: :finn_car,
    adapter: Ecto.Adapters.Postgres
end
