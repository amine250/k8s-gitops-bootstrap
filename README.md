# k8s-gitops-bootstrap
This project creates 3 kind clusters : `admin-cluster` and `workload-cluster-1` then `workload-cluster-2`.

Then Argo CD is deployed on `admin-cluster`.

The goal of this project is to test how Argo CD can pick up new k8s clusters declaratively then deploy applications each on their respective cluster.
## Step 1
```sh
terraform init
terraform apply
```
## Step 2
Access Argo CD :
```sh
kubectl -n argocd port-forward service/argocd-server 3080:80
```

Visit : http://localhost:3080
* User: `admin`
* Password: `admin`





## Help
### Workaround for when being behind a corporate proxy self signed cert and get the error :
`Failed to pull image "ecr-public.aws.com/docker/library/redis:7.2.8-alpine": rpc error: code = Unknown desc = failed to pull and unpack image "ecr-public.aws.com/docker/library/redis:7.2.8-alpine": failed to resolve reference "ecr-public.aws.com/docker/library/redis:7.2.8-alpine": failed to do request: Head "https://ecr-public.aws.com/v2/docker/library/redis/manifests/7.2.8-alpine": tls: failed to verify certificate: x509: certificate signed by unknown authority`:
```sh
docker exec -it admin-cluster-worker bash
```
then
```sh
echo -e '[plugins."io.containerd.grpc.v1.cri".registry.mirrors."ecr-public.aws.com"]\n  endpoint = ["https://ecr-public.aws.com"]\n\n[plugins."io.containerd.grpc.v1.cri".registry.configs."ecr-public.aws.com".tls]\n  insecure_skip_verify = true' >> /etc/containerd/config.toml
```
```sh
systemctl restart containerd
crictl pull ecr-public.aws.com/docker/library/redis:7.2.8-alpine
```
```