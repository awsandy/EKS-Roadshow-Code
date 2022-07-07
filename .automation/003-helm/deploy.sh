curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm version --short
helm search repo nginx
echo "add bitnami repo"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo bitnami
helm search repo nginx
helm search repo bitnami/nginx
echo "install"
helm install mywebserver bitnami/nginx
sleep 5
kubectl get svc,po,deploy
kubectl describe deployment mywebserver
kubectl get pods -l app.kubernetes.io/name=nginx
kubectl get service mywebserver-nginx -o wide
#sleep 60
#curl
echo "wait 2 minutes then curl the ELB URL" 

