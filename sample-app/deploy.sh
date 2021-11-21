cat << EOF > app-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: default
  name: deployment-2048
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: app-2048
  replicas: 1
  template:
    metadata:
      labels:
        app.kubernetes.io/name: app-2048
    spec:
      containers:
      - image: alexwhen/docker-2048
        imagePullPolicy: Always
        name: app-2048
        ports:
        - containerPort: 80
EOF
kubectl apply -f app-deployment.yaml
