# Get the URL with kubectl
```shell
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'
```