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

***NOTE: You need to connect to your GCP account using GCP CLI commands***

## Step 2 Create all required resources using Terraform

1. Once the image is in GCR, copy the full path using the copy command next to the image (It should look like this ```gcr.io/ghost-blog-324611/ghost@sha256:4048f1a038c34f1b613fc09cc23cd2fcfad9a14db1ac617b417c529ecea43f17```). Keep this saved this need to be available for Terraform.

2. clone this repository to the local machine
3. Make appropriate changes to the terraform.tfvars file for your environment
4. Use Terraform init, followed by terraform apply command (May use terraform plan to look at the resources to be created and make appropraiet adjustments)

***NOTE: One of the issues I have come across ghost is, it defaults to "http://localhost:2368" for the links other than the home page. This can be fixed by setting the ENV variable "URL". If you have a custom domain you may supplply it here and make necessary DNS changes. If you don't have one you should be able to use the Cloud Run endpoint. This means you have to run the terraform apply twice or write some scripts to read it from the CloudRun attributes and set the URL variable.***

Finally. A Cloud run hosted website can be found [here](https://cloudrun-srv-rdvuf5br2a-nw.a.run.app/)
