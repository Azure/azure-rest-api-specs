## Generate autorest code
```yaml
input-file: https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/purview/data-plane/Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
java: true
output-folder: ../
namespace: com.azure.analytics.purview.catalog
generate-client-interfaces: false
sync-methods: all
license-header: MICROSOFT_MIT_SMALL
low-level-client: true
credential-types: tokencredential
credential-scopes: https://purview.azure.net/.default
title: PurviewCatalogClient
artifact-id: azure-analytics-purview-catalog
service-name: PurviewCatalog
service-versions:
  - 2021-05-01-preview
generate-client-as-impl: true
add-context-parameter: true
context-client-method-parameter: true
generate-sync-async-clients: true
generate-samples: true
polling: {}

generate-builder-per-client: false
```
