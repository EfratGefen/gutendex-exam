#!/bin/bash

# Wait for PostgreSQL to start
DATABASE_HOST=${DATABASE_HOST:-"postgres"}
DATABASE_PORT=${DATABASE_PORT:-"5432"}

echo "Waiting for PostgreSQL to start..."
until nc -z -v -w30 $DATABASE_HOST $DATABASE_PORT; do
  echo "Unable to connect to $DATABASE_HOST:$DATABASE_PORT. Waiting 5 seconds..."
  sleep 5
done

echo "PostgreSQL is up, applying migrations..."
python manage.py migrate  # הרצת המיגרציות

echo "Collecting static files..."
python manage.py collectstatic --noinput  # אוסף קבצים סטטיים

echo "Starting Django..."
python manage.py runserver 0.0.0.0:8000  # מפעיל את Django
