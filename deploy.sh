cd ../gh-pages/
git pull || error_code=$?
error_code_int=$(($error_code + 0))

if [ $error_code_int -ne 0 ]; then
    echo "git pull failed";
	exit 1;
fi

cd ../gh-pages/

git pull || error_code=$?
error_code_int=$(($error_code + 0))

if [ $error_code_int -ne 0 ]; then
    echo "git pull failed";
	exit 1;
fi

cd ../Address2MapFE/docker/

./compose.prod.sh || error_code=$?
error_code_int=$(($error_code + 0))

if [ $error_code_int -ne 0 ]; then
    echo "./compose.prod.sh failed";
	exit 1;
fi
cd ../k8s

kubectl apply -f deployment.main.yaml || error_code=$?
error_code_int=$(($error_code + 0))

if [ $error_code_int -ne 0 ]; then
    echo "kubectl apply -f deployment.main.yaml failed";
	exit 1;
fi

kubectl rollout restart deployment address2map-fe-deployment -n address2map || error_code=$?
error_code_int=$(($error_code + 0))

if [ $error_code_int -ne 0 ]; then
    echo "kubectl rollout restart deployment address2map-web-deployment -n address2map failed";
	exit 1;
fi
