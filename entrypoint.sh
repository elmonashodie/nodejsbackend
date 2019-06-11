#!/bin/ash
set -e

echo "Starting in $NODE_ENV environment"
if [ "$NODE_ENV" == "development" ]
then
  npm run dev
else
  npm run start
fi