#!/usr/bin/env bash


if [ $# -lt 1 ]; then
    echo "No overlay specified, please specify an overlay from bootstrap/overlays"
    exit 1
else
    OVERLAY=$1
    echo "Configuring cluster ${OVERLAY}"
fi

oc project openshift-gitops
kustomize build bootstrap/overlays/${OVERLAY}/operator | oc apply -f -

# wait until Operator is ready
oc wait --for=condition=ready pod -l control-plane=gitops-operator -n openshift-gitops-operator

kustomize build bootstrap/overlays/${OVERLAY}/instance | oc apply -f -

