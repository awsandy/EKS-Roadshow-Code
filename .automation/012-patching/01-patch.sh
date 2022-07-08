eksctl upgrade cluster --name=eksworkshop-eksctl
eksctl upgrade cluster --name=eksworkshop-eksctl --approve
#
eksctl utils update-kube-proxy --cluster=eksworkshop-eksctl --approve
eksctl utils update-coredns --cluster=eksworkshop-eksctl --approve
#
kubectl get daemonset kube-proxy --namespace kube-system -o=jsonpath='{$.spec.template.spec.containers[:1].image}'
kubectl describe deployment coredns --namespace kube-system | grep Image | cut -d "/" -f 3
#
eksctl upgrade nodegroup --name=nodegroup --cluster=eksworkshop-eksctl --kubernetes-version=1.22
kubectl get nodes --watch
