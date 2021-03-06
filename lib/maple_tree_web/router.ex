defmodule MapleTreeWeb.Router do
  use MapleTreeWeb, :router

  import MapleTreeWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MapleTreeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :set_user_theme
    plug :set_user_locale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :group_guard do
    plug :belongs_to_group
  end

  scope "/", MapleTreeWeb do
    pipe_through :browser

    # landing
    live "/", PageLive, :index
    live "/users/register", UserRegistrationLive, :new
  end

  scope "/", MapleTreeWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/shopping-list", ShoppingListLive, :index
  end

  scope "/groups", MapleTreeWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/", GroupsPageLive, :index
    live "/new", NewGroupPageLive, :new
    live "/join/:code", JoinGroupLive, :join
  end

  scope "/group/:group_id", MapleTreeWeb do
    pipe_through [:browser, :group_guard]

    live "/", GroupsDetailsLive, :show
    live "/shopping_list", ShoppingListLive, :index
    live "/shopping_list/new", NewShoppingListLive, :new
    live "/shopping_list/:shopping_list_id", ShoppingListDetailsLive, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", MapleTreeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:browser, :require_authenticated_user]
      live_dashboard "/dashboard", metrics: MapleTreeWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", MapleTreeWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    post "/_form/register/user", UserRegistrationController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", MapleTreeWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", MapleTreeWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
