defmodule ChatTestTask.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field(:title, :string)
    has_many(:messages, ChatTestTask.Message)

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
