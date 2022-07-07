for i in `ls -l | awk '{print $9}' | grep 0`; do
cd $i
./cleanup.sh
cd ..
done
#eksctl delete cluster --name eksworkshop-eksctl