defmodule ChatTestTask.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :username, :string
      add :content, :text

      timestamps()
    end

  end
end
