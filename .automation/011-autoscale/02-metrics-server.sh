echo "deploy metrics server"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml
sleep 5
kubectl get apiservice v1beta1.metrics.k8s.io -o json | jq '.status'