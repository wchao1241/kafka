#!/bin/sh

# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

/bin/sh -c "./bin/kafka-server-start.sh config/server.properties --override broker.id=$(hostname | awk -F'-' '{print $NF}') --override zookeeper.connect=$ZOO_SVC_NAME.$ZOO_NS.svc.cluster.local:2181"

while true; do   
	/bin/sh -c "./bin/kafka-topics.sh --create --zookeeper $ZOO_SVC_NAME.$ZOO_NS.svc.cluster.local:2181 --topic $TOPIC_TAG --replication-factor $REPLICAS --partitions 10"
    if [[ "$?" == "0" ]]; then
      break
    fi
	echo "create topics failed.  Waiting..."
    sleep 30
done 