defmodule HelloWeb.IntegrationCase do
  use ExUnit.CaseTemplate
  alias Phoenix.Ecto.SQL.Sandbox

  using do
    quote do
      use HelloWeb, :verified_routes
    end
  end

  setup tags do
    Hello.DataCase.setup_sandbox(tags)

    sandbox_metadata = Sandbox.encode_metadata(Sandbox.metadata_for(Hello.Repo, self()))
    user_agent = "/" <> sandbox_metadata

    req =
      Req.new(
        base_url: HelloWeb.Endpoint.url(),
        headers: [user_agent: user_agent],
        max_retries: 0
      )

    {:ok, req: req}
  end
end
