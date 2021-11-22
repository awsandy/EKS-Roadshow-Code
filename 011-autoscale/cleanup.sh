
kubectl delete hpa,svc php-apache
kubectl delete deployment php-apache
kubectl delete pod load-generator

kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.1/components.yaml
kubectl delete ns metrics
helm uninstall kube-ops-view
unset ASG_NAME
unset AUTOSCALER_VERSION
unset K8S_VERSION
