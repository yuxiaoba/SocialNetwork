#!/bin/bash

cd $(dirname $0)/..
NS="social-network"

kubectl create namespace ${NS}

./scripts/create-all-configmap.sh 

# The following script optionally creates local docker images suitable for local customization.
# ./scripts/build-docker-img.sh

for service in *.yaml ;  do
  kubectl apply -f $service -n ${NS}
done



cd - >/dev/null
