``` yaml $(java)
packages:
- module: azure-analytics-purview-administration
  service: purview
  input-file:
  - Azure.Analytics.Purview.MetadataPolicies/preview/2021-07-01-preview/purviewMetadataPolicy.json
  - Azure.Analytics.Purview.Account/preview/2019-11-01-preview/account.json
- module: azure-analytics-purview-catalog
  service: purview
  input-file:
  - Azure.Analytics.Purview.Catalog/preview/2021-05-01-preview/purviewcatalog.json
  require: readme.java.catalog.md
- module: azure-analytics-purview-scanning
  service: purview
  input-file:
  - Azure.Analytics.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
```
