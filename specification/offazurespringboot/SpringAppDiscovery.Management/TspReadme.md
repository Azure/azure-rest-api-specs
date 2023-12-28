

``` yaml
library-name: SpringAppDiscovery
namespace: Azure.ResourceManager.SpringAppDiscovery
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/c1ba9df47907f9012ae14ca4616aed9e5665f9e5/specification/offazurespringboot/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

mgmt-debug:
 show-serialized-names: true

rename-mapping:
    SpringbootsitesModel: SpringBootSite
    SpringbootsitesPatch: SpringBootSitePatch
    SpringbootsitesProperties: SpringBootSiteProperties
    SpringbootsitesListResult: SpringBootSiteList
    SpringbootserversModel: SpringBootServer
    SpringbootserversPatch: SpringBootServerPatch
    SpringbootserversProperties: SpringBootServerProperties
    SpringbootserversProperties.machineArmId: -|arm-id
    SpringbootserversProperties.fqdnAndIpAddressList: -|ip-address
    SpringbootserversListResult: SpringBootServerList
    SpringbootappsModel: SpringBootApp
    SpringbootappsPatch: SpringBootAppPatch
    SpringbootappsProperties: SpringBootAppProperties
    SpringbootappsProperties.machineArmIds: -|arm-id
    SpringbootappsListResult: SpringBootAppList
    ProvisioningState: SpringAppDiscoveryProvisioningState
    Error: SpringBootSiteError
    ErrorSummary: SpringBootSiteErrorSummary
    ErrorSummariesProperties: SpringBootSiteErrorSummariesProperties
    ErrorSummaryModel: SpringBootSiteErrorSummaryModel
    Summary: SpringBootSiteSummary
    SummariesProperties: SpringBootSiteSummariesProperties
    SpringbootsitesModelExtendedLocation: SpringBootSiteModelExtendedLocation
    SpringbootappsPropertiesMiscsItem: SpringBootAppMiscsItem
    SpringbootappsPropertiesApplicationConfigurationsItem: SpringBootAppApplicationConfigurationsItem
    SpringbootappsPropertiesInstancesItem: SpringBootAppInstancesItem
    SpringbootappsPropertiesInstancesItem.machineArmId: -|arm-id

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'

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
