

``` yaml
library-name: NetworkAnalytics
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/c67016198d67ef0d833f12fe867b1adbad513315/specification/networkanalytics/resource-manager/readme.md
#tag: package-2023-11-15
skip-csproj: true
modelerfour:
  flatten-payloads: false

#mgmt-debug:
#  show-serialized-names: true

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'

rename-mapping:
  AccountSas: AccountSasContent
  ControlState: DataProductControlState
  DataType: DataProductDataType
  DataTypeState: DataProductDataTypeState
  DefaultAction: NetworkAclDefaultAction
  ListRoleAssignments: RoleAssignmentListResult

prepend-rp-prefix:
  - IPRules
  - KeyVaultInfo
  - ManagedResourceGroupConfiguration
  - ProvisioningState
  - VirtualNetworkRule


directive:
  - remove-operation: 'DataTypes_Get'
  - remove-operation: 'DataTypes_Create'
  - remove-operation: 'DataTypes_Update'
  - remove-operation: 'DataTypes_Delete'
  - remove-operation: 'DataTypes_DeleteData'
  - remove-operation: 'DataTypes_GenerateStorageContainerSasToken'
```
