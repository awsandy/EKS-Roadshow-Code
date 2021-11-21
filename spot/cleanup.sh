kubectl delete -f ecsdemo-frontend-service.yaml
kubectl delete -f ecsdemo-frontend-deployment.yaml
#
kubectl delete -f ecsdemo-crystal-service.yaml
kubectl delete -f ecsdemo-crystal-deployment.yaml
#
kubectl delete -f ecsdemo-nodejs-service.yaml
kubectl delete -f ecsdemo-nodejs-deployment.yaml
#
kubectl label nodes --all lifecycle-
eksctl delete nodegroup --cluster=eksworkshop-eksctl --region=${AWS_REGION} --name=ng-spot