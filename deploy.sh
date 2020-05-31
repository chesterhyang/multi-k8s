docker build -t chesterhyang/multi-client:latest -t chesterhyang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chesterhyang/multi-server:latest -t chesterhyang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chesterhyang/multi-worker:latest -t chesterhyang/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push chesterhyang/multi-client:latest
docker push chesterhyang/multi-server:latest
docker push chesterhyang/multi-worker:latest

docker push chesterhyang/multi-client:$SHA
docker push chesterhyang/multi-server:$SHA
docker push chesterhyang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chesterhyang/multi-server:$SHA
kubectl set image deployments/client-deployment client=chesterhyang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chesterhyang/multi-worker:$SHA