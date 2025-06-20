defmodule HelloWeb.Integration.EFGHTest do
  use HelloWeb.IntegrationCase, async: true

  setup %{req: req} do
    req = Req.Request.put_header(req, "accept", "application/json")

    {:ok, req: req}
  end

  test "create a few things, then list them all", %{req: req} do
    names = ["e", "f", "g", "h"]
    for name <- names do
      response = Req.post!(req, url: ~p"/api/things", json: %{thing: %{name: name}})
      assert response.status == 201
      assert %{"id" => _} = response.body["data"]
    end

    response = Req.get!(req, url: ~p"/api/things")
    assert response.status == 200
    assert ^names = Enum.map(response.body["data"], & &1["name"]) |> Enum.sort()
  end
end
