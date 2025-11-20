using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.NetworkAnalytics;

@doc("The data lake house resource")
@removed(Versions.v2023_11_15)
model DataLakeHouseResources is TrackedResource<StorageProperties> {
  @doc("The data lake house resource name")
  @key("storageName")
  @segment("dataLakeHouses")
  @path
  name: string;
}

@doc("Details of the NetworkAnalytics Storage.")
@removed(Versions.v2023_11_15)
model StorageProperties {
  @doc("Storage properties")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Managed Resource Group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @visibility(Lifecycle.Create)
  @removed(Versions.v2023_03_31_preview)
  @doc("unique Identifier Name")
  uniqueIdentifierName: string;

  @doc("Common Storage Account properties.")
  @madeOptional(Versions.v2023_03_31_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  commonStorageAccountProperties?: CommonStorageAccountProperties;

  @doc("Bronze Storage Account properties.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  bronzeStorageAccountProperties?: BronzeStorageAccountProperties;

  @doc("Azure DataExplorer Cluster properties.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  azureDataExplorerProperties: AzureDataExplorerProperties;
}

@doc("Common Storage Account Properties.")
@removed(Versions.v2023_11_15)
model CommonStorageAccountProperties {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The SKU of the storage account.")
  @removed(Versions.v2023_11_15)
  @added(Versions.v2023_03_31_preview)
  sku: Sku;

  @visibility(Lifecycle.Create)
  @doc("Allow or disallow public network access to Storage Account.")
  publicNetworkAccess?: string;

  @doc("Network rule set")
  networkacls?: NetworkAcls;

  @visibility(Lifecycle.Create)
  @doc("Blob Services")
  blobServices?: BlobServices;

  @doc("Private End Point")
  privateEndPoint?: PrivateEndPoint;
}

@doc("The SKU of the storage account.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model Sku {
  @doc("The name of the SKU.")
  name: SkuName;
}

@doc("The storage redundancy options.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
enum SkuName {
  @doc("The locally redundant storage.")
  Standard_LRS,

  @doc("The geo redundant storage.")
  Standard_GRS,

  @doc("The zone redundant storage.")
  Standard_ZRS,

  @doc("The geo-zone redundant storage.")
  Standard_GZRS,
}

@doc("Configuration for BronzeAccount")
@removed(Versions.v2023_11_15)
model BronzeStorageAccountProperties {
  @doc("Enables Secure File Transfer Protocol, if set to true")
  isSftpEnabled: boolean;
}

@doc("ADx Properties")
@removed(Versions.v2023_11_15)
model AzureDataExplorerProperties {
  @visibility(Lifecycle.Create)
  @doc("Virtual Network Configuration")
  virtualNetworkConfiguration?: VirtualNetworkConfiguration;

  @doc("Kusto Cluster Principal Assignments")
  kustoClusterPrincipalAssignments: KustoClusterPrincipalAssignments;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The ADX SKU details")
  @added(Versions.v2023_03_31_preview)
  @removed(Versions.v2023_11_15)
  adxSku: AdxSku;

  @doc("An array represents the availability zones of the cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @added(Versions.v2023_03_31_preview)
  @removed(Versions.v2023_11_15)
  zones?: string[];
}

@doc("The ADX SKU details")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model AdxSku {
  @doc("SKU name.")
  name: AdxSkuName;

  @doc("SKU tier.")
  tier: SkuTier;

  @doc("The number of instances of the cluster.")
  capacity?: int32;
}

@doc("The ADX SKU tier options.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
enum SkuTier {
  @doc("The Basic tier.")
  Basic,

  @doc("The Premium tier.")
  Premium,
}

@doc("The KustoRole options.")
@removed(Versions.v2023_11_15)
enum KustoRole {
  @doc("The Kusto Cluster Admin role.")
  AllDatabasesAdmin,

  @doc("The Kusto Database Viewer role.")
  AllDatabasesViewer,
}

@doc("The PrincipalType options.")
@removed(Versions.v2023_11_15)
enum PrincipalType {
  @doc("The principal is an app.")
  App,

  @doc("The principal is a group.")
  Group,

  @doc("The principal is a user.")
  User,
}

@doc("ADx Role assignments")
@removed(Versions.v2023_11_15)
model KustoClusterPrincipalAssignments {
  @visibility(Lifecycle.Create)
  @doc("system Identity Name")
  systemIdentityName?: string;

  @doc("Kusto roles")
  role: KustoRole;

  @doc("Principal type.")
  principalType: PrincipalType;
}

@doc("Virtual Network Configuration")
@removed(Versions.v2023_11_15)
model VirtualNetworkConfiguration {
  @doc("Resource ID of a subnet")
  subnetId: string;

  @doc("Engine Public IP ID")
  enginePublicIpId: string;

  @doc("Data Management Public Ip ID")
  dataManagementPublicIpId: string;
}

@doc("Private End Point Resource")
@removed(Versions.v2023_11_15)
model PrivateEndPoint {
  @doc("Resource ID of a subnet")
  subnetId: string;

  @doc("The private link resource service id")
  privateLinkServiceId: string;

  @doc("The private link resource group id.")
  groupIds: string[];

  @doc("The private link resource customDnsConfigs.")
  customDnsConfigs: string;
}

@doc("Resource Access Rules.")
model ResourceAccessRules {
  @doc("The tenant ID of resource.")
  tenantId: string;

  @doc("Resource ID")
  resourceId: string;
}

@doc("Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Possible values are any combination of Logging|Metrics|AzureServices (For example, \"Logging, Metrics\"), or None to bypass none of those traffics.")
enum Bypass {
  @doc("Represents no bypassing of traffic.")
  None,

  @doc("Represents bypassing logging traffic.")
  Logging,

  @doc("Represents bypassing metrics traffic.")
  Metrics,

  @doc("Represents bypassing azure services traffic.")
  AzureServices,
}

@doc("Network rule set")
@removed(Versions.v2023_11_15)
model NetworkAcls {
  @doc("Specifies whether traffic is bypassed for Logging/Metrics/AzureServices")
  bypass: Bypass;

  @doc("Virtual Network Rule")
  virtualNetworkRule: VirtualNetworkRule[];

  @doc("IP rule with specific IP or IP range in CIDR format.")
  @identifiers(#[])
  ipRules: IPRules[];

  @doc("Resource Access Rules.")
  @identifiers(#[])
  resourceAccessRules: ResourceAccessRules[];

  @doc("Default Action")
  @renamedFrom(Versions.v2023_03_31_preview, "defaultAction")
  defaultActionType: DefaultAction;
}

@doc("Restore Policy")
@removed(Versions.v2023_11_15)
model RestorePolicy {
  @doc("Restore Policy enabled or disabled boolean value")
  enabled: boolean;

  @doc("Restore Policy in days")
  days: int32;
}

@doc("Configuration for creating Blob Service")
@removed(Versions.v2023_11_15)
model BlobServices {
  @doc("Restore Policy")
  restorePolicy: RestorePolicy;
}

@armResourceOperations
@removed(Versions.v2023_11_15)
interface Storage
  extends TrackedResourceOperations<
      DataLakeHouseResources,
      StorageProperties
    > {}
