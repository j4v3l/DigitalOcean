# Use an official Alpine Linux as a parent image
FROM alpine:latest

# Install dependencies
RUN apk add --update \
  python3 \
  py3-pip \
  unzip \
  curl \
  bash \
  ca-certificates \
  openssl \
  openssh \
  make \
  git \
  && rm -rf /var/cache/apk/*


# Install Ansible
RUN apk add ansible

# Install Terraform
ENV TERRAFORM_VERSION=1.7.1
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
  rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Set the working directory in the container to /workspace
WORKDIR /workspace

# Add the current directory contents into the container at /workspace
ADD . /workspace