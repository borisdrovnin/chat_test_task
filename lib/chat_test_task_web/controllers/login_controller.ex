defmodule ChatTestTaskWeb.LoginController do
  use ChatTestTaskWeb, :controller

  def index(conn, _params) do
    username = get_session(conn, :username)
    render(conn, "index.html", username: username)
  end

  def login(conn, %{"username" => username}) do
    if Regex.match?(~r/(\w|\d)+/, username) do
      put_session(conn, :username, username)
      |> put_flash(:info, "Добро пожаловать: #{username}!")
      |> redirect(to: "/chats")
    else
      conn
      |> put_flash(:error, "Неверное имя пользователя!")
      |> redirect(to: "/")
    end
  end
end
