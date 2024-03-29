#!/usr/bin/env bash

KEY_NAME=$1
POD_NAME=$(kubectl get pods --namespace "default" -l "app=openvpn,release=openvpn" -o jsonpath='{ .items[0].metadata.name }')
SERVICE_NAME=$(kubectl get svc --namespace "default" -l "app=openvpn,release=openvpn" -o jsonpath='{ .items[0].metadata.name }')
SERVICE_IP=$(kubectl get svc --namespace "default" "$SERVICE_NAME" -o go-template='{{ range $k, $v := (index .status.loadBalancer.ingress 0)}}{{ $v }}{{end}}')

kubectl --namespace "default" exec -it "$POD_NAME" /etc/openvpn/setup/newClientCert.sh "$KEY_NAME" "$SERVICE_IP"
kubectl --namespace "default" exec -it "$POD_NAME" cat "/etc/openvpn/certs/pki/$KEY_NAME.ovpn" > "$KEY_NAME.ovpn"
