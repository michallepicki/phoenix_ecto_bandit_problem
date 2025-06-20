defmodule HelloWeb.ThingController do
  use HelloWeb, :controller

  alias Hello.Some
  alias Hello.Some.Thing

  action_fallback HelloWeb.FallbackController

  def index(conn, _params) do
    things = Some.list_things()
    render(conn, :index, things: things)
  end

  def create(conn, %{"thing" => thing_params}) do
    with {:ok, %Thing{} = thing} <- Some.create_thing(thing_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/things/#{thing}")
      |> render(:show, thing: thing)
    end
  end

  def show(conn, %{"id" => id}) do
    thing = Some.get_thing!(id)
    render(conn, :show, thing: thing)
  end

  def update(conn, %{"id" => id, "thing" => thing_params}) do
    thing = Some.get_thing!(id)

    with {:ok, %Thing{} = thing} <- Some.update_thing(thing, thing_params) do
      render(conn, :show, thing: thing)
    end
  end

  def delete(conn, %{"id" => id}) do
    thing = Some.get_thing!(id)

    with {:ok, %Thing{}} <- Some.delete_thing(thing) do
      send_resp(conn, :no_content, "")
    end
  end
end
