## Running the social network application on Kubernetes

### Before you start

Get the IP address for the DNS resolver. Then set it in files such as:
- `<path-of-repo>/socialNetwork/openshift/nginx-web-server-config/nginx.conf`
- `<path-of-repo>/socialNetwork/openshift/media-frontend-config/nginx.conf`

### Deploy services

Run the script `<path-of-repo>/socialNetwork/kubernetes/scripts/deploy-all-services-and-configurations.sh`


### Register users and construct social graphs

- If using an off-cluster client:
  - Use `kubectl -n social-network get svc nginx-thrift` to get the cluster-ip.
  - Paste the cluster ip at `<path-of-repo>/socialNetwork/scripts/init_social_graph.py:72`
- If using an on-cluster client:
  - Use `nginx-thrift.social-network.svc.cluster.local` as cluster-ip and paste it at `<path-of-repo>/socialNetwork/scripts/init_social_graph.py:72`
- Register users and construct social graph by running `cd <path-of-repo>/socialNetwork && python3 scripts/init_social_graph.py`.
  This will initialize a social graph based on [Reed98 Facebook Networks](http://networkrepository.com/socfb-Reed98.php), with 962 users and 18.8K social graph edges. 

### Running HTTP workload generator
```
cd `<path-of-repo>/socialNetwork/kubernetes/loadgenerator
kubectl apply -f loadgenerator-compose.yaml
kubectl apply -f loadgenerator-home.yaml
kubectl apply -f loadgenerator-user.yaml
```

