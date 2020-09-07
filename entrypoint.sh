#!/bin/bash

if [ -z "${INSTANA_API_ENDPOINT}" ]; then
    echo "The required 'INSTANA_API_ENDPOINT' environment variable is not set"
    exit 3
fi

if [ -z "${INSTANA_API_TOKEN}" ]; then
    echo "The required 'INSTANA_API_TOKEN' environment variable is not set"
    exit 3
fi

readonly INSTANA_AGENT_TAGS="${1}"
readonly INSTANA_AGENT_ZONE="${2}"

if [ -n "${INSTANA_AGENT_ZONE}" ]; then
    query="entity.zone:\"${INSTANA_AGENT_ZONE}\""
fi

if [ -n "${INSTANA_AGENT_TAGS}" ]; then
    IFS=',' read -r -a tags <<< "${INSTANA_AGENT_TAGS}"

    for tag in "${tags[@]}"
    do
        if [ -n "${query}" ]; then
            query="${query} AND entity.tag:\"${tag}\""
        else 
            query="entity.tag:\"${tag}\""
        fi
    done
fi

echo "Triggering the configuration update of agents matching the following query: '${query}'"

if RESPONSE=$(curl \
    --location \
    --silent \
    --fail \
    --request POST \
    --header "authorization: apiToken ${INSTANA_API_TOKEN}" \
    --write-out "%{http_code}" \
    "${INSTANA_API_ENDPOINT}/api/host-agent/configuration?query=${query// /%20}")
then
    echo "The configuration update succeeded"
else
    echo "The configuration update failed with status code: ${RESPONSE}"
    exit 1
fi