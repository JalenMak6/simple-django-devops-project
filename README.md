# Simple Devops project


This is a simple static django webapplication for the devops projects.

It will include the Devops tools such as Docker, Jenkins, ArgoCD and kubernetes.

The idea will be pushing the code to the Github while create a Dockerfile and push the image to the DockerHub.

A seaprate K8s repo will include two directories (Helm Charts and custom manifest directory) for the ArgoCD to sync with and deploy the django application to the kubernetes cluster.
