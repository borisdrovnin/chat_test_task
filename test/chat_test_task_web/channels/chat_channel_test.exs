defmodule ChatTestTaskWeb.ChatChannelTest do
  use ChatTestTaskWeb.ChannelCase
  import Ecto.Query

  alias ChatTestTaskWeb.ChatChannel
  alias ChatTestTask.{Repo, Chat, Message}

  setup do
    new_chat = Repo.insert!(%Chat{title: "asdf"})
    topic = "chat:#{new_chat.id}"

    {:ok, _, socket} =
      socket()
      |> subscribe_and_join(ChatChannel, topic)

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    push(socket, "new_msg", %{"content" => "data", "username" => "user1"})
    assert_broadcast("new_msg", %{"content" => "data", "username" => "user1"})

    assert Repo.one(from(c in Message, select: count(c.id))) == 1
    assert Repo.one(from(c in Message)).content == "data"
    assert Repo.one(from(c in Message)).username == "user1"
  end
end
