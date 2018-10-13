defmodule ChatTestTaskWeb.LoginController do
  use ChatTestTaskWeb, :controller

  @doc """
    Главная страница с предложением ввести имя пользователя
  """
  def index(conn, _params) do
    username = get_session(conn, :username)
    render(conn, "index.html", username: username)
  end

  @doc """
    Сохраняет имя пользователя в сессии, в случае упеха редиректит на /chats
  """
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
