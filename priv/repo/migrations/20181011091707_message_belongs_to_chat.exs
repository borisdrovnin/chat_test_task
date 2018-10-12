defmodule ChatTestTask.Repo.Migrations.MessageBelongsToChat do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :chat_id, references(:chats)
    end
  end
end
