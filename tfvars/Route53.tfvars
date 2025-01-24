dns_domain     = "vm.delivery.hansencx.com"
aws_provider   = "default"
region         = "us-east-1"
cluster_name   = "vmanep-use1-dev3-csf-eks"
hosted_zone_id = "Z0362731FLNB9XG7BLIO"
product        = "CSF"

custom_ingress = {
  # App URLs. Each URL should map to the respective service. The format can vary, but it must contain the service keyword.
  # <dns_domain> value will be appended after whatever you provide as a value here Ex: test-grafana.prov.delivery.hansencx.com
  app_urls = {
    grafana    = "grafana-vmanep-use1-dev3-csf"    # Example: test-grafana or grafana-domain
    kibana     = "kibana-vmanep-use1-dev3-csf"     # Example: test-grafana or kibana-domain
    jaeger     = "jaeger-vmanep-use1-dev3-csf"     # Example: test-grafana or jaeger-domain
    argocd     = "argocd-vmanep-use1-dev3-csf"     # Example: test-grafana or argocd-domain
    prometheus = "prometheus-vmanep-use1-dev3-csf" # Example: test-grafana or prometheus-domain
  }

  # albRecs here used for creating cognito app callback urls.
  # Uncomment the product(s) and provide with the customized subdomain value completely except .<dns_domain> with comma(,) seperated for multiple
  # Allowed App callback urls gets created based on customized values Ex: https://catalog-ui-cluster.prov.delivery.hansencx.com/oauth2/idpresponse
  albRecs = {
    # Catalog = [] # <dns_domain> value will be appended after whatever you give here
    # CPQ     = []
    PI      = [ "pi-ui-vmanep-use1-dev3-csf" ]
    # CS      = []
    OM      = ["grafana-vmanep-use1-dev3-csf", "jaeger-vmanep-use1-dev3-csf", "kibana-vmanep-use1-dev3-csf", "prometheus-vmanep-use1-dev3-csf", "om-ui-oct-vmanep-use1-dev3-csf", "om-ui-runtime-vmanep-use1-dev3-csf"]
    # INF     = []
    # TL      = []
    # PROV    = []
  }
  # nlbRecs here used for creating cognito api callback urls.
  # Uncomment the product(s) and provide with the customized record name completely except .<dns_domain> with comma(,) seperated for multiple
  # Allowed Api callback urls gets created based on customized values Ex: https://catalog-api-cluster.prov.delivery.hansencx.com/oauth2/idpresponse
  nlbRecs = {
    # Catalog = [] # <dns_domain> value will be appended after whatever you give here
    # CPQ     = []
    PI      = ["pi-core-vmanep-use1-dev3-csf", "pi-history-vmanep-use1-dev3-csf"]
    CS      = ["cs-core-vmanep-use1-dev3-csf"]
    OM      = ["om-api-vmanep-use1-dev3-csf", "argocd-vmanep-use1-dev3-csf"]
    # INF     = []
    TL      = ["dso-api-vmanep-use1-dev3-csf", "dso-api-query-vmanep-use1-dev3-csf", "dso-audit-vmanep-use1-dev3-csf", "dso-core-vmanep-use1-dev3-csf", "dso-notification-vmanep-use1-dev3-csf", "dso-notification-stub-vmanep-use1-dev3-csf"]
    # PROV    = []
  }
  # Uncomment and replace with actual full signout URLs data with proper postfix value relevant to your environment only for PROV
  signout_urls = {
    # PROV = ["https://replace-with-workflow-signout-url", "https://replace-with-operations-signout-url"]
  }
}
