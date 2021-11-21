
echo "generate load"
kubectl --generator=run-pod/v1 run -i --tty load-generator --image=busybox /bin/sh
echo "while true; do wget -q -O - http://php-apache; done"

