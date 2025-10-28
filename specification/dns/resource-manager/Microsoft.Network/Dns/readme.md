# DNS

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

---

## Getting Started

To build the SDK for DNS, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### General Settings

These are the global settings for the DNS API.

``` yaml
openapi-type: arm
tag: package-2023-07-preview
```

### Tag: package-2023-07-preview

These settings apply only when `--tag=package-2023-07-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-07-preview'
input-file:
  - preview/2023-07-01-preview/dns.json
directive:
  - where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}"]
    suppress: PathForNestedResource
    reason: DNS Zones API design.
  - where:
      - $.definitions.RecordSetProperties.properties.TTL
      - $.definitions.RecordSetProperties.properties.ARecords
      - $.definitions.RecordSetProperties.properties.AAAARecords
      - $.definitions.RecordSetProperties.properties.MXRecords
      - $.definitions.RecordSetProperties.properties.NSRecords
      - $.definitions.RecordSetProperties.properties.PTRRecords
      - $.definitions.RecordSetProperties.properties.SRVRecords
      - $.definitions.RecordSetProperties.properties.TXTRecords
      - $.definitions.RecordSetProperties.properties.CNAMERecord
      - $.definitions.RecordSetProperties.properties.SOARecord
      - $.definitions.RecordSetProperties.properties.DSRecords
      - $.definitions.RecordSetProperties.properties.TLSARecords
      - $.definitions.RecordSetProperties.properties.NAPTRRecords
      - $.definitions.RecordSetUpdateParameters.properties.RecordSet
    suppress:
      - DefinitionsPropertiesNamesCamelCase
    reason: DNS Zones API design. We cannot update this since DNS Zones service has already shipped public versions.
  - where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}"].patch
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}"].get
    suppress: ParametersOrder
    reason: This rule demands changing order of the parameters, but we cannot do it. Changing the order would introduce a breaking change, since DNS Zones service has already shipped public versions.
  - where: $.definitions.Zone
    suppress: TopLevelResourcesListBySubscription
    reason: List by subscription is included in the Zones_List operation.
  - suppress: CreateOperationAsyncResponseValidation
    reason: This option is designed for cases where the server does NOT follow ARM guidelines
    # https://azure.github.io/autorest/extensions/#x-ms-long-running-operation-options
  - suppress: DeleteOperationAsyncResponseValidation
    reason: This option is designed for cases where the server does NOT follow ARM guidelines
    # https://azure.github.io/autorest/extensions/#x-ms-long-running-operation-options
  - suppress: ResourceNameRestriction
    reason: We already have naming validation at service end.
  - suppress: ResourceMustReferenceCommonTypes
    reason: 'We have already defined Resource which has exactly same json structure. Not referencing from common-types here to avoid breaking change, since DNS Zones service has already shipped public versions'
  - suppress: LroErrorContent
    reason: 'We have already defined CloudError which has exactly same json structure. Not referencing from common-types here to avoid breaking change, since DNS Zones service has already shipped public versions'

suppressions:
  - code: XmsLongRunningOperationOptions
    reason: This option is designed for cases where the server does NOT follow ARM guidelines
    # https://azure.github.io/autorest/extensions/#x-ms-long-running-operation-options
  - code: UnSupportedPatchProperties
    reason: Breaking change to remove name or type properties.
  - code: OperationsAPIImplementation
    reason: Operation APIs for Microsoft.Network are to be defined in Network swagger.
  - code: GetCollectionOnlyHasValueAndNextLink
    reason: This is just a Get operation and not a List operation.
  - code: AvoidAdditionalProperties
    reason: This rule demands removing additional properties, but we cannot do it. Removing additional properties would introduce a breaking change, since DNS Zones service has already shipped public versions.
```

### Tag: package-2018-05

These settings apply only when `--tag=package-2018-05` is specified on the command line.

```yaml $(tag) == 'package-2018-05'
input-file:
  - stable/2018-05-01/dns.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
  - where:
      - $.definitions.RecordSetProperties.properties.TTL
      - $.definitions.RecordSetProperties.properties.ARecords
      - $.definitions.RecordSetProperties.properties.AAAARecords
      - $.definitions.RecordSetProperties.properties.MXRecords
      - $.definitions.RecordSetProperties.properties.NSRecords
      - $.definitions.RecordSetProperties.properties.PTRRecords
      - $.definitions.RecordSetProperties.properties.SRVRecords
      - $.definitions.RecordSetProperties.properties.TXTRecords
      - $.definitions.RecordSetProperties.properties.CNAMERecord
      - $.definitions.RecordSetProperties.properties.SOARecord
      - $.definitions.RecordSetUpdateParameters.properties.RecordSet
    suppress:
      - DefinitionsPropertiesNamesCamelCase  
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-preview'
input-file:
- preview/2018-03-01-preview/dns.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
  - where:
      - $.definitions.RecordSetProperties.properties.TTL
      - $.definitions.RecordSetProperties.properties.ARecords
      - $.definitions.RecordSetProperties.properties.AAAARecords
      - $.definitions.RecordSetProperties.properties.MXRecords
      - $.definitions.RecordSetProperties.properties.NSRecords
      - $.definitions.RecordSetProperties.properties.PTRRecords
      - $.definitions.RecordSetProperties.properties.SRVRecords
      - $.definitions.RecordSetProperties.properties.TXTRecords
      - $.definitions.RecordSetProperties.properties.CNAMERecord
      - $.definitions.RecordSetProperties.properties.SOARecord
      - $.definitions.RecordSetUpdateParameters.properties.RecordSet
    suppress:
      - DefinitionsPropertiesNamesCamelCase
```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- stable/2017-10-01/dns.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
  - where:
      - $.definitions.RecordSetProperties.properties.TTL
      - $.definitions.RecordSetProperties.properties.ARecords
      - $.definitions.RecordSetProperties.properties.AAAARecords
      - $.definitions.RecordSetProperties.properties.MXRecords
      - $.definitions.RecordSetProperties.properties.NSRecords
      - $.definitions.RecordSetProperties.properties.PTRRecords
      - $.definitions.RecordSetProperties.properties.SRVRecords
      - $.definitions.RecordSetProperties.properties.TXTRecords
      - $.definitions.RecordSetProperties.properties.CNAMERecord
      - $.definitions.RecordSetProperties.properties.SOARecord
      - $.definitions.RecordSetUpdateParameters.properties.RecordSet
    suppress:
      - DefinitionsPropertiesNamesCamelCase
```

### Tag: package-2017-09

These settings apply only when `--tag=package-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-2017-09'
input-file:
- stable/2017-09-01/dns.json
```

### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
input-file:
- stable/2016-04-01/dns.json
```

### Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-05-preview'
input-file:
- preview/2015-05-04-preview/dns.json
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- stable/2016-04-01/dns.json
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-typescript
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_dns']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)