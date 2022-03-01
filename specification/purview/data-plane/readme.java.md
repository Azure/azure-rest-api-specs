## Java

``` yaml $(java)
packages:
- name: azure-analytics-purview-administration
  input-file:
  - Azure.Analytics.Purview.MetadataPolicies/preview/2021-07-01-preview/purviewMetadataPolicy.json
  - Azure.Analytics.Purview.Account/preview/2019-11-01-preview/account.json
  tag: package-administration
- name: azure-analytics-purview-catalog
  input-file:
  - Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
  tag: package-catalog
- name: azure-analytics-purview-scanning
  input-file:
  - Azure.Analytics.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
```

``` yaml $(java) && $(tag) == 'package-administration'
batch:
  - package-metadata: true
  - package-account: true
```

``` yaml $(java) && $(package-metadata)
input-file:
  - https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/purview/data-plane/Azure.Analytics.Purview.MetadataPolicies/preview/2021-07-01-preview/purviewMetadataPolicy.json

java: true
namespace: com.azure.analytics.purview.administration
license-header: MICROSOFT_MIT_SMALL
low-level-client: true
generate-samples: true
title: PurviewMetadataClient
service-name: PurviewMetadata
artifact-id: azure-analytics-purview-administration
service-versions:
  - 2021-07-01-preview
```

``` yaml $(java) && $(package-account)
input-file:
  - https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/purview/data-plane/Azure.Analytics.Purview.Account/preview/2019-11-01-preview/account.json

java: true
namespace: com.azure.analytics.purview.administration
license-header: MICROSOFT_MIT_SMALL
low-level-client: true
generate-samples: true
title: PurviewAccountClient
artifact-id: azure-analytics-purview-administration
service-name: PurviewAccount
service-versions:
  - 2019-11-01-preview
```

``` yaml $(java) && $(tag) == 'package-catalog'
input-file: Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
java: true
namespace: com.azure.analytics.purview.catalog
generate-client-interfaces: false
sync-methods: all
license-header: MICROSOFT_MIT_SMALL
low-level-client: true
title: PurviewCatalogClient
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
