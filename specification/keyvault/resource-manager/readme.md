# KeyVault

> see https://aka.ms/autorest

This is the AutoRest configuration file for KeyVault.

---

## Getting Started

To build the SDK for KeyVault, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the KeyVault API.

``` yaml
openapi-type: arm
tag: package-preview-2021-06
```


### Tag: package-preview-2021-06

These settings apply only when `--tag=package-preview-2021-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-06'
input-file:
  - Microsoft.KeyVault/preview/2021-06-01-preview/common.json
  - Microsoft.KeyVault/preview/2021-06-01-preview/keys.json
  - Microsoft.KeyVault/preview/2021-06-01-preview/keyvault.json
  - Microsoft.KeyVault/preview/2021-06-01-preview/managedHsm.json
  - Microsoft.KeyVault/preview/2021-06-01-preview/providers.json
  - Microsoft.KeyVault/preview/2021-06-01-preview/secrets.json
```
### Tag: package-preview-2021-04

These settings apply only when `--tag=package-preview-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-04'
input-file:
  - Microsoft.KeyVault/preview/2021-04-01-preview/common.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/keyvault.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/managedHsm.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/providers.json
```
### Tag: package-preview-2021-04-full

These settings apply only when `--tag=package-preview-2021-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-04-full'
input-file:
  - Microsoft.KeyVault/preview/2021-04-01-preview/common.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/keyvault.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/managedHsm.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/providers.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/keys.json
  - Microsoft.KeyVault/preview/2021-04-01-preview/secrets.json
```

### Tag: package-preview-2020-04

These settings apply only when `--tag=package-preview-2020-04` is specified on the command line.
This tag is for the development of preview features related to managed HSM of Azure CLI and PowerShell.

``` yaml $(tag) == 'package-preview-2020-04'
input-file:
  - Microsoft.KeyVault/stable/2019-09-01/keyvault.json
  - Microsoft.KeyVault/stable/2019-09-01/providers.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/managedHsm.json
```

### Tag: package-preview-2020-04-full

These settings apply only when `--tag=package-preview-2020-04-full` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-04-full'
input-file:
  - Microsoft.KeyVault/preview/2020-04-01-preview/keys.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/keyvault.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/providers.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/secrets.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/managedHsm.json
```

### Tag: package-2019-09

These settings apply only when `--tag=package-2019-09` is specified on the command line.

``` yaml $(tag) == 'package-2019-09'
input-file:
- Microsoft.KeyVault/stable/2019-09-01/keyvault.json
- Microsoft.KeyVault/stable/2019-09-01/providers.json
- Microsoft.KeyVault/stable/2019-09-01/keys.json
```

### Tag: package-2018-02-14-preview

These settings apply only when `--tag=package-2018-02-14-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-14-preview'
input-file:
- Microsoft.KeyVault/preview/2018-02-14-preview/keyvault.json
- Microsoft.KeyVault/preview/2018-02-14-preview/providers.json
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- Microsoft.KeyVault/stable/2018-02-14/keyvault.json
- Microsoft.KeyVault/stable/2018-02-14/providers.json
```

### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- Microsoft.KeyVault/stable/2016-10-01/keyvault.json
- Microsoft.KeyVault/stable/2016-10-01/providers.json
```

### Tag: package-2015-06

These settings apply only when `--tag=package-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-2015-06'
input-file:
- Microsoft.KeyVault/stable/2015-06-01/keyvault.json
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- Microsoft.KeyVault/stable/2019-09-01/keyvault.json
- Microsoft.KeyVault/stable/2019-09-01/providers.json
- Microsoft.KeyVault/stable/2019-09-01/secrets.json
```

### Supressions

``` yaml
directive:
- suppress:
    - R3016 # The 'release_policy' property for KeyCreateParameters does not support camelCase.
    - R3026 # The 'PrivateEndpointConnection' and 'PrivateLinkResource' sub-resources don't define PATCH as per Network Team's specification.
    - R3025 # The 'PrivateLinkResource' is only accessible via List operation; does not define GET as per Network Team's specification.
    - R4015 # The 'MHSMPrivateEndpointConnection' sub-resource doesn't define List as per Network Team's specification.
    - R2005 # The 'ManagedHsms_PurgeDeleted' operation should not return a mix of 202 and syncronous return types (200, 201, 204) as directed by SDK team.
    - R4009 # Vault object is the only one that need to be tracked with SystemData
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_key_vault']
  - repo: azure-resource-manager-schemas
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
