docker build -t okram/multi-client:latest -t okram/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t okram/multi-server:latest -t okram/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t okram/multi-worker:latest -t okram/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push okram/multi-client:latest
docker push okram/multi-server:latest
docker push okram/multi-worker:latest

docker push okram/multi-client:$SHA
docker push okram/multi-server:$SHA
docker push okram/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=okram/multi-server:$SHA
kubectl set image deployments/client-deployment client=okram/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=okram/multi-worker:$SHA