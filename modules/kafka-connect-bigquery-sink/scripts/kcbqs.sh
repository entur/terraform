#!/bin/bash

KAFKA_CONNECT_URL=http://$CONNECT_REST_ADVERTISED_HOST_NAME:$CONNECT_REST_PORT/connectors
CONFIG_PAYLOAD=/etc/kafka-connect-bigquery-sink/config/kafka-connect-bigquery-sink.json
CONNECTOR_NAME=kafka-connect-bigquery-sink

displayUsage() {
  echo "Kafka Connect - BigQuery Sink Connector management script"
  echo -e "Usage: $0 [--status|--start|--stop] \n"
}

isConnected() {
  curl -s $KAFKA_CONNECT_URL | jq ".[]" | grep -wc $CONNECTOR_NAME
}

statusCheck() {
  if [ "$(isConnected)" -eq 1 ]; then
    echo "Active configuration: $CONNECTOR_NAME"
    return 0
  else
    echo "No active configuration found!"
    return 1
  fi
}

stopConnector() {
  if [ "$(isConnected)" -eq 1 ]; then
    status=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE $KAFKA_CONNECT_URL/$CONNECTOR_NAME)
    if [ $status == 204 ]; then
      echo "Unregistered configuration: $CONNECTOR_NAME"
      return 0
    else
      echo "Failed to unregistered configuration: $CONNECTOR_NAME, Status code: $status"
      return 1
    fi
  else
    echo "No registered configuration found to stop"
    return 0
  fi
}

# wait for Kafka connect to be up and running..
waitForKafkaConnect() {
  waittime="3 minute"
  endtime=$(date -ud "$waittime" +%s)
  while [ $(curl -s -o /dev/null -w %{http_code} $KAFKA_CONNECT_URL) != 200 ] && [ $(date -u +%s) -le $endtime ]; do
    echo -e $(date) "\tKafka Connect HTTP state: " $(curl -s -o /dev/null -w %{http_code} $KAFKA_CONNECT_URL) " (waiting for 5s)"
    sleep 5
  done
}

startConnector() {
  waitForKafkaConnect
  if [ "$(isConnected)" -eq 0 ]; then
    status=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Accept:application/json" -H "Content-Type:application/json" $KAFKA_CONNECT_URL/ -d @$CONFIG_PAYLOAD)
    if [[ $status == 201 ]]; then
      echo "Registered new configuration: $CONNECTOR_NAME"
      return 0
    else
      echo "Failed to registered configuration: $CONNECTOR_NAME, Status code: $status"
      return 1
    fi
  else
    echo "Registered configuration: $CONNECTOR_NAME already exists"
    return 0
  fi
}

# Only one argument expected, display usage otherwise
if [ $# -ne 1 ]; then
  displayUsage
  exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
case "$1" in
"--start")
  startConnector
  ;;
"--stop")
  stopConnector
  ;;
"--status")
  statusCheck
  ;;
*)
  displayUsage
  ;;
esac
