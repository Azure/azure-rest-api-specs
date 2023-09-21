# Readme

> see https://aka.ms/autorest

```yaml
title: RPaaSClient
openapi-type: arm
openapi-subtype: rpaas
```

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
