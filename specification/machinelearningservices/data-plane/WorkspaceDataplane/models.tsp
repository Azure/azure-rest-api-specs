import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.MachineLearningServices.WorkspaceDataplane;

/** Encryption status. */
union EncryptionStatus {
  string,

  /** Encryption is enabled. */
  Enabled: "Enabled",

  /** Encryption is disabled. */
  Disabled: "Disabled",
}

/** Connection status of the service consumer with the service provider. */
union EndpointServiceConnectionStatus {
  string,

  /** Connection approved. */
  Approved: "Approved",

  /** Connection pending. */
  Pending: "Pending",

  /** Connection rejected. */
  Rejected: "Rejected",

  /** Connection disconnected. */
  Disconnected: "Disconnected",

  /** Connection timeout. */
  Timeout: "Timeout",
}

/** Provisioning state of the workspace. */
union ProvisioningState {
  string,

  /** Unknown state. */
  Unknown: "Unknown",

  /** Updating. */
  Updating: "Updating",

  /** Creating. */
  Creating: "Creating",

  /** Deleting. */
  Deleting: "Deleting",

  /** Succeeded. */
  Succeeded: "Succeeded",

  /** Failed. */
  Failed: "Failed",

  /** Canceled. */
  Canceled: "Canceled",
}

/** Whether requests from Public Network are allowed. */
union PublicNetworkAccessType {
  string,

  /** Public network access enabled. */
  Enabled: "Enabled",

  /** Public network access disabled. */
  Disabled: "Disabled",
}

/** Compute runtime configuration. */
model ComputeRuntimeDto {
  /** Spark runtime version. */
  sparkRuntimeVersion?: string;
}

/** CosmosDB settings. */
model CosmosDbSettings {
  /** Collections throughput. */
  collectionsThroughput?: int32;
}

/** Encryption configuration. */
model EncryptionProperty {
  /** The byok cosmosdb account that customer brings to store customer's data with encryption. */
  cosmosDbResourceId?: string;

  /** Identity to be used with the keyVault. */
  identity?: IdentityForCmk;

  /** KeyVault details to do the encryption. */
  keyVaultProperties: KeyVaultProperties;

  /** The byok search account that customer brings to store customer's data with encryption. */
  searchAccountResourceId?: string;

  /** Encryption status. */
  status: EncryptionStatus;

  /** The byok storage account that customer brings to store customer's data with encryption. */
  storageAccountResourceId?: string;
}

/** Feature store settings. */
model FeatureStoreSettings {
  /** Compute runtime configuration. */
  computeRuntime?: ComputeRuntimeDto;

  /** Offline store connection name. */
  offlineStoreConnectionName?: string;

  /** Online store connection name. */
  onlineStoreConnectionName?: string;
}

/** Identity for customer managed key. */
model IdentityForCmk {
  /** UserAssignedIdentity to be used to fetch the encryption key from keyVault. */
  userAssignedIdentity?: string;
}

/** Key vault properties. */
model KeyVaultProperties {
  /** Currently, we support only SystemAssigned MSI. We need this when we support UserAssignedIdentities. */
  identityClientId?: string;

  /** KeyVault key identifier to encrypt the data. */
  @minLength(1)
  keyIdentifier: string;

  /** KeyVault Arm Id that contains the data encryption key. */
  @minLength(1)
  keyVaultArmId: string;
}

/** Managed service identity. */
model ManagedServiceIdentity {
  /** The service principal ID of the system assigned identity. */
  principalId?: string;

  /** The tenant ID of the system assigned identity. */
  tenantId?: string;

  /** Type of managed service identity. */
  type?: string;

  /** The set of user assigned identities associated with the resource. */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/** User assigned identity properties. */
model UserAssignedIdentity {
  /** The client ID of the assigned identity. */
  clientId?: string;

  /** The principal ID of the assigned identity. */
  principalId?: string;
}

/** Notebook preparation error. */
model NotebookPreparationError {
  /** Error message. */
  errorMessage?: string;

  /** Status code. */
  statusCode?: int32;
}

/** Notebook resource information. */
model NotebookResourceInfo {
  /** FQDN. */
  fqdn?: string;

  /** Whether private link is enabled. */
  isPrivateLinkEnabled?: boolean;

  /** The error that occurs when preparing notebook. */
  notebookPreparationError?: NotebookPreparationError;

  /** The data plane resourceId that used to initialize notebook component. */
  resourceId?: string;
}

/** Private endpoint connection. */
model PrivateEndpointConnection {
  /** Fully qualified resource ID for the resource. */
  id?: string;

  /** The name of the resource. */
  name?: string;

  /** The type of the resource. */
  type?: string;

  /** Managed service identity. */
  identity?: ManagedServiceIdentity;

  /** Same as workspace location. */
  location?: string;

  /** Private endpoint. */
  privateEndpoint?: WorkspacePrivateEndpointResource;

  /** The connection state. */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /** Provisioning state. */
  provisioningState?: EndpointServiceConnectionStatus;

  /** Optional SKU. */
  sku?: Sku;

  /** Resource tags. */
  tags?: Record<string>;
}

/** Private link service connection state. */
model PrivateLinkServiceConnectionState {
  /** Some RP chose "None". Other RPs use this for region expansion. */
  actionsRequired?: string;

  /** User-defined message that, per NRP doc, may be used for approval-related message. */
  description?: string;

  /** Connection status. */
  status?: EndpointServiceConnectionStatus;
}

/** Service managed resources settings. */
model ServiceManagedResourcesSettings {
  /** CosmosDB settings. */
  cosmosDb?: CosmosDbSettings;
}

/** Shared private link resource. */
model SharedPrivateLinkResource {
  /** Unique name of the private link. */
  name?: string;

  /** Group id of the private link. */
  groupId?: string;

  /** The resource id that private link links to. */
  privateLinkResourceId?: string;

  /** Request message. */
  requestMessage?: string;

  /** Connection status. */
  status?: EndpointServiceConnectionStatus;
}

/** SKU definition. */
model Sku {
  /** The SKU name. */
  name?: string;

  /** The SKU tier. */
  tier?: string;

  /** The SKU size. */
  size?: string;

  /** The SKU family. */
  family?: string;

  /** The SKU capacity. */
  capacity?: int32;
}

/** Workspace hub configuration. */
model WorkspaceHubConfig {
  /** Additional workspace storage accounts. */
  additionalWorkspaceStorageAccounts?: string[];

  /** Default workspace resource group. */
  defaultWorkspaceResourceGroup?: string;
}

/** Private endpoint resource. */
model WorkspacePrivateEndpointResource {
  /** The resource ID of the private endpoint. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The subnetId that the private endpoint is connected to. */
  @visibility(Lifecycle.Read)
  subnetArmId?: string;
}

/** The properties of a machine learning workspace. */
model WorkspaceProperties {
  /** The flag to indicate whether to allow public access when behind VNet. */
  allowPublicAccessWhenBehindVnet?: boolean;

  /** ARM id of the application insights associated with this workspace. */
  applicationInsights?: string;

  /** Associated workspaces. */
  associatedWorkspaces?: string[];

  /** Container registries. */
  containerRegistries?: string[];

  /** ARM id of the container registry associated with this workspace. */
  containerRegistry?: string;

  /** The description of this workspace. */
  description?: string;

  /** Url for the discovery service to identify regional endpoints for machine learning experimentation services. */
  discoveryUrl?: string;

  /** Whether data isolation is enabled. */
  enableDataIsolation?: boolean;

  /** Encryption configuration. */
  encryption?: EncryptionProperty;

  /** Existing workspaces. */
  existingWorkspaces?: string[];

  /** Settings for feature store type workspace. */
  featureStoreSettings?: FeatureStoreSettings;

  /** The friendly name for this workspace. This name in mutable. */
  friendlyName?: string;

  /** The flag to signal HBI data in the workspace and reduce diagnostic data collected by the service. */
  hbiWorkspace?: boolean;

  /** Hub resource ID. */
  hubResourceId?: string;

  /** The compute name for image build. */
  imageBuildCompute?: string;

  /** ARM id of the key vault associated with this workspace. */
  keyVault?: string;

  /** Key vaults. */
  keyVaults?: string[];

  /** Managed network configuration. */
  managedNetwork?: Record<string>;

  /** The URI associated with this workspace that machine learning flow must point at to set up tracking. */
  @visibility(Lifecycle.Read)
  mlFlowTrackingUri?: string;

  /** The notebook info of Azure ML workspace. */
  @visibility(Lifecycle.Read)
  notebookInfo?: NotebookResourceInfo;

  /** The user assigned identity resource id that represents the workspace identity. */
  primaryUserAssignedIdentity?: string;

  /** The list of private endpoint connections in the workspace. */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /** Count of private connections in the workspace. */
  @visibility(Lifecycle.Read)
  privateLinkCount?: int32;

  /** The current deployment state of workspace resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Whether requests from Public Network are allowed. */
  publicNetworkAccess?: PublicNetworkAccessType;

  /** The service managed resource settings. */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /** The name of the managed resource group created by workspace RP in customer subscription if the workspace is CMK workspace. */
  @visibility(Lifecycle.Read)
  serviceProvisionedResourceGroup?: string;

  /** The list of shared private link resources in this workspace. */
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /** Retention time in days after workspace get soft deleted. */
  softDeleteRetentionInDays?: int32;

  /** ARM id of the storage account associated with this workspace. */
  storageAccount?: string;

  /** Storage accounts. */
  storageAccounts?: string[];

  /** If the storage associated with the workspace has hierarchical namespace(HNS) enabled. */
  @visibility(Lifecycle.Read)
  storageHnsEnabled?: boolean;

  /** The auth mode used for accessing the system datastores of the workspace. */
  systemDatastoresAuthMode?: string;

  /** The tenant id associated with this workspace. */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /** Enabling v1_legacy_mode may prevent you from using features provided by the v2 API. */
  v1LegacyMode?: boolean;

  /** Workspace hub configuration. */
  workspaceHubConfig?: WorkspaceHubConfig;

  /** The immutable id associated with this workspace. */
  @visibility(Lifecycle.Read)
  workspaceId?: string;
}

/** Machine learning workspace. */
model Workspace {
  /** Fully qualified resource ID for the resource. */
  id?: string;

  /** The name of the resource. */
  name?: string;

  /** The type of the resource. */
  type?: string;

  /** Managed service identity. */
  identity?: ManagedServiceIdentity;

  /** The workspace kind. */
  kind?: string;

  /** The workspace location. */
  location?: string;

  /** Additional attributes of the entity. */
  properties: WorkspaceProperties;

  /** Optional SKU. */
  sku?: Sku;

  /** Resource tags. */
  tags?: Record<string>;
}
