import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shady_urls, ShadyUrlsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "JGWJ93TzZac5S9VBkm5eE/CsqnRwJZLrs6wSzGxSGK9cZ8WZs6EunxQSe+qsaZOl",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
