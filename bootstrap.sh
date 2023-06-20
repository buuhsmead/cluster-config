#!/usr/bin/env bash


if [ $# -lt 1 ]; then
    echo "No overlay specified, please specify an overlay from bootstrap/overlays"
    exit 1
else
    OVERLAY=$1
    echo "Configuring cluster ${OVERLAY}"
fi

oc project cluster-gitops
kustomize build bootstrap/overlays/${OVERLAY} | oc apply -f -

