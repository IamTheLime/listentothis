defmodule Listentothis.Repo do
  use Ecto.Repo, 
    otp_app: :listentothis,
    adapter: Ecto.Adapters.Postgres

  # @doc """
  # Dynamically loads the repository url from the
  # DATABASE_URL environment variable.
  # """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  # def all(_module), do: []

  # def get(:user, id) do
  #   Enum.find all(:users), fn userDetails -> Map.get(userDetails, :id) == id end
  # end

  # def get_by(module, params) do
  #   Enum.find all(module),
  #   fn userDetails ->
  #       Enum.all?(params, fn {key, val} -> Map.get(userDetails, key) == val end)
  #   end
  # end

end
