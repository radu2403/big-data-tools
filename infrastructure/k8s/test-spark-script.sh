#!/bin/bash

/mnt/c/Spark/spark-3.4.0-bin-hadoop3/bin/spark-submit \
    --master k8s://https://bd99f767-27db-4dd2-b751-740f640ed648.eu-central-1.linodelke.net:443 \
        --deploy-mode cluster \
        --name pi-test \
        --conf spark.kubernetes.namespace=spark \
        --class org.apache.spark.examples.SparkPi \
        --conf spark.kubernetes.driver.pod.name=pi-test-driver3 \
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