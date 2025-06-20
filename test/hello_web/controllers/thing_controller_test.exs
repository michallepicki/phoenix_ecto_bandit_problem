defmodule HelloWeb.ThingControllerTest do
  use HelloWeb.ConnCase

  import Hello.SomeFixtures
  alias Hello.Some.Thing

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all things", %{conn: conn} do
      conn = get(conn, ~p"/api/things")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create thing" do
    test "renders thing when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/things", thing: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/things/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/things", thing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update thing" do
    setup [:create_thing]

    test "renders thing when data is valid", %{conn: conn, thing: %Thing{id: id} = thing} do
      conn = put(conn, ~p"/api/things/#{thing}", thing: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/things/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, thing: thing} do
      conn = put(conn, ~p"/api/things/#{thing}", thing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete thing" do
    setup [:create_thing]

    test "deletes chosen thing", %{conn: conn, thing: thing} do
      conn = delete(conn, ~p"/api/things/#{thing}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/things/#{thing}")
      end
    end
  end

  defp create_thing(_) do
    thing = thing_fixture()

    %{thing: thing}
  end
end
