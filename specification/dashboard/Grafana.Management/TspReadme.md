

``` yaml

library-name: Grafana
namespace: Azure.ResourceManager.Grafana
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/0235efbc79f71f77932a7df73fbda71351524f9a/specification/dashboard/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  AzureMonitorWorkspaceIntegration: MonitorWorkspaceIntegration
  AzureMonitorWorkspaceIntegration.azureMonitorWorkspaceResourceId: MonitorWorkspaceResourceId|arm-id
  GrafanaIntegrations.azureMonitorWorkspaceIntegrations: MonitorWorkspaceIntegrations
  ManagedGrafanaPropertiesUpdateParameters: ManagedGrafanaPatchProperties

  ResourceSku: ManagedGrafanaSku

prepend-rp-prefix:
  - ApiKey
  - PublicNetworkAccess
  - ProvisioningState
  - ZoneRedundancy

format-by-name-rules:
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'
  'privateLinkResourceId': 'arm-id'

acronym-mapping:
  CPU: Cpu
  CPUs: Cpus
  Os: OS
  Ip: IP
  Ips: IPs|ips
  ID: Id
  IDs: Ids
  VM: Vm
  VMs: Vms
  Vmos: VmOS
  VMScaleSet: VmScaleSet
  DNS: Dns
  VPN: Vpn
  NAT: Nat
  WAN: Wan
  Ipv4: IPv4|ipv4
  Ipv6: IPv6|ipv6
  Ipsec: IPsec|ipsec
  SSO: Sso
  URI: Uri
  Etag: ETag|etag

```
