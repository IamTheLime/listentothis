defmodule ListentothisWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use ListentothisWeb, :controller
      use ListentothisWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ListentothisWeb
      import Plug.Conn
      import ListentothisWeb.Router.Helpers
      import ListentothisWeb.Gettext
      import Listentothis.Auth, only: [ authenticate_user: 2]
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/listentothis_web/templates",
                        namespace: ListentothisWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ListentothisWeb.Router.Helpers
      import ListentothisWeb.ErrorHelpers
      import ListentothisWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller

      import Listentothis.Auth
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import ListentothisWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
