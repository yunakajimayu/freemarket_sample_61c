# server "db.example.com", user: "deploy", roles: %w{db}
server "52.198.209.142", user: "ec2-user", roles: %w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"
set :BASIC_AUTH_USER, "production"
set :BASIC_AUTH_PASSWORD, "production"
# role-based syntax
# ==================