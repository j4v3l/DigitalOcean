#!/bin/bash

# Replace 'your_personal_access_token' with your actual Digital Ocean Personal Access Token
ACCESS_TOKEN="your_personal_access_token"

# API Endpoint to list all images
API_URL="https://api.digitalocean.com/v2/images"

# Use curl to make the API request and pipe the output to jq for formatting
if [ -z "$1" ]
then
  curl -s -X GET -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" $API_URL | jq '.'
else
  curl -s -X GET -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" $API_URL | jq --arg search_term "$1" '.images[] | select(.slug | contains($search_term))'
fi

# #!/bin/bash

# # Check the operating system
# OS=$(uname)

# # Install required software based on the operating system
# if [ "$OS" == "Linux" ]; then
#   if ! command -v curl &> /dev/null; then
#     sudo apt-get update
#     sudo apt-get install -y curl
#   fi
#   if ! command -v jq &> /dev/null; then
#     sudo apt-get install -y jq
#   fi
# elif [ "$OS" == "Darwin" ]; then  # Mac OS
#   if ! command -v curl &> /dev/null; then
#     brew install curl
#   fi
#   if ! command -v jq &> /dev/null; then
#     brew install jq
#   fi
# else
#   echo "Unsupported operating system. Please run this script on Linux or Mac OS."
#   exit 1
# fi

# # Replace 'your_personal_access_token' with your actual Digital Ocean Personal Access Token
# ACCESS_TOKEN="your_personal_access_token"

# # API Endpoint to list all images
# API_URL="https://api.digitalocean.com/v2/images"

# # Use curl to make the API request and pipe the output to jq for formatting
# if [ -z "$1" ]
# then
#   curl -s -X GET -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" $API_URL | jq '.'
# else
#   curl -s -X GET -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" $API_URL | jq --arg search_term "$1" '.images[] | select(.slug | contains($search_term))'
# fi