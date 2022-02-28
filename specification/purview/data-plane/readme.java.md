``` yaml
batch:
- service: purview
  module: azure-analytics-purview-administration
  input-file:
  - Azure.Analytics.Purview.MetadataPolicies/preview/2021-07-01-preview/purviewMetadataPolicy.json
  - Azure.Analytics.Purview.Account/preview/2019-11-01-preview/account.json
- service: purview
  module: azure-analytics-purview-catalog
  input-file:
  - Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
- service: purview
  module: azure-analytics-purview-scanning
  input-file:
  - Azure.Analytics.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
```
