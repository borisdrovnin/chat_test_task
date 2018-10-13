defmodule ChatTestTaskWeb.ChatController do
  use ChatTestTaskWeb, :controller
  alias ChatTestTask.{Repo, Chat}
  alias ChatTestTaskWeb.{MessageService}

  @doc """
    Отображает список чатов
  """
  def index(conn, _params) do
    username = get_session(conn, :username)
    render(conn, "index.html", username: username, chats: Repo.all(Chat))
  end

  @doc """
    Создаёт чат, принимает один параметр `title` - название чата
  """
  def create(conn, %{"title" => title}) do
    Chat.changeset(%Chat{}, %{title: title})
    |> Repo.insert()

    redirect(conn, to: "/chats")
  end

  @doc """
    Отображает список сообщений в чате
  """
  def show(conn, %{"id" => id}) do
    %{messages: messages, chat: chat} = MessageService.get_messages_from_chat(id)
    username = get_session(conn, :username)
    render(conn, "show.html", messages: messages, chat: chat, username: username)
  end
end
