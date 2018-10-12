defmodule ChatTestTaskWeb.Router do
  use ChatTestTaskWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ChatTestTaskWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", LoginController, :index)
    post("/", LoginController, :login)
    get("/chats", ChatController, :index)
    post("/chats", ChatController, :create)
    get("/chats/:id", ChatController, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatTestTaskWeb do
  #   pipe_through :api
  # end
end
