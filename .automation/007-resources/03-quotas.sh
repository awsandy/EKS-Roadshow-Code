# Create different namespaces
kubectl create namespace blue
kubectl create namespace red
kubectl create quota blue-team --hard=limits.cpu=1,limits.memory=1G --namespace blue
kubectl create quota red-team --hard=services.loadbalancers=1 --namespace red
echo "# Error when creating a resource without defined limit"
kubectl run --namespace blue --image hande007/stress-ng blue-cpu-pod --restart=Never --  --vm-keep --vm-bytes 512m --timeout 600s --vm 2 --oomable --verbose

echo "# Error when creating a deployment without specifying limits (Replicaset has errors)"
kubectl create --namespace blue deployment blue-cpu-deploy --image hande007/stress-ng
kubectl describe --namespace blue replicaset -l app=blue-cpu-deploy  

echo "# Error when creating more than one AWS Load Balancer"
kubectl run --namespace red --image nginx:latest red-nginx-pod --restart=Never --limits=cpu=0.1,memory=100M
kubectl expose --namespace red pod red-nginx-pod --port 80 --type=LoadBalancer --name red-nginx-service-1
kubectl expose --namespace red pod red-nginx-pod --port 80 --type=LoadBalancer --name red-nginx-service-2
echo "success"
# Create Pod
kubectl run --namespace blue --limits=cpu=0.25,memory=250M --image nginx blue-nginx-pod-1 --restart=Never --restart=Never
kubectl run --namespace blue --limits=cpu=0.25,memory=250M --image nginx blue-nginx-pod-2 --restart=Never --restart=Never
kubectl run --namespace blue --limits=cpu=0.25,memory=250M --image nginx blue-nginx-pod-3 --restart=Never --restart=Never
sleep 5
echo "check quotas/utilization"
kubectl describe quota blue-team --namespace blue
kubectl describe quota red-team --namespace red
sleep 5
echo "cleanup"
kubectl delete namespace red
kubectl delete namespace blue