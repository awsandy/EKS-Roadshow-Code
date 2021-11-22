
test -n "$ROLE_NAME" && echo ROLE_NAME is "$ROLE_NAME" || echo ROLE_NAME is not set
aws iam attach-role-policy \
  --role-name $ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy
aws iam list-attached-role-policies --role-name $ROLE_NAME | grep CloudWatchAgentServerPolicy || echo 'Policy not found'
curl -s https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/eksworkshop-eksctl/;s/{{region_name}}/${AWS_REGION}/" | kubectl apply -f -
sleep 5
kubectl -n amazon-cloudwatch get daemonsets
echo "
Use the URL below to access Cloudwatch Container Insights in $AWS_REGION:

https://console.aws.amazon.com/cloudwatch/home?region=${AWS_REGION}#cw:dashboard=Container;context=~(clusters~'eksworkshop-eksctl~dimensions~(~)~performanceType~'Service)"
#
