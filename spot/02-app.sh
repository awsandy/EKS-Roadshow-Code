for n in $(kubectl get nodes -l eks.amazonaws.com/capacityType=SPOT --no-headers | cut -d " " -f1); do echo "Pods on instance ${n}:";kubectl get pods --all-namespaces  --no-headers --field-selector spec.nodeName=${n} ; echo ; done
kubectl apply -f ecsdemo-frontend-deployment.yaml
kubectl apply -f ecsdemo-frontend-service.yaml
kubectl apply -f ecsdemo-crystal-deployment.yaml
kubectl apply -f ecsdemo-crystal-service.yaml
kubectl apply -f ecsdemo-nodejs-deployment.yaml
kubectl apply -f ecsdemo-nodejs-service.yaml