export loadbalancer=$(kubectl -n my-nginx get svc my-nginx -o jsonpath='{.status.loadBalancer.ingress[*].hostname}')
curl -k -s http://${loadbalancer} | grep title