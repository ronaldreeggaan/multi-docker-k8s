docker build -t ronaldreeggan/multi-docker-client:latest -t ronaldreeggan/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t ronaldreeggan/multi-docker-server:latest -t ronaldreeggan/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t ronaldreeggan/multi-docker-worker:latest -t ronaldreeggan/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ronaldreeggan/multi-docker-client:latest
docker push ronaldreeggan/multi-docker-server:latest
docker push ronaldreeggan/multi-docker-worker:latest

docker push ronaldreeggan/multi-docker-client:$SHA
docker push ronaldreeggan/multi-docker-server:$SHA
docker push ronaldreeggan/multi-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment multi-docker-server=ronaldreeggan/multi-docker-server:$SHA
kubectl set image deployments/client-deployment multi-docker-client=ronaldreeggan/multi-docker-client:$SHA
kubectl set image deployments/woker-deployment multi-docker-worker=ronaldreeggan/multi-docker-worker:$SHA