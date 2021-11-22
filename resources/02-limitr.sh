cat <<EoF > low-usage-limit-range.yml
apiVersion: v1
kind: LimitRange
metadata:
  name: low-usage-range
spec:
  limits:
  - max:
      cpu: 1
      memory: 300M 
    min:
      cpu: 0.5
      memory: 100M
    type: Container
EoF

kubectl apply -f low-usage-limit-range.yml --namespace low-usage

cat <<EoF > high-usage-limit-range.yml
apiVersion: v1
kind: LimitRange
metadata:
  name: high-usage-range
spec:
  limits:
  - max:
      cpu: 2
      memory: 2G 
    min:
      cpu: 1
      memory: 1G
    type: Container
EoF

kubectl apply -f high-usage-limit-range.yml --namespace high-usage

echo "Error due to higher memory request than defined in low-usage namespace: wanted 1g memory above max of 300m"
kubectl run --namespace low-usage --requests=memory=1G,cpu=0.5 --image  hande007/stress-ng basic-request-pod --restart=Never --  --vm-keep   --vm-bytes 2g --timeout 600s --vm 1 --oomable --verbose 

echo "Error due to lower cpu request than defined in high-usage namespace: wanted 0.5 below min of 1"
kubectl run --namespace high-usage --requests=memory=1G,cpu=0.5 --image  hande007/stress-ng basic-request-pod --restart=Never --  --vm-keep   --vm-bytes 2g --timeout 600s --vm 1 --oomable --verbose 
sleep 5
kubectl run --namespace low-usage --image  hande007/stress-ng low-usage-pod --restart=Never --  --vm-keep   --vm-bytes 200m --timeout 600s --vm 2 --oomable --verbose 
kubectl run --namespace high-usage  --image  hande007/stress-ng high-usage-pod --restart=Never --  --vm-keep   --vm-bytes 200m --timeout 600s --vm 2 --oomable --verbose 
kubectl run --namespace unrestricted-usage --image  hande007/stress-ng unrestricted-usage-pod --restart=Never --  --vm-keep   --vm-bytes 200m --timeout 600s --vm 2 --oomable --verbose 
echo "verify that LimitRange values are being inherited by the pods in each namespace."
eval 'kubectl  -n='{low-usage,high-usage,unrestricted-usage}' get pod -o=custom-columns='Name:spec.containers[*].name','Namespace:metadata.namespace','Limits:spec.containers[*].resources.limits';'
sleep 5
echo "cleanup"
kubectl delete namespace low-usage
kubectl delete namespace high-usage
kubectl delete namespace unrestricted-usage