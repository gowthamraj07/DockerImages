#!/bin/bash
set -e

# Export TARGETARCH to ensure the correct architecture is used
export TARGETARCH=${TARGETARCH:-$(uname -m)}

# Check if the necessary environment variables are set
if [ -z "$REPO_URL" ] || [ -z "$TOKEN" ]; then
    echo "Error: REPO_URL and TOKEN environment variables must be set."
    exit 1
fi

# Configuration name for the runner
RUNNER_NAME="${RUNNER_NAME:-$(hostname)}"

# Register the runner with the repository and disable auto-update
./config.sh --url $REPO_URL --token $TOKEN --name $RUNNER_NAME --work _work --replace --disableupdate

# Run the runner
./run.sh
