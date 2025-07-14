# Helm Charts - Botpress Custom

Este repositório contém o Helm Chart personalizado para instalação do **Botpress** com:

- Persistência em PVC (Longhorn)
- PostgreSQL externo
- Ingress com Cert-Manager e TLS
- Segurança com `securityContext` para UID `999`
- InitContainers para chown e espera do PostgreSQL

## ✅ Repositório Helm

Adicione este repositório ao seu Helm:

```bash
helm repo add botpress-custom https://fernandohara.github.io/botpress-helm-chart
helm repo update

helm upgrade --install -n botpress-custom --create-namespace botpress-custom botpress-custom/botpress-custom -f botpress-custom-values.yaml