#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
echo "Removing PID file..."
rm -f ./tmp/pids/server.pid

# wait for db container starting to db migration
echo "Waiting for db..."
dockerize -wait tcp://$DATABASE_HOST:$DATABASE_PORT -timeout 60s

# db migration
echo "Running migrations..."
rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
