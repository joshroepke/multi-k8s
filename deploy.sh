docker build -t joshroepke/multi-client:latest -t joshroepke/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joshroepke/multi-server:latest -t joshroepke/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joshroepke/multi-worker:latest -t joshroepke/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push joshroepke/multi-client:latest
docker push joshroepke/multi-server:latest
docker push joshroepke/multi-worker:latest
docker push joshroepke/multi-client:$SHA
docker push joshroepke/multi-server:$SHA
docker push joshroepke/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=joshroepke/multi-server:$SHA
kubectl set image deployments/client-deployment client=joshroepke/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=joshroepke/multi-worker:$SHA
