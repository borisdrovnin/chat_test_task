defmodule ChatTestTaskWeb.MessageService do
  @moduledoc """
    Модуль содержит вспомогательные методы для работы с сообщениями в чате
  """

  alias ChatTestTask.{Repo, Chat, Message}

  @doc """
    Получить все сообщения из чата с идентификатором `chat_id`
    Возвращает ассоциативный массив с соответствующим чатом и списком сообщений
  """
  def get_messages_from_chat(chat_id) do
    chat = Repo.get(Chat, chat_id)
    query = Ecto.assoc(chat, :messages)
    messages = Repo.all(query)
    %{chat: chat, messages: messages}
  end

  @doc """
    Создать сообщение в чате с идентификатором `chat_id`
    с именем пользователя `username` и содержимым `content`
  """
  def create(chat_id, %{"username" => username, "content" => content}) do
    chat = Repo.get(Chat, chat_id)

    message =
      Ecto.build_assoc(
        chat,
        :messages,
        %Message{username: username, content: content}
      )

    Repo.insert!(message)
  end
end
