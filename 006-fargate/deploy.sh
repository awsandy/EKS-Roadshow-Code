eksctl create fargateprofile \
  --cluster eksworkshop-eksctl \
  --name game-2048 \
  --namespace game-2048
eksctl get fargateprofile \
  --cluster eksworkshop-eksctl \
  -o yaml

cat << EOF > f-app-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: game-2048
EOF

kubectl apply -f f-app-namespace.yaml

cat << EOF > f-app-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: game-2048
  name: fargate-deployment-2048
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: f-app-2048
  replicas: 1
  template:
    metadata:
      labels:
        app.kubernetes.io/name: f-app-2048
    spec:
      containers:
      - image: alexwhen/docker-2048
        imagePullPolicy: Always
        name: app-2048
        ports:
        - containerPort: 80
EOF


kubectl apply -f f-app-deployment.yaml
sleep 2
kubectl get deployment -n game-2048
sleep 2
kubectl get pods -n game-2048
echo "pod name for forwarding"
kubectl get pods -n game-2048 | grep fargate-deployment-2048 | cut -f1 -d' '

kubectl get nodes


