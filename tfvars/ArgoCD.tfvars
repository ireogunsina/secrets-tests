aws_provider = "default" # (e.g., "default")
region       = "us-east-1"   # (e.g., "us-east-1")

# The name of the Kubernetes cluster where ArgoCD will be deployed.
cluster_name   = "vmanep-use1-qa5-csf-eks" # (e.g., "test-cluster")
dns_domain     = "vm.delivery.hansencx.com" # (e.g., "xxx.xxxxx.hansencx.com)

#The argocd va;ue should  be same as eks config tfvars file
custom_ingress = {
  app_urls = {
    argocd     = "argocd-vmanep-use1-qa5-csf"     # Example: test-argocd or argocd-domain
  }
}

# argocd ldap configuration
ldap_info = {
  ldap_name         = "n/a"          # (e.g., HansenTxxxx)
  ldap_bindDN       = "n/a"       # (e.g., CN=xxxxx,OU=xxx Axxxxs,OU=Hansen,DC=hsxxxh,DC=xxx)
  ldap_user_baseDN  = "n/a"  # (e.g., OU=Users,OU=xxx,OU=Hansen,DC=hsxxxh,DC=xxx)
  ldap_group_baseDN = "n/a" # (e.g., OU=Hansen,DC=hxxxh,DC=xxx) 
}

# BEGIN ANSIBLE MANAGED BLOCK

es_log_endpoint = "vpc-vmanep-use1-qa5-csf-es-5iqnyo4bpdkysnnx2w5qn7mj3m.us-east-1.es.amazonaws.com"
# END ANSIBLE MANAGED BLOCK

