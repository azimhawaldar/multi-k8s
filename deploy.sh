docker build -t azimah/multi-client:latest -t azimah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t azimah/multi-server:latest -t azimah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t azimah/multi-worker:latest -t azimah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push azimah/multi-client:latest
docker push azimah/multi-server:latest
docker push azimah/multi-worker:latest

docker push azimah/multi-client:$SHA
docker push azimah/multi-server:$SHA
docker push azimah/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=azimah/multi-server:$SHA
kubectl set image deployments/client-deployment client=azimah/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=azimah/multi-worker:$SHA


