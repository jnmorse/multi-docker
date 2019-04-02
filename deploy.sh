# Build our images
docker build -t jnmorse/multi-client:latest -t jnmorse/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jnmorse/multi-server:latest -t jnmorse/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jnmorse/multi-worker:latest -t jnmorse/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push them to Docker Hub
docker push jnmorse/multi-client:latest
docker push jnmorse/multi-server:latest
docker psuh jnmorse/multi-worker:latest

docker push jnmorse/multi-client:$SHA
docker push jnmorse/multi-server:$SHA
docker psuh jnmorse/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jnmorse/multi-client:$SHA
kubectl set image deployments/server-deployment server=jnmorse/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jnmorse/multi-worker:$SHA
