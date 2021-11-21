helm list
helm uninstall mywebserver
sleep 5
kubectl get pods -l app.kubernetes.io/name=nginx
kubectl get service mywebserver-nginx -o wide
