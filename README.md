# Gost blog on Google Cloud Run 

This is an opinionated module to install the popular blog platform [Ghost](https://ghost.org) in Google Cloud/[Cloud Run](https://cloud.google.com/run).

## Pre-requisits

* [Docker service](https://docs.docker.com/desktop/windows/install/) installed on the development machine.
* GCP account with at least one project
* Cloud Run and Cloud SQL API's enabled
* [Terraform](https://www.terraform.io/downloads.html) installed on the machine 
* GCP [Cloud SDK](https://cloud.google.com/sdk/docs/install)installed and configured

## Step 1 Push ghost docker image to GCR

Follow the steps below ..

1. Pull the ghost image to local machine, tag it and push it to GCR

```
    docker pull ghost:3.12.0
    docker tag ghost:3.12.0 gcr.io/<GCP_PROJECT_NAME>/ghost:3.12.0
    docker push gcr.io/<GCP_PROJECT_NAME>/ghost:3.12.0
```

> **_NOTE:_** You need to connect to your GCP account using GCP CLI commands

## Step 2 Create all required resources using Terraform

1. Once the image is in GCR, copy the full path using the copy command next to the image (It should look like this ```gcr.io/<PROJECT-ID>/ghost@sha256:4048f1a038c34f1b613fc09cc23cd2fcfad9a14db1ac617b417c529ecea43f17```). Keep this saved this need to be available for Terraform.

2. clone this repository to the local machine
3. Make appropriate changes to the terraform.tfvars file for your environment
4. Use Terraform init, followed by terraform apply command (May use terraform plan to look at the resources to be created and make appropraiet adjustments)

> **_NOTE:_** One of the issues I have come across ghost is you get a 503 error on the first hit on the app. The reason for this ghost takes up to a minute to start the application. The fix for this could be either to fix it in ghost (may be to deliver what is in the cache until it comes online?) or keep at least one container running by adding the following line.
```"autoscaling.knative.dev/minscale" = "1"```

Finally. An example Cloud run hosted ghost website can be found [here](https://ghost-cloudrun-rdvuf5br2a-nw.a.run.app/)

> **_NOTE:_**  The note content.It is not recommended to put the variables in plain text for production releases, please make use of [Google Secrets Manager](https://cloud.google.com/secret-manager) to store the secrets.

# Bulk deletion of blogs

The bulk deletion of the blogs are done using the cloudrun function called "delete" in "ghost-posts". This achieve using a cloud function module written in Python 3.9. The code can be found in "main.py". It connects directly to the database and deletes al records from the table "posts". 
(NOTE: The script has set it as emails as I don't wanted to remove all blogs. Just change the parameter db_table = "emails" of main.py to "posts").

The terraform file couldfunction.tf does everything to do with publishing this code. It zips up everything in the folder "scripts" an uploads it to the cloudfunctions. 

> **_NOTE_**  You might see a hashing function added to the name attribute blucket name. This is to make it unique each time, otherwise it shows up an error. The code is below
```name                =  format("%s#%s", "ghost-posts.zip", data.archive_file.function_archive.output_md5)```

# Networks

There is a custom network also available which has 3 seperate subnets as below ..

1. dev-subnet
2. test-subnet
3. prod-network

Each of them has 2 IP ranges on it, one dedicated for application and other one for management, backup monitoring etc.

# Monitoring Dashboard

"monitoring.tf" will create a dashboard for monitoring services, but nothing has been configured on this yet. There are many possibilities to do monitoring and alerting which may be implimented during the implimentation phase. This is just PoC.

# CI/CD

From the requirements it isn't clear what part of the application need to be on the pipeline, hence I have done it only for a demo cloudrun project. If it is meant for the Ghost project, just minor changes on the variables will enable this. The pipeline is achieved by using GCP cloud build service. The code from "cloudbuild.tf" will create a webhook from the code repository and will automate creation of the container, pushing it to GCR and enabling a cloud run service called "config-service"

# Security

I don't think this is something we can implement seperately, every component mentioned above should be built with security in mind. The service accounts used in the PoC may not necessarily use the principle of least privileges, but this is extremely important while creating the services in production. There can be many improvements on the logging, monitoring and alerting. Giving a single dashboard for the security team. Google's on Site Reliability Engineering methods can be implimented for self correcting applicatins. Tools like "Cloud Armor" may be used for the network security. 



