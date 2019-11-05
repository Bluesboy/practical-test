### Requirements
- **gcloud** installed and configured to work with project
- **kubectl**, **helm**, **make** installed

### Targets
#### Part 1
- **cluster** -- create GKE cluster and get context for kubectl
- **tiller** -- initiate helm in current GKE cluster
- **prometheus** -- install prometheus-operator
- **ingress** -- install nginx-ingress
- **destroy** -- destroy GKE cluster with GCP deployment

#### Part 2
- **cluster** -- create GKE cluster and get context for kubectl
- **tiller** -- initiate helm in current GKE cluster
- **prometheus** -- install prometheus-operator
- **ingress** -- install nginx-ingress
- **openvpn** -- install OpenVPN server
- **vpn-key** -- create OpenVPN configuration file for user, requeres **user** argument ```make vpn-key user=<username>```
- **rev-key** -- revoke OpenVPN certificate for user, requeres **user** argument ```make rev-key user=<username>```
- **destroy** -- destroy GKE cluster with GCP deployment
