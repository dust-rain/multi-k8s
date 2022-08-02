docker build -t lizard4garden/multi-client:latest -t lizard4garden/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lizard4garden/multi-server:latest  -t lizard4garden/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lizard4garden/multi-worker:latest -t lizard4garden/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push lizard4garden/multi-client:latest
docker push lizard4garden/multi-server:latest
docker push lizard4garden/multi-worker:latest

docker push lizard4garden/multi-client:$SHA
docker push lizard4garden/multi-server:$SHA
docker push lizard4garden/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lizard4garden/multi-client:$SHA
kubectl set image deployments/server-deployment server=lizard4garden/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lizard4garden/multi-worker:$SHA
