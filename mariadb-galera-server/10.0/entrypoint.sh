#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# If the command start with an option prepend 'mysqld'
if [ "${1:0:1}" = '-' ]; then
  set -- mysqld "$@"
fi

exec "$@"
