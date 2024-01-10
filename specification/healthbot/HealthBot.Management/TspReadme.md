

``` yaml

library-name: HealthBot
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/6b08774c89877269e73e11ac3ecbd1bd4e14f5a0/specification/healthbot/resource-manager/readme.md
tag: package-2021-08-24
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  HealthBotProperties.botManagementPortalLink: -|uri
  HealthBotProperties: HealthBotProperties
  KeyVaultProperties: HealthBotKeyVaultProperties

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


```
