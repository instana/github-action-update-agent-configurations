#!/bin/sh -le

readonly INSTANA_AGENT_TAG="${1}"

if [ -z "${INSTANA_API_ENDPOINT}" ]; then
    echo "The required 'INSTANA_API_ENDPOINT' environment variable is not set"
    exit 2
fi

if [ -z "${INSTANA_API_KEY}" ]; then
    echo "The required 'INSTANA_API_KEY' environment variable is not set"
    exit 2
fi

echo "Triggering the configuration update of agents using the following tags: '${INSTANA_AGENT_TAG}'"

if RESPONSE=$(curl \
    --location \
    --silent \
    --fail \
    --request POST \
    --header "authorization: apiToken ${INSTANA_API_KEY}" \
    -w "%{http_code}" \
    "${INSTANA_API_ENDPOINT}/api/host-agent/configuration/update?query=entity.tag:${INSTANA_AGENT_TAG}")
then
    echo "The configuration update succeeded"
else
    echo "The configuration update failed: ${RESPONSE}"
    exit 1
fi