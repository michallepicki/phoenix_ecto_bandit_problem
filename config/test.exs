import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :hello, Hello.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hello_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :hello, sql_sandbox: true

config :hello, HelloWeb.Endpoint,
  http: [
    # this possibly increases the chance of encountering the errors?
    #
    thousand_island_options: [num_acceptors: 1],
    #
    # possibly this setting works-around most of errors?
    # (apart from occasional "(Req.TransportError) socket closed" errors)
    #
    # http_1_options: [max_requests: 1],
    #
    ip: {127, 0, 0, 1},
    port: 4002
  ],
  secret_key_base: "i33y2k9pbKm6f4MphdUnszI2uptfB4Vp66IG584XOCwAq/Gm/0LEsZuktgSKEw5m",
  server: true

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
