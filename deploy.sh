docker build -t bharadhwajt/multi-client:latest  -t bharadhwajt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bharadhwajt/multi-server:latest  -t bharadhwajt/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t bharadhwajt/multi-worker:latest  -t bharadhwajt/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push bharadhwajt/multi-client:latest
docker push bharadhwajt/multi-server:latest
docker push bharadhwajt/multi-worker:latest
docker push bharadhwajt/multi-client:$SHA
docker push bharadhwajt/multi-server:$SHA
docker push bharadhwajt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bharadhwajt/multi-server:$SHA
kubectl set image deployments/client-deployment server=bharadhwajt/multi-client:$SHA
kubectl set image deployments/worker-deployment server=bharadhwajt/multi-worker:$SHA