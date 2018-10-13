defmodule ChatTestTaskWeb.ChatChannel do
  use Phoenix.Channel
  alias ChatTestTaskWeb.{MessageService}

  def join("chat:" <> _chat_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", message, socket) do
    "chat:" <> chat_id = socket.topic
    MessageService.create(chat_id, message)
    broadcast!(socket, "new_msg", message)
    {:noreply, socket}
  end
end
