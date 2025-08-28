# Nginx

> see https://aka.ms/autorest

This is the AutoRest configuration file for Nginx.



---
## Getting Started
To build the SDK for Nginx, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Nginx API.

``` yaml
title: NginxManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-01-preview
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - NGINX.NGINXPLUS/preview/2025-03-01-preview/openapi.json

suppressions:
  - code: GetCollectionResponseSchema
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/wafPolicies"]
    reason: This is by design to avoid high bandwidth consumption as agreed with the partner
  - code: PutRequestResponseSchemeArm
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/apiKeys/{apiKeyName}"].put
  - code: PutRequestResponseSchemeArm
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/configurations/{configurationName}"].put
    reason: This is by design. We do not return provided file contents in the response. 
  - code: PutResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/apiKeys/{apiKeyName}"]
    reason: This is a synchronous API returns a 200 as agreed with the partner. 
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/providers/NGINX.NGINXPLUS/operations"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/providers/NGINX.NGINXPLUS/nginxDeployments"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/apiKeys"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/apiKeys/{apiKeyName}"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/certificates"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/certificates/{certificateName}"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/configurations"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/configurations/{configurationName}"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/configurations/{configurationName}/analyze"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/listDefaultWafPolicies"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/wafPolicies"]
  - code: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: Changing the casing of the provider Namespace would trigger rules needing us to rewrite all our previous versions
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/NGINX.NGINXPLUS/nginxDeployments/{nginxDeploymentName}/wafPolicies/{wafPolicyName}"]
```

### Tag: package-2024-11-01-preview

These settings apply only when `--tag=package-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01-preview'
input-file:
  - NGINX.NGINXPLUS/preview/2024-11-01-preview/swagger.json
```

### Tag: package-2024-09-01-preview

These settings apply only when `--tag=package-2024-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-09-01-preview'
input-file:
  - NGINX.NGINXPLUS/preview/2024-09-01-preview/swagger.json
```

### Tag: package-2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-06-01-preview'
input-file:
- NGINX.NGINXPLUS/preview/2024-06-01-preview/swagger.json
```


### Tag: package-2024-01-01-preview

These settings apply only when `--tag=package-2024-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-01-01-preview'
input-file:
- NGINX.NGINXPLUS/preview/2024-01-01-preview/swagger.json
```

### Tag: package-2023-09-01

These settings apply only when `--tag=package-2023-09-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-09-01'
input-file:
- NGINX.NGINXPLUS/stable/2023-09-01/swagger.json
```


### Tag: package-2023-04-01

These settings apply only when `--tag=package-2023-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-04-01'
input-file:
- NGINX.NGINXPLUS/stable/2023-04-01/swagger.json
```

### Tag: package-2022-08-01

These settings apply only when `--tag=package-2022-08-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-08-01'
input-file:
- NGINX.NGINXPLUS/stable/2022-08-01/swagger.json
```

### Tag: package-2021-05-01-preview

These settings apply only when `--tag=package-2021-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-01-preview'
input-file:
- NGINX.NGINXPLUS/preview/2021-05-01-preview/swagger.json
```

## Suppression
``` yaml
directive:
  - suppress: PutRequestResponseSchemeArm
    from: swagger.json
    reason: Temporary suppression needed to avoid delays for business needs and maintain production timelines. It's also approved before in previous PR in private repo.
```    
---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)