#!/bin/sh

set -e

mkdir -p /etc/ihatemoney/

SECRET_KEY=`openssl rand -hex 64`
SQLALCHEMY_DATABASE_URI="sqlite:///$SQLITE_DATABASE"

# store env variables in config file
cat <<EOF > /etc/ihatemoney/ihatemoney.cfg
DEBUG = False
SQLALCHEMY_DATABASE_URI = "$SQLALCHEMY_DATABASE_URI"
SQLACHEMY_DEBUG = DEBUG
SQLALCHEMY_TRACK_MODIFICATIONS = False
SECRET_KEY = '$SECRET_KEY'
ACTIVATE_DEMO_PROJECT = $ACTIVATE_DEMO_PROJECT
ADMIN_PASSWORD = '$ADMIN_PASSWORD'
ALLOW_PUBLIC_PROJECT_CREATION = $ALLOW_PUBLIC_PROJECT_CREATION
ACTIVATE_ADMIN_DASHBOARD = $ACTIVATE_ADMIN_DASHBOARD
EOF

# trigger database initialization
ihatemoney --help

# execute crate table + trigger statements for bill tracking
sqlite3 $SQLITE_DATABASE < /bin/trigger_bill_update.sql

# start dev server (for now; gunicorn would be better)
ihatemoney runserver --host 0.0.0.0 --port 80