defmodule TryoutGen.Repo.Migrations.Events do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
    end
  end
end
