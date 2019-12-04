docker build -t $DOCKER_USERNAME/fibonacci-client:latest -t $DOCKER_USERNAME/fibonacci-client:$SHA ./client
docker build -t $DOCKER_USERNAME/fibonacci-server:latest -t $DOCKER_USERNAME/fibonacci-server:$SHA ./server
docker build -t $DOCKER_USERNAME/fibonacci-worker:latest -t $DOCKER_USERNAME/fibonacci-worker:$SHA ./worker

docker push $DOCKER_USERNAME/fibonacci-client:latest
docker push $DOCKER_USERNAME/fibonacci-server:latest
docker push $DOCKER_USERNAME/fibonacci-worker:latest

docker push $DOCKER_USERNAME/fibonacci-client:$SHA
docker push $DOCKER_USERNAME/fibonacci-server:$SHA
docker push $DOCKER_USERNAME/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=$DOCKER_USERNAME/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=$DOCKER_USERNAME/fibonacci-client:$SHA
kubectl set image deployments/worker-deployment worker=$DOCKER_USERNAME/fibonacci-worker:$SHA