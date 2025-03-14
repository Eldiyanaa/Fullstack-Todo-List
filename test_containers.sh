#!/bin/bash

echo "Checking running containers..."
docker ps
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Testing Frontend..."
if curl -s --head http://localhost:80 | grep "200 OK" > /dev/null; then
   echo -e "${GREEN}Frontend is working!${NC}"
else
   echo -e "${RED}Frontend test failed.${NC}"
fi

echo "Testing Backend..."
if curl -s --head http://localhost:3000 | grep "200 OK" > /dev/null; then
   echo -e "${GREEN}Backend is working!${NC}"
else
   echo -e "${RED}Backend test failed.${NC}"
fi
echo "Testing backend API..."
curl -I http://localhost:3000

echo "Checking database connection..."
docker exec -it fd7e8e188153 mongosh --eval "show dbs"

#docker exec -it c9948493c20e mongosh -u user -p password --eval "show dbs"
#docker exec -it c9948493c20e cat /etc/mongod.conf


#echo "Checking database connection..."
#docker exec -it <c9948493c20e> mongodb -uuser -ppassword -e "SHOW DATABASES;"