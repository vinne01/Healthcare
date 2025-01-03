#!/bin/bash

# Exit if any command fails
set -e

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Run migrations (important to set up the database schema)
echo "Running migrations..."
python manage.py migrate --noinput

# Collect static files for production
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Create superuser if it doesn't exist (optional)
echo "Creating superuser..."
python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username="admin").exists():
    User.objects.create_superuser("admin", "admin@example.com", "password")
EOF

# Run tests (optional)
# echo "Running tests..."
# python manage.py test

echo "Build completed successfully."
