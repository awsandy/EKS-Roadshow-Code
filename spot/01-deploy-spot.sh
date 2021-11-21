kubectl get nodes \
  --label-columns=eks.amazonaws.com/capacityType \
  --selector=eks.amazonaws.com/capacityType=ON_DEMAND
eksctl create nodegroup \
  --cluster=eksworkshop-eksctl --region=${AWS_REGION} \
  --managed --spot --name=ng-spot \
  --instance-types=m5.large,m4.large,m5d.large,m5a.large,m5ad.large,m5n.large,m5dn.large
kubectl get nodes --sort-by=.metadata.creationTimestamp
kubectl get nodes \
  --label-columns=eks.amazonaws.com/capacityType \
  --selector=eks.amazonaws.com/capacityType=SPOT
