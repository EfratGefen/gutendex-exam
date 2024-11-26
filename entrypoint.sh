#!/bin/bash

# Set default parameters
DATABASE_HOST=${DATABASE_HOST:-"postgres"}
DATABASE_PORT=${DATABASE_PORT:-"5432"}

echo "Waiting for PostgreSQL to start..."

# Loop to wait until PostgreSQL is up
until nc -z -v -w30 $DATABASE_HOST $DATABASE_PORT
do
  echo "Unable to connect to $DATABASE_HOST:$DATABASE_PORT. Waiting 5 seconds..."
  sleep 5
done

echo "PostgreSQL is up, applying migrations..."

# Apply migrations
python manage.py migrate

echo "Starting Django..."

# Run Django
python manage.py runserver 0.0.0.0:8000
