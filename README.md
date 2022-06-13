# Assesment Project

## Starting the project with setting up the env

- Under tf folder each env Terraform file if preset
- cd to the folder and run ```terraform init``` to pull required providers plugins
- post that run ```terraform apply``` this will create the the required Mysql databases and AKS clusters in each of the env

## preparing the python program

- primitive flask app is written that will take the environmnet=dev or stage or prod as onfo the environment variable the it will connect with the respect mysql database in the Cloud(for now credentials are hardcoded it can be moved to Azure DevOps variables)
- this all will get user input in the /form and it add the entered data and push to the database

## package the code in a docker file

- The Flask code is pacakged using the dockerfile, by running running `docker build --tag python-tf-assesment`
- same image is pushed to docker hub and can be pulled by running `docker push smekarthick/python-tf-assesment`

## installing Prometheus and Grafana

- Make sure your local kubectl context point to the newly build cluser
- Run the install_prom_graph.sh
- At the end of this script it will start a port forwaring to the localhost for Prometheus and Grafana instances
- This will help us in finihing the configurations

## prepare AzureDevOps pipeline/github actions

- Azure devops pipline CI/CD and its working fine -> <https://dev.azure.com/KartCorp/Assesment/_build/results?buildId=22&view=results>
- this step will build the image and will push to Container Registory(dockerhub) on a commit is performed on main branch
- Build on top of that for release
- Added deployment and Servcie k8s yaml manifest for release
- Also the CI/CD pipeline also perofrm the release of the code

## Possible improvments
- Lot of items are hardcoded it can be segregated
- tf file can segregated i to values backend and env files.
- passwords can be moved into secrets
- Build and release can be split for better handling
- CI/CD pipeline naming needs to be refined.

### Restrictions
- im not aware - but helm based installtion can be added to the Tf yaml.
- Ask was to prepare in GKE but i was not have a active GCP account i used Azure account.
- im not much familier with Jenkins just now going though it, so went with AzureDevops
- Considering the cost the env is shutdown now