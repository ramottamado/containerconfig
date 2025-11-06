#!/bin/bash

set -e

SPARK_WORKLOAD="${SPARK_WORKLOAD:-master}"
SPARK_MASTER_URL="${SPARK_MASTER:-spark://spark-master:7077}"

clean_exit() {
  echo Received trapped signal, beginning shutdown...
  /opt/spark/sbin/stop-master.sh
  /opt/spark/sbin/stop-history-server.sh
  /opt/spark/sbin/stop-worker.sh
  exit 0
}

case "${SPARK_WORKLOAD}" in
  master)
  /opt/spark/sbin/start-master.sh #--properties-file /opt/spark/work-dir/conf/spark-defaults.conf
  ;;
  worker)
  /opt/spark/sbin/start-worker.sh "${SPARK_MASTER_URL}" #--properties-file /opt/spark/work-dir/conf/spark-defaults.conf
  ;;
  history)
  /opt/spark/sbin/start-history-server.sh #--properties-file /opt/spark/work-dir/conf/spark-defaults.conf
  ;;
esac

pid=$(pgrep java)

echo "Spark ${SPARK_WORKLOAD} started with PID ${pid}"

trap clean_exit TERM HUP INT
trap ":" EXIT

tail -F --pid="${pid}" /opt/spark/logs/*"${HOSTNAME}".out &

newpid="$!"

wait "${newpid}"
