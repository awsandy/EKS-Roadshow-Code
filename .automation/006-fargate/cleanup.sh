kubectl delete -f f-app-deployment.yaml
eksctl delete fargateprofile \
  --name game-2048 \
  --cluster eksworkshop-eksctl
sleep 4
kubectl delete namespace game-2048
