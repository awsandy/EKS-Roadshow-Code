sudo yum install siege -y
siege --version
export WP_ELB=$(kubectl -n wordpress-cwi get svc understood-zebu-wordpress -o jsonpath="{.status.loadBalancer.ingress[].hostname}")

siege -q -t 15S -c 200 -i http://${WP_ELB}