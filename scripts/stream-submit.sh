spark-submit \
  --master k8s://https://<KUBE_API_ENDPOINT> \
  --deploy-mode cluster \
  --name spark-streaming-job \
  --conf spark.executor.instances=2 \
  --conf spark.kubernetes.container.image=my-spark-streaming:latest \
  --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
  local:///opt/bitnami/spark/jobs/streaming.py
