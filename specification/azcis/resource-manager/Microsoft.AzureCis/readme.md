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

```yaml $(tag) == '2023-08-22-preview'
input-file:
  - preview/2023-08-22-preview/aad.json
  - preview/2023-08-22-preview/dscm.json
  - preview/2023-08-22-preview/environment.json
  - preview/2023-08-22-preview/genevaActions.json
  - preview/2023-08-22-preview/plannedQuota.json
  - preview/2023-08-22-preview/pav2.json
  - preview/2023-08-22-preview/cloudSprout.json
```