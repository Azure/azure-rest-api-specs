import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Kusto;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("SKU name.")
enum AzureSkuName {
  `Dev(No SLA)_Standard_D11_v2`,
  `Dev(No SLA)_Standard_E2a_v4`,
  Standard_D11_v2,
  Standard_D12_v2,
  Standard_D13_v2,
  Standard_D14_v2,
  Standard_D32d_v4,
  Standard_D16d_v5,
  Standard_D32d_v5,
  `Standard_DS13_v2+1TB_PS`,
  `Standard_DS13_v2+2TB_PS`,
  `Standard_DS14_v2+3TB_PS`,
  `Standard_DS14_v2+4TB_PS`,
  Standard_L4s,
  Standard_L8s,
  Standard_L16s,
  Standard_L8s_v2,
  Standard_L16s_v2,
  Standard_L8s_v3,
  Standard_L16s_v3,
  Standard_L32s_v3,
  Standard_L8as_v3,
  Standard_L16as_v3,
  Standard_L32as_v3,
  Standard_E64i_v3,
  Standard_E80ids_v4,
  Standard_E2a_v4,
  Standard_E4a_v4,
  Standard_E8a_v4,
  Standard_E16a_v4,
  `Standard_E8as_v4+1TB_PS`,
  `Standard_E8as_v4+2TB_PS`,
  `Standard_E16as_v4+3TB_PS`,
  `Standard_E16as_v4+4TB_PS`,
  `Standard_E8as_v5+1TB_PS`,
  `Standard_E8as_v5+2TB_PS`,
  `Standard_E16as_v5+3TB_PS`,
  `Standard_E16as_v5+4TB_PS`,
  Standard_E2ads_v5,
  Standard_E4ads_v5,
  Standard_E8ads_v5,
  Standard_E16ads_v5,
  `Standard_EC8as_v5+1TB_PS`,
  `Standard_EC8as_v5+2TB_PS`,
  `Standard_EC16as_v5+3TB_PS`,
  `Standard_EC16as_v5+4TB_PS`,
  Standard_EC8ads_v5,
  Standard_EC16ads_v5,
  `Standard_E8s_v4+1TB_PS`,
  `Standard_E8s_v4+2TB_PS`,
  `Standard_E16s_v4+3TB_PS`,
  `Standard_E16s_v4+4TB_PS`,
  `Standard_E8s_v5+1TB_PS`,
  `Standard_E8s_v5+2TB_PS`,
  `Standard_E16s_v5+3TB_PS`,
  `Standard_E16s_v5+4TB_PS`,
  Standard_E2d_v4,
  Standard_E4d_v4,
  Standard_E8d_v4,
  Standard_E16d_v4,
  Standard_E2d_v5,
  Standard_E4d_v5,
  Standard_E8d_v5,
  Standard_E16d_v5,
}

@doc("SKU tier.")
enum AzureSkuTier {
  Basic,
  Standard,
}

@doc("The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove all identities.")
enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

@doc("The state of the resource.")
enum State {
  Creating,
  Unavailable,
  Running,
  Deleting,
  Deleted,
  Stopping,
  Stopped,
  Starting,
  Updating,
  Migrated,
}

@doc("The provisioned state of the resource.")
enum ProvisioningState {
  Running,
  Creating,
  Deleting,
  Succeeded,
  Failed,
  Moving,
  Canceled,
}

@doc("When enabled, the cluster is deployed into the configured subnet, when disabled it will be removed from the subnet.")
enum VnetState {
  Enabled,
  Disabled,
}

@doc("Language extension that can run within KQL query.")
enum LanguageExtensionName {
  PYTHON,
  R,
}

@doc("Language extension image name.")
enum LanguageExtensionImageName {
  R,
  Python3_6_5,
  Python3_10_8,
  Python3_10_8_DL,
  PythonCustomImage,
}

@doc("Public network access to the cluster is enabled by default. When disabled, only private endpoint connection to the cluster is allowed")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The engine type")
enum EngineType {
  V2,
  V3,
}

@doc("Whether or not to restrict outbound network access.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'")
enum ClusterNetworkAccessFlag {
  Enabled,
  Disabled,
}

@doc("Indicates what public IP type to create - IPv4 (default), or DualStack (both IPv4 and IPv6)")
enum PublicIPType {
  IPv4,
  DualStack,
}

@doc("The role of the cluster in the migration process.")
enum MigrationClusterRole {
  Source,
  Destination,
}

@doc("Message providing the reason why the given name is invalid.")
enum Reason {
  Invalid,
  AlreadyExists,
}

@doc("Cluster principal role.")
enum ClusterPrincipalRole {
  AllDatabasesAdmin,
  AllDatabasesViewer,
}

@doc("Principal type.")
enum PrincipalType {
  App,
  Group,
  User,
}

@doc("The origin of the following setup.")
enum DatabaseShareOrigin {
  Direct,
  DataShare,
  Other,
}

@doc("Scale type.")
enum AzureScaleType {
  automatic,
  manual,
  none,
}

@doc("Kind of the database")
enum Kind {
  ReadWrite,
  ReadOnlyFollowing,
}

enum CallerRole {
  Admin,
  None,
}

@doc("Database principal role.")
enum DatabasePrincipalRole {
  Admin,
  Ingestor,
  Monitor,
  User,
  UnrestrictedViewer,
  Viewer,
}

@doc("Database principal type.")
enum DatabasePrincipalType {
  App,
  Group,
  User,
}

@doc("The language name, for example Python.")
enum Language {
  Python,
}

@doc("The default principals modification kind")
enum DefaultPrincipalsModificationKind {
  Union,
  Replace,
  None,
}

@doc("Kind of the endpoint for the data connection")
enum DataConnectionKind {
  EventHub,
  EventGrid,
  IotHub,
  CosmosDb,
}

@doc("The principals modification kind of the database")
enum PrincipalsModificationKind {
  Union,
  Replace,
  None,
}

@doc("The data format of the message. Optionally the data format can be added to each message.")
enum EventHubDataFormat {
  MULTIJSON,
  JSON,
  CSV,
  TSV,
  SCSV,
  SOHSV,
  PSV,
  TXT,
  RAW,
  SINGLEJSON,
  AVRO,
  TSVE,
  PARQUET,
  ORC,
  APACHEAVRO,
  W3CLOGFILE,
}

@doc("The compression type")
enum Compression {
  None,
  GZip,
}

@doc("Indication for database routing information from the data connection, by default only database routing information is allowed")
enum DatabaseRouting {
  Single,
  Multi,
}

@doc("The data format of the message. Optionally the data format can be added to each message.")
enum IotHubDataFormat {
  MULTIJSON,
  JSON,
  CSV,
  TSV,
  SCSV,
  SOHSV,
  PSV,
  TXT,
  RAW,
  SINGLEJSON,
  AVRO,
  TSVE,
  PARQUET,
  ORC,
  APACHEAVRO,
  W3CLOGFILE,
}

@doc("The data format of the message. Optionally the data format can be added to each message.")
enum EventGridDataFormat {
  MULTIJSON,
  JSON,
  CSV,
  TSV,
  SCSV,
  SOHSV,
  PSV,
  TXT,
  RAW,
  SINGLEJSON,
  AVRO,
  TSVE,
  PARQUET,
  ORC,
  APACHEAVRO,
  W3CLOGFILE,
}

@doc("The name of blob storage event type to process.")
enum BlobStorageEventType {
  `Microsoft.Storage.BlobCreated`,
  `Microsoft.Storage.BlobRenamed`,
}

@doc("The status of operation.")
enum Status {
  Succeeded,
  Canceled,
  Failed,
  Running,
}

@doc("The type of resource, for instance Microsoft.Kusto/clusters/databases.")
@fixed
enum Type {
  `Microsoft.Kusto/clusters/databases`,
  `Microsoft.Kusto/clusters/attachedDatabaseConfigurations`,
}

@doc("Azure SKU definition.")
model AzureSku {
  @doc("SKU name.")
  name: AzureSkuName;

  @doc("The number of instances of the cluster.")
  capacity?: int32;

  @doc("SKU tier.")
  tier: AzureSkuTier;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of managed identity used. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user-assigned identities. The type 'None' will remove all identities.")
  type: IdentityType;

  @doc("The list of user identities associated with the Kusto cluster. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties>;
}

model ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Class representing the Kusto cluster properties.")
model ClusterProperties {
  @doc("The state of the resource.")
  @visibility("read")
  state?: State;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The cluster URI.")
  @visibility("read")
  uri?: string;

  @doc("The cluster data ingestion URI.")
  @visibility("read")
  dataIngestionUri?: string;

  @doc("The reason for the cluster's current state.")
  @visibility("read")
  stateReason?: string;

  @doc("The cluster's external tenants.")
  trustedExternalTenants?: TrustedExternalTenant[];

  @doc("Optimized auto scale definition.")
  optimizedAutoscale?: OptimizedAutoscale;

  @doc("A boolean value that indicates if the cluster's disks are encrypted.")
  enableDiskEncryption?: boolean;

  @doc("A boolean value that indicates if the streaming ingest is enabled.")
  enableStreamingIngest?: boolean;

  @doc("Virtual network definition.")
  virtualNetworkConfiguration?: VirtualNetworkConfiguration;

  @doc("KeyVault properties for the cluster encryption.")
  keyVaultProperties?: KeyVaultProperties;

  @doc("A boolean value that indicates if the purge operations are enabled.")
  enablePurge?: boolean;

  @doc("List of the cluster's language extensions.")
  languageExtensions?: LanguageExtensionsList;

  @doc("A boolean value that indicates if double encryption is enabled.")
  enableDoubleEncryption?: boolean;

  @doc("Public network access to the cluster is enabled by default. When disabled, only private endpoint connection to the cluster is allowed")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The list of ips in the format of CIDR allowed to connect to the cluster.")
  allowedIpRangeList?: string[];

  @doc("The engine type")
  engineType?: EngineType;

  @doc("The cluster's accepted audiences.")
  acceptedAudiences?: AcceptedAudiences[];

  @doc("A boolean value that indicates if the cluster could be automatically stopped (due to lack of data or no activity for many days).")
  enableAutoStop?: boolean;

  @doc("Whether or not to restrict outbound network access.  Value is optional but if passed in, must be 'Enabled' or 'Disabled'")
  restrictOutboundNetworkAccess?: ClusterNetworkAccessFlag;

  @doc("List of allowed FQDNs(Fully Qualified Domain Name) for egress from Cluster.")
  allowedFqdnList?: string[];

  @doc("Indicates what public IP type to create - IPv4 (default), or DualStack (both IPv4 and IPv6)")
  publicIPType?: PublicIPType;

  @doc("Virtual Cluster graduation properties")
  @visibility("create")
  virtualClusterGraduationProperties?: string;

  @doc("A list of private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Properties of the peer cluster involved in a migration to/from this cluster.")
  @visibility("read")
  migrationCluster?: MigrationClusterProperties;
}

@doc("Represents a tenant ID that is trusted by the cluster.")
model TrustedExternalTenant {
  @doc("GUID representing an external tenant.")
  value?: string;
}

@doc("A class that contains the optimized auto scale definition.")
model OptimizedAutoscale {
  @doc("The version of the template defined, for instance 1.")
  version: int32;

  @doc("A boolean value that indicate if the optimized autoscale feature is enabled or not.")
  isEnabled: boolean;

  @doc("Minimum allowed instances count.")
  minimum: int32;

  @doc("Maximum allowed instances count.")
  maximum: int32;
}

@doc("A class that contains virtual network definition.")
model VirtualNetworkConfiguration {
  @doc("The subnet resource id.")
  @visibility("read", "create")
  subnetId: string;

  @doc("Engine service's public IP address resource id.")
  @visibility("read", "create")
  enginePublicIpId: string;

  @doc("Data management's service public IP address resource id.")
  @visibility("read", "create")
  dataManagementPublicIpId: string;

  @doc("When enabled, the cluster is deployed into the configured subnet, when disabled it will be removed from the subnet.")
  state?: VnetState;
}

@doc("Properties of the key vault.")
model KeyVaultProperties {
  @doc("The name of the key vault key.")
  keyName?: string;

  @doc("The version of the key vault key.")
  keyVersion?: string;

  @doc("The Uri of the key vault.")
  keyVaultUri?: string;

  @doc("The user assigned identity (ARM resource id) that has access to the key.")
  userIdentity?: string;
}

@doc("The list of language extension objects.")
@pagedResult
model LanguageExtensionsList {
  @doc("The list of language extensions.")
  @items
  value?: LanguageExtension[];
}

@doc("The language extension object.")
model LanguageExtension {
  @doc("The language extension name.")
  languageExtensionName?: LanguageExtensionName;

  @doc("The language extension image name.")
  languageExtensionImageName?: LanguageExtensionImageName;

  @doc("The language extension custom image name.")
  languageExtensionCustomImageName?: string;
}

@doc("Represents an accepted audience trusted by the cluster.")
model AcceptedAudiences {
  @doc("GUID or valid URL representing an accepted audience.")
  value?: string;
}

@doc("Properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("Private endpoint which the connection belongs to.")
  @visibility("read")
  privateEndpoint?: PrivateEndpointProperty;

  @doc("Connection State of the Private Endpoint Connection.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionStateProperty;

  @doc("Group id of the private endpoint.")
  @visibility("read")
  groupId?: string;

  @doc("Provisioning state of the private endpoint.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Private endpoint which the connection belongs to.")
model PrivateEndpointProperty {
  @doc("Resource id of the private endpoint.")
  @visibility("read")
  id?: string;
}

@doc("Connection State of the Private Endpoint Connection.")
model PrivateLinkServiceConnectionStateProperty {
  @doc("The private link service connection status.")
  status?: string;

  @doc("The private link service connection description.")
  description?: string;

  @doc("Any action that is required beyond basic workflow (approve/ reject/ disconnect)")
  @visibility("read")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Represents a properties of a cluster that is part of a migration.")
model MigrationClusterProperties {
  @doc("The resource ID of the cluster.")
  @visibility("read")
  id?: string;

  @doc("The public URL of the cluster.")
  @visibility("read")
  uri?: string;

  @doc("The public data ingestion URL of the cluster.")
  @visibility("read")
  dataIngestionUri?: string;

  @doc("The role of the cluster in the migration process.")
  @visibility("read")
  role?: MigrationClusterRole;
}

@doc("Class representing an update to a Kusto cluster.")
model ClusterUpdate extends Resource {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("Resource location.")
  location?: string;

  @doc("The SKU of the cluster.")
  sku?: AzureSku;

  @doc("The availability zones of the cluster.")
  zones?: string[];

  @doc("The identity of the cluster, if configured.")
  identity?: Identity;

  @doc("The cluster properties.")
  properties?: ClusterProperties;
}

@doc("A cluster migrate request.")
model ClusterMigrateRequest {
  @doc("Resource ID of the destination cluster or kusto pool.")
  clusterResourceId: string;
}

@doc("A principal assignment check name availability request.")
model ClusterPrincipalAssignmentCheckNameRequest {
  @doc("Principal Assignment resource name.")
  name: string;

  @doc("The type of resource, Microsoft.Kusto/clusters/principalAssignments.")
  type: "Microsoft.Kusto/clusters/principalAssignments";
}

@doc("The result returned from a check name availability request.")
model CheckNameResult {
  @doc("Specifies a Boolean value that indicates if the name is available.")
  nameAvailable?: boolean;

  @doc("The name that was checked.")
  name?: string;

  @doc("Message indicating an unavailable name due to a conflict, or a description of the naming rules that are violated.")
  message?: string;

  @doc("Message providing the reason why the given name is invalid.")
  reason?: Reason;
}

@doc("A class representing cluster principal property.")
model ClusterPrincipalProperties {
  @doc("The principal ID assigned to the cluster principal. It can be a user email, application ID, or security group name.")
  principalId: string;

  @doc("Cluster principal role.")
  role: ClusterPrincipalRole;

  @doc("The tenant id of the principal")
  tenantId?: string;

  @doc("Principal type.")
  principalType: PrincipalType;

  @doc("The tenant name of the principal")
  @visibility("read")
  tenantName?: string;

  @doc("The principal name")
  @visibility("read")
  principalName?: string;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The service principal object id in AAD (Azure active directory)")
  @visibility("read")
  aadObjectId?: string;
}

@doc("The list Kusto database principals operation response.")
@pagedResult
model FollowerDatabaseListResult {
  @doc("The list of follower database result.")
  @items
  value?: FollowerDatabaseDefinition[];
}

@doc("A class representing follower database request.")
model FollowerDatabaseDefinition {
  @doc("Resource id of the cluster that follows a database owned by this cluster.")
  clusterResourceId: string;

  @doc("Resource name of the attached database configuration in the follower cluster.")
  attachedDatabaseConfigurationName: string;

  @doc("The database name owned by this cluster that was followed. * in case following all databases.")
  @visibility("read")
  databaseName?: string;

  @doc("Table level sharing specifications")
  @visibility("read")
  tableLevelSharingProperties?: TableLevelSharingProperties;

  @doc("The origin of the following setup.")
  @visibility("read")
  databaseShareOrigin?: DatabaseShareOrigin;
}

@doc("Tables that will be included and excluded in the follower database")
model TableLevelSharingProperties {
  @doc("List of tables to include in the follower database")
  tablesToInclude?: string[];

  @doc("List of tables to exclude from the follower database")
  tablesToExclude?: string[];

  @doc("List of external tables to include in the follower database")
  externalTablesToInclude?: string[];

  @doc("List of external tables to exclude from the follower database")
  externalTablesToExclude?: string[];

  @doc("List of materialized views to include in the follower database")
  materializedViewsToInclude?: string[];

  @doc("List of materialized views to exclude from the follower database")
  materializedViewsToExclude?: string[];

  @doc("List of functions to include in the follower database")
  functionsToInclude?: string[];

  @doc("List of functions to exclude from the follower database")
  functionsToExclude?: string[];
}

model DiagnoseVirtualNetworkResult {
  @doc("The list of network connectivity diagnostic finding")
  findings?: string[];
}

@doc("The Kusto SKU description of given resource type")
model SkuDescription {
  @doc("The resource type")
  @visibility("read")
  resourceType?: string;

  @doc("The name of the SKU")
  @visibility("read")
  name?: string;

  @doc("The tier of the SKU")
  @visibility("read")
  tier?: string;

  @doc("The set of locations that the SKU is available")
  @visibility("read")
  locations?: string[];

  @doc("Locations and zones")
  @visibility("read")
  locationInfo?: SkuLocationInfoItem[];

  @doc("The restrictions because of which SKU cannot be used")
  @visibility("read")
  restrictions?: Record<unknown>[];
}

@doc("The locations and zones info for SKU.")
model SkuLocationInfoItem {
  @doc("The available location of the SKU.")
  location: string;

  @doc("The available zone of the SKU.")
  zones?: string[];

  @doc("Gets details of capabilities available to a SKU in specific zones.")
  zoneDetails?: ResourceSkuZoneDetails[];
}

@doc("Describes The zonal capabilities of a SKU.")
model ResourceSkuZoneDetails {
  @doc("The set of zones that the SKU is available in with the specified capabilities.")
  @visibility("read")
  name?: string[];

  @doc("A list of capabilities that are available for the SKU in the specified list of zones.")
  @visibility("read")
  capabilities?: ResourceSkuCapabilities[];
}

@doc("Describes The SKU capabilities object.")
model ResourceSkuCapabilities {
  @doc("An invariant to describe the feature.")
  @visibility("read")
  name?: string;

  @doc("An invariant if the feature is measured by quantity.")
  @visibility("read")
  value?: string;
}

@doc("The result returned from a cluster check name availability request.")
model ClusterCheckNameRequest {
  @doc("Cluster name.")
  name: string;

  @doc("The type of resource, Microsoft.Kusto/clusters.")
  type: "Microsoft.Kusto/clusters";
}

@doc("The result returned from a database check name availability request.")
model CheckNameRequest {
  @doc("Resource name.")
  name: string;

  @doc("The type of resource, for instance Microsoft.Kusto/clusters/databases.")
  type: Type;
}

@doc("The result returned from a AttachedDatabaseConfigurations check name availability request.")
model AttachedDatabaseConfigurationsCheckNameRequest {
  @doc("Attached database resource name.")
  name: string;

  @doc("The type of resource, for instance Microsoft.Kusto/clusters/attachedDatabaseConfigurations.")
  type: "Microsoft.Kusto/clusters/attachedDatabaseConfigurations";
}

@doc("The result returned from a managedPrivateEndpoints check name availability request.")
model ManagedPrivateEndpointsCheckNameRequest {
  @doc("Managed private endpoint resource name.")
  name: string;

  @doc("The type of resource, for instance Microsoft.Kusto/clusters/managedPrivateEndpoints.")
  type: "Microsoft.Kusto/clusters/managedPrivateEndpoints";
}

@doc("List of available SKUs for a Kusto Cluster.")
@pagedResult
model ListResourceSkusResult {
  @doc("The collection of available SKUs for an existing resource.")
  @items
  value?: AzureResourceSku[];
}

@doc("Azure resource SKU definition.")
model AzureResourceSku {
  @doc("Resource Namespace and Type.")
  resourceType?: string;

  @doc("The SKU details.")
  sku?: AzureSku;

  @doc("The number of instances of the cluster.")
  capacity?: AzureCapacity;
}

@doc("Azure capacity definition.")
model AzureCapacity {
  @doc("Scale type.")
  scaleType: AzureScaleType;

  @doc("Minimum allowed capacity.")
  minimum: int32;

  @doc("Maximum allowed capacity.")
  maximum: int32;

  @doc("The default capacity that would be used.")
  default: int32;
}

@doc("The request to invite a follower to a database.")
model DatabaseInviteFollowerRequest {
  @doc("The email of the invited user for which the follower invitation is generated.")
  inviteeEmail: string;

  @doc("Table level sharing specifications")
  tableLevelSharingProperties?: TableLevelSharingProperties;
}

@doc("The result returned from a follower invitation generation request.")
model DatabaseInviteFollowerResult {
  @doc("The generated invitation token.")
  generatedInvitation?: string;
}

@doc("A principal assignment check name availability request.")
model DatabasePrincipalAssignmentCheckNameRequest {
  @doc("Principal Assignment resource name.")
  name: string;

  @doc("The type of resource, Microsoft.Kusto/clusters/databases/principalAssignments.")
  type: "Microsoft.Kusto/clusters/databases/principalAssignments";
}

@doc("A class representing database principal property.")
model DatabasePrincipalProperties {
  @doc("The principal ID assigned to the database principal. It can be a user email, application ID, or security group name.")
  principalId: string;

  @doc("Database principal role.")
  role: DatabasePrincipalRole;

  @doc("The tenant id of the principal")
  tenantId?: string;

  @doc("Principal type.")
  principalType: PrincipalType;

  @doc("The tenant name of the principal")
  @visibility("read")
  tenantName?: string;

  @doc("The principal name")
  @visibility("read")
  principalName?: string;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The service principal object id in AAD (Azure active directory)")
  @visibility("read")
  aadObjectId?: string;
}

@doc("The list Kusto database principals operation response.")
@pagedResult
model DatabasePrincipalListResult {
  @doc("The list of Kusto database principals.")
  @items
  value?: DatabasePrincipal[];
}

@doc("A class representing database principal entity.")
model DatabasePrincipal {
  @doc("Database principal role.")
  role: DatabasePrincipalRole;

  @doc("Database principal name.")
  name: string;

  @doc("Database principal type.")
  type: DatabasePrincipalType;

  @doc("Database principal fully qualified name.")
  fqn?: string;

  @doc("Database principal email if exists.")
  email?: string;

  @doc("Application id - relevant only for application principal type.")
  appId?: string;

  @doc("The tenant name of the principal")
  @visibility("read")
  tenantName?: string;
}

@doc("The list Kusto database principals operation request.")
model DatabasePrincipalListRequest {
  @doc("The list of Kusto database principals.")
  value?: DatabasePrincipal[];
}

@doc("A class representing database script property.")
model ScriptProperties {
  @doc("The url to the KQL script blob file. Must not be used together with scriptContent property")
  scriptUrl?: string;

  @doc("The SaS token that provide read access to the file which contain the script. Must be provided when using scriptUrl property.")
  @visibility("create")
  scriptUrlSasToken?: string;

  @doc("The script content. This property should be used when the script is provide inline and not through file in a SA. Must not be used together with scriptUrl and scriptUrlSasToken properties.")
  @visibility("create")
  scriptContent?: string;

  @doc("A unique string. If changed the script will be applied again.")
  forceUpdateTag?: string;

  @doc("Flag that indicates whether to continue if one of the command fails.")
  continueOnErrors?: boolean;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A class representing the properties of a sandbox custom image object.")
model SandboxCustomImageProperties {
  @doc("The language name, for example Python.")
  language: Language;

  @doc("The version of the language.")
  languageVersion: string;

  @doc("The requirements file content.")
  requirementsFileContent?: string;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The result returned from a sandboxCustomImage check name availability request.")
model SandboxCustomImagesCheckNameRequest {
  @doc("Sandbox custom image resource name.")
  name: string;

  @doc("The type of resource, for instance Microsoft.Kusto/clusters/sandboxCustomImages.")
  type: "Microsoft.Kusto/clusters/sandboxCustomImages";
}

@doc("A class representing the properties of a managed private endpoint object.")
model ManagedPrivateEndpointProperties {
  @doc("The ARM resource ID of the resource for which the managed private endpoint is created.")
  privateLinkResourceId: string;

  @doc("The region of the resource to which the managed private endpoint is created.")
  privateLinkResourceRegion?: string;

  @doc("The groupId in which the managed private endpoint is created.")
  groupId: string;

  @doc("The user request message.")
  requestMessage?: string;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource required zone names.")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("Collection of Outbound Environment Endpoints")
model OutboundNetworkDependenciesEndpointListResult
  is Azure.Core.Page<OutboundNetworkDependenciesEndpoint>;

@doc("Endpoints accessed for a common purpose that the Kusto Service Environment requires outbound network access to.")
model OutboundNetworkDependenciesEndpoint extends ProxyResource {
  @doc("The outbound environment endpoint properties.")
  properties?: OutboundNetworkDependenciesEndpointProperties;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@doc("Endpoints accessed for a common purpose that the Kusto Service Environment requires outbound network access to.")
model OutboundNetworkDependenciesEndpointProperties {
  @doc("The type of service accessed by the Kusto Service Environment, e.g., Azure Storage, Azure SQL Database, and Azure Active Directory.")
  category?: string;

  @doc("The endpoints that the Kusto Service Environment reaches the service at.")
  endpoints?: EndpointDependency[];

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A domain name that a service is reached at, including details of the current connection status.")
model EndpointDependency {
  @doc("The domain name of the dependency.")
  domainName?: string;

  @doc("The ports used when connecting to DomainName.")
  endpointDetails?: EndpointDetail[];
}

@doc("Current TCP connectivity information from the Kusto cluster to a single endpoint.")
model EndpointDetail {
  @doc("The port an endpoint is connected to.")
  port?: int32;

  @doc("The ip address of the endpoint.")
  ipAddress?: string;
}

@doc("Class representing the an attached database configuration properties of kind specific.")
model AttachedDatabaseConfigurationProperties {
  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The name of the database which you would like to attach, use * if you want to follow all current and future databases.")
  databaseName: string;

  @doc("The resource id of the cluster where the databases you would like to attach reside.")
  clusterResourceId: string;

  @doc("The list of databases from the clusterResourceId which are currently attached to the cluster.")
  @visibility("read")
  attachedDatabaseNames?: string[];

  @doc("The default principals modification kind")
  defaultPrincipalsModificationKind: DefaultPrincipalsModificationKind;

  @doc("Table level sharing specifications")
  tableLevelSharingProperties?: TableLevelSharingProperties;

  @doc("Overrides the original database name. Relevant only when attaching to a specific database.")
  databaseNameOverride?: string;

  @doc("Adds a prefix to the attached databases name. When following an entire cluster, that prefix would be added to all of the databases original names from leader cluster.")
  databaseNamePrefix?: string;
}

@doc("Class representing an data connection validation.")
model DataConnectionValidation {
  @doc("The name of the data connection.")
  dataConnectionName?: string;

  @doc("The data connection properties to validate.")
  properties?: DataConnection;
}

@doc("The list Kusto data connection validation result.")
model DataConnectionValidationListResult {
  @doc("The list of Kusto data connection validation errors.")
  value?: DataConnectionValidationResult[];
}

@doc("The result returned from a data connection validation request.")
model DataConnectionValidationResult {
  @doc("A message which indicates a problem in data connection validation.")
  errorMessage?: string;
}

@doc("A data connection check name availability request.")
model DataConnectionCheckNameRequest {
  @doc("Data Connection name.")
  name: string;

  @doc("The type of resource, Microsoft.Kusto/clusters/databases/dataConnections.")
  type: "Microsoft.Kusto/clusters/databases/dataConnections";
}

@doc("A script name availability request.")
model ScriptCheckNameRequest {
  @doc("Script name.")
  name: string;

  @doc("The type of resource, Microsoft.Kusto/clusters/databases/scripts.")
  type: "Microsoft.Kusto/clusters/databases/scripts";
}

@doc("A class that contains database statistics information.")
model DatabaseStatistics {
  @doc("The database size - the total size of compressed data and index in bytes.")
  size?: float32;
}

@doc("Class representing the Kusto database properties.")
model ReadWriteDatabaseProperties {
  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The time the data should be kept before it stops being accessible to queries in TimeSpan.")
  softDeletePeriod?: duration;

  @doc("The time the data should be kept in cache for fast queries in TimeSpan.")
  hotCachePeriod?: duration;

  @doc("The statistics of the database.")
  @visibility("read")
  statistics?: DatabaseStatistics;

  @doc("Indicates whether the database is followed.")
  @visibility("read")
  isFollowed?: boolean;

  @doc("KeyVault properties for the database encryption.")
  keyVaultProperties?: KeyVaultProperties;

  @doc("The database suspension details. If the database is suspended, this object contains information related to the database's suspension state.")
  @visibility("read")
  suspensionDetails?: SuspensionDetails;
}

@doc("The database suspension details. If the database is suspended, this object contains information related to the database's suspension state.")
model SuspensionDetails {
  @doc("The starting date and time of the suspension state.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspensionStartDate?: utcDateTime;
}

@doc("Class representing the Kusto database properties.")
model ReadOnlyFollowingDatabaseProperties {
  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The time the data should be kept before it stops being accessible to queries in TimeSpan.")
  @visibility("read")
  softDeletePeriod?: duration;

  @doc("The time the data should be kept in cache for fast queries in TimeSpan.")
  hotCachePeriod?: duration;

  @doc("The statistics of the database.")
  @visibility("read")
  statistics?: DatabaseStatistics;

  @doc("The name of the leader cluster")
  @visibility("read")
  leaderClusterResourceId?: string;

  @doc("The name of the attached database configuration cluster")
  @visibility("read")
  attachedDatabaseConfigurationName?: string;

  @doc("The principals modification kind of the database")
  @visibility("read")
  principalsModificationKind?: PrincipalsModificationKind;

  @doc("Table level sharing specifications")
  @visibility("read")
  tableLevelSharingProperties?: TableLevelSharingProperties;

  @doc("The original database name, before databaseNameOverride or databaseNamePrefix where applied.")
  @visibility("read")
  originalDatabaseName?: string;

  @doc("The origin of the following setup.")
  @visibility("read")
  databaseShareOrigin?: DatabaseShareOrigin;

  @doc("The database suspension details. If the database is suspended, this object contains information related to the database's suspension state.")
  @visibility("read")
  suspensionDetails?: SuspensionDetails;
}

@doc("Class representing the Kusto event hub connection properties.")
model EventHubConnectionProperties {
  @doc("The resource ID of the event hub to be used to create a data connection.")
  eventHubResourceId: string;

  @doc("The event hub consumer group.")
  consumerGroup: string;

  @doc("The table where the data should be ingested. Optionally the table information can be added to each message.")
  tableName?: string;

  @doc("The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.")
  mappingRuleName?: string;

  @doc("The data format of the message. Optionally the data format can be added to each message.")
  dataFormat?: EventHubDataFormat;

  @doc("System properties of the event hub")
  eventSystemProperties?: string[];

  @doc("The event hub messages compression type")
  compression?: Compression;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub.")
  managedIdentityResourceId?: string;

  @doc("The object ID of the managedIdentityResourceId")
  @visibility("read")
  managedIdentityObjectId?: string;

  @doc("Indication for database routing information from the data connection, by default only database routing information is allowed")
  databaseRouting?: DatabaseRouting;

  @doc("When defined, the data connection retrieves existing Event hub events created since the Retrieval start date. It can only retrieve events retained by the Event hub, based on its retention period.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrievalStartDate?: utcDateTime;
}

@doc("Class representing the Kusto Iot hub connection properties.")
model IotHubConnectionProperties {
  @doc("The resource ID of the Iot hub to be used to create a data connection.")
  iotHubResourceId: string;

  @doc("The iot hub consumer group.")
  consumerGroup: string;

  @doc("The table where the data should be ingested. Optionally the table information can be added to each message.")
  tableName?: string;

  @doc("The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.")
  mappingRuleName?: string;

  @doc("The data format of the message. Optionally the data format can be added to each message.")
  dataFormat?: IotHubDataFormat;

  @doc("System properties of the iot hub")
  eventSystemProperties?: string[];

  @doc("The name of the share access policy")
  sharedAccessPolicyName: string;

  @doc("Indication for database routing information from the data connection, by default only database routing information is allowed")
  databaseRouting?: DatabaseRouting;

  @doc("When defined, the data connection retrieves existing Event hub events created since the Retrieval start date. It can only retrieve events retained by the Event hub, based on its retention period.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrievalStartDate?: utcDateTime;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class representing the Kusto event grid connection properties.")
model EventGridConnectionProperties {
  @doc("The resource ID of the storage account where the data resides.")
  storageAccountResourceId: string;

  @doc("The resource ID of the event grid that is subscribed to the storage account events.")
  eventGridResourceId?: string;

  @doc("The resource ID where the event grid is configured to send events.")
  eventHubResourceId: string;

  @doc("The event hub consumer group.")
  consumerGroup: string;

  @doc("The table where the data should be ingested. Optionally the table information can be added to each message.")
  tableName?: string;

  @doc("The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.")
  mappingRuleName?: string;

  @doc("The data format of the message. Optionally the data format can be added to each message.")
  dataFormat?: EventGridDataFormat;

  @doc("A Boolean value that, if set to true, indicates that ingestion should ignore the first record of every file")
  ignoreFirstRecord?: boolean;

  @doc("The name of blob storage event type to process.")
  blobStorageEventType?: BlobStorageEventType;

  @doc("The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub and storage account.")
  managedIdentityResourceId?: string;

  @doc("The object ID of managedIdentityResourceId")
  @visibility("read")
  managedIdentityObjectId?: string;

  @doc("Indication for database routing information from the data connection, by default only database routing information is allowed")
  databaseRouting?: DatabaseRouting;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class representing the Kusto CosmosDb data connection properties.")
model CosmosDbDataConnectionProperties {
  @doc("The case-sensitive name of the existing target table in your cluster. Retrieved data is ingested into this table.")
  tableName: string;

  @doc("The name of an existing mapping rule to use when ingesting the retrieved data.")
  mappingRuleName?: string;

  @doc("The resource ID of a managed system or user-assigned identity. The identity is used to authenticate with Cosmos DB.")
  managedIdentityResourceId: string;

  @doc("The object ID of the managed identity resource.")
  @visibility("read")
  managedIdentityObjectId?: string;

  @doc("The resource ID of the Cosmos DB account used to create the data connection.")
  cosmosDbAccountResourceId: string;

  @doc("The name of an existing database in the Cosmos DB account.")
  cosmosDbDatabase: string;

  @doc("The name of an existing container in the Cosmos DB database.")
  cosmosDbContainer: string;

  @doc("Optional. If defined, the data connection retrieves Cosmos DB documents created or updated after the specified retrieval start date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrievalStartDate?: utcDateTime;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class representing a read write database.")
model ReadWriteDatabase extends Database {
  @doc("The database properties.")
  properties?: ReadWriteDatabaseProperties;

  @doc("Kind of the database")
  kind: "ReadWrite";
}

@doc("Class representing a read only following database.")
model ReadOnlyFollowingDatabase extends Database {
  @doc("The database properties.")
  properties?: ReadOnlyFollowingDatabaseProperties;

  @doc("Kind of the database")
  kind: "ReadOnlyFollowing";
}

@doc("Class representing an event hub data connection.")
model EventHubDataConnection extends DataConnection {
  @doc("The Event Hub data connection properties to validate.")
  properties?: EventHubConnectionProperties;

  @doc("Kind of the endpoint for the data connection")
  kind: "EventHub";
}

@doc("Class representing an iot hub data connection.")
model IotHubDataConnection extends DataConnection {
  @doc("The Iot Hub data connection properties.")
  properties?: IotHubConnectionProperties;

  @doc("Kind of the endpoint for the data connection")
  kind: "IotHub";
}

@doc("Class representing an Event Grid data connection.")
model EventGridDataConnection extends DataConnection {
  @doc("The properties of the Event Grid data connection.")
  properties?: EventGridConnectionProperties;

  @doc("Kind of the endpoint for the data connection")
  kind: "EventGrid";
}

@doc("Class representing a CosmosDb data connection.")
model CosmosDbDataConnection extends DataConnection {
  @doc("The properties of the CosmosDb data connection.")
  properties?: CosmosDbDataConnectionProperties;

  @doc("Kind of the endpoint for the data connection")
  kind: "CosmosDb";
}

@doc("Operation Result Entity.")
model OperationResult {
  @doc("ID of the resource.")
  @visibility("read")
  id?: string;

  @doc("Name of the resource.")
  @visibility("read")
  name?: string;

  @doc("status of the Operation result.")
  @visibility("read")
  status?: Status;

  @doc("The operation start time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation end time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Percentage completed.")
  @maxValue(100)
  percentComplete?: float32;

  @doc("Properties of the operation results")
  properties?: OperationResultProperties;

  @doc("Object that contains the error code and message if the operation failed.")
  error?: OperationResultErrorProperties;
}

@doc("Operation result properties")
model OperationResultProperties {
  @doc("The kind of the operation.")
  operationKind?: string;

  @doc("The provisioned state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The state of the operation.")
  operationState?: string;
}

@doc("Operation result error properties")
model OperationResultErrorProperties {
  @doc("The code of the error.")
  code?: string;

  @doc("The error message.")
  message?: string;
}
