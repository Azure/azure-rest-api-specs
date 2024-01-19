

``` yaml
library-name: ApiCenter
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/a29126ca8200a6c981a4e908e41fe55730df4cad/specification/apicenter/resource-manager/readme.md
#tag: package-2023-07-01-preview
skip-csproj: true
modelerfour:
  flatten-payloads: false

#mgmt-debug: 
#  show-serialized-names: true

rename-mapping:
  ServiceCollection: ApiCenterServiceListResult

prepend-rp-prefix:
  - ProvisioningState
  - Service

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
