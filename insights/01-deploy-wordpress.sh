# Create a namespace wordpress
kubectl create namespace wordpress-cwi

# Add the bitnami Helm Charts Repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Deploy WordPress in its own namespace
helm -n wordpress-cwi install understood-zebu bitnami/wordpress
sleep 5
kubectl -n wordpress-cwi rollout status deployment understood-zebu-wordpress
sleep 5

export SERVICE_URL=$(kubectl get svc -n wordpress-cwi understood-zebu-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
sleep 5
echo "Public URL: http://$SERVICE_URL/"
export ADMIN_URL="http://$SERVICE_URL/admin"
export ADMIN_PASSWORD=$(kubectl get secret --namespace wordpress-cwi understood-zebu-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)

echo "Admin URL: http://$SERVICE_URL/admin
Username: user
Password: $ADMIN_PASSWORD
"
