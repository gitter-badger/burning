#!/bin/bash
set -xe

usage()
{
cat << EOF
usage: $0 options

This script builds the burning application.

OPTIONS:
   -h      Show this message
   -d      docroot directory name defaults to 'www'
   -o      Directory to include OPS modules, not included otherwise ex. 'sites/default/'
EOF
}

DOCROOT="www"
OPSDIR=
while getopts ":hd:o:" OPTION
do
     case $OPTION in
         h ) usage
             exit 1;;
         d ) DOCROOT=$OPTARG;;
         o ) OPSDIR=$OPTARG;;
         ? ) usage
             exit;;
     esac
done

# Drush executable.
[[ $DRUSH && ${DRUSH-x} ]] || DRUSH=drush

# Build base.
[[ $BUILD_ROOT && ${BUILD_ROOT-x} ]] || BUILD_ROOT="."

# Move to the top directory.
ROOT="$(dirname $0)/.."
cd $ROOT

# Chores.
(
  for DIR in $BUILD_ROOT/www-build sites-backup burning/1 burning/modules/contrib burning/themes/contrib burning/libraries; do
    rm -Rf $DIR
  done
)

# Build the profile itself.
(
  cd burning
  $DRUSH make --no-core --contrib-destination drupal-org.make .
  cd ..
)

# Build core and move the profile in place.
(
  # Build core.
  $DRUSH make burning/drupal-org-core.make $BUILD_ROOT/www-build

  # Check if sites/default exists, which means it is an existing installation.
  if [ -d $BUILD_ROOT/$DOCROOT/sites/default ]; then
    cp -rp $BUILD_ROOT/$DOCROOT/sites/default sites-backup
  fi

  # Restore the sites directory.
  if [ -d sites-backup ]; then
    rm -Rf $BUILD_ROOT/www-build/sites/default
    mv sites-backup/ $BUILD_ROOT/www-build/sites/default
  fi

  # Move the profile in place.
  ln -s ../../burning $BUILD_ROOT/www-build/profiles/burning

  # Fix permisions before deleting.
  chmod -R +w $BUILD_ROOT/$DOCROOT/sites/* || true
  rm -Rf $BUILD_ROOT/$DOCROOT || true

  # Restore updated site.
  mv $BUILD_ROOT/www-build $BUILD_ROOT/$DOCROOT
)

CUR_DIR=$(pwd)
#Build the ops profile
(
  if [ -n "$OPSDIR" ] && [ -d $BUILD_ROOT/$DOCROOT/$OPSDIR ] ; then
    cd $BUILD_ROOT/$DOCROOT/$OPSDIR
    $DRUSH make --no-core --contrib-destination $CUR_DIR/$BUILD_ROOT/burning/os-ops.make .
    cd $CUR_DIR
  fi
)

#Download behat.
(
  cd burning/behat
  curl -s https://getcomposer.org/installer | php
  php composer.phar install
)

# Download libraries.
(
  cd $ROOT
  rm -rf burning/modules/burning/burning_core/composer
  curl -s https://getcomposer.org/installer | php
  php composer.phar install
  cd $ROOT
)
