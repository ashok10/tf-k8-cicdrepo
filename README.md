# tf-k8-cicdrepo

# EKS + Terraform + GitHub Actions Sample


This repo provisions a VPC and EKS cluster, installs NGINX Ingress via Helm (Terraform `helm_release`), and has a GitHub Actions pipeline to plan/apply Terraform and deploy Helm charts.


## How the pipeline works


- **PRs** trigger `terraform plan` to validate and review infrastructure changes.
- **Push to main** triggers `terraform apply` (auto-approve). After apply completes, a separate job updates kubeconfig and deploys Helm charts (ingress and sample app).


## Secrets


Set the following in your repository settings -> Secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (optional)


## To run locally


Ensure AWS credentials are available in your environment.


```bash
cd terraform
terraform init
terraform apply
