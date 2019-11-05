#!/usr/bin/env bash

KEY_NAME=$1
POD_NAME=$(kubectl get pods -n "default" -l "app=openvpn,release=openvpn" -o jsonpath='{.items[0].metadata.name}')
kubectl -n "default" exec -it "$POD_NAME" /etc/openvpn/setup/revokeClientCert.sh $KEY_NAME
