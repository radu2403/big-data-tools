# Get the URL with kubectl
```shell
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server} '
```

# Setting the K8s config file
The config files are found in 2 places
1) the WSL2 command
```shell
code ~/.kube/config
```
2) the Windiws UI
```shell
code /mnt/c/Users/user/.kube/config
```

# Test command
```shell
bin/spark-submit \
        --master k8s://https://0aa48fb2-1328-4e35-b0a3-28af096a65c8.it-mil-1.linodelke.net:443 \
        --deploy-mode cluster \
        --name pi-test \
        --conf spark.kubernetes.namespace=spark \
        --class org.apache.spark.examples.SparkPi \
        --conf spark.kubernetes.driver.pod.name=pi-test-driver \
        --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
        --conf spark.kubernetes.driver.request.cores=1000m \
        --conf spark.kubernetes.driver.limit.cores=1000m \
        --conf spark.kubernetes.driver.limit.memory=1000Mi \
        --conf spark.kubernetes.authenticate.executor.serviceAccountName=spark \
        --conf spark.kubernetes.executor.podNamePrefix=pi-test-exc \
        --conf spark.kubernetes.executor.request.cores=1000m \
        --conf spark.kubernetes.executor.limit.cores=1000m \
        --conf spark.kubernetes.executor.limit.memory=1000Mi \
        --conf spark.executor.instances=1 \
        --conf spark.executor.cores=1 \
        --conf spark.cores.max=1 \
        --conf spark.executor.memory=1000m \
        --conf spark.kubernetes.container.image=wiseupdata/pyspark:3.4.0 \
        --conf spark.kubernetes.container.image.pullPolicy=Always \
        local:///mnt/c/Spark/spark-3.4.0-bin-hadoop3/examples/jars/spark-examples_2.12-3.4.0.jar 10
```
