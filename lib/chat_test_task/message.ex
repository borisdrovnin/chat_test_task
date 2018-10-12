defmodule ChatTestTask.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field(:content, :string)
    field(:username, :string)
    belongs_to(:chat, ChatTestTask.Chat)

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:username, :content])
    |> validate_required([:username, :content])
  end
end
