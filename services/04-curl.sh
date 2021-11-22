export loadbalancer=$(kubectl -n my-nginx get svc my-nginx -o jsonpath='{.status.loadBalancer.ingress[*].hostname}')
sleep 30
curl -k -s http://${loadbalancer} | grep title