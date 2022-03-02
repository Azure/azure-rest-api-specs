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
  tag: package-catalog-2021-05-preview
- name: azure-analytics-purview-scanning
  input-file:
  - Azure.Analytics.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
```

### administration

``` yaml $(java) && $(tag) == 'package-administration'
batch:
  - package-metadata: true
  - package-account: true
```

``` yaml $(java) && $(package-metadata)
input-file: Azure.Analytics.Purview.MetadataPolicies/preview/2021-07-01-preview/purviewMetadataPolicy.json
namespace: com.azure.analytics.purview.administration
low-level-client: true
generate-samples: true
title: PurviewMetadataClient
service-name: PurviewMetadata
artifact-id: azure-analytics-purview-administration
service-versions:
  - 2021-07-01-preview

generate-builder-per-client: false
```

``` yaml $(java) && $(package-account)
input-file: Azure.Analytics.Purview.Account/preview/2019-11-01-preview/account.json
namespace: com.azure.analytics.purview.administration
low-level-client: true
generate-samples: true
title: PurviewAccountClient
artifact-id: azure-analytics-purview-administration
service-name: PurviewAccount
service-versions:
  - 2019-11-01-preview

generate-builder-per-client: false
```

### catalog

``` yaml $(java) && $(tag) == 'package-catalog-2021-05-preview'
namespace: com.azure.analytics.purview.catalog
low-level-client: true
title: PurviewCatalogClient
service-versions:
  - 2021-05-01-preview
generate-samples: true
polling: {}

generate-builder-per-client: false
```
