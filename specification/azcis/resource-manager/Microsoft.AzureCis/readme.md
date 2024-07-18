# Readme

> see https://aka.ms/autorest

```yaml
title: RPaaSClient
openapi-type: arm
openapi-subtype: rpaas
tag: 2023-08-22-preview
```

> Exception for adding resourcetypes inside the resource folder.  
> Work item to track the move outside the folder: [Product Backlog Item 25525935: [RPaaS] Move resourcetypes outside the resources folder into dedicated CIS-FRP folder](https://dev.azure.com/msazure/One/_workitems/edit/25525935) under the feature : [Feature 25354335\* [RPaaS] Migration of swaggers into service Namespaces](https://dev.azure.com/msazure/One/_workitems/edit/25354335)

### Tag: 2023-08-22-preview

```yaml $(tag) == '2023-08-22-preview'
input-file:
  - preview/2023-08-22-preview/aad.json
  - preview/2023-08-22-preview/dscm.json
  - preview/2023-08-22-preview/environment.json
  - preview/2023-08-22-preview/genevaActions.json
  - preview/2023-08-22-preview/plannedQuota.json
  - preview/2023-08-22-preview/pav2.json
```

### Tag: 2023-08-22

These settings apply only when `--tag=2023-08-22` is specified on the command line.

```yaml $(tag) == '2023-08-22'
input-file:
  - stable/2023-08-22/plannedQuota.json
  - stable/2023-08-22/dscm.json
```

### Tag: 2024-06-11-preview

These settings apply only when `--tag=2024-06-11-preview` is specified on the command line.

```yaml $(tag) == '2024-06-11-preview'
input-file:
  - preview/2024-06-11-preview/cloudSprout.json
```

### Tag: 2024-06-24-preview

These settings apply only when `--tag=2024-06-24-preview` is specified on the command line.

```yaml $(tag) == '2024-06-24-preview'
input-file:
  - preview/2024-06-24-preview/dscm.json
  - preview/2024-06-24-preview/environment.json
  - preview/2024-06-24-preview/genevaActions.json
  - preview/2024-06-24-preview/plannedQuota.json
```