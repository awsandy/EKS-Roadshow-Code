kubectl -n my-nginx get svc my-nginx
kubectl -n my-nginx patch svc my-nginx -p '{"spec": {"type": "LoadBalancer"}}'
sleep 5
kubectl -n my-nginx get svc my-nginx

