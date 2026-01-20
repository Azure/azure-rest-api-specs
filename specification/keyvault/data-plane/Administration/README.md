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
openapi-type: data-plane
tag: package-2025-07-01
```

### Tag: package-2025-07-01

These settings apply only when `--tag=package-2025-07-01` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01'
input-file:
  - stable/2025-07-01/administration.json
```

### Tag: package-preview-2025-06-01-preview

These settings apply only when `--tag=package-preview-2025-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-06-01-preview'
input-file:
  - preview/2025-06-01-preview/administration.json
```

### Tag: package-7.6

These settings apply only when `--tag=package-7.6` is specified on the command line.

```yaml $(tag) == 'package-7.6'
input-file:
  - stable/7.6/administration.json
```

### Tag: package-preview-7.6-preview.2

These settings apply only when `--tag=package-preview-7.6-preview.2` is specified on the command line.

``` yaml $(tag) == 'package-preview-7.6-preview.2'
input-file:
  - preview/7.6-preview.2/administration.json
```

### Tag: package-7.5

These settings apply only when `--tag=package-7.5` is specified on the command line.

``` yaml $(tag) == 'package-7.5'
input-file:
  - stable/7.5/administration.json
```

---

# Code Generation

## General

These transforms apply to any generator.

``` yaml
directive:
# Rename models back to what they were before 7.4 for autorest-based code generators.
# Generated names were disambiguated for generators not using autorest but still processing x-ms-enum.name.
# See https://github.com/Azure/azure-rest-api-specs/pull/22435 for details.
- from: certificates.json
  where: $.definitions.Action
  transform: $.properties.action_type["x-ms-enum"].name = "ActionType";
- from: keys.json
  where: $.definitions.LifetimeActionsType
  transform: $.properties.type["x-ms-enum"].name = "ActionType";
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.KeyVault
  sync-methods: None
  output-folder: $(csharp-sdks-folder)/keyvault/Microsoft.Azure.KeyVault/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  namespace: com.microsoft.azure.keyvault
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 0
  output-folder: $(azure-libraries-for-java-folder)/azure-keyvault
  override-client-name: KeyVaultClientBase
```

## Suppression

``` yaml
directive:
  - suppress: IntegerTypeMustHaveFormat
    from: securitydomain.json
    reason: KV uses format "unixtime", which is not supported by the linter at the moment.
  - suppress: IntegerTypeMustHaveFormat
    from: certificates.json
    reason: KV uses format "unixtime", which is not supported by the linter at the moment.
  - suppress: IntegerTypeMustHaveFormat
    from: keys.json
    reason: KV uses format "unixtime", which is not supported by the linter at the moment.
  - suppress: IntegerTypeMustHaveFormat
    from: secrets.json
    reason: KV uses format "unixtime", which is not supported by the linter at the moment.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificateOperation.properties.cancellation_requested
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificateOperation.properties.status_details
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificateOperation.properties.request_id
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificatePolicy.properties.key_props
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificatePolicy.properties.secret_props
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificatePolicy.properties.x509_props
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificatePolicy.properties.lifetime_actions
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.X509CertificateProperties.properties.key_usage
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.X509CertificateProperties.properties.validity_months
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.IssuerParameters.properties.cert_transparency
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.Action.properties.action_type
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.Trigger.properties.lifetime_percentage
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.Trigger.properties.days_before_expiry
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.SubjectAlternativeNames.properties.dns_names
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.IssuerBundle.properties.org_details
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.IssuerCredentials.properties.account_id
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.OrganizationDetails.properties.admin_details
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.AdministratorDetails.properties.first_name
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.AdministratorDetails.properties.last_name
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificateIssuerSetParameters.properties.org_details
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificateIssuerUpdateParameters.properties.org_details
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: certificates.json
    where: $.definitions.CertificateOperationUpdateParameter.properties.cancellation_requested
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyProperties.properties.key_size
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyProperties.properties.reuse_key
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.JsonWebKey.properties.key_ops
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.JsonWebKey.properties.key_hsm
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyBundle.properties.release_policy
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyCreateParameters.properties.key_size
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyCreateParameters.properties.public_exponent
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyCreateParameters.properties.release_policy
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyCreateParameters.properties.key_ops
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyImportParameters.properties.Hsm
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyImportParameters.properties.release_policy
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyUpdateParameters.properties.key_ops
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: keys.json
    where: $.definitions.KeyUpdateParameters.properties.release_policy
    reason: Consistency with other properties.
  - suppress: MISSING_REQUIRED_PARAMETER
    from: certificates.json
    where: $..parameters[?(@.name=='vaultBaseUrl')]
    reason: Suppress an invalid error caused by a bug in the linter.
  - suppress: MISSING_REQUIRED_PARAMETER
    from: keys.json
    where: $..parameters[?(@.name=='vaultBaseUrl')]
    reason: Suppress an invalid error caused by a bug in the linter.
  - suppress: MISSING_REQUIRED_PARAMETER
    from: secrets.json
    where: $..parameters[?(@.name=='vaultBaseUrl')]
    reason: Suppress an invalid error caused by a bug in the linter.
  - suppress: MISSING_REQUIRED_PARAMETER
    from: storage.json
    reason: Suppress an invalid error caused by a bug in the linter.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: securitydomain.json
    where: $.definitions.TransferKey.properties.transfer_key
    reason: Merely refactored existing definitions into new files.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: securitydomain.json
    where: $.definitions.UploadPendingResponse.properties.status_details
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: securitydomain.json
    where: $.definitions.SecurityDomainOperationStatus.properties.status_details
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: securitydomain.json
    where: $.definitions.SecurityDomainJsonWebKey.properties.key_ops
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: securitydomain.json
    where: $.definitions.SecurityDomainJsonWebKey.properties["x5t#S256"]
    reason: Consistency with other properties.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: securitydomain.json
    where: $.definitions.TransferKey.properties.key_format
    reason: Consistency with other properties
  - suppress: DOUBLE_FORWARD_SLASHES_IN_URL
    from: rbac.json
    reason: / is a valid scope in this scenario.
  - suppress: OBJECT_MISSING_REQUIRED_PROPERTY
    from: rbac.json
    where: $..parameters[?(@.name=='scope')]
    reason: Suppress an invalid error caused by a bug in the linter.
```
