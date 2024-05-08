#!/bin/bash
# Check if two arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 [init|apply|plan|destroy] [dev|prod]"
  exit 1
fi

# Assign arguments to variables
ACTION=$1
ENV=$2

# Define the Terraform directory based on the environment
TERRAFORM_DIR="terraform-project/environments/$ENV"
# Define paths for the inventory and playbook files (relative to the Ansible project directory)
INVENTORY_FILE="inventory/$ENV/hosts"
PLAYBOOK_FILE="playbooks/$ENV.yml"
ANSIBLE_PROJECT_DIR="ansible-project"

# Store the initial directory
INITIAL_DIR=$(pwd)

# Change to the Terraform directory
cd $TERRAFORM_DIR

# Check if terraform.tfvars file exists
if [ ! -f terraform.tfvars ]; then
  # Create terraform.tfvars file
  cat << EOF > terraform.tfvars
do_token = "your_digitalocean_token"

# Variables for the VPS module
enable_vps_module = true
droplet_name = "your_droplet_name"
size = "your_droplet_size"
region = "your_droplet_region"
image_name = "your_image_name"
graceful_shutdown = true
monitoring = true
tags = ["tag1", "tag2"]

# Variables for the SSH Key module
enable_ssh_module = true
ssh_key_name = "your_ssh_key_name"
ssh_key_path = "your_ssh_key_path"

# Variables for the DNS module
enable_dns_module = false
domain_name = "your_domain_name"
enable_subdomain = false
subdomain_name = "your_subdomain_name"

# Variables for the Networking module
enable_networking_module = true
firewall_name = "vps-firewall"

# Variables for the Storage module
enable_storage = true
volume_description = "value-added storage"
volume_name = "storage"
volume_size = 10
EOF
fi

# Exit the script on any error
set -e

# Perform Terraform actions
case "$ACTION" in
init)
  terraform init
  ;;
destroy)
  terraform destroy -auto-approve
  exit 0
  ;;
apply)
  terraform apply -auto-approve
  ;;
plan)
  terraform plan
  ;;
*)
  echo "Invalid action. Please provide either 'init', 'apply', 'plan' or 'destroy'."
  exit 1
  ;;
esac

# Continue only after successful 'apply'
if [ "$ACTION" == "apply" ]; then
  # Get droplet IP address
  DROPLET_IP=$(terraform output -raw droplet_ip)

  # Navigate back to the initial directory
  cd $INITIAL_DIR

  # Change to the Ansible project directory
  cd $ANSIBLE_PROJECT_DIR

  # Overwrite the inventory file with the new structure
  {
    echo "[${ENV}_servers]"
    echo "${ENV}_server_01 ansible_host=${DROPLET_IP}"
    echo
    echo "[${ENV}_servers:vars]"
    echo "ansible_user=root"
  } >$INVENTORY_FILE

  echo ""

  # Terminal display to state that ansible will run now
  echo "Ansible will run in 60 seconds..."

  # Wait for 10 seconds
  sleep 60

  # Run ansible-playbook using the updated inventory file and playbook paths
  ansible-playbook -i $INVENTORY_FILE $PLAYBOOK_FILE

  # Update .ssh/config file
  SSH_CONFIG="$HOME/.ssh/config"
  HOST_ENTRY="Host $ENV
  User $ENV
  HostName $DROPLET_IP
  Port 22"

  if grep -q "Host $ENV" "$SSH_CONFIG"; then
    # Host entry exists, update it
    sed -i '' "/^Host $ENV/,+3d" "$SSH_CONFIG"
    echo "$HOST_ENTRY" >>"$SSH_CONFIG"
  else
    # Host entry does not exist, append it
    echo "$HOST_ENTRY" >>"$SSH_CONFIG"
  fi
fi # Ensure this 'fi' closes the 'if' block for 'apply' action

echo "Done!"
