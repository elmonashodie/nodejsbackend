#!/bin/bash

file=./.env
if [ -f "$file" ]; then
  echo "WARNING: Files already exist are you sure you want to overwrite with new passwords?"
  read -p "Continue (y/n)?" choice
  if [[ ! $choice =~ ^[Yy]$ ]]
  then
      echo "Exit"
      exit
  fi
fi

if [[ $# -eq 0 ]]; then
  echo "No arguments suplied"
  echo "prod  for production"
  echo "dev   for development"
  exit
elif [ "$1" == "prod" ]; then
  echo "Creating production credentials."
  MONGO_USERNAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
  MONGO_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1)
  MONGO_ROOT=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1)
  SESSION=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1)
  NODE_ENV=production
elif [ "$1" == 'dev' ]; then
  echo "Creating development credentials."
  MONGO_USERNAME=dev
  MONGO_PASSWORD=password
  MONGO_ROOT=password
  SESSION=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1)
  NODE_ENV=development
else
  echo "Unknown parameter"
  echo "prod  for production"
  echo "dev   for development"
  exit
fi

mkdir cert
openssl genpkey -algorithm RSA -out ./cert/private_key.pem -pkeyopt rsa_keygen_bits:2048
openssl rsa -pubout -in ./cert/private_key.pem -out ./cert/public_key.pem

cat > .env <<EOF
#!/usr/bin/env bash
# MongoDB
MONGO_USERNAME=$MONGO_USERNAME
MONGO_PASSWORD=$MONGO_PASSWORD
MONGO_ROOT=$MONGO_ROOT
SESSION=$SESSION
NODE_ENV=$NODE_ENV
GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=
EOF

echo "Start with: docker-compose up"