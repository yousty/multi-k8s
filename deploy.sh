docker build -t ncri/multi-client:latest -t ncri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ncri/multi-server:latest -t ncri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ncri/multi-worker:latest -t ncri/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ncri/multi-client:latest
docker push ncri/multi-server:latest
docker push ncri/multi-worker:latest

docker push ncri/multi-client:$SHA
docker push ncri/multi-server:$SHA
docker push ncri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ncri/multi-server:$SHA
kubectl set image deployments/client-deployment client=ncri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ncri/multi-worker:$SHA
