@echo off
REM Check if two arguments are provided
IF NOT "%~2"=="" (
  SET ACTION=%~1
  SET ENV=%~2
) ELSE (
  echo Usage: %0 [init|apply|plan|destroy] [dev|prod]
  exit /b 1
)

REM Define the Terraform directory based on the environment
SET TERRAFORM_DIR=terraform-project\environments\%ENV%
REM Define paths for the inventory and playbook files (relative to the Ansible project directory)
SET INVENTORY_FILE=inventory\%ENV%\hosts
SET PLAYBOOK_FILE=playbooks\%ENV%.yml
SET ANSIBLE_PROJECT_DIR=ansible-project

REM Store the initial directory
SET INITIAL_DIR=%cd%

REM Change to the Terraform directory
cd %TERRAFORM_DIR%

REM Check if terraform.tfvars file exists
IF NOT EXIST terraform.tfvars (
  REM Create terraform.tfvars file
  (
    echo do_token = "your_digitalocean_token"
    echo.
    echo enable_vps_module = true
    echo droplet_name = "your_droplet_name"
    echo size = "your_droplet_size"
    echo region = "your_droplet_region"
    echo image_name = "your_image_name"
    echo graceful_shutdown = true
    echo monitoring = true
    echo tags = ["tag1", "tag2"]
    echo.
    echo enable_ssh_module = true
    echo ssh_key_name = "your_ssh_key_name"
    echo ssh_key_path = "your_ssh_key_path"
    echo.
    echo enable_dns_module = false
    echo domain_name = "your_domain_name"
    echo enable_subdomain = false
    echo subdomain_name = "your_subdomain_name"
    echo.
    echo enable_networking_module = true
    echo firewall_name = "vps-firewall"
    echo.
    echo enable_storage = true
    echo volume_description = "value-added storage"
    echo volume_name = "storage"
    echo volume_size = 10
  ) > terraform.tfvars
)

REM Perform Terraform actions
IF "%ACTION%"=="init" (
  terraform init
) ELSE IF "%ACTION%"=="destroy" (
  terraform destroy -auto-approve
  exit /b 0
) ELSE IF "%ACTION%"=="apply" (
  terraform apply -auto-approve
) ELSE IF "%ACTION%"=="plan" (
  terraform plan
) ELSE (
  echo Invalid action. Please provide either 'init', 'apply', 'plan' or 'destroy'.
  exit /b 1
)

REM Continue only after successful 'apply'
IF "%ACTION%"=="apply" (
  REM Get droplet IP address
  FOR /F "tokens=*" %%G IN ('terraform output -raw droplet_ip') DO SET DROPLET_IP=%%G

  REM Navigate back to the initial directory
  cd %INITIAL_DIR%

  REM Change to the Ansible project directory
  cd %ANSIBLE_PROJECT_DIR%

  REM Overwrite the inventory file with the new structure
  (
    echo [%ENV%_servers]
    echo %ENV%_server_01 ansible_host=%DROPLET_IP%
    echo.
    echo [%ENV%_servers:vars]
    echo ansible_user=root
  ) > %INVENTORY_FILE%

  echo.

  REM Terminal display to state that ansible will run now
  echo Ansible will run in 60 seconds...

  REM Wait for 60 seconds
  timeout /t 60 /nobreak

  REM Run ansible-playbook using the updated inventory file and playbook paths
  ansible-playbook -i %INVENTORY_FILE% %PLAYBOOK_FILE%

  REM Update .ssh/config file
  SET SSH_CONFIG=%USERPROFILE%\.ssh\config
  SET HOST_ENTRY=Host %ENV%^^^r^^^nUser %ENV%^^^r^^^nHostName %DROPLET_IP%^^^r^^^nPort 22

  findstr /v /c:"Host %ENV%" "%SSH_CONFIG%" > temp && move /y temp "%SSH_CONFIG%"
  echo %HOST_ENTRY% >> "%SSH_CONFIG%"
)

echo Done!