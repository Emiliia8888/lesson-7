# Lesson 7: Terraform + EKS + ECR + Helm

## Опис

У цьому проєкті за допомогою Terraform створено інфраструктуру AWS, що включає Kubernetes-кластер (Amazon EKS) та репозиторій Amazon ECR. Django-застосунок контейнеризовано, завантажено в ECR і розгорнуто в Kubernetes за допомогою Helm.

## Використані технології

* Terraform
* Amazon EKS
* Amazon ECR
* AWS RDS PostgreSQL
* Docker
* Kubernetes
* Helm
* AWS CLI

## Розгортання інфраструктури

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Підключення до EKS

```bash
aws eks update-kubeconfig --region eu-central-1 --name dev-eks-cluster
```

## Авторизація в ECR

```bash
aws ecr get-login-password --region eu-central-1 \
| docker login --username AWS --password-stdin \
034255117140.dkr.ecr.eu-central-1.amazonaws.com
```

## Завантаження Docker-образу

```bash
docker tag django-app:latest \
034255117140.dkr.ecr.eu-central-1.amazonaws.com/django-app:latest

docker push \
034255117140.dkr.ecr.eu-central-1.amazonaws.com/django-app:latest
```

## Розгортання Helm-чарта

```bash
cd charts/django-app

helm lint .

helm install django-app .

# або оновлення
helm upgrade --install django-app .
```

## Перевірка

```bash
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get hpa
```

## Реалізовано

* Terraform-модуль EKS
* Terraform-модуль ECR
* Helm Deployment
* Helm Service (LoadBalancer)
* Helm ConfigMap
* Helm Secret
* Horizontal Pod Autoscaler (2–6 реплік, 70% CPU)
* Підключення ConfigMap через `envFrom`
* Використання Docker-образу з Amazon ECR
