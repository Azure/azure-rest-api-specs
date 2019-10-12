# Instance Metadata Service
> see https://aka.ms/autorest

This is the AutoRest configuration file for Instance Metadata Service.

## Getting Started
To build the SDKs for Instance Metadata Service, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:
> `autorest readme.md`

To see additional help and options, run:
> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information
These are the global settings for the Instance Metadata Service API.

``` yaml
openapi-type: data-plane
azure-arm: true
tag: package-2019-02-01
output-folder: ./Generated
```

### Tag: package-2018-10-01

These settings apply only when `--tag=package-2018-10-01` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01'
input-file:
- Microsoft.InstanceMetadataService/stable/2018-10-01/imds.json
```

### Tag: package-2019-02-01

These settings apply only when `--tag=package-2019-02-01` is specified on the command line.

```yaml $(tag) == 'package-2019-02-01'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-02-01/imds.json
```

### Tag: package-2019-03-11

These settings apply only when `--tag=package-2019-03-11` is specified on the command line.

```yaml $(tag) == 'package-2019-03-11'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-03-11/imds.json
```

### Tag: package-2019-04-30

These settings apply only when `--tag=package-2019-04-30` is specified on the command line.

```yaml $(tag) == 'package-2019-04-30'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-04-30/imds.json
```

### Tag: package-2019-06-01

These settings apply only when `--tag=package-2019-06-01` is specified on the command line.

```yaml $(tag) == 'package-2019-06-01'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-06-01/imds.json
```

### Tag: package-2019-06-04

These settings apply only when `--tag=package-2019-06-04` is specified on the command line.

```yaml $(tag) == 'package-2019-06-04'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-06-04/imds.json
```

### Tag: package-2019-08-01

These settings apply only when `--tag=package-2019-08-01` is specified on the command line.

```yaml $(tag) == 'package-2019-08-01'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-08-01/imds.json
```

### Tag: package-2019-08-15

These settings apply only when `--tag=package-2019-08-15` is specified on the command line.

```yaml $(tag) == 'package-2019-08-15'
input-file:
- Microsoft.InstanceMetadataService/stable/2019-08-15/imds.json
```

## Suppression
 ``` yaml
 directive:
   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2018-10-01/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-02-01/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-03-11/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-04-30/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-06-01/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-06-04/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-08-01/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description

   - suppress: HttpsSupportedScheme
     reason: IMDS does not require HTTPS to query it

   - suppress: SecurityDefinitionsStructure
     reason: IMDS does not support any authentication

   - suppress: DefinitionsPropertiesNamesCamelCase
     reason: The following properties follow the Oath2 spec, which does not use camelCase.
     from: Microsoft.InstanceMetadataService/stable/2019-08-15/imds.json
     where:
       - $.definitions.IdentityTokenResponse.properties.access_token
       - $.definitions.IdentityTokenResponse.properties.expires_in
       - $.definitions.IdentityTokenResponse.properties.expires_on
       - $.definitions.IdentityTokenResponse.properties.ext_expires_in
       - $.definitions.IdentityTokenResponse.properties.not_before
       - $.definitions.IdentityTokenResponse.properties.resource
       - $.definitions.IdentityTokenResponse.properties.token_type
       - $.definitions.IdentityTokenResponse.properties.client_id
       - $.definitions.IdentityTokenResponse.properties.object_id
       - $.definitions.IdentityTokenResponse.properties.msi_res_id
       - $.definitions.IdentityErrorResponse.properties.error_description
 ```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  azure-arm: true
  output-folder: ./Generated
  clear-output-folder: true
```

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
```

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2018-10-01/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-02-01/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-03-11/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-04-30/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-06-01/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-06-04/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-08-01/imds.json
  - $(this-folder)/Microsoft.InstanceMetadataService/stable/2019-08-15/imds.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

