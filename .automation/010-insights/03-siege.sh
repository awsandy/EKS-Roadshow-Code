sudo yum install siege -y
siege --version
export WP_ELB=$(kubectl -n wordpress-cwi get svc understood-zebu-wordpress -o jsonpath="{.status.loadBalancer.ingress[].hostname}")
echo $WP_ELB
echo "siege for 5 mins in background"
siege -q -t 300S -c 200 -i http://${WP_ELB} &