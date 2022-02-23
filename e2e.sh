#!/bin/bash

cd e2e

docker-compose down > /dev/null 2>&1

#sleep 10

docker-compose build
docker-compose up -d

docker-compose ps

docker-compose run --rm e2e

if [ $? -eq 0 ]
then
  echo "---------------------------------------"
  echo "INTEGRATION TESTS PASSED....."
  echo "---------------------------------------"
  docker-compose down
  exit 0
else
  echo "---------------------------------------"
  echo "INTEGRATION TESTS FAILED....."
  echo "---------------------------------------"
  docker-compose down
  exit 1
fi

#docker-compose down
