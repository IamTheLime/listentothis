defmodule Listentothis.Auth do
    import Phoenix.Controller 
    alias Rumbl.Router.Helpers
    import Plug.Conn
    import Comeonin.Pbkdf2, only: [checkpw: 2, dummy_checkpw: 0]
    require IEx
    #The result of the init function is passed on to the call function of the same plug,
    #in this case the init function receives the module name of the repository and delivers
    #it to the call function
    
    def init(opts) do
        Keyword.fetch!(opts, :repo)
    end

    # As this plug is called in the browser pipeline this verification happens each time the url is called
    #
    def call(conn, repo) do
        user_id = get_session(conn, :user_id)
        user = user_id && repo.get(Listener.User, user_id)
        assign(conn, :current_user, user)
    end

    #### No longer in the realm of the plug

    # Responsible for atributing a valid user to an asign of the page
    def login(conn,user) do
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
    end

    # verifies the validity of a login
    def login_user_pass(conn, username, pass, opts) do
        repo = Keyword.fetch! opts, :repo
        user = repo.get_by(Listener.User, username: username)

        cond do
            user && checkpw(pass, user.password_hash) ->
                {:ok, login(conn, user)}
            user ->
                {:error, :unauthorized, conn}
            true ->
                dummy_checkpw()
                {:error, :not_found, conn} 
        end
    end

    # verifies if the an user is connected with validity
    def authenticate_user(conn, _opts) do
        if conn.assigns.current_user do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in to access that page")
            |> redirect(to: Helpers.page_path(conn, :index))
            |> halt()
        end
    end

    def logout(conn) do
        configure_session(conn, drop: true)
    end

end