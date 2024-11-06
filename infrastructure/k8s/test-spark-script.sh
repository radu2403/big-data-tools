#!/bin/bash

kubectl delete pods --all -n default

/mnt/c/Spark/spark-3.4.0-bin-hadoop3/bin/spark-submit \
    --master k8s://https://0aa48fb2-1328-4e35-b0a3-28af096a65c8.it-mil-1.linodelke.net:443 \
        --deploy-mode cluster \
        --name pi-test \
        --conf spark.kubernetes.namespace=default \
        --class org.apache.spark.examples.SparkPi \
        --conf spark.kubernetes.driver.pod.name=pi-test-driver \
        --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
        --conf spark.kubernetes.driver.request.cores=500m \
        --conf spark.kubernetes.driver.limit.cores=500m \
        --conf spark.kubernetes.driver.limit.memory=500Mi \
        --conf spark.kubernetes.authenticate.executor.serviceAccountName=spark \
        --conf spark.kubernetes.executor.podNamePrefix=pi-test-exc \
        --conf spark.kubernetes.executor.request.cores=500m \
        --conf spark.kubernetes.executor.limit.cores=500m \
        --conf spark.kubernetes.executor.limit.memory=500Mi \
        --conf spark.executor.instances=1 \
        --conf spark.executor.cores=1 \
        --conf spark.cores.max=1 \
        --conf spark.executor.memory=500m \
        --conf spark.kubernetes.container.image=wiseupdata/pyspark:3.4.0 \
        --conf spark.kubernetes.container.image.pullPolicy=Always \
        local:///opt/spark/examples/jars/spark-examples_2.12-3.4.0.jar 100000

kubectl logs pi-test-driver -f
