# Readme

> see https://aka.ms/autorest

```yaml
title: RPaaSClient
openapi-type: arm
openapi-subtype: rpaas
tag: 2024-06-24-preview
```

> Exception for adding resourcetypes inside the resource folder.  
> Work item to track the move outside the folder: [Product Backlog Item 25525935: [RPaaS] Move resourcetypes outside the resources folder into dedicated CIS-FRP folder](https://dev.azure.com/msazure/One/_workitems/edit/25525935) under the feature : [Feature 25354335\* [RPaaS] Migration of swaggers into service Namespaces](https://dev.azure.com/msazure/One/_workitems/edit/25354335)

### Tag: 2023-08-22-preview

These settings apply only when `--tag=2023-08-22-preview` is specified on the command line.

```yaml $(tag) == '2023-08-22-preview'
input-file:
  - Microsoft.AzureCis/preview/2023-08-22-preview/aad.json
  - Microsoft.AzureCis/preview/2023-08-22-preview/certificate.json
  - Microsoft.AzureCis/preview/2023-08-22-preview/dscm.json
  - Microsoft.AzureCis/preview/2023-08-22-preview/environment.json
  - Microsoft.AzureCis/preview/2023-08-22-preview/genevaActions.json
  - Microsoft.AzureCis/preview/2023-08-22-preview/plannedQuota.json
```

### Tag: 2023-08-22

These settings apply only when `--tag=2023-08-22` is specified on the command line.

```yaml $(tag) == '2023-08-22'
input-file:
  - Microsoft.AzureCis/stable/2023-08-22/plannedQuota.json
```

### Tag: 2024-06-24-preview

These settings apply only when `--tag=2024-06-24-preview` is specified on the command line.

```yaml $(tag) == '2024-06-24-preview'
input-file:
  - Microsoft.AzureCis/preview/2024-06-24-preview/aad.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/azcopy.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/certificate.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/dns.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/dscm.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/dsmsmanagedkeysecret.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/environment.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/eventgrid.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/ficp.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/genevaActions.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/plannedQuota.json
  - Microsoft.AzureCis/preview/2024-06-24-preview/storageAccountDsms.json
```

### Tag: 2024-11-20-preview

These settings apply only when `--tag=2024-11-20-preview` is specified on the command line.

```yaml $(tag) == '2024-11-20-preview'
input-file:
  - Microsoft.AzureCis/preview/2024-11-20-preview/cloudSprout.json
```

### Tag: 2025-12-04-preview

These settings apply only when `--tag=2025-12-04-preview` is specified on the command line.

```yaml $(tag) == '2025-12-04-preview'
input-file:
  - Microsoft.AzureCis/preview/2025-12-04-preview/plannedQuota.json
```

## Suppression

``` yaml
directive:
  - suppress: BodyTopLevelProperties
    from: certificate.json
    reason: 'value and nextLink are top-level properties'
  - suppress: PreviewVersionOverOneYear
    from: certificate.json
    reason: 'this version is still in use'
  - suppress: AllProxyResourcesShouldHaveDelete
    from: certificate.json
    reason: 'the delete method is not ready'
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    from: certificate.json
    reason: 'this version is sutable'	
```
