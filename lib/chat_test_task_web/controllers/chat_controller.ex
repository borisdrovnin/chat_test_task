defmodule ChatTestTaskWeb.ChatController do
  use ChatTestTaskWeb, :controller
  alias ChatTestTask.{Repo, Chat}

  def index(conn, _params) do
    username = get_session(conn, :username)
    render(conn, "index.html", username: username, chats: Repo.all(Chat))
  end

  def create(conn, %{"title" => title}) do
    Chat.changeset(%Chat{}, %{title: title})
    |> Repo.insert()

    redirect(conn, to: "/chats")
  end

  def show(conn, %{"id" => id}) do
    chat = Repo.get(Chat, id)
    query = Ecto.assoc(chat, :messages)
    messages = Repo.all(query)
    render(conn, "show.html", messages: messages, chat: chat)
  end
end
