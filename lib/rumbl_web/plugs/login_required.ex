defmodule RumblWeb.LoginRequired do
  import Plug.Conn
  use RumblWeb, :controller

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Please sign in to continue")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end