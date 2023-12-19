#!/bin/bash

stage_one () {

	curl http://127.0.0.1:8000/download/file.txt --silent --output <ID_card.txt>
	cat ID_card.txt
}

echo "Welcome to the True or False Game!"

curl http://127.0.0.1:8000/download/login --silent --cookie-jar cookie.txt --user <username:password>
echo "Login message: the-message-from-endpoint"