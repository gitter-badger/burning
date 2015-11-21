#!/bin/bash

# Modify the MySQL settings below so they will match your own.
MYSQL_USERNAME="root"
MYSQL_PASSWORD="root"
MYSQL_HOST="localhost"
MYSQL_DB_NAME="burning"

# Modify the login details below to be the desired login details for the Administrator account.
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="admin"
ADMIN_EMAIL="admin@example.com"

# Set the base url of the site address.
BASE_DOMAIN_URL="http://localhost/burning/www"

chmod 777 www/sites/default
rm -rf www/
mkdir www

bash scripts/build.sh

cd www

drush si -y burning --account-name=$ADMIN_USERNAME --account-pass=$ADMIN_PASSWORD --account-mail=$ADMIN_EMAIL --db-url=mysql://$MYSQL_USERNAME:$MYSQL_PASSWORD@$MYSQL_HOST/$MYSQL_DB_NAME --uri=$BASE_DOMAIN_URL burning_migrate_content.dummy_content=TRUE

# These commands migrates dummy content and is used for development and testing.
# Comment out both lines if you wish to have a clean OpenScholar installation.
#drush mi --all --user=1

drush cc all
drush uli --uri=$BASE_DOMAIN_URL
