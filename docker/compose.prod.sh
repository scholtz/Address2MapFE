DAY=$(date -d "$D" '+%d')
MONTH=$(date -d "$D" '+%m')
YEAR=$(date -d "$D" '+%Y')
ver=1.$YEAR.$MONTH.$DAY
docker build -t "scholtz2/address2mapfe:$ver" -f prod.Dockerfile  /home/cicd/Address2Map  || error_code=$?
error_code_int=$(($error_code + 0))
if [ $error_code_int -ne 0 ]; then
    echo "build failed";
	exit 1;
fi

docker push "scholtz2/address2mapfe:$ver"
echo "IMAGE: scholtz2/address2mapfe:$ver"

sed -i "s~scholtz2/address2mapfe:.*~scholtz2/address2mapfe:$ver~" ../k8s/deployment.main.yaml
