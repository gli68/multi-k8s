docker build -t gli68/multi-client:latest -t gli68/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gli68/multi-server:latest -t gli68/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gli68/multi-worker:latest -t gli68/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gli68/multi-client:latest
docker push gli68/multi-server:latest
docker push gli68/multi-worker:latest
docker push gli68/multi-client:$SHA
docker push gli68/multi-server:$SHA
docker push gli68/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gli68/multi-server:$SHA
kubectl set image deployments/client-deployment client=gli68/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gli68/multi-worker:$SHA

