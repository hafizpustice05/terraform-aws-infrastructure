# terraform-aws-infrastructure

To run this project you simply need to have terraform and AWS cli

# Requirements
- terraform
- AWS CLI

## Executing commands
As we are using terraform commands

## Setup secret_key and access_key in your system
Following this command
 
``` export AWS_ACCESS_KEY_ID = value```

 ```export AWS_SECRET_ACCESS_KEY = value```

You also configure by AWS cli, you have to be install aws cli, then following this command

    aws configure

### Command: init
The terraform init command initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.

    terraform init

### Command: plan
Also, The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. By default, when Terraform creates a plan it:

    terraform plan

### Command: apply
The terraform apply command executes the actions proposed in a Terraform plan.

    terraform apply [options] [plan file]

We can pass the -auto-approve option to instruct Terraform to apply the plan without asking for confirmation.

    terraform apply -auto-approve

We can also pass the -var-file option to instruct Terraform to apply the variable file

    terraform apply -var-file file_name_with_extension
    terraform apply -var-file terraform-dev.tfvars

### Command: state list
The terraform state list command is used to list resources within a Terraform state.

    terraform state list

### Command: state show
The terraform state show command is used to show the attributes of a single resource in the Terraform state.

    terraform state show [options] ADDRESS

### Command: destroy
The terraform destroy command is a convenient way to destroy all remote objects managed by a particular Terraform configuration.

    terraform destroy

### Terraform variable value set by cli
The terraform  command executes the actions proposed in a Terraform plan.

    export TF_VAR_variablename = 'variable value'


### Connect ec2 by linux command
The terraform  command executes the actions proposed in a Terraform plan.

    ssh ec2-user@public_ip