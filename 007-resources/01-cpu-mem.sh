kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml
kubectl get apiservice v1beta1.metrics.k8s.io -o json | jq '.status'
echo "sleep 2 minutes for metrics sevrer to fire up .."
sleep 120
kubectl get apiservice v1beta1.metrics.k8s.io -o json | jq '.status'
kubectl get deployment metrics-server -n kube-system

# Deploy Limits pod with hard limit on cpu at 500m but wants 1000m
kubectl run --limits=memory=1G,cpu=0.5 --image  hande007/stress-ng basic-limit-cpu-pod --restart=Never --  --vm-keep --vm-bytes 512m --timeout 600s --vm 1 --oomable --verbose 

# Deploy Request pod with soft limit on memory 
kubectl run --requests=memory=1G,cpu=0.5 --image  hande007/stress-ng basic-request-pod --restart=Never --  --vm-keep   --vm-bytes 2g --timeout 600s --vm 1 --oomable --verbose 

# Deploy restricted pod with limits and requests wants cpu 2 and memory at 1G
kubectl run --requests=cpu=1,memory=1G --limits=cpu=1.8,memory=2G --image  hande007/stress-ng basic-restricted-pod  --restart=Never --  --vm-keep  --vm-bytes 1g --timeout 600s --vm 2 --oomable --verbose 

# Deploy Limits pod with hard limit on memory at 1G but wants 2G
kubectl run --limits=memory=1G,cpu=1 --image  hande007/stress-ng basic-limit-memory-pod --restart=Never --  --vm-keep  --vm-bytes 2g --timeout 600s --vm 1 --oomable --verbose 
sleep 10
kubectl get pod
kubectl top pod
sleep 10
kubectl delete pod basic-request-pod
kubectl delete pod basic-limit-memory-pod
kubectl delete pod basic-limit-cpu-pod
kubectl delete pod basic-restricted-pod

