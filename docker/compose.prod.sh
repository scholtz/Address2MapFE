DAY=$(date -d "$D" '+%d')
MONTH=$(date -d "$D" '+%m')
YEAR=$(date -d "$D" '+%Y')
ver=1.$YEAR.$MONTH.$DAY
docker build -t "registry.h1.scholtz.sk/biatec:$ver" -f dockerfile.prod  /home/cicd/Biatec/ippl  || error_code=$?
if [ "$error_code" -ne 0 ]; then
    echo "build failed";
	exit 1;
fi


docker push "registry.h1.scholtz.sk/biatec:$ver"
echo "IMAGE: registry.h1.scholtz.sk/biatec:$ver"

sed -i "s~registry.h1.scholtz.sk/biatec:.*~registry.h1.scholtz.sk/biatec:$ver~" deployment.main.yaml
sed -i "s~registry.h1.scholtz.sk/biatec:.*~registry.h1.scholtz.sk/biatec:$ver~" deployment.test.yaml

kubectl apply -f deployment.main.yaml
kubectl apply -f deployment.test.yaml

kubectl rollout restart deployment/biatec-web-deployment -n biatec
kubectl rollout restart deployment/biatec-web-test-deployment -n biatec
