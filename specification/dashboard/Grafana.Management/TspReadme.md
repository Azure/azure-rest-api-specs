

``` yaml

library-name: Grafana
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


```
