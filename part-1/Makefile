DEP_NAME=part-1
deployment_name := $(shell gcloud deployment-manager deployments list --format="value(name)")

.PHONY : cluster tiller prometheus ingress echo
cluster :
ifeq ($(deployment_name), $(DEP_NAME))
	@echo Deployment Exists
else
	cd cluster && gcloud deployment-manager deployments create $(DEP_NAME) --config=cluster.yaml
endif
	gcloud container clusters get-credentials $(DEP_NAME)-insecure-cluster
tiller : cluster
	kubectl apply -f serviceaccount.yaml
	helm init --service-account=tiller
prometheus :
	helm install -f prometheus-operator/values.yaml -n prometheus --namespace monitoring stable/prometheus-operator
ingress :
	helm install -f nginx-ingress/values.yaml -n nginx --namespace default stable/nginx-ingress
destroy :
	gcloud deployment-manager deployments delete $(DEP_NAME) --quiet
