# Notes
Kubernetes (k8s) needs three components to be set up / configured for a web service to work correctly:
- **Deployment**: these are the containers that run the actual applications. These need Docker images and the configuration is slightly different from docker-compose files.
- **Service**: this layer sets up the internal networking configuration, e.g. mapping pod ports to container ports. 
- **Ingress**: this layer configures the external host names, ports, TLS certificates etc.

## Ingress
- The ingress layer uses the officially provided (by Kubernetes) [ingress-nginx](https://github.com/kubernetes/ingress-nginx).
- Other options include Traefik, Kong, haproxy. Of these Traefik has been tried and proved difficult to configure.
- TLS certificates are issued by [cert-manager](https://github.com/jetstack/cert-manager) in coordination with [Let's Encrypt](https://letsencrypt.org/)

# Steps
- Set up ingress-nginx with a DigitalOcean LoadBalancer so that we have a public facing IP - apply both: `mandatory` and `cloud-generic` templates (see reference below).
- Create two `A` records in DNS settings to map to the public facing IP created above: subdomain + wildcard (strictly, only the wildcard is needed but e.g. you can use k8s.jaagalabs.com in the next point).
- Edit the cloud-generic template to add an annotation to point to domain name added in the previous step. This is needed to fix [this bug](https://github.com/jetstack/cert-manager/issues/863#issuecomment-567062996) that prevents SSL certs from being issued.
- Set up a certificate issuer that uses the production server of Let's Encrypt and link it to the ingress.
- Create and deploy yaml file that includes `Deployment` and `Service`
- Create and deploy ingress file that sets up hostnames + TLS

# References
- [How to Set Up an Nginx Ingress with Cert-Manager on DigitalOcean Kubernetes](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes)
- To fix cert issue: https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes