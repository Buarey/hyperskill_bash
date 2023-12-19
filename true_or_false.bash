#!/bin/bash

echo "Welcome to the True or False Game!"

curl http://127.0.0.1:8000/download/file.txt --silent --output <ID_card.txt>
cat ID_card.txt