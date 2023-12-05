# Readme

> see https://aka.ms/autorest

```yaml
title: RPaaSClient
openapi-type: arm
openapi-subtype: rpaas
```

> Exception for adding resourcetypes inside  the resource folder.  
Work item to track the move outside the folder: [Product Backlog Item 25525935: [RPaaS] Move resourcetypes outside the resources folder into dedicated CIS-FRP folder](https://dev.azure.com/msazure/One/_workitems/edit/25525935)  under the feature : [Feature 25354335* [RPaaS] Migration of swaggers into service Namespaces](https://dev.azure.com/msazure/One/_workitems/edit/25354335)
```yaml $(tag) == '2023-08-22-preview'
input-file: 
  - preview/2023-08-22-preview/dscm.json
```

```yaml $(tag) == '2021-08-10-privatepreview'
input-file: 
  - preview/2021-08-10-privatepreview/environment.json
  - preview/2021-08-10-privatepreview/dstsServiceAccount.json
  - preview/2021-08-10-privatepreview/dstsServiceClientIdentity.json
  - preview/2021-08-10-privatepreview/dsmsRootFolder.json
  - preview/2021-08-10-privatepreview/dsmsAllowlist.json
  - preview/2021-08-10-privatepreview/dstsApplication.json
```

```yaml $(tag) == '2021-02-01'
input-file: 
  - stable/2021-02-01/environment.json
  - stable/2021-02-01/dstsServiceAccount.json
```

``` yaml
suppressions:
  - code: PathResourceProviderNamePascalCase
```
