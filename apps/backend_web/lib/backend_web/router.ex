defmodule CP.Web.Router do
  use CP.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CP.Web do
    pipe_through :api
  end

  scope "/scrapper", CP.Web do
    pipe_through :api

    resources "/pages", PageController, except: [:new, :edit]
  end
end
