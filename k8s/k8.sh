#!/bin/bash

set -ex

kubectl delete all,ing --all

kubectl run config-server --expose --port=8888 --image=ibuchh/spring-petclinic-config-server  --image-pull-policy=Always
kubectl run discovery-server --expose --port=8761 --image=ibuchh/spring-petclinic-discovery-server  --image-pull-policy=Always
kubectl run admin-server --expose --port=9090 --image=ibuchh/spring-petclinic-admin-server  --image-pull-policy=Always



kubectl run vets-service --expose --port=8083 --image=ibuchh/spring-petclinic-vets-service --image-pull-policy=Always
kubectl run visits-service --expose --port=8082 --image=ibuchh/spring-petclinic-visits-service --image-pull-policy=Always
kubectl run customers-service --expose --port=8081 --image=ibuchh/spring-petclinic-customers-service  --image-pull-policy=Always

kubectl run hystrix-service --expose --port=7979 --image=ibuchh/spring-petclinic-hystrix-dashboard  --image-pull-policy=Always
kubectl run zipkin-service --expose --port=9411 --image=openzipkin/zipkin  --image-pull-policy=Always



kubectl run api-gateway --port=8080 --image=ibuchh/spring-petclinic-discovery-server --image-pull-policy=Always
kubectl expose deploy api-gateway --type=LoadBalancer

