@echo off
SETLOCAL

REM Check if the correct number of arguments are provided
IF "%~2"=="" (
    echo Usage: run_docker.bat ^<directory^> ^<image-name^>
    exit /b 1
)

REM Get the directory and image name from the command line arguments
SET "DIRECTORY=%~1"
SET "IMAGE_NAME=%~2"

REM Build the Docker image
docker build -t %IMAGE_NAME% .

REM Run the Docker command
docker run -it -v %DIRECTORY%:/app %IMAGE_NAME% /bin/bash