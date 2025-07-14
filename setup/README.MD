# General Steps

## Ingress-nginx Setup
```BASH
kubectl create namespace ingress-nginx
```


```BASH
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.publishService.enabled=false \
  --set controller.service.type=NodePort \
  --set controller.service.nodePorts.http=30080 \
  --set controller.service.nodePorts.https=30443 \
  --set controller.hostNetwork=false \
  --set controller.kind=Deployment


```


## Namespace and PVC define

### Create Namespace
```BASH
kubectl create namespace mlflow
kubectl create namespace spark
kubectl create namespace kafka
kubectl create namespace airflow

```

### Create PV and PVC

```BASH
kubectl apply -f volumes/pv/airflow-pv.yaml
kubectl apply -f volumes/pvc/airflow-pvc.yaml

kubectl apply -f volumes/pv/spark-pv.yaml
kubectl apply -f volumes/pvc/spark-pvc.yaml

kubectl apply -f volumes/pv/mlflow-pv.yaml
kubectl apply -f volumes/pvc/mlflow-pvc.yaml

kubectl apply -f volumes/pv/postgres-pv.yaml
kubectl apply -f volumes/pvc/postgres-pvc.yaml
```


## Metric Deployment with helm
Server Version : 1.27

```BASH
helm install metrics-server metrics-server/metrics-server --namespace kube-system --create-namespace --set image.tag=v0.7.2 --set-string args='{--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP\,ExternalIP\,Hostname,--kubelet-use-node-status-port,--metric-resolution=15s}'

```