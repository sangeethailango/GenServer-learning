import Config

config :tryout_gen, TryoutGen.Repo,
  database: "tryout_gen_repo",
  username: "sangeetha",
  password: "pass",
  hostname: "localhost"

config :tryout_gen,
  ecto_repos: [TryoutGen.Repo]
