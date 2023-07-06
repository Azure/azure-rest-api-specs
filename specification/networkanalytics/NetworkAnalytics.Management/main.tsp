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
  v2023_04_30_preview: "2023-04-30-preview"
}

@doc("The data lake house resource")
model DataLakeHouseResources is TrackedResource < StorageProperties > {
    @doc("The data lake house resource name")
    @key("storageName")
    @segment("dataLakeHouses")
    @path
    name: string;
}

@doc("The network analytics product resource")
@singleton
@added(Versions.v2023_03_31_preview)
model NetworkAnalyticsProducts is ProxyResource < NetworkAnalyticsProductsProperties > {
    @doc("The network analytics product name")
    @key("networkAnalyticsProductName")
    @segment("networkAnalyticsProducts")
    @path
    name: string;
}

@doc("The data connector resource")
@added(Versions.v2023_03_31_preview)
model DataConnectors is TrackedResource <DataConnectorsProperties> {
    @doc("The data connector name")
    @key("dataConnectorName")
    @segment("dataConnectors")
    @path
    name: string;
}

@doc("Details of the NetworkAnalytics Storage.")
model StorageProperties {
    @doc("Storage properties")
    @visibility("read")
    provisioningState ?: ProvisioningState;
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
model NetworkAnalyticsProductsProperties {
    @doc("The network analytics product provisioning state")
    @visibility("read")
    provisioningState ?: ProvisioningState;
    @doc("The network analytics product information")
    @extension("x-ms-identifiers", ["productName"])
    @visibility("create", "read")
    networkAnalyticsProductInformation: NetworkAnalyticsProductInformation[];
}

@doc("Details of the Data Connector Properties. The product details are to be added from the supported values which can be fetched by making a GET call on the Network Analytics Product resource.")
@added(Versions.v2023_03_31_preview)
model DataConnectorsProperties {
    @doc("The data connector provisioning state")
    @visibility("read")
    provisioningState ?: ProvisioningState;
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
    productConnector: string,
    @doc("The product connector dataset")
    @visibility("create", "read")
    productConnectorDataset: string,
    @doc("An array of the ARM IDs for the Data Lake House resources")
    @visibility("create", "read")
    dataLakeHouses: string[],
    @doc("The data ingestion path")
    @visibility("read")
    dataIngestionPath ?: string,
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
model NetworkAnalyticsProductConnectorInformation {
    @doc("The connector name")
    @minLength(3)
    @maxLength(63)
    connectorName: string,
    @doc("The datasets supported by the connector")
    datasets: string[]
}

@doc("The data retention, dataset and compute configurations for the connector")
@added(Versions.v2023_03_31_preview)
model DataConnectorConfiguration {
  @doc("The data retention configuration")
  dataRetentionProperties?: DataRetentionProperties,
  @doc("The datasets configuration array ")
  dataset?: DatasetConfiguration,
  @doc("The compute configuration")
  compute: ComputeConfiguration
}

@doc("The data retention properties")
@added(Versions.v2023_03_31_preview)
model DataRetentionProperties {
    @doc("The Azure data explorer retention properties")
    dataExplorer?: RetentionProperties,
    @doc("The bronze storage account retention properties")
    bronzeStorageAccount?: RetentionProperties,
    @doc("The silver storage account retention properties")
    silverStorageAccount?: RetentionProperties,
    @doc("The gold storage account retention properties")
    goldStorageAccount?: RetentionProperties,
}

@doc("The retention properties model")
@added(Versions.v2023_03_31_preview)
model RetentionProperties {
    @doc("The data retention period in days")
    retentionDays: int32
}

@doc("The connector dataset information ")
@added(Versions.v2023_03_31_preview)
model DatasetConfiguration {
    @doc("The name of the dataset")
    datasetName?: string,
    @doc("The column key holding the timestamp data")
    timestampKey?: utcDateTime,
    @doc("Columns to be masked")
    columnsToMask?: string[]
}

@doc("The compute configuration")
@added(Versions.v2023_03_31_preview)
model ComputeConfiguration {
    @doc("The data connector throughput configuration.")
    throughput: Throughput;
}

@doc("The data connector throughput configuration")
@added(Versions.v2023_03_31_preview)
model Throughput {
    @doc("The data connector throughput tier.")
    tier: throughputTier;
}

@doc("The data connector throughput tier for the ADX cluster.")
@added(Versions.v2023_03_31_preview)
enum throughputTier{
    @doc("The Basic throughput tier.")
    Basic,
    @doc("The Standard throughput tier.")
    Standard,
    @doc("The Premium throughput tier.")
    Premium
}

@doc("Common Storage Account Properties.")
model CommonStorageAccountProperties {
    @visibility("create", "read")
    @doc("The SKU of the storage account.")
    @added(Versions.v2023_03_31_preview)
    sku : Sku;
    @visibility("create")
    @doc("Allow or disallow public network access to Storage Account.")
    publicNetworkAccess?: string;
    @doc("Network rule set")
    networkacls ?: NetworkAcls;
    @visibility("create")
    @doc("Blob Services")
    blobServices?: BlobServices;
    @doc("Private End Point")
    privateEndPoint?: PrivateEndPoint;
}

@doc("The SKU of the storage account.")
@added(Versions.v2023_03_31_preview)
model Sku {
    @doc("The name of the SKU.")
	name: SkuName;
}

@doc("The storage redundancy options.")
@added(Versions.v2023_03_31_preview)
enum SkuName {
    @doc("The locally redundant storage.")
    Standard_LRS,
    @doc("The geo redundant storage.")
	Standard_GRS,
    @doc("The zone redundant storage.")
	Standard_ZRS,
    @doc("The geo-zone redundant storage.")
	Standard_GZRS
}

@doc("Configuration for BronzeAccount")
model BronzeStorageAccountProperties {
    @doc("Enables Secure File Transfer Protocol, if set to true")
    isSftpEnabled: boolean;
}

@doc("ADx Properties")
model AzureDataExplorerProperties {
    @visibility("create")
    @doc("Virtual Network Configuration")
    virtualNetworkConfiguration?: VirtualNetworkConfiguration;
    @doc("Kusto Cluster Principal Assignments")
    kustoClusterPrincipalAssignments: KustoClusterPrincipalAssignments;
    @visibility("create", "read")
    @doc("The ADX SKU details")
    @added(Versions.v2023_03_31_preview)
    adxSku: AdxSku;
    @doc("An array represents the availability zones of the cluster.")
    @visibility("create", "read")
    @added(Versions.v2023_03_31_preview)
    zones ?: string[];
}

@doc("The ADX SKU details")
@added(Versions.v2023_03_31_preview)
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
enum SkuTier {
    @doc("The Basic tier.")
    Basic,
    @doc("The Premium tier.")
    Premium
}

@doc("The ADX SKU name options.")
@added(Versions.v2023_03_31_preview)
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
enum KustoRole {
  @doc("The Kusto Cluster Admin role.")
  AllDatabasesAdmin,
  @doc("The Kusto Database Viewer role.")
  AllDatabasesViewer,
}

@doc("The PrincipalType options.")
enum PrincipalType {
  @doc("The principal is an app.")
  App,
  @doc("The principal is a group.")
  Group,
  @doc("The principal is a user.")
  User,
}

@doc("ADx Role assignments")
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
    action ?: string;
    @doc("Gets the state of virtual network rule.")
    state ?: string;
}

@doc("IP rule with specific IP or IP range in CIDR format.")
model IPRules {
    @doc("IP Rules Value")
    value ? : string;
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

enum Bypass {
   None,
   Logging,
   Metrics,
   AzureServices
}

enum DefaultAction {
  Allow,
  Deny
}

@doc("Network rule set")
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

@doc("Restore Policy")
model RestorePolicy {
    @doc("Restore Policy enabled or disabled boolean value")
    enabled: boolean;
    @doc("Restore Policy in days")
    days: int32;
}

@doc("Configuration for creating Blob Service")
model BlobServices {
    @doc("Restore Policy")
    restorePolicy: RestorePolicy;
}

@doc("Virtual Network Configuration")
model VirtualNetworkConfiguration {
    @doc("Resource ID of a subnet")
    subnetId: string;
    @doc("Engine Public IP ID")
    enginePublicIpId: string;
    @doc("Data Management Public Ip ID")
    dataManagementPublicIpId: string;
}

@doc("An ingestion endpoint for metrics relating to the parent resource")
@added(Versions.v2023_04_30_preview)
@singleton
model MetricsIngestionEndpointResources is ExtensionResource < MetricsIngestionEndpointProperties > {
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

@armResourceOperations
interface Storage
  extends TrackedResourceOperations<DataLakeHouseResources, StorageProperties> {}

@added(Versions.v2023_03_31_preview)
@armResourceOperations(NetworkAnalyticsProducts)
interface NetworkAnalyticsProduct
  extends TrackedResourceOperations<
      NetworkAnalyticsProducts,
      NetworkAnalyticsProductsProperties
    > {}

@added(Versions.v2023_03_31_preview)
@armResourceOperations(DataConnectors)
interface DataConnector
  extends TrackedResourceOperations<DataConnectors, DataConnectorsProperties> {}

@added(Versions.v2023_04_30_preview)
@armResourceOperations(MetricsIngestionEndpointProperties)
interface MetricsIngestionEndpoints extends ExtensionResourceOperations<MetricsIngestionEndpointResources, MetricsIngestionEndpointProperties> {}