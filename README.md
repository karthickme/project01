# Assesment Project

## Starting the project with setting up the env

- Under tf folder each env Terraform file if preset
- cd to the folder and run ```terraform init``` to pull required providers plugins
- post that run ```terraform apply``` this will create the the required Mysql databases and AKS clusters in each of the env

## preparing the python program

- primitive flask app is written that will take the environmnet=dev or stage or prod as onfo the environment variable the it will connect with the respect mysql database in the Cloud(for now credentials are hardcoded it can be moved to Azure DevOps variables)
- this all will get user input in the /form and it add the entered data and push to the database

## pacakge code in a docker file

- todo
