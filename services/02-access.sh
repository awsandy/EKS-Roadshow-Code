kubectl get service -n kube-system -l k8s-app=kube-dns
kubectl -n my-nginx run curl --image=radial/busyboxplus:curl -i --tty
echo "nslookup my-nginx"
echo "exit"