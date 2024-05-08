# 🚀 DigitalOcean

## 📚 Table of Contents
- [Project Structure](#-project-structure)
- [Setup](#-setup)
- [Running the Project](#-running-the-project)

## 🏗️ Project Structure
This project is divided into two main parts: the Ansible project and the Terraform project.

- The Ansible project is located in the `ansible-project` directory and contains the configuration files for setting up the server environment.
- The Terraform project is located in the `terraform-project` directory and contains the configuration files for provisioning the infrastructure.

## 🔧 Setup
1. Clone the repository to your local machine.
2. Generate an SSH key using the `generate_ssh_key.sh` script.
3. Update the `terraform.tfvars` file in the `terraform-project/environments/dev` or `terraform-project/environments/prod` directory with your DigitalOcean token and other required information.

## 🏃‍♀️ Running the Project
You can run the project using the `setup.sh` or `setup.bat` script depending on your operating system. The script takes two arguments: the action (`init`, `apply`, `plan`, `destroy`) and the environment (`dev`, `prod`).

For example, to initialize the project for the `dev` environment, you would run:

```sh
./setup.sh init dev
./setup.sh apply prod
```