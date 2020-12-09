docker build -t andreasbuc/multi-client:latest -t andreasbuc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andreasbuc/multi-server:latest -t andreasbuc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andreasbuc/multi-worker:latest -t andreasbuc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andreasbuc/multi-client:latest
docker push andreasbuc/multi-server:latest
docker push andreasbuc/multi-worker:latest

docker push andreasbuc/multi-client:$SHA
docker push andreasbuc/multi-server:$SHA
docker push andreasbuc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andreasbuc/multi-server:$SHA
kubectl set image deployments/client-deployment client=andreasbuc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andreasbuc/multi-worker:$SHA
