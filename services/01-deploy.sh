cat <<EoF > ~/environment/run-my-nginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
  namespace: my-nginx
spec:
  selector:
    matchLabels:
      run: my-nginx
  replicas: 2
  template:
    metadata:
      labels:
        run: my-nginx
    spec:
      containers:
      - name: my-nginx
        image: nginx
        ports:
        - containerPort: 80
EoF
# create the namespace
kubectl create ns my-nginx
# create the nginx deployment with 2 replicas
kubectl -n my-nginx apply -f ~/environment/run-my-nginx.yaml

kubectl -n my-nginx get pods -o wide
kubectl -n my-nginx get pods -o yaml | grep 'podIP:'

kubectl -n my-nginx expose deployment/my-nginx
sleep 5
kubectl -n my-nginx get svc my-nginx
# Create a variable set with the my-nginx service IP
export MyClusterIP=$(kubectl -n my-nginx get svc my-nginx -ojsonpath='{.spec.clusterIP}')

# Create a new deployment and allocate a TTY for the container in the pod
kubectl -n my-nginx run -i --tty load-generator --env="MyClusterIP=${MyClusterIP}" --image=busybox /bin/sh
echo "wget -q -O - ${MyClusterIP} | grep '<title>'"
echo "exit"
