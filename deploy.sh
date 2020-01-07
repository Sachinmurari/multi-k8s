docker build -t sachinmurari/multi-client:latest -t sachinmurari/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sachinmurari/multi-worker:latest -t sachinmurari/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t sachinmurari/multi-server:latest -t sachinmurari/multi-server:$SHA -f ./client/Dockerfile ./server
docker push sachinmurari/multi-client:latest
docker push sachinmurari/multi-server:latest
docker push sachinmurari/multi-worker:latest
docker push sachinmurari/multi-client:$SHA
docker push sachinmurari/multi-server:$SHA
docker push sachinmurari/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sachinmurari/multi-client:$SHA
kubectl set image deployments/server-deployment server=sachinmurari/multi-server:$SHA
kubectl set image deployments/server-deployment server=sachinmurari/multi-worker:$SHA
