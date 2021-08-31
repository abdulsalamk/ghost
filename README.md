<h1> Gost blog on Google Cloud Run </h1>
<p>This is an opinionated module to install the popular blog platform <a href="https://ghost.org" target="_blank" >Ghost</a> in Google Cloud/Cloud Run.</p>

<h2> Prerequisits </h2>

* <a href="https://docs.docker.com/desktop/windows/install/"> Docker service </a> installed on the development machine.
* GCP account with at least one project
* Cloud Run and Cloud SQL API's enabled
* <a href="https://www.terraform.io/downloads.html"> Terraform </a> installed on the machine 
* GCP <a href="https://cloud.google.com/sdk/docs/install"> Cloud SDK </a> installed and configured

<h2> Step 1 upload ghost docker image to GCR </h2>
Follow the steps below ..
1. Pull the ghost image to local machine
<pre><code>
    docker pull ghost:3.12.0 <br />
    docker tag ghost:3.12.0 gcr.io/<GCP_PROJECT_NAME>/ghost:3.12.0
    docker push gcr.io/<GCP_PROJECT_NAME>/ghost:3.12.0
</code></pre>
