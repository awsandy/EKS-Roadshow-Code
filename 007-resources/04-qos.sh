cat <<EoF > high-priority-class.yml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 100
globalDefault: false
description: "High-priority Pods"
EoF

kubectl apply -f high-priority-class.yml


cat <<EoF > low-priority-class.yml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: low-priority
value: 50
globalDefault: false
description: "Low-priority Pods"
EoF

kubectl apply -f low-priority-class.yml
sleep 5
echo "deploy low pri pods"

cat <<EoF > low-priority-deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx-deployment
  name: nginx-deployment
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx-deployment
  template:
    metadata:
      labels:
        app: nginx-deployment
    spec:
      priorityClassName: "low-priority"      
      containers:            
       - image: nginx
         name: nginx-deployment
         resources:
           limits:
              memory: 200m  
EoF
kubectl apply -f low-priority-deployment.yml
sleep 5
kubectl get deployment nginx-deployment
echo "sleep 1m 1 of 3"
sleep 30
kubectl get deployment nginx-deployment
echo "sleep 1m 2 of 3"
sleep 30
kubectl get deployment nginx-deployment
echo "sleep 1m 3 of 3"
sleep 30
kubectl get deployment nginx-deployment

echo "high pri pod deployment"

cat <<EoF > high-priority-deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: high-nginx-deployment
  name: high-nginx-deployment
spec:
  replicas: 5
  selector:
    matchLabels:
      app: high-nginx-deployment
  template:
    metadata:
      labels:
        app: high-nginx-deployment
    spec:
      priorityClassName: "high-priority"      
      containers:            
       - image: nginx
         name: high-nginx-deployment
         resources:
           limits:
              memory: 200m
EoF
kubectl apply -f high-priority-deployment.yml

sleep 5
kubectl get deployment nginx-deployment
kubectl get deployment high-nginx-deployment
echo "sleep 1m 1 of 3"
sleep 30
kubectl get deployment nginx-deployment
kubectl get deployment high-nginx-deployment
echo "sleep 1m 2 of 3"
sleep 30
kubectl get deployment nginx-deployment
kubectl get deployment high-nginx-deployment
echo "sleep 1m 3 of 3"
sleep 30
kubectl get deployment nginx-deployment
kubectl get deployment high-nginx-deployment
