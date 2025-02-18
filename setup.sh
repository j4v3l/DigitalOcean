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

# Check if terraform.tfvars file exists, if not, create it
if [ ! -f terraform.tfvars ]; then
  cat << EOF > terraform.tfvars
do_token = "${DO_TOKEN:-your_digitalocean_token}"

enable_vps_module = ${ENABLE_VPS_MODULE:-true}
droplet_name = "${DROPLET_NAME:-your_droplet_name}"
size = "${DROPLET_SIZE:-your_droplet_size}"
region = "${DROPLET_REGION:-your_droplet_region}"
image_name = "${IMAGE_NAME:-your_image_name}"
graceful_shutdown = ${GRACEFUL_SHUTDOWN:-true}
monitoring = ${MONITORING:-true}
tags = ${TAGS:-["tag1","tag2"]}

enable_ssh_module = ${ENABLE_SSH_MODULE:-true}
ssh_key_name = "${SSH_KEY_NAME:-your_ssh_key_name}"
ssh_key_path = "${SSH_KEY_PATH:-your_ssh_key_path}"

enable_dns_module = ${ENABLE_DNS_MODULE:-false}
domain_name = "${DOMAIN_NAME:-your_domain_name}"
enable_subdomain = ${ENABLE_SUBDOMAIN:-false}
subdomain_name = "${SUBDOMAIN_NAME:-your_subdomain_name}"

enable_networking_module = ${ENABLE_NETWORKING_MODULE:-true}
firewall_name = "${FIREWALL_NAME:-vps-firewall}"

enable_storage = ${ENABLE_STORAGE:-true}
volume_description = "${VOLUME_DESCRIPTION:-value-added storage}"
volume_name = "${VOLUME_NAME:-storage}"
volume_size = ${VOLUME_SIZE:-10}
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
