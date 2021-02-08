use Mix.Config

config :core, ecto_repos: [Core.Repo]

config :logger,
  backends: [LogflareLogger.HttpBackend, {LoggerFileBackend, :info_log}, :console],
  utc_log: true,
  truncate: 4096,
  level: :info,
  sync_threshold: 500,
  discard_threshold: 500

config :logger, :info_log,
  path: "log/thelog.log",
  level: :info

config :logflare_logger_backend,
  # Default LogflareLogger level is :info. Note that log messages are filtered by the :logger application first
  level: :info,
  api_key: "---",
  source_id: "---",
  # minimum time in ms before a log batch is sent to the server ",
  flush_interval: 1_000,
  # maximum number of events before a log batch is sent to the server
  max_batch_size: 50

import_config "#{Mix.env}.exs"
