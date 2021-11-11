# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :maple_tree, MapleTree.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :maple_tree, MapleTreeWeb.Endpoint,
  server: true,
  url: [scheme: "https", host: "mapletree.app", port: "443"],
  # Use iptables to map to 80 in the OS level
  http: [:inet6, port: "4000"],
  https: [
    :inet6,
    # Use iptables to map to 443 in the OS level
    port: 8443,
    cipher_suite: :compatible,
    keyfile: "priv/ssl/key.pem",
    certfile: "priv/ssl/csr.pem",
    transport_options: [socket_opts: [:inet6]]
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :maple_tree, MapleTreeWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :maple_tree, MapleTreeWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#         transport_options: [socket_opts: [:inet6]]
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :maple_tree, MapleTreeWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.
