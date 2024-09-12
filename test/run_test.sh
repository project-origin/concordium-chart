#!/bin/bash

# Ensures script fails if something goes wrong.
set -eo pipefail

# define variables
cluster_name=concordium-test
cluster_context_name=kind-${cluster_name}
install_name=concordium-test

# define cleanup function
cleanup() {
    kind delete cluster --name ${cluster_name} >/dev/null 2>&1
}

# define debug function
debug() {
    echo -e "\n\nTest failed ❌"
    echo -e "\nDebugging information:"
    echo -e "\nHelm list:"
    helm list --kube-context ${cluster_context_name}

    echo -e "\nHelm status:"
    helm status ${install_name} --show-desc --show-resources --kube-context ${cluster_context_name}
}

# trap cleanup function on script exit
trap 'cleanup' 0
trap 'debug; cleanup' ERR

# create kind cluster
kind delete cluster -n ${cluster_name}
kind create cluster -n ${cluster_name}

# install chart
helm install ${install_name} chart --set network=mainnet,collector.enabled=false --kube-context ${cluster_context_name} --wait

# wait for the statefulset to be available
kubectl wait --for=condition=available deployment/${install_name} --timeout=120s --context ${cluster_context_name}

echo -e "\nTest completed successfully ✅\n"
