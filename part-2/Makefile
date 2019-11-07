DEP_NAME=part-2
deployment_name := $(shell gcloud deployment-manager deployments list --format="value(name)")

.PHONY : cluster tiller prometheus ingress ingress-ext openvpn vpn-key rev-key
cluster :
ifeq ($(deployment_name), $(DEP_NAME))
	@echo Deployment Exists
else
	cd cluster && gcloud deployment-manager deployments create $(DEP_NAME) --config=cluster.yaml
endif
	gcloud container clusters get-credentials $(DEP_NAME)-secure-cluster
tiller : cluster
	kubectl apply -f serviceaccount.yaml
	helm init --service-account=tiller
prometheus :
	helm install -f prometheus-operator/values.yaml -n prometheus --namespace monitoring stable/prometheus-operator
ingress :
	helm install -f nginx-ingress-internal/values.yaml -n nginx-internal --namespace default stable/nginx-ingress
	helm install -f nginx-ingress/values.yaml -n nginx --namespace default stable/nginx-ingress
openvpn :
	helm install -f openvpn/values.yaml -n openvpn --namespace default stable/openvpn
destroy :
	gcloud deployment-manager deployments delete $(DEP_NAME) --quiet
vpn-key :
	./create-vpn.sh $(user)
rev-key :
	./revoke-vpn.sh $(user)
