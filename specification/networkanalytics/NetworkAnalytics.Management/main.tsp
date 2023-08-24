import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";

using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Microsoft.NetworkAnalytics",
})
@versioned(Microsoft.NetworkAnalytics.Versions)
namespace Microsoft.NetworkAnalytics;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The available API versions for the Microsoft.NetworkAnalytics RP.")
enum Versions {
  @doc("The 2022-11-15-preview version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_11_15_preview: "2022-11-15-preview",

  @doc("The 2023-03-31-preview version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_03_31_preview: "2023-03-31-preview",

  @doc("The 2023-04-30-preview version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_04_30_preview: "2023-04-30-preview",

  @doc("The 2023-11-15 stable version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_11_15: "2023-11-15",
}

@doc("The data lake house resource")
@removed(Versions.v2023_11_15)
model DataLakeHouseResources is TrackedResource<StorageProperties> {
  @doc("The data lake house resource name")
  @key("storageName")
  @segment("dataLakeHouses")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "Suppressing updateable property warning for network analytics products for now"
@doc("The network analytics product resource")
@singleton
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProducts
  is ProxyResource<NetworkAnalyticsProductsProperties> {
  @doc("The network analytics product name")
  @key("networkAnalyticsProductName")
  @segment("networkAnalyticsProducts")
  @path
  name: string;
}

@doc("The data connector resource")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataConnectors is TrackedResource<DataConnectorsProperties> {
  @doc("The data connector name")
  @key("dataConnectorName")
  @segment("dataConnectors")
  @path
  name: string;
}

@doc("Details of the NetworkAnalytics Storage.")
@removed(Versions.v2023_11_15)
model StorageProperties {
  @doc("Storage properties")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed Resource Group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @visibility("create")
  @removed(Versions.v2023_03_31_preview)
  @doc("unique Identifier Name")
  uniqueIdentifierName: string;

  @doc("Common Storage Account properties.")
  @madeOptional(Versions.v2023_03_31_preview)
  @visibility("create", "read")
  commonStorageAccountProperties?: CommonStorageAccountProperties;

  @doc("Bronze Storage Account properties.")
  @visibility("create", "read")
  bronzeStorageAccountProperties?: BronzeStorageAccountProperties;

  @doc("Azure DataExplorer Cluster properties.")
  @visibility("create", "read")
  azureDataExplorerProperties: AzureDataExplorerProperties;
}

@doc("Details of the network analytics product properties")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProductsProperties {
  @doc("The network analytics product provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The network analytics product information")
  @extension("x-ms-identifiers", ["productName"])
  @visibility("create", "read")
  networkAnalyticsProductInformation: NetworkAnalyticsProductInformation[];
}

@doc("Details of the Data Connector Properties. The product details are to be added from the supported values which can be fetched by making a GET call on the Network Analytics Product resource.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataConnectorsProperties {
  @doc("The data connector provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The network analytics product to which this connector belongs to")
  @visibility("create", "read")
  productName: string;

  @doc("The version of the corresponding product")
  @visibility("create", "read")
  productVersion: string;

  @doc("The product connector")
  @visibility("create", "read")
  productConnector: string;

  @doc("The product connector dataset")
  @visibility("create", "read")
  productConnectorDataset: string;

  @doc("An array of the ARM IDs for the Data Lake House resources")
  @visibility("create", "read")
  dataLakeHouses: string[];

  @doc("The data ingestion path")
  @visibility("read")
  dataIngestionPath?: string;

  @doc("The data connector configuration")
  @visibility("create", "read")
  dataConnectorConfiguration: DataConnectorConfiguration;
}

@doc("The status of the current operation.")
enum ProvisioningState {
  /** Represents a succeeded operation. */
  Succeeded,
  /** Represents a failed operation. */
  Failed,
  /** Represents a canceled operation. */
  Canceled,
  /** Represents a pending operation. */
  Provisioning,
  /** Represents a pending operation. */
  Updating,
  /** Represents an operation under deletion. */
  Deleting,
  /** Represents an accepted operation. */
  Accepted,
}

@doc("ManagedResourceGroup related properties")
model ManagedResourceGroupConfiguration {
  @doc("Name of managed resource group")
  name: string;

  @doc("Managed Resource Group location")
  location: string;
}

@doc("The network analytics product information")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProductInformation {
  @doc("Name of the network analytics product")
  @minLength(3)
  @maxLength(63)
  productName: string;

  @doc("The available versions for the product")
  productVersions: string[];

  @doc("The connectors supported by the product")
  @extension("x-ms-identifiers", ["connectorName"])
  productConnectors: NetworkAnalyticsProductConnectorInformation[];
}

@doc("Data Connector Information")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProductConnectorInformation {
  @doc("The connector name")
  @minLength(3)
  @maxLength(63)
  connectorName: string;

  @doc("The datasets supported by the connector")
  datasets: string[];
}

@doc("The data retention, dataset and compute configurations for the connector")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataConnectorConfiguration {
  @doc("The data retention configuration")
  dataRetentionProperties?: DataRetentionProperties;

  @doc("The datasets configuration array ")
  dataset?: DatasetConfiguration;

  @doc("The compute configuration")
  compute: ComputeConfiguration;
}

@doc("The data retention properties")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataRetentionProperties {
  @doc("The Azure data explorer retention properties")
  dataExplorer?: RetentionProperties;

  @doc("The bronze storage account retention properties")
  bronzeStorageAccount?: RetentionProperties;

  @doc("The silver storage account retention properties")
  silverStorageAccount?: RetentionProperties;

  @doc("The gold storage account retention properties")
  goldStorageAccount?: RetentionProperties;
}

@doc("The retention properties model")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model RetentionProperties {
  @doc("The data retention period in days")
  retentionDays: int32;
}

@doc("The connector dataset information ")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DatasetConfiguration {
  @doc("The name of the dataset")
  datasetName?: string;

  @doc("The column key holding the timestamp data")
  timestampKey?: utcDateTime;

  @doc("Columns to be masked")
  columnsToMask?: string[];
}

@doc("The compute configuration")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model ComputeConfiguration {
  @doc("The data connector throughput configuration.")
  throughput: Throughput;
}

@doc("The data connector throughput configuration")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model Throughput {
  @doc("The data connector throughput tier.")
  tier: throughputTier;
}

@doc("The data connector throughput tier for the ADX cluster.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
enum throughputTier {
  @doc("The Basic throughput tier.")
  Basic,

  @doc("The Standard throughput tier.")
  Standard,

  @doc("The Premium throughput tier.")
  Premium,
}

@doc("Common Storage Account Properties.")
@removed(Versions.v2023_11_15)
model CommonStorageAccountProperties {
  @visibility("create", "read")
  @doc("The SKU of the storage account.")
  @removed(Versions.v2023_11_15)
  @added(Versions.v2023_03_31_preview)
  sku: Sku;

  @visibility("create")
  @doc("Allow or disallow public network access to Storage Account.")
  publicNetworkAccess?: string;

  @doc("Network rule set")
  networkacls?: NetworkAcls;

  @visibility("create")
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
  @visibility("create")
  @doc("Virtual Network Configuration")
  virtualNetworkConfiguration?: VirtualNetworkConfiguration;

  @doc("Kusto Cluster Principal Assignments")
  kustoClusterPrincipalAssignments: KustoClusterPrincipalAssignments;

  @visibility("create", "read")
  @doc("The ADX SKU details")
  @added(Versions.v2023_03_31_preview)
  @removed(Versions.v2023_11_15)
  adxSku: AdxSku;

  @doc("An array represents the availability zones of the cluster.")
  @visibility("create", "read")
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

@doc("The ADX SKU name options.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
enum AdxSkuName {
  @doc("The Dev_No_SLA_Standard_D11_v2 SKU")
  Dev_No_SLA_Standard_D11_v2: "Dev(No SLA)_Standard_D11_v2",

  @doc("The Dev_No_SLA_Standard_E2a_v4 SKU")
  Dev_No_SLA_Standard_E2a_v4: "Dev(No SLA)_Standard_E2a_v4",

  @doc("The Standard_D11_v2 SKU")
  Standard_D11_v2: "Standard_D11_v2",

  @doc("The Standard_D12_v2 SKU")
  Standard_D12_v2: "Standard_D12_v2",

  @doc("The Standard_D13_v2 SKU")
  Standard_D13_v2: "Standard_D13_v2",

  @doc("The Standard_D14_v2 SKU")
  Standard_D14_v2: "Standard_D14_v2",

  @doc("The Standard_D32d_v4 SKU")
  Standard_D32d_v4: "Standard_D32d_v4",

  @doc("The Standard_D16d_v5 SKU")
  Standard_D16d_v5: "Standard_D16d_v5",

  @doc("The Standard_D32d_v5 SKU")
  Standard_D32d_v5: "Standard_D32d_v5",

  @doc("The Standard_DS13_v2_1TB_PS SKU")
  Standard_DS13_v2_1TB_PS: "Standard_DS13_v2+1TB_PS",

  @doc("The Standard_DS13_v2_2TB_PS SKU")
  Standard_DS13_v2_2TB_PS: "Standard_DS13_v2+2TB_PS",

  @doc("The Standard_DS14_v2_3TB_PS SKU")
  Standard_DS14_v2_3TB_PS: "Standard_DS14_v2+3TB_PS",

  @doc("The Standard_DS14_v2_4TB_PS SKU")
  Standard_DS14_v2_4TB_PS: "Standard_DS14_v2+4TB_PS",

  @doc("The Standard_L4s SKU")
  Standard_L4s: "Standard_L4s",

  @doc("The Standard_L8s SKU")
  Standard_L8s: "Standard_L8s",

  @doc("The Standard_L16s SKU")
  Standard_L16s: "Standard_L16s",

  @doc("The Standard_L8s_v2 SKU")
  Standard_L8s_v2: "Standard_L8s_v2",

  @doc("The Standard_L16s_v2 SKU")
  Standard_L16s_v2: "Standard_L16s_v2",

  @doc("The Standard_L8s_v3 SKU")
  Standard_L8s_v3: "Standard_L8s_v3",

  @doc("The Standard_L16s_v3 SKU")
  Standard_L16s_v3: "Standard_L16s_v3",

  @doc("The Standard_L32s_v3 SKU")
  Standard_L32s_v3: "Standard_L32s_v3",

  @doc("The Standard_L8as_v3 SKU")
  Standard_L8as_v3: "Standard_L8as_v3",

  @doc("The Standard_L16as_v3 SKU")
  Standard_L16as_v3: "Standard_L16as_v3",

  @doc("The Standard_L32as_v3 SKU")
  Standard_L32as_v3: "Standard_L32as_v3",

  @doc("The Standard_E64i_v3 SKU")
  Standard_E64i_v3: "Standard_E64i_v3",

  @doc("The Standard_E80ids_v4 SKU")
  Standard_E80ids_v4: "Standard_E80ids_v4",

  @doc("The Standard_E2a_v4 SKU")
  Standard_E2a_v4: "Standard_E2a_v4",

  @doc("The Standard_E4a_v4 SKU")
  Standard_E4a_v4: "Standard_E4a_v4",

  @doc("The Standard_E8a_v4 SKU")
  Standard_E8a_v4: "Standard_E8a_v4",

  @doc("The Standard_E16a_v4 SKU")
  Standard_E16a_v4: "Standard_E16a_v4",

  @doc("The Standard_E8as_v4_1TB_PS SKU")
  Standard_E8as_v4_1TB_PS: "Standard_E8as_v4+1TB_PS",

  @doc("The Standard_E8as_v4_2TB_PS SKU")
  Standard_E8as_v4_2TB_PS: "Standard_E8as_v4+2TB_PS",

  @doc("The Standard_E16as_v4_3TB_PS SKU")
  Standard_E16as_v4_3TB_PS: "Standard_E16as_v4+3TB_PS",

  @doc("The Standard_E16as_v4_4TB_PS SKU")
  Standard_E16as_v4_4TB_PS: "Standard_E16as_v4+4TB_PS",

  @doc("The Standard_E8as_v5_1TB_PS SKU")
  Standard_E8as_v5_1TB_PS: "Standard_E8as_v5+1TB_PS",

  @doc("The Standard_E8as_v5_2TB_PS SKU")
  Standard_E8as_v5_2TB_PS: "Standard_E8as_v5+2TB_PS",

  @doc("The Standard_E16as_v5_3TB_PS SKU")
  Standard_E16as_v5_3TB_PS: "Standard_E16as_v5+3TB_PS",

  @doc("The Standard_E16as_v5_4TB_PS SKU")
  Standard_E16as_v5_4TB_PS: "Standard_E16as_v5+4TB_PS",

  @doc("The Standard_E2ads_v5 SKU")
  Standard_E2ads_v5: "Standard_E2ads_v5",

  @doc("The Standard_E4ads_v5 SKU")
  Standard_E4ads_v5: "Standard_E4ads_v5",

  @doc("The Standard_E8ads_v5 SKU")
  Standard_E8ads_v5: "Standard_E8ads_v5",

  @doc("The Standard_E16ads_v5 SKU")
  Standard_E16ads_v5: "Standard_E16ads_v5",

  @doc("The Standard_EC8as_v5_1TB_PS SKU")
  Standard_EC8as_v5_1TB_PS: "Standard_EC8as_v5+1TB_PS",

  @doc("The Standard_EC8as_v5_2TB_PS SKU")
  Standard_EC8as_v5_2TB_PS: "Standard_EC8as_v5+2TB_PS",

  @doc("The Standard_EC16as_v5_3TB_PS SKU")
  Standard_EC16as_v5_3TB_PS: "Standard_EC16as_v5+3TB_PS",

  @doc("The Standard_EC16as_v5_4TB_PS SKU")
  Standard_EC16as_v5_4TB_PS: "Standard_EC16as_v5+4TB_PS",

  @doc("The Standard_EC8ads_v5 SKU")
  Standard_EC8ads_v5: "Standard_EC8ads_v5",

  @doc("The Standard_EC16ads_v5 SKU")
  Standard_EC16ads_v5: "Standard_EC16ads_v5",

  @doc("The Standard_E8s_v4_1TB_PS SKU")
  Standard_E8s_v4_1TB_PS: "Standard_E8s_v4+1TB_PS",

  @doc("The Standard_E8s_v4_2TB_PS SKU")
  Standard_E8s_v4_2TB_PS: "Standard_E8s_v4+2TB_PS",

  @doc("The Standard_E16s_v4_3TB_PS SKU")
  Standard_E16s_v4_3TB_PS: "Standard_E16s_v4+3TB_PS",

  @doc("The Standard_E16s_v4_4TB_PS SKU")
  Standard_E16s_v4_4TB_PS: "Standard_E16s_v4+4TB_PS",

  @doc("The Standard_E8s_v5_1TB_PS SKU")
  Standard_E8s_v5_1TB_PS: "Standard_E8s_v5+1TB_PS",

  @doc("The Standard_E8s_v5_2TB_PS SKU")
  Standard_E8s_v5_2TB_PS: "Standard_E8s_v5+2TB_PS",

  @doc("The Standard_E16s_v5_3TB_PS SKU")
  Standard_E16s_v5_3TB_PS: "Standard_E16s_v5+3TB_PS",

  @doc("The Standard_E16s_v5_4TB_PS SKU")
  Standard_E16s_v5_4TB_PS: "Standard_E16s_v5+4TB_PS",

  @doc("The Standard_E2d_v4 SKU")
  Standard_E2d_v4: "Standard_E2d_v4",

  @doc("The Standard_E4d_v4 SKU")
  Standard_E4d_v4: "Standard_E4d_v4",

  @doc("The Standard_E8d_v4 SKU")
  Standard_E8d_v4: "Standard_E8d_v4",

  @doc("The Standard_E16d_v4 SKU")
  Standard_E16d_v4: "Standard_E16d_v4",

  @doc("The Standard_E2d_v5 SKU")
  Standard_E2d_v5: "Standard_E2d_v5",

  @doc("The Standard_E4d_v5 SKU")
  Standard_E4d_v5: "Standard_E4d_v5",

  @doc("The Standard_E8d_v5 SKU")
  Standard_E8d_v5: "Standard_E8d_v5",

  @doc("The Standard_E16d_v5 SKU")
  Standard_E16d_v5: "Standard_E16d_v5",
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
  @visibility("create")
  @doc("system Identity Name")
  systemIdentityName?: string;

  @doc("Kusto roles")
  role: KustoRole;

  @doc("Principal type.")
  principalType: PrincipalType;
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

@doc("Virtual Network Rule")
model VirtualNetworkRule {
  @doc("Resource ID of a subnet")
  id: string;

  @doc("The action of virtual network rule.")
  action?: string;

  @doc("Gets the state of virtual network rule.")
  state?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppressing casing style warning for iprules for now."
@doc("IP rule with specific IP or IP range in CIDR format.")
model IPRules {
  @doc("IP Rules Value")
  value?: string;

  @doc("The action of virtual network rule.")
  action: string;
}

@doc("Resource Access Rules.")
model ResourceAccessRules {
  @doc("The tenant ID of resource.")
  tenantId: string;

  @doc("Resource ID")
  resourceId: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Suppressing documentation required warning nfor bypass for now."
enum Bypass {
  None,
  Logging,
  Metrics,
  AzureServices,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Suppressing documentation required warning for default action for now."
enum DefaultAction {
  Allow,
  Deny,
}

@doc("Network rule set")
@removed(Versions.v2023_11_15)
model NetworkAcls {
  @doc("Specifies whether traffic is bypassed for Logging/Metrics/AzureServices")
  bypass: Bypass;

  @doc("Virtual Network Rule")
  virtualNetworkRule: VirtualNetworkRule[];

  @doc("IP rule with specific IP or IP range in CIDR format.")
  @extension("x-ms-identifiers", [])
  ipRules: IPRules[];

  @doc("Resource Access Rules.")
  @extension("x-ms-identifiers", [])
  resourceAccessRules: ResourceAccessRules[];

  @doc("Default Action")
  @renamedFrom(Versions.v2023_03_31_preview, "defaultAction")
  defaultActionType: DefaultAction;
}

@doc("Data Product Network rule set")
@added(Versions.v2023_11_15)
model DataProductNetworkAcls {
  @doc("Virtual Network Rule")
  virtualNetworkRule: VirtualNetworkRule[];

  @doc("IP rule with specific IP or IP range in CIDR format.")
  @extension("x-ms-identifiers", [])
  ipRules: IPRules[];

  @doc("The list of query ips in the format of CIDR allowed to connect to query/visualization endpoint.")
  allowedQueryIpRangeList: string[];

  @doc("Default Action")
  defaultAction: DefaultAction;
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

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "Suppressing updateable property warning for metrics ingestion endpoint for now."
@doc("An ingestion endpoint for metrics relating to the parent resource")
@added(Versions.v2023_04_30_preview)
@singleton
model MetricsIngestionEndpointResources
  is ExtensionResource<MetricsIngestionEndpointProperties> {
  @doc("Metrics Ingestion Endpoint Name")
  @key("metricsIngestionEndpointName")
  @segment("metricsIngestionEndpoints")
  @path
  name: string;
}

@doc("The resource-specific properties of a Metrics Ingestion Endpoint")
@added(Versions.v2023_04_30_preview)
model MetricsIngestionEndpointProperties {
  @doc("Name of the External Metrics Ingress Gateway region where the compute should be deployed")
  @visibility("create", "read")
  ingressRegionName: string;

  @visibility("read")
  @doc("Event Hub URL to which the metrics should be sent for this resource")
  eventHubUrl?: string;

  @visibility("read")
  @doc("Event Hub name to which the metrics should be sent for this resource")
  eventHubName?: string;

  @visibility("read")
  @doc("Key Vault URL where the connection string exists for authentication")
  keyVaultUrl?: string;

  @visibility("read")
  @doc("Resource id of KeyVault")
  keyVaultResourceId?: string;

  @visibility("read")
  @doc("Resource id of user assigned managed identity")
  userManagedIdentityResourceId?: string;

  @visibility("read")
  @doc("Principal id of user assigned managed identity created under managed resource group")
  userManagedIdentityPrincipalId?: string;

  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed Resource Group Configuration")
  @visibility("create", "read")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}

@doc("The data product resource.")
@added(Versions.v2023_11_15)
model DataProduct is TrackedResource<DataProductProperties> {
  @doc("The data product resource name")
  @key("dataProductName")
  @segment("dataProducts")
  @path
  @pattern("^[a-z][a-z0-9]*$")
  @minLength(3)
  @maxLength(63)
  name: string;

  ...ManagedServiceIdentity;
}

@doc("The data product properties.")
@added(Versions.v2023_11_15)
model DataProductProperties {
  @doc("The resource GUID property of the data product resource.")
  @visibility("read")
  resourceGuid?: string;

  @doc("Latest provisioning state  of data product.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Data product publisher name.")
  @visibility("create", "read")
  publisher: string;

  @doc("Product name of data product.")
  @visibility("create", "read")
  product: string;

  @doc("Major version of data product.")
  @visibility("create", "read")
  majorVersion: string;

  @doc("List of name or email associated with data product resource deployment.")
  @visibility("create", "read", "update")
  owners?: string[];

  @doc("Flag to enable or disable redundancy for data product.")
  @visibility("create", "read")
  redundancy?: ControlState;

  @doc("Purview account url for data product to connect to.")
  @visibility("create", "update", "read")
  purviewAccount?: string;

  @doc("Purview collection url for data product to connect to.")
  @visibility("create", "update", "read")
  purviewCollection?: string;

  @doc("Flag to enable or disable private link for data product resource.")
  @visibility("create", "update", "read")
  privateLinksEnabled?: ControlState;

  @doc("Flag to enable or disable public access of data product resource.")
  @visibility("create", "read")
  publicNetworkAccess?: ControlState;

  @doc("Flag to enable customer managed key encryption for data product.")
  @visibility("create", "read")
  customerManagedKeyEncryptionEnabled?: ControlState;

  @doc("Customer managed encryption key details for data product.")
  @visibility("create", "read")
  customerEncryptionKey?: EncryptionKeyDetails;

  @doc("Network rule set for data product.")
  @visibility("create", "read")
  networkacls?: DataProductNetworkAcls;

  @doc("Managed resource group configuration.")
  @visibility("create")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("List of available minor versions of the data product resource.")
  @visibility("read")
  availableMinorVersions?: string[];

  @doc("Current configured minor version of the data product resource.")
  @visibility("read", "update")
  currentMinorVersion?: string;

  @doc("Documentation link for the data product based on definition file.")
  @visibility("read")
  documentation?: string;

  @doc("Resource links which exposed to the customer to query the data.")
  @visibility("read")
  consumptionEndpoints?: ConsumptionEndpointsProperties;

  @doc("Key vault url.")
  @visibility("read")
  keyVaultUrl?: string;
}

@doc("Encryption key details.")
@added(Versions.v2023_11_15)
model EncryptionKeyDetails {
  @doc("The Uri of the key vault.")
  keyVaultUri: string;

  @doc("The name of the key vault key.")
  keyName: string;

  @doc("The version of the key vault key.")
  keyVersion: string;
}

@doc("The data type state")
@added(Versions.v2023_11_15)
enum ControlState {
  @doc("Field to enable a setting.")
  Enabled,

  @doc("Field to disable a setting.")
  Disabled,
}

@doc("Details of Consumption Properties")
@added(Versions.v2023_11_15)
model ConsumptionEndpointsProperties {
  @doc("Ingestion url to upload the data.")
  @visibility("read")
  ingestionUrl?: string;

  @doc("Resource Id of ingestion endpoint.")
  @visibility("read")
  ingestionResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("Url to consume file type.")
  @visibility("read")
  fileAccessUrl?: string;

  @doc("Resource Id of file access endpoint.")
  @visibility("read")
  fileAccessResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("Url to consume the processed data.")
  @visibility("read")
  queryUrl?: string;

  @doc("Resource Id of query endpoint.")
  @visibility("read")
  queryResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Kusto/clusters";
    }
  ]>;
}

@doc("The details for storage account sas creation.")
@added(Versions.v2023_11_15)
model AccountSas {
  @doc("Sas token start timestamp.")
  @format("date-time")
  startTimeStamp: string;

  @doc("Sas token expiry timestamp.")
  @format("date-time")
  expiryTimeStamp: string;

  @doc("Ip Address")
  ipAddress: string;
}

@doc("Details of storage account sas token .")
@added(Versions.v2023_11_15)
model AccountSasToken {
  @doc("Field to specify storage account sas token.")
  storageAccountSasToken: string;
}

@doc("Details of storage container account sas token .")
@added(Versions.v2023_11_15)
model ContainerSasToken {
  @doc("Field to specify storage container sas token.")
  storageContainerSasToken: string;
}

@doc("Details for KeyVault.")
@added(Versions.v2023_11_15)
model KeyVaultInfo {
  @doc("key vault url.")
  keyVaultUrl: string;
}

@doc("The data type resource.")
@added(Versions.v2023_11_15)
@parentResource(DataProduct)
model DataType is ProxyResource<DataTypeProperties> {
  @doc("The data type name.")
  @segment("dataTypes")
  @key("dataTypeName")
  @path
  @pattern("^[a-z][a-z0-9-]*$")
  @minLength(3)
  @maxLength(63)
  name: string;
}

@doc("The data type properties")
@added(Versions.v2023_11_15)
model DataTypeProperties {
  @doc("Latest provisioning state  of data product.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("State of data type.")
  @visibility("read", "create", "update")
  state?: DataTypeState;

  @doc("Reason for the state of data type.")
  @visibility("read")
  stateReason?: string;

  @doc("Field for storage output retention in days.")
  @visibility("read", "create", "update")
  storageOutputRetention?: int32;

  @doc("Field for database cache retention in days.")
  @visibility("read", "create", "update")
  databaseCacheRetention?: int32;

  @doc("Field for database data retention in days.")
  @visibility("read", "create", "update")
  databaseRetention?: int32;

  @doc("Url for data visualization.")
  @visibility("read")
  visualizationUrl?: string;
}

@doc("The data type state")
@added(Versions.v2023_11_15)
enum DataTypeState {
  @doc("Field to specify stopped state.")
  Stopped,

  @doc("Field to specify running state.")
  Running,
}

@doc("The details for container sas creation.")
@added(Versions.v2023_11_15)
model ContainerSaS is AccountSas;

@doc("The details for role assignment response.")
@added(Versions.v2023_11_15)
model RoleAssignmentDetail is RoleAssignmentCommonProperties {
  @doc("Id of role assignment request")
  roleAssignmentId: string;
}

@doc("list role assignments.")
@added(Versions.v2023_11_15)
model ListRoleAssignments {
  @doc("Count of role assignments.")
  count: int32;

  @doc("list of role assignments")
  @extension("x-ms-identifiers", ["roleAssignmentId"])
  roleAssignmentResponse: RoleAssignmentDetail[];
}

@doc("The data type state")
@added(Versions.v2023_11_15)
enum DataProductUserRole {
  @doc("Field to specify user of type Reader.")
  Reader,

  @doc("""
Field to specify user of type SensitiveReader.
This user has privileged access to read sensitive data of a data product.
""")
  SensitiveReader,
}

@doc("The details for role assignment common properties.")
@added(Versions.v2023_11_15)
model RoleAssignmentCommonProperties {
  @doc("Role Id of the Built-In Role")
  roleId: string;

  @doc("Object ID of the AAD principal or security-group.")
  principalId: string;

  @doc("User name.")
  userName: string;

  @doc("Data Type Scope at which the role assignment is created.")
  dataTypeScope: string[];

  @doc("Type of the principal Id: User, Group or ServicePrincipal")
  principalType: string;

  @doc("Data Product role to be assigned to a user.")
  role: DataProductUserRole;
}

@doc("The data catalog resource.")
@singleton
@added(Versions.v2023_11_15)
model DataProductsCatalog is ProxyResource<DataProductsCatalogProperties> {
  @doc("The data catalog name")
  @key("dataProductsCatalogName")
  @segment("dataProductsCatalogs")
  @path
  name: string;
}

@doc("Details for data catalog properties.")
@added(Versions.v2023_11_15)
model DataProductsCatalogProperties {
  @doc("The data catalog provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The data product publisher information.")
  publishers: PublisherInformation[];
}

@doc("Details for Publisher Information.")
@added(Versions.v2023_11_15)
model PublisherInformation {
  @doc("Name of the publisher.")
  publisherName: string;

  @doc("Data product information.")
  dataProducts: DataProductInformation[];
}

@added(Versions.v2023_11_15)
@doc("Data Product Information")
model DataProductInformation {
  @doc("Name of data product.")
  dataProductName: string;

  @doc("Description about data product.")
  description: string;

  @doc("Version information of data product.")
  dataProductVersions: DataProductVersion[];
}

@doc("Data Product Version.")
@added(Versions.v2023_11_15)
model DataProductVersion {
  @doc("Version of data product")
  version: string;
}

@armResourceOperations
@removed(Versions.v2023_11_15)
interface Storage
  extends TrackedResourceOperations<
      DataLakeHouseResources,
      StorageProperties
    > {}

@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
@armResourceOperations(NetworkAnalyticsProducts)
interface NetworkAnalyticsProduct
  extends TrackedResourceOperations<
      NetworkAnalyticsProducts,
      NetworkAnalyticsProductsProperties
    > {}

@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
@armResourceOperations(DataConnectors)
interface DataConnector
  extends TrackedResourceOperations<DataConnectors, DataConnectorsProperties> {}

@added(Versions.v2023_04_30_preview)
@armResourceOperations(MetricsIngestionEndpointProperties)
interface MetricsIngestionEndpoints
  extends ExtensionResourceOperations<
      MetricsIngestionEndpointResources,
      MetricsIngestionEndpointProperties
    > {}

@doc("Operations on data catalog resource.")
@added(Versions.v2023_11_15)
@armResourceOperations
interface DataProductsCatalogs {
  @doc("Retrieve data type resource.")
  get is ArmResourceRead<DataProductsCatalog>;
}

@doc("Operations on data type resource.")
@added(Versions.v2023_11_15)
@armResourceOperations
interface DataTypes {
  @doc("Create data type resource.")
  create is ArmResourceCreateOrUpdateAsync<DataType>;

  @doc("Retrieve data type resource.")
  get is ArmResourceRead<DataType>;

  @doc("Update data type resource.")
  update is ArmResourcePatchAsync<DataType, DataTypeProperties>;

  @doc("Delete data type resource.")
  @segment("deleteData")
  delete is ArmResourceDeleteWithoutOkAsync<DataType>;

  @doc("Generate sas token for storage container.")
  generateStorageContainerSasToken is ArmResourceActionAsync<
    DataType,
    ContainerSaS,
    ContainerSasToken
  >;

  @doc("List data type by parent resource.")
  listByParent is ArmResourceListByParent<DataType>;
}

@doc("Operations on data product resource.")
@added(Versions.v2023_11_15)
@armResourceOperations
interface DataProducts {
  @doc("Create data product resource.")
  create is ArmResourceCreateOrUpdateAsync<DataProduct>;

  @doc("Retrieve data product resource.")
  get is ArmResourceRead<DataProduct>;

  @doc("Update data product resource.")
  update is ArmResourcePatchAsync<DataProduct, DataProductProperties>;

  @doc("Delete data product resource.")
  delete is ArmResourceDeleteWithoutOkAsync<DataProduct>;

  @doc("Generate sas token for storage account.")
  generateStorageAccountSasToken is ArmResourceActionAsync<
    DataProduct,
    AccountSas,
    AccountSasToken
  >;

  @doc("Initiate key rotation on Data Product.")
  rotateKey is ArmResourceActionNoContentAsync<DataProduct, KeyVaultInfo>;

  @doc("Assign role to the data product.")
  addUserRole is ArmResourceActionAsync<
    DataProduct,
    RoleAssignmentCommonProperties,
    RoleAssignmentDetail
  >;

  @doc("Remove role from the data product.")
  removeUserRole is ArmResourceActionNoContentAsync<
    DataProduct,
    RoleAssignmentDetail
  >;

  @doc("List user roles associated with the data product.")
  listRolesAssignments is ArmResourceActionAsync<
    DataProduct,
    {},
    ListRoleAssignments
  >;

  @doc("List data products by resource group.")
  listByResourceGroup is ArmResourceListByParent<DataProduct>;

  @doc("List data products by subscription.")
  listBySubscription is ArmListBySubscription<DataProduct>;
}
