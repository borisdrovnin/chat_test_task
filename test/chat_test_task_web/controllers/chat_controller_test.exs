defmodule ChatTestTaskWeb.ChatControllerTest do
  use ChatTestTaskWeb.ConnCase
  import Ecto.Query

  alias ChatTestTask.{Repo, Chat, Message}

  test "GET /chats", %{conn: conn} do
    Repo.insert(%Chat{title: "title1"})
    Repo.insert(%Chat{title: "title2"})
    conn = get(conn, "/chats")
    # must include title1 and title2
    assert String.contains?(html_response(conn, 200), "title1")
    assert String.contains?(html_response(conn, 200), "title2")
  end

  test "POST /chats", %{conn: conn} do
    conn = post(conn, "/chats", %{title: "new title"})
    # assert redirect
    html_response(conn, 302)
    assert Repo.one(from(c in Chat, select: count(c.id))) == 1
    assert Repo.one(from(c in Chat)).title == "new title"
  end

  test "GET /chats/:id with no messages", %{conn: conn} do
    chat = Repo.insert!(%Chat{title: "title1"})
    conn = get(conn, "/chats/#{chat.id}")
    # no messages
    refute String.contains?(html_response(conn, 200), "<li class=\"list-group-item\">")
  end

  test "GET /chats/:id with messages", %{conn: conn} do
    chat = Repo.insert!(%Chat{title: "title1"})

    msg1 =
      Ecto.build_assoc(chat, :messages, %Message{username: "foobar", content: "message content"})

    msg2 =
      Ecto.build_assoc(chat, :messages, %Message{username: "foobar", content: "another message"})

    Repo.insert!(msg1)
    Repo.insert!(msg2)
    conn = get(conn, "/chats/#{chat.id}")
    assert String.contains?(html_response(conn, 200), "message content")
    assert String.contains?(html_response(conn, 200), "another message")
  end
end
