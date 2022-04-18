## Generate autorest code

``` yaml $(java)
batch:
  - package-metadata: true
  - package-account: true
```

``` yaml $(package-metadata)
tag: package-2021-07-01-preview
output-folder: $(java-sdks-folder)/sdk/purview/azure-analytics-purview-administration

java: true
namespace: com.azure.analytics.purview.administration
data-plane: true
credential-types: tokencredential
credential-scopes: https://purview.azure.net/.default
generate-samples: true
title: PurviewMetadataClient
service-name: PurviewMetadata
artifact-id: azure-analytics-purview-administration
service-versions:
  - 2021-07-01-preview

generate-builder-per-client: false
```

``` yaml $(package-account)
tag: 2019-11-01-preview
input-file:
  - Azure.Analytics.Purview.Account/preview/2019-11-01-preview/account.json
output-folder: $(java-sdks-folder)/sdk/purview/azure-analytics-purview-administration

java: true
namespace: com.azure.analytics.purview.administration
license-header: MICROSOFT_MIT_SMALL
data-plane: true
credential-types: tokencredential
credential-scopes: https://purview.azure.net/.default
generate-samples: true
title: PurviewAccountClient
artifact-id: azure-analytics-purview-administration
service-name: PurviewAccount
service-versions:
  - 2019-11-01-preview

generate-builder-per-client: false
```
