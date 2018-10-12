defmodule ChatTestTaskWeb.PageControllerTest do
  use ChatTestTaskWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    # input with name 'username'
    assert html_response(conn, 200) =~ ~S[<input type="text" class="form-control" name="username"]
  end

  test "POST / with valid username", %{conn: conn} do
    conn = post(conn, "/", %{username: "asdf"})
    html_response(conn, 302)
    assert get_session(conn, :username) == "asdf"
    assert get_flash(conn, :info) == "Добро пожаловать: asdf!"
  end

  test "POST / with invalid username", %{conn: conn} do
    conn = post(conn, "/", %{username: ""})
    html_response(conn, 302)
    assert get_flash(conn, :error) == "Неверное имя пользователя!"
  end
end
