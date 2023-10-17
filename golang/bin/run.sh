echo "go env echo start"
echo $GOROOT
echo $GOPATH

echo "get run params from env, or set default value here"
echo 'get serverList'
echo $serverList
if [[ "$serverList" == "" ]]
then
serverList=127.0.0.1
export serverList
else
serverList=$serverList
export serverList
fi
echo 'serverList is ' $serverList

echo 'get namespace'
echo $namespace
if [[ "$namespace" == "" ]]
then
namespace=
export namespace
else
namespace=$namespace
export namespace
fi
echo 'namespace is ' $namespace

echo 'get ACCESS_KEY'
echo $ACCESS_KEY
if [[ "$ACCESS_KEY" == "" ]]
then
ACCESS_KEY=XXXX
export ACCESS_KEY
else
ACCESS_KEY=$ACCESS_KEY
export ACCESS_KEY
fi
echo 'ACCESS_KEY is ' $ACCESS_KEY

echo 'get SECRET_KEY'
echo $SECRET_KEY
if [[ "$SECRET_KEY" == "" ]]
then
SECRET_KEY=XXXX
export SECRET_KEY
else
SECRET_KEY=$SECRET_KEY
export SECRET_KEY
fi
echo 'SECRET_KEY is ' $SECRET_KEY

echo "download go version and run case"
cd ./golang
go mod init nacos_go_test
go get github.com/nacos-group/nacos-sdk-go/v2/clients@v2.2.2
cat go.mod
go mod tidy
gotestsum --junitfile ./TEST-report.xml