#!/bin/bash
set -e

# Function to deregister the runner
remove_runner() {
    echo "Deregistering runner..."
    ./config.sh remove --unattended --token $TOKEN
}

# Register trap to remove the runner when the container stops
trap 'remove_runner; exit 130' INT
trap 'remove_runner; exit 143' TERM

# Check if the necessary environment variables are set
if [ -z "$REPO_URL" ] || [ -z "$TOKEN" ]; then
    echo "Error: REPO_URL and TOKEN environment variables must be set."
    exit 1
fi

# Determine the runner name
RUNNER_NAME=${DOCKER_NAME:-$(hostname)}

# Check if the runner is already configured
if [ -f ".runner" ]; then
    echo "Runner already configured. Skipping registration."
else
    echo "Configuring runner..."
    ./config.sh --url $REPO_URL --token $TOKEN --name $RUNNER_NAME --work _work --replace --unattended --labels $LABELS
fi

# Start the runner
./run.sh