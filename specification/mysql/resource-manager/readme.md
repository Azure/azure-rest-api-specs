# MySql

> see https://aka.ms/autorest

This is the AutoRest configuration file for MySql.

---

## Getting Started

To build the SDK for MySql, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the MySql API.

``` yaml
title: MySQLManagementClient
description: The Microsoft Azure management API provides create, read, update, and delete functionality for Azure MySQL resources including servers, databases, firewall rules, VNET rules, log files and configurations with new business model.
openapi-type: arm
tag: package-flexibleserver-2024-06-01-preview
```

``` yaml $(package-flexibleservers)
tag: package-flexibleserver-2024-06-01-preview
```

``` yaml $(package-singleservers)
tag: package-2020-01-01
```

### Tag: package-2017-12-01-preview

These settings apply only when `--tag=package-2017-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-01-preview'
input-file:
- Microsoft.DBforMySQL/legacy/preview/2017-12-01-preview/mysql.json
```

### Tag: package-2017-12-01

These settings apply only when `--tag=package-2017-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-01'
input-file:
- Microsoft.DBforMySQL/legacy/stable/2017-12-01/mysql.json
- Microsoft.DBforMySQL/legacy/stable/2017-12-01/ServerSecurityAlertPolicies.json
```

### Tag: package-2018-06-01-privatepreview

These settings apply only when `--tag=package-2018-06-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-01-privatepreview'
input-file:
- Microsoft.DBforMySQL/legacy/preview/2018-06-01-privatepreview/mysql.json
- Microsoft.DBforMySQL/legacy/preview/2018-06-01-privatepreview/PrivateEndpointConnections.json
- Microsoft.DBforMySQL/legacy/preview/2018-06-01-privatepreview/PrivateLinkResources.json
```

### Tag: package-2018-06-01

These settings apply only when `--tag=package-2018-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-01'
input-file:
- Microsoft.DBforMySQL/legacy/stable/2017-12-01/mysql.json
- Microsoft.DBforMySQL/legacy/stable/2017-12-01/ServerSecurityAlertPolicies.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/QueryPerformanceInsights.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/PerformanceRecommendations.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/PrivateEndpointConnections.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/PrivateLinkResources.json
```

### Tag: package-2020-01-01-privatepreview

These settings apply only when `--tag=package-2020-01-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01-privatepreview'
input-file:
- Microsoft.DBforMySQL/legacy/preview/2020-01-01-privatepreview/DataEncryptionKeys.json
```

### Tag: package-2020-01-01

These settings apply only when `--tag=package-2020-01-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01'
input-file:
- Microsoft.DBforMySQL/legacy/stable/2017-12-01/mysql.json
- Microsoft.DBforMySQL/legacy/stable/2017-12-01/ServerSecurityAlertPolicies.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/QueryPerformanceInsights.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/PerformanceRecommendations.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/PrivateEndpointConnections.json
- Microsoft.DBforMySQL/legacy/stable/2018-06-01/PrivateLinkResources.json
- Microsoft.DBforMySQL/legacy/stable/2020-01-01/DataEncryptionKeys.json
- Microsoft.DBforMySQL/legacy/stable/2020-01-01/Servers.json
```

### Tag: package-2020-07-01-privatepreview

These settings apply only when `--tag=package-2020-07-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-01-privatepreview'
input-file:
- Microsoft.DBforMySQL/legacy/preview/2020-07-01-privatepreview/mysql.json
```

### Tag: package-2020-07-01-preview

These settings apply only when `--tag=package-2020-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-01-preview'
input-file:
- Microsoft.DBforMySQL/legacy/preview/2020-07-01-preview/mysql.json
```

### Tag: package-flexibleserver-2021-05-01-preview

These settings apply only when `--tag=package-flexibleserver-2021-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2021-05-01-preview'
input-file:
- Microsoft.DBforMySQL/legacy/preview/2021-05-01-preview/mysql.json
```

### Tag: package-flexibleserver-2021-05-01

These settings apply only when `--tag=package-flexibleserver-2021-05-01` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2021-05-01'
input-file:
- Microsoft.DBforMySQL/legacy/stable/2021-05-01/mysql.json
```

### Tag: package-flexibleserver-2021-12-01-preview

These settings apply only when `--tag=package-flexibleserver-2021-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2021-12-01-preview'
input-file:
- Microsoft.DBforMySQL/Backups/preview/2021-12-01-preview/Backups.json
- Microsoft.DBforMySQL/Configurations/preview/2021-12-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2021-12-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2021-12-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2021-12-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/preview/2021-12-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2021-12-01-preview/ServiceOperations.json
- Microsoft.DBforMySQL/AAD/preview/2021-12-01-preview/AzureADAdministrator.json
```

### Tag: package-flexibleserver-2022-09-30-preview

These settings apply only when `--tag=package-flexibleserver-2022-09-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2022-09-30-preview'
input-file:
- Microsoft.DBforMySQL/AAD/preview/2021-12-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/preview/2022-09-30-preview/Backups.json
- Microsoft.DBforMySQL/Backups/preview/2022-09-30-preview/BackupAndExport.json
- Microsoft.DBforMySQL/Configurations/preview/2021-12-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2021-12-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2021-12-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2022-09-30-preview/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/preview/2021-12-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2022-09-30-preview/ServiceOperations.json
- Microsoft.DBforMySQL/common-types/v1/common-types.json
suppressions:
  - code: PropertiesTypeObjectNoDefinition
    from: common-types.json
    reason: This will be fixed in new versions.
```

### Tag: package-flexibleserver-2023-06-01-preview

These settings apply only when `--tag=package-flexibleserver-2023-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-06-01-preview'
input-file:
- Microsoft.DBforMySQL/AAD/preview/2023-06-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/preview/2023-06-01-preview/Backups.json
- Microsoft.DBforMySQL/Backups/preview/2023-06-01-preview/BackupAndExport.json
- Microsoft.DBforMySQL/Configurations/preview/2023-06-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2023-06-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2023-06-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2023-06-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/preview/2023-06-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2023-06-01-preview/ServiceOperations.json
- Microsoft.DBforMySQL/common-types/v1/common-types.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PropertiesTypeObjectNoDefinition
    from: common-types.json
    reason: This will be fixed in new versions.
```

### Tag: package-flexibleserver-2023-06-01-preview-new

These settings apply only when `--tag=package-flexibleserver-2023-06-01-preview-new` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-06-01-preview-new'
input-file:
- Microsoft.DBforMySQL/AAD/preview/2023-06-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/preview/2023-06-01-preview/Backups.json
- Microsoft.DBforMySQL/Backups/preview/2023-06-01-preview/BackupAndExport.json
- Microsoft.DBforMySQL/Configurations/preview/2023-06-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2023-06-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2023-06-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2023-06-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/preview/2023-06-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2021-12-01-preview/ServiceOperations.json
- Microsoft.DBforMySQL/common-types/v1/common-types.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PropertiesTypeObjectNoDefinition
    from: common-types.json
    reason: This will be fixed in new versions.
```

### Tag: package-flexibleserver-2023-06-30

These settings apply only when `--tag=package-flexibleserver-2023-06-30` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-06-30'
input-file:
- Microsoft.DBforMySQL/AAD/stable/2023-06-30/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/stable/2023-06-30/Backups.json
- Microsoft.DBforMySQL/Backups/stable/2023-06-30/BackupAndExport.json
- Microsoft.DBforMySQL/Configurations/stable/2023-06-30/Configurations.json
- Microsoft.DBforMySQL/Databases/stable/2023-06-30/Databases.json
- Microsoft.DBforMySQL/Firewall/stable/2023-06-30/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/stable/2023-06-30/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/stable/2023-06-30/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/stable/2023-06-30/ServiceOperations.json
- Microsoft.DBforMySQL/Maintenance/preview/2023-10-01-preview/Maintenances.json
- Microsoft.DBforMySQL/common-types/v1/common-types.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PropertiesTypeObjectNoDefinition
    from: common-types.json
    reason: This will be fixed in new versions.
```

### Tag: package-flexibleserver-2023-10-01-preview

These settings apply only when `--tag=package-flexibleserver-2023-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-10-01-preview'
input-file:
- Microsoft.DBforMySQL/AAD/preview/2023-06-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/preview/2023-06-01-preview/Backups.json
- Microsoft.DBforMySQL/Backups/preview/2023-06-01-preview/BackupAndExport.json
- Microsoft.DBforMySQL/Configurations/preview/2023-06-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2023-06-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2023-06-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2023-10-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/preview/2023-06-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2023-06-01-preview/ServiceOperations.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2023-10-01-preview/AdvancedThreatProtectionSettings.json
- Microsoft.DBforMySQL/common-types/v1/common-types.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
```

### Tag: package-flexibleserver-2023-12-01-preview

These settings apply only when `--tag=package-flexibleserver-2023-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-12-01-preview'
input-file:
- Microsoft.DBforMySQL/AAD/preview/2023-06-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/preview/2023-10-01-preview/Backups.json
- Microsoft.DBforMySQL/Backups/preview/2023-10-01-preview/BackupAndExport.json
- Microsoft.DBforMySQL/Backups/preview/2023-10-01-preview/LongRunningBackups.json
- Microsoft.DBforMySQL/Configurations/preview/2023-06-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2023-06-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2023-06-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2023-12-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2023-12-01-preview/AdvancedThreatProtectionSettings.json
- Microsoft.DBforMySQL/LogFiles/preview/2023-06-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2023-12-01-preview/ServiceOperations.json
- Microsoft.DBforMySQL/Maintenance/preview/2023-10-01-preview/Maintenances.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PutResponseCodes
    from: LongRunningBackups.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutResponseCodes
    from: AdvancedThreatProtectionSettings.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutInOperationName
    from: AdvancedThreatProtectionSettings.json
    reason: "This API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario"
  - code: AllProxyResourcesShouldHaveDelete
    from: AdvancedThreatProtectionSettings.json
    reason: "PUT API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario, we do not support DELETE operation"
```

### Tag: package-flexibleserver-2023-12-30

These settings apply only when `--tag=package-flexibleserver-2023-12-30` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-12-30'
input-file:
- Microsoft.DBforMySQL/AAD/preview/2023-06-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/preview/2023-10-01-preview/Backups.json
- Microsoft.DBforMySQL/Backups/preview/2023-10-01-preview/BackupAndExport.json
- Microsoft.DBforMySQL/Backups/preview/2023-10-01-preview/LongRunningBackups.json
- Microsoft.DBforMySQL/Configurations/preview/2023-06-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2023-06-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2023-06-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/stable/2023-12-30/FlexibleServers.json
- Microsoft.DBforMySQL/FlexibleServers/stable/2023-12-30/AdvancedThreatProtectionSettings.json
- Microsoft.DBforMySQL/LogFiles/preview/2023-06-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/stable/2023-12-30/ServiceOperations.json
- Microsoft.DBforMySQL/Maintenance/preview/2023-10-01-preview/Maintenances.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PutResponseCodes
    from: LongRunningBackups.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutResponseCodes
    from: AdvancedThreatProtectionSettings.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutInOperationName
    from: AdvancedThreatProtectionSettings.json
    reason: "This API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario"
  - code: AllProxyResourcesShouldHaveDelete
    from: AdvancedThreatProtectionSettings.json
    reason: "PUT API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario, we do not support DELETE operation"
```

### Tag: package-flexibleserver-2024-01-01

These settings apply only when `--tag=package-flexibleserver-2024-01-01` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2024-01-01'
input-file:
- Microsoft.DBforMySQL/AAD/stable/2023-12-30/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/Backups.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/BackupAndExport.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/LongRunningBackups.json
- Microsoft.DBforMySQL/Configurations/stable/2023-12-30/Configurations.json
- Microsoft.DBforMySQL/Databases/stable/2023-12-30/Databases.json
- Microsoft.DBforMySQL/Firewall/stable/2023-12-30/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/stable/2023-12-30/FlexibleServers.json
- Microsoft.DBforMySQL/FlexibleServers/stable/2023-12-30/AdvancedThreatProtectionSettings.json
- Microsoft.DBforMySQL/LogFiles/stable/2023-12-30/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/stable/2023-12-30/ServiceOperations.json
- Microsoft.DBforMySQL/Maintenance/stable/2023-12-30/Maintenances.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PutResponseCodes
    from: LongRunningBackups.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutResponseCodes
    from: AdvancedThreatProtectionSettings.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutInOperationName
    from: AdvancedThreatProtectionSettings.json
    reason: "This API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario"
  - code: AllProxyResourcesShouldHaveDelete
    from: AdvancedThreatProtectionSettings.json
    reason: "PUT API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario, we do not support DELETE operation"
```

### Tag: package-flexibleserver-2024-02-01-preview

These settings apply only when `--tag=package-flexibleserver-2024-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2024-02-01-preview'
input-file:
- Microsoft.DBforMySQL/AAD/stable/2023-12-30/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/Backups.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/BackupAndExport.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/LongRunningBackups.json
- Microsoft.DBforMySQL/Configurations/stable/2023-12-30/Configurations.json
- Microsoft.DBforMySQL/Databases/stable/2023-12-30/Databases.json
- Microsoft.DBforMySQL/Firewall/stable/2023-12-30/FirewallRules.json
- Microsoft.DBforMySQL/LogFiles/stable/2023-12-30/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/stable/2023-12-30/ServiceOperations.json
- Microsoft.DBforMySQL/Maintenance/stable/2023-12-30/Maintenances.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2024-02-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2024-02-01-preview/AdvancedThreatProtectionSettings.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PutResponseCodes
    from: LongRunningBackups.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutResponseCodes
    from: AdvancedThreatProtectionSettings.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutInOperationName
    from: AdvancedThreatProtectionSettings.json
    reason: "This API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario"
  - code: AllProxyResourcesShouldHaveDelete
    from: AdvancedThreatProtectionSettings.json
    reason: "PUT API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario, we do not support DELETE operation"
```

### Tag: package-flexibleserver-2024-06-01-preview

These settings apply only when `--tag=package-flexibleserver-2024-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2024-06-01-preview'
input-file:
- Microsoft.DBforMySQL/AAD/stable/2023-12-30/AzureADAdministrator.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/Backups.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/BackupAndExport.json
- Microsoft.DBforMySQL/Backups/stable/2023-12-30/LongRunningBackups.json
- Microsoft.DBforMySQL/Configurations/stable/2023-12-30/Configurations.json
- Microsoft.DBforMySQL/Databases/stable/2023-12-30/Databases.json
- Microsoft.DBforMySQL/Firewall/stable/2023-12-30/FirewallRules.json
- Microsoft.DBforMySQL/LogFiles/stable/2023-12-30/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/stable/2023-12-30/ServiceOperations.json
- Microsoft.DBforMySQL/Maintenance/stable/2023-12-30/Maintenances.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2024-06-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2024-06-01-preview/AdvancedThreatProtectionSettings.json
suppressions:
  - code: PostOperationAsyncResponseValidation
    from: FlexibleServers.json
    reason: This check is optional.
  - code: PutResponseCodes
    from: LongRunningBackups.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutResponseCodes
    from: AdvancedThreatProtectionSettings.json
    reason: "202 is a pattern that is already used in our existing resources and being carried forward to new implementations to maintain consistency for our customers. This has already been approved by the API review board."
  - code: PutInOperationName
    from: AdvancedThreatProtectionSettings.json
    reason: "This API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario"
  - code: AllProxyResourcesShouldHaveDelete
    from: AdvancedThreatProtectionSettings.json
    reason: "PUT API is used to update thread detecion configuration, which is required by ARM policy, especially for `deployIfNotExist` scenario, we do not support DELETE operation"
```

### Tag: package-flexibleserver-2023-06-30-privatelink

These settings apply only when `--tag=package-flexibleserver-2023-06-30-privatelink` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2023-06-30-privatelink'
input-file:
- Microsoft.DBforMySQL/common-types/v1/common-types.json
- Microsoft.DBforMySQL/PrivateLink/stable/2023-06-30/PrivateEndpointConnections.json
- Microsoft.DBforMySQL/PrivateLink/stable/2023-06-30/PrivateLinkResources.json
suppressions:
  - code: PropertiesTypeObjectNoDefinition
    from: common-types.json
    reason: This will be fixed in new versions.
```

### Tag: package-flexibleserver-2022-01-01

These settings apply only when `--tag=package-flexibleserver-2022-01-01` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2022-01-01'
input-file:
- Microsoft.DBforMySQL/Backups/stable/2022-01-01/Backups.json
- Microsoft.DBforMySQL/Configurations/stable/2022-01-01/Configurations.json
- Microsoft.DBforMySQL/Databases/stable/2022-01-01/Databases.json
- Microsoft.DBforMySQL/Firewall/stable/2022-01-01/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/stable/2022-01-01/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/stable/2022-01-01/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/stable/2022-01-01/ServiceOperations.json
- Microsoft.DBforMySQL/AAD/stable/2022-01-01/AzureADAdministrator.json
```

### Tag: package-flexibleserver-2022-09-30-preview-privatelink

These settings apply only when `--tag=package-flexibleserver-2022-09-30-preview-privatelink` is specified on the command line.

``` yaml $(tag) == 'package-flexibleserver-2022-09-30-preview-privatelink'
input-file:
- Microsoft.DBforMySQL/Backups/preview/2021-12-01-preview/Backups.json
- Microsoft.DBforMySQL/Configurations/preview/2021-12-01-preview/Configurations.json
- Microsoft.DBforMySQL/Databases/preview/2021-12-01-preview/Databases.json
- Microsoft.DBforMySQL/Firewall/preview/2021-12-01-preview/FirewallRules.json
- Microsoft.DBforMySQL/FlexibleServers/preview/2021-12-01-preview/FlexibleServers.json
- Microsoft.DBforMySQL/LogFiles/preview/2021-12-01-preview/LogFiles.json
- Microsoft.DBforMySQL/ServiceOperations/preview/2021-12-01-preview/ServiceOperations.json
- Microsoft.DBforMySQL/AAD/preview/2021-12-01-preview/AzureADAdministrator.json
- Microsoft.DBforMySQL/PrivateLink/preview/2022-09-30-preview/PrivateEndpointConnections.json
- Microsoft.DBforMySQL/PrivateLink/preview/2022-09-30-preview/PrivateLinkResources.json
```

## Suppression

``` yaml
directive:
  - suppress: PathResourceProviderNamePascalCase
    reason: The name of the provider is Microsoft.DBforMySQL
  - suppress: OperationsApiResponseSchema
    from: mysql.json
    reason: Property isDataAction is not included in get operation reponse body
  - suppress: OperationsApiResponseSchema
    from: Microsoft.DBforMySQL/preview/2021-12-01-preview/ServiceOperations.json
    reason: Property isDataAction is not included in get operation reponse body
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

### C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.MySQL
  output-folder: $(csharp-sdks-folder)/mysql/Microsoft.Azure.Management.MySQL/src/mysql/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
