import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MachineLearningServices;

/**
 * The current deployment state of workspace resource. The provisioningState is to indicate states for resource provisioning.
 */
union ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Indicates whether or not the encryption is enabled for the workspace.
 */
union EncryptionStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * create a workspace with soft delete capability
 */
union SoftDeleteEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * Allow a soft deleted workspace to be recovered
 */
union AllowRecoverSoftDeletedWorkspace {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * Whether requests from Public Network are allowed.
 */
union PublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Timeout
   */
  Timeout: "Timeout",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Level of workspace setup error
 */
union DiagnoseResultLevel {
  string,

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Information
   */
  Information: "Information",
}

/**
 * An enum describing the unit of usage measurement.
 */
union UsageUnit {
  string,

  /**
   * Count
   */
  Count: "Count",
}

/**
 * Three lettered code specifying the currency of the VM price. Example: USD
 */
union BillingCurrency {
  string,

  /**
   * USD
   */
  USD: "USD",
}

/**
 * The unit of time measurement for the specified VM price. Example: OneHour
 */
union UnitOfMeasure {
  string,

  /**
   * OneHour
   */
  OneHour: "OneHour",
}

/**
 * Operating system type used by the VM.
 */
union VMPriceOSType {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * The type of the VM.
 */
union VMTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * LowPriority
   */
  LowPriority: "LowPriority",

  /**
   * Spot
   */
  Spot: "Spot",
}

/**
 * An enum describing the unit of quota measurement.
 */
union QuotaUnit {
  string,

  /**
   * Count
   */
  Count: "Count",
}

/**
 * Status of update workspace quota.
 */
union Status {
  string,

  /**
   * Undefined
   */
  Undefined: "Undefined",

  /**
   * Success
   */
  Success: "Success",

  /**
   * Failure
   */
  Failure: "Failure",

  /**
   * InvalidQuotaBelowClusterMinimum
   */
  InvalidQuotaBelowClusterMinimum: "InvalidQuotaBelowClusterMinimum",

  /**
   * InvalidQuotaExceedsSubscriptionLimit
   */
  InvalidQuotaExceedsSubscriptionLimit: "InvalidQuotaExceedsSubscriptionLimit",

  /**
   * InvalidVMFamilyName
   */
  InvalidVMFamilyName: "InvalidVMFamilyName",

  /**
   * OperationNotSupportedForSku
   */
  OperationNotSupportedForSku: "OperationNotSupportedForSku",

  /**
   * OperationNotEnabledForRegion
   */
  OperationNotEnabledForRegion: "OperationNotEnabledForRegion",
}

/**
 * The type of compute
 */
union ComputeType {
  string,

  /**
   * AKS
   */
  AKS: "AKS",

  /**
   * Kubernetes
   */
  Kubernetes: "Kubernetes",

  /**
   * AmlCompute
   */
  AmlCompute: "AmlCompute",

  /**
   * ComputeInstance
   */
  ComputeInstance: "ComputeInstance",

  /**
   * DataFactory
   */
  DataFactory: "DataFactory",

  /**
   * VirtualMachine
   */
  VirtualMachine: "VirtualMachine",

  /**
   * HDInsight
   */
  HDInsight: "HDInsight",

  /**
   * Databricks
   */
  Databricks: "Databricks",

  /**
   * DataLakeAnalytics
   */
  DataLakeAnalytics: "DataLakeAnalytics",

  /**
   * SynapseSpark
   */
  SynapseSpark: "SynapseSpark",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union UnderlyingResourceAction {
  string,

  /**
   * Delete
   */
  Delete: "Delete",

  /**
   * Detach
   */
  Detach: "Detach",
}

/**
 * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
 */
union NodeState {
  string,

  /**
   * idle
   */
  idle: "idle",

  /**
   * running
   */
  running: "running",

  /**
   * preparing
   */
  preparing: "preparing",

  /**
   * unusable
   */
  unusable: "unusable",

  /**
   * leaving
   */
  leaving: "leaving",

  /**
   * preempted
   */
  preempted: "preempted",
}

/**
 * format for the workspace connection value
 */
union ValueFormat {
  string,

  /**
   * JSON
   */
  JSON: "JSON",
}

/**
 * The reason for the restriction.
 */
union ReasonCode {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * NotAvailableForRegion
   */
  NotAvailableForRegion: "NotAvailableForRegion",

  /**
   * NotAvailableForSubscription
   */
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * Intended usage of the cluster
 */
union ClusterPurpose {
  string,

  /**
   * FastProd
   */
  FastProd: "FastProd",

  /**
   * DenseProd
   */
  DenseProd: "DenseProd",

  /**
   * DevTest
   */
  DevTest: "DevTest",
}

/**
 * Enable or disable ssl for scoring
 */
union SslConfigurationStatus {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Auto
   */
  Auto: "Auto",
}

/**
 * Load Balancer Type
 */
union LoadBalancerType {
  string,

  /**
   * PublicIp
   */
  PublicIp: "PublicIp",

  /**
   * InternalLoadBalancer
   */
  InternalLoadBalancer: "InternalLoadBalancer",
}

/**
 * Compute OS Type
 */
union OsType {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * Virtual Machine priority
 */
union VmPriority {
  string,

  /**
   * Dedicated
   */
  Dedicated: "Dedicated",

  /**
   * LowPriority
   */
  LowPriority: "LowPriority",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
 */
union RemoteLoginPortPublicAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",
}

/**
 * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
 */
union AllocationState {
  string,

  /**
   * Steady
   */
  Steady: "Steady",

  /**
   * Resizing
   */
  Resizing: "Resizing",
}

/**
 * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
 */
union ApplicationSharingPolicy {
  string,

  /**
   * Personal
   */
  Personal: "Personal",

  /**
   * Shared
   */
  Shared: "Shared",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
 */
union SshPublicAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Current state of an ComputeInstance.
 */
union ComputeInstanceState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Restarting
   */
  Restarting: "Restarting",

  /**
   * JobRunning
   */
  JobRunning: "JobRunning",

  /**
   * SettingUp
   */
  SettingUp: "SettingUp",

  /**
   * SetupFailed
   */
  SetupFailed: "SetupFailed",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * UserSettingUp
   */
  UserSettingUp: "UserSettingUp",

  /**
   * UserSetupFailed
   */
  UserSetupFailed: "UserSetupFailed",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Unusable
   */
  Unusable: "Unusable",
}

/**
 * The Compute Instance Authorization type. Available values are personal (default).
 */
union ComputeInstanceAuthorizationType {
  string,

  /**
   * personal
   */
  personal: "personal",
}

/**
 * Name of the last operation.
 */
union OperationName {
  string,

  /**
   * Create
   */
  Create: "Create",

  /**
   * Start
   */
  Start: "Start",

  /**
   * Stop
   */
  Stop: "Stop",

  /**
   * Restart
   */
  Restart: "Restart",

  /**
   * Reimage
   */
  Reimage: "Reimage",

  /**
   * Delete
   */
  Delete: "Delete",
}

/**
 * Operation status.
 */
union OperationStatus {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * CreateFailed
   */
  CreateFailed: "CreateFailed",

  /**
   * StartFailed
   */
  StartFailed: "StartFailed",

  /**
   * StopFailed
   */
  StopFailed: "StopFailed",

  /**
   * RestartFailed
   */
  RestartFailed: "RestartFailed",

  /**
   * ReimageFailed
   */
  ReimageFailed: "ReimageFailed",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * SystemAssigned,UserAssigned
   */
  `SystemAssigned,UserAssigned`,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * None
   */
  None,
}

/**
 * Azure Machine Learning workspace REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display name of operation
   */
  display?: OperationDisplay;
}

/**
 * Display name of operation
 */
model OperationDisplay {
  /**
   * The resource provider name: Microsoft.MachineLearningExperimentation
   */
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  resource?: string;

  /**
   * The operation that users can perform.
   */
  operation?: string;

  /**
   * The description for the operation.
   */
  description?: string;
}

/**
 * The properties of a machine learning workspace.
 */
model WorkspaceProperties {
  /**
   * The immutable id associated with this workspace.
   */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * The description of this workspace.
   */
  description?: string;

  /**
   * The friendly name for this workspace. This name in mutable
   */
  friendlyName?: string;

  /**
   * ARM id of the key vault associated with this workspace. This cannot be changed once the workspace has been created
   */
  keyVault?: string;

  /**
   * ARM id of the application insights associated with this workspace. This cannot be changed once the workspace has been created
   */
  applicationInsights?: string;

  /**
   * ARM id of the container registry associated with this workspace. This cannot be changed once the workspace has been created
   */
  containerRegistry?: string;

  /**
   * ARM id of the storage account associated with this workspace. This cannot be changed once the workspace has been created
   */
  storageAccount?: string;

  /**
   * Url for the discovery service to identify regional endpoints for machine learning experimentation services
   */
  discoveryUrl?: string;

  /**
   * The current deployment state of workspace resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The encryption settings of Azure ML workspace.
   */
  encryption?: EncryptionProperty;

  /**
   * The flag to signal HBI data in the workspace and reduce diagnostic data collected by the service
   */
  hbiWorkspace?: boolean;

  /**
   * create a workspace with soft delete capability
   */
  softDeleteEnabled?: SoftDeleteEnabled;

  /**
   * Allow a soft deleted workspace to be recovered
   */
  allowRecoverSoftDeletedWorkspace?: AllowRecoverSoftDeletedWorkspace;

  /**
   * The name of the managed resource group created by workspace RP in customer subscription if the workspace is CMK workspace
   */
  @visibility(Lifecycle.Read)
  serviceProvisionedResourceGroup?: string;

  /**
   * Count of private connections in the workspace
   */
  @visibility(Lifecycle.Read)
  privateLinkCount?: int32;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The flag to indicate whether to allow public access when behind VNet.
   */
  allowPublicAccessWhenBehindVnet?: boolean;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The list of private endpoint connections in the workspace.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The list of shared private link resources in this workspace.
   */
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /**
   * The notebook info of Azure ML workspace.
   */
  @visibility(Lifecycle.Read)
  notebookInfo?: NotebookResourceInfo;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * The tenant id associated with this workspace.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * If the storage associated with the workspace has hierarchical namespace(HNS) enabled.
   */
  @visibility(Lifecycle.Read)
  storageHnsEnabled?: boolean;

  /**
   * The URI associated with this workspace that machine learning flow must point at to set up tracking.
   */
  @visibility(Lifecycle.Read)
  mlFlowTrackingUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EncryptionProperty {
  /**
   * Indicates whether or not the encryption is enabled for the workspace.
   */
  status: EncryptionStatus;

  /**
   * The identity that will be used to access the key vault for encryption at rest.
   */
  identity?: IdentityForCmk;

  /**
   * Customer Key vault properties.
   */
  keyVaultProperties: KeyVaultProperties;

  /**
   * The Bring-Your-Own cosmosdb account that customer brings to store data
   */
  cosmosDbResourceId?: string;

  /**
   * The Bring-Your-Own storage account that customer brings to store data
   */
  storageAccountResourceId?: string;

  /**
   * The Bring-Your-Own search account that customer brings to store index
   */
  searchAccountResourceId?: string;
}

/**
 * Identity that will be used to access key vault for encryption at rest
 */
model IdentityForCmk {
  /**
   * The ArmId of the user assigned identity that will be used to access the customer managed key vault
   */
  userAssignedIdentity?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KeyVaultProperties {
  /**
   * The ArmId of the keyVault where the customer owned encryption key is present.
   */
  keyVaultArmId: string;

  /**
   * Key vault uri to access the encryption key.
   */
  keyIdentifier: string;

  /**
   * For future use - The client id of the identity which will be used to access key vault.
   */
  identityClientId?: string;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The ARM identifier for Subnet resource that private endpoint links to
   */
  @visibility(Lifecycle.Read)
  subnetArmId?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The user assigned identities associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User Assigned Identity
 */
model UserAssignedIdentity {
  /**
   * The principal ID of the user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of the user assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The clientId(aka appId) of the user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Sku of the resource
 */
model Sku {
  /**
   * Name of the sku
   */
  name?: string;

  /**
   * Tier of the sku like Basic or Enterprise
   */
  tier?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SharedPrivateLinkResource {
  /**
   * Unique name of the private link.
   */
  name?: string;

  /**
   * Resource properties.
   */
  properties?: SharedPrivateLinkResourceProperty;
}

/**
 * Properties of a shared private link resource.
 */
model SharedPrivateLinkResourceProperty {
  /**
   * The resource id that private link links to.
   */
  privateLinkResourceId?: string;

  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * Request message.
   */
  requestMessage?: string;

  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotebookResourceInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  fqdn?: string;

  /**
   * the data plane resourceId that used to initialize notebook component
   */
  resourceId?: string;

  /**
   * The error that occurs when preparing notebook.
   */
  notebookPreparationError?: NotebookPreparationError;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotebookPreparationError {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  errorMessage?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  statusCode?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ServiceManagedResourcesSettings {
  /**
   * The settings for the service managed cosmosdb account.
   */
  cosmosDb?: CosmosDbSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CosmosDbSettings {
  /**
   * The throughput of the collections in cosmosdb database
   */
  collectionsThroughput?: int32;
}

/**
 * The parameters for updating a machine learning workspace.
 */
model WorkspaceUpdateParameters {
  /**
   * The resource tags for the machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The sku of the workspace.
   */
  sku?: Sku;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * The properties that the machine learning workspace will be updated with.
   */
  properties?: WorkspacePropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a machine learning workspace.
 */
model WorkspacePropertiesUpdateParameters {
  /**
   * The description of this workspace.
   */
  description?: string;

  /**
   * The friendly name for this workspace.
   */
  friendlyName?: string;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Parameters to diagnose a workspace
 */
model DiagnoseWorkspaceParameters {
  /**
   * Value of Parameters
   */
  value?: DiagnoseRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseRequestProperties {
  /**
   * Setting for diagnosing user defined routing
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  udr?: Record<unknown>;

  /**
   * Setting for diagnosing network security group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nsg?: Record<unknown>;

  /**
   * Setting for diagnosing resource lock
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  resourceLock?: Record<unknown>;

  /**
   * Setting for diagnosing dns resolution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  dnsResolution?: Record<unknown>;

  /**
   * Setting for diagnosing dependent storage account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  storageAccount?: Record<unknown>;

  /**
   * Setting for diagnosing dependent key vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  keyVault?: Record<unknown>;

  /**
   * Setting for diagnosing dependent container registry
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  containerRegistry?: Record<unknown>;

  /**
   * Setting for diagnosing dependent application insights
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  applicationInsights?: Record<unknown>;

  /**
   * Setting for diagnosing unclassified category of problems
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  others?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseResponseResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: DiagnoseResponseResultValue;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiagnoseResponseResultValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  userDefinedRouteResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  networkSecurityRuleResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceLockResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  dnsResolutionResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  storageAccountResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  keyVaultResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  containerRegistryResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  applicationInsightsResults?: DiagnoseResult[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  otherResults?: DiagnoseResult[];
}

/**
 * Result of Diagnose
 */
model DiagnoseResult {
  /**
   * Code for workspace setup error
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Level of workspace setup error
   */
  @visibility(Lifecycle.Read)
  level?: DiagnoseResultLevel;

  /**
   * Message of workspace setup error
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListWorkspaceKeysResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  userStorageKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  userStorageResourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  appInsightsInstrumentationKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  containerRegistryCredentials?: RegistryListCredentialsResult;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  notebookAccessKeys?: ListNotebookKeysResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RegistryListCredentialsResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  username?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  passwords?: Password[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Password {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListNotebookKeysResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  primaryAccessKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  secondaryAccessKey?: string;
}

/**
 * The List Usages operation response.
 */
model ListUsagesResult is Azure.Core.Page<Usage>;

/**
 * Describes AML Resource Usage.
 */
model Usage {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility(Lifecycle.Read)
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * An enum describing the unit of usage measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: UsageUnit;

  /**
   * The current usage of the resource.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int64;

  /**
   * The maximum permitted usage of the resource.
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * The name of the type of usage.
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * The List Virtual Machine size operation response.
 */
model VirtualMachineSizeListResult {
  /**
   * The list of virtual machine sizes supported by AmlCompute.
   */
  value?: VirtualMachineSize[];
}

/**
 * Describes the properties of a VM size.
 */
model VirtualMachineSize {
  /**
   * The name of the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The family name of the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * The number of vCPUs supported by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  vCPUs?: int32;

  /**
   * The number of gPUs supported by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  gpus?: int32;

  /**
   * The OS VHD disk size, in MB, allowed by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  osVhdSizeMB?: int32;

  /**
   * The resource volume size, in MB, allowed by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  maxResourceVolumeMB?: int32;

  /**
   * The amount of memory, in GB, supported by the virtual machine size.
   */
  @visibility(Lifecycle.Read)
  memoryGB?: float64;

  /**
   * Specifies if the virtual machine size supports low priority VMs.
   */
  @visibility(Lifecycle.Read)
  lowPriorityCapable?: boolean;

  /**
   * Specifies if the virtual machine size supports premium IO.
   */
  @visibility(Lifecycle.Read)
  premiumIO?: boolean;

  /**
   * The estimated price information for using a VM.
   */
  estimatedVMPrices?: EstimatedVMPrices;

  /**
   * Specifies the compute types supported by the virtual machine size.
   */
  supportedComputeTypes?: string[];
}

/**
 * The estimated price info for using a VM.
 */
model EstimatedVMPrices {
  /**
   * Three lettered code specifying the currency of the VM price. Example: USD
   */
  billingCurrency: BillingCurrency;

  /**
   * The unit of time measurement for the specified VM price. Example: OneHour
   */
  unitOfMeasure: UnitOfMeasure;

  /**
   * The list of estimated prices for using a VM of a particular OS type, tier, etc.
   */
  values: EstimatedVMPrice[];
}

/**
 * The estimated price info for using a VM of a particular OS type, tier, etc.
 */
model EstimatedVMPrice {
  /**
   * The price charged for using the VM.
   */
  retailPrice: float64;

  /**
   * Operating system type used by the VM.
   */
  osType: VMPriceOSType;

  /**
   * The type of the VM.
   */
  vmTier: VMTier;
}

/**
 * Quota update parameters.
 */
model QuotaUpdateParameters {
  /**
   * The list for update quota.
   */
  value?: QuotaBaseProperties[];

  /**
   * Region of workspace quota to be updated.
   */
  location?: string;
}

/**
 * The properties for Quota update or retrieval.
 */
model QuotaBaseProperties {
  /**
   * Specifies the resource ID.
   */
  id?: string;

  /**
   * Specifies the resource type.
   */
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  unit?: QuotaUnit;
}

/**
 * The result of update workspace quota.
 */
model UpdateWorkspaceQuotasResult is Azure.Core.Page<UpdateWorkspaceQuotas>;

/**
 * The properties for update Quota response.
 */
model UpdateWorkspaceQuotas {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: QuotaUnit;

  /**
   * Status of update workspace quota.
   */
  status?: Status;
}

/**
 * The List WorkspaceQuotasByVMFamily operation response.
 */
model ListWorkspaceQuotas is Azure.Core.Page<ResourceQuota>;

/**
 * The quota assigned to a resource.
 */
model ResourceQuota {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility(Lifecycle.Read)
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: ResourceName;

  /**
   * The maximum permitted quota of the resource.
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: QuotaUnit;
}

/**
 * The Resource Name.
 */
model ResourceName {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * Paginated list of Machine Learning compute objects wrapped in ARM resource envelope.
 */
model PaginatedComputeResourcesList is Azure.Core.Page<ComputeResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Components1D3SwueSchemasComputeresourceAllof1 {
  /**
   * Compute properties
   */
  properties?: Compute;
}

/**
 * Machine Learning compute object.
 */
@discriminator("computeType")
model Compute {
  /**
   * The type of compute
   */
  computeType: ComputeType;

  /**
   * Location for the underlying compute
   */
  computeLocation?: string;

  /**
   * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The description of the Machine Learning compute.
   */
  description?: string;

  /**
   * The time at which the compute was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the compute was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * ARM resource id of the underlying compute
   */
  resourceId?: string;

  /**
   * Errors during provisioning
   */
  @visibility(Lifecycle.Read)
  provisioningErrors?: ErrorResponse[];

  /**
   * Indicating whether the compute was provisioned by user and brought from outside if true, or machine learning service provisioned it if false.
   */
  @visibility(Lifecycle.Read)
  isAttachedCompute?: boolean;

  /**
   * Opt-out of local authentication and ensure customers can use only MSI and AAD exclusively for authentication.
   */
  disableLocalAuth?: boolean;
}

/**
 * AmlCompute update parameters.
 */
model ClusterUpdateParameters {
  /**
   * The properties of the amlCompute.
   */
  properties?: ClusterUpdateProperties;
}

/**
 * The properties of a amlCompute that need to be updated.
 */
model ClusterUpdateProperties {
  /**
   * Properties of ClusterUpdate
   */
  properties?: ScaleSettingsInformation;
}

/**
 * Desired scale settings for the amlCompute.
 */
model ScaleSettingsInformation {
  /**
   * scale settings for AML Compute
   */
  scaleSettings?: ScaleSettings;
}

/**
 * scale settings for AML Compute
 */
model ScaleSettings {
  /**
   * Max number of nodes to use
   */
  maxNodeCount: int32;

  /**
   * Min number of nodes to use
   */
  minNodeCount?: int32;

  /**
   * Node Idle Time before scaling down amlCompute. This string needs to be in the RFC Format.
   */
  nodeIdleTimeBeforeScaleDown?: duration;
}

/**
 * Result of AmlCompute Nodes
 */
model AmlComputeNodesInformation {
  /**
   * The collection of returned AmlCompute nodes details.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  nodes?: AmlComputeNodeInformation[];

  /**
   * The continuation token.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Compute node information related to a AmlCompute.
 */
model AmlComputeNodeInformation {
  /**
   * ID of the compute node.
   */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /**
   * Private IP address of the compute node.
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * Public IP address of the compute node.
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * SSH port number of the node.
   */
  @visibility(Lifecycle.Read)
  port?: int32;

  /**
   * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
   */
  @visibility(Lifecycle.Read)
  nodeState?: NodeState;

  /**
   * ID of the Experiment running on the node, if any else null.
   */
  @visibility(Lifecycle.Read)
  runId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotebookAccessTokenResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  notebookResourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  hostName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  publicDns?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  accessToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  tokenType?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  expiresIn?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  refreshToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  scope?: string;
}

/**
 * Secrets related to a Machine Learning compute. Might differ for every type of compute.
 */
@discriminator("computeType")
model ComputeSecrets {
  /**
   * The type of compute
   */
  computeType: ComputeType;
}

/**
 * List of private endpoint connection associated with the specified workspace
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @pageItems
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * Specifies the location of the resource.
   */
  location?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The sku of the workspace.
   */
  sku?: Sku;

  /**
   * System data
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListStorageAccountKeysResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  userStorageKey?: string;
}

/**
 * Paginated list of Workspace connection objects.
 */
model PaginatedWorkspaceConnectionsList is Azure.Core.Page<WorkspaceConnection>;

/**
 * Workspace Connection specific properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceConnectionProps {
  /**
   * Category of the workspace connection.
   */
  category?: string;

  /**
   * Target of the workspace connection.
   */
  target?: string;

  /**
   * Authorization type of the workspace connection.
   */
  authType?: string;

  /**
   * Value details of the workspace connection.
   */
  value?: string;

  /**
   * format for the workspace connection value
   */
  valueFormat?: ValueFormat;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ExternalFqdnResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @pageItems
  value?: FqdnEndpoints[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpoints {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: FqdnEndpointsProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpointsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  category?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  endpoints?: FqdnEndpoint[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  domainName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  endpointDetails?: FqdnEndpointDetail[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FqdnEndpointDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  port?: int32;
}

/**
 * The List Aml user feature operation response.
 */
model ListAmlUserFeatureResult is Azure.Core.Page<AmlUserFeature>;

/**
 * Features enabled for a workspace
 */
model AmlUserFeature {
  /**
   * Specifies the feature ID
   */
  id?: string;

  /**
   * Specifies the feature name
   */
  displayName?: string;

  /**
   * Describes the feature for user experience
   */
  description?: string;
}

/**
 * List of skus with features
 */
model SkuListResult is Azure.Core.Page<WorkspaceSku>;

/**
 * Describes Workspace Sku details and features
 */
model WorkspaceSku {
  /**
   * The set of locations that the SKU is available. This will be supported and registered Azure Geo Regions (e.g. West US, East US, Southeast Asia, etc.).
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * A list of locations and availability zones in those locations where the SKU is available.
   */
  @visibility(Lifecycle.Read)
  locationInfo?: ResourceSkuLocationInfo[];

  /**
   * Sku Tier like Basic or Enterprise
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  resourceType?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * List of features/user capabilities associated with the sku
   */
  @visibility(Lifecycle.Read)
  capabilities?: SKUCapability[];

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  restrictions?: Restriction[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceSkuLocationInfo {
  /**
   * Location of the SKU
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * List of availability zones where the SKU is supported.
   */
  @visibility(Lifecycle.Read)
  zones?: string[];

  /**
   * Details of capabilities available to a SKU in specific zones.
   */
  @visibility(Lifecycle.Read)
  zoneDetails?: ResourceSkuZoneDetails[];
}

/**
 * Describes The zonal capabilities of a SKU.
 */
model ResourceSkuZoneDetails {
  /**
   * The set of zones that the SKU is available in with the specified capabilities.
   */
  @visibility(Lifecycle.Read)
  name?: string[];

  /**
   * A list of capabilities that are available for the SKU in the specified list of zones.
   */
  @visibility(Lifecycle.Read)
  capabilities?: SKUCapability[];
}

/**
 * Features/user capabilities associated with the sku
 */
model SKUCapability {
  /**
   * Capability/Feature ID
   */
  name?: string;

  /**
   * Details about the feature/capability
   */
  value?: string;
}

/**
 * The restriction because of which SKU cannot be used.
 */
model Restriction {
  /**
   * The type of restrictions. As of now only possible value for this is location.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  @visibility(Lifecycle.Read)
  values?: string[];

  /**
   * The reason for the restriction.
   */
  reasonCode?: ReasonCode;
}

/**
 * Represents a resource ID. For example, for a subnet, it is the resource URL for the subnet.
 */
model ResourceId {
  /**
   * The ID of the resource
   */
  id: string;
}

/**
 * A Machine Learning compute based on AKS.
 */
model AKS extends Compute {
  /**
   * AKS properties
   */
  properties?: AKSProperties;

  /**
   * The type of compute
   */
  computeType: "AKS";
}

/**
 * AKS properties
 */
model AKSProperties {
  /**
   * Cluster full qualified domain name
   */
  clusterFqdn?: string;

  /**
   * System services
   */
  @visibility(Lifecycle.Read)
  systemServices?: SystemService[];

  /**
   * Number of agents
   */
  agentCount?: int32;

  /**
   * Agent virtual machine size
   */
  agentVmSize?: string;

  /**
   * Intended usage of the cluster
   */
  clusterPurpose?: ClusterPurpose = ClusterPurpose.FastProd;

  /**
   * SSL configuration
   */
  sslConfiguration?: SslConfiguration;

  /**
   * AKS networking configuration for vnet
   */
  aksNetworkingConfiguration?: AksNetworkingConfiguration;

  /**
   * Load Balancer Type
   */
  loadBalancerType?: LoadBalancerType = LoadBalancerType.PublicIp;

  /**
   * Load Balancer Subnet
   */
  loadBalancerSubnet?: string;
}

/**
 * A system service running on a compute.
 */
model SystemService {
  /**
   * The type of this system service.
   */
  @visibility(Lifecycle.Read)
  systemServiceType?: string;

  /**
   * Public IP address
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * The version for this type.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * The ssl configuration for scoring
 */
model SslConfiguration {
  /**
   * Enable or disable ssl for scoring
   */
  status?: SslConfigurationStatus;

  /**
   * Cert data
   */
  cert?: string;

  /**
   * Key data
   */
  key?: string;

  /**
   * CNAME of the cert
   */
  cname?: string;

  /**
   * Leaf domain label of public endpoint
   */
  leafDomainLabel?: string;

  /**
   * Indicates whether to overwrite existing domain label.
   */
  overwriteExistingDomain?: boolean;
}

/**
 * Advance configuration for AKS networking
 */
model AksNetworkingConfiguration {
  /**
   * Virtual network subnet resource ID the compute nodes belong to
   */
  subnetId?: string;

  /**
   * A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  serviceCidr?: string;

  /**
   * An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.
   */
  @pattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  dnsServiceIP?: string;

  /**
   * A CIDR notation IP range assigned to the Docker bridge network. It must not overlap with any Subnet IP ranges or the Kubernetes service address range.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  dockerBridgeCidr?: string;
}

/**
 * A Machine Learning compute based on Kubernetes Compute.
 */
model Kubernetes extends Compute {
  ...KubernetesSchema;

  /**
   * The type of compute
   */
  computeType: "Kubernetes";
}

/**
 * Kubernetes Compute Schema
 */
model KubernetesSchema {
  /**
   * Properties of Kubernetes
   */
  properties?: KubernetesProperties;
}

/**
 * Kubernetes properties
 */
model KubernetesProperties {
  /**
   * Relay connection string.
   */
  relayConnectionString?: string;

  /**
   * ServiceBus connection string.
   */
  serviceBusConnectionString?: string;

  /**
   * Extension principal-id.
   */
  extensionPrincipalId?: string;

  /**
   * Extension instance release train.
   */
  extensionInstanceReleaseTrain?: string;

  /**
   * VC name.
   */
  vcName?: string;

  /**
   * Compute namespace
   */
  `namespace`?: string = "default";

  /**
   * Default instance type
   */
  defaultInstanceType?: string;

  /**
   * Instance Type Schema
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  instanceTypes?: Record<InstanceTypeSchema>;
}

/**
 * Instance type schema.
 */
model InstanceTypeSchema {
  /**
   * Node Selector
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nodeSelector?: Record<string>;

  /**
   * Resource requests/limits for this instance type
   */
  resources?: InstanceTypeSchemaResources;
}

/**
 * Resource requests/limits for this instance type
 */
model InstanceTypeSchemaResources {
  /**
   * Resource requests for this instance type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  requests?: Record<string>;

  /**
   * Resource limits for this instance type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  limits?: Record<string>;
}

/**
 * AML Compute properties
 */
model AmlComputeProperties {
  /**
   * Compute OS Type
   */
  osType?: OsType = OsType.Linux;

  /**
   * Virtual Machine Size
   */
  vmSize?: string;

  /**
   * Virtual Machine priority
   */
  vmPriority?: VmPriority;

  /**
   * Virtual Machine image for AML Compute - windows only
   */
  virtualMachineImage?: VirtualMachineImage;

  /**
   * Network is isolated or not
   */
  isolatedNetwork?: boolean;

  /**
   * Scale settings for AML Compute
   */
  scaleSettings?: ScaleSettings;

  /**
   * Credentials for an administrator user account that will be created on each compute node.
   */
  userAccountCredentials?: UserAccountCredentials;

  /**
   * Virtual network subnet resource ID the compute nodes belong to.
   */
  subnet?: ResourceId;

  /**
   * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
   */
  remoteLoginPortPublicAccess?: RemoteLoginPortPublicAccess = RemoteLoginPortPublicAccess.NotSpecified;

  /**
   * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
   */
  @visibility(Lifecycle.Read)
  allocationState?: AllocationState;

  /**
   * The time at which the compute entered its current allocation state.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  allocationStateTransitionTime?: utcDateTime;

  /**
   * Collection of errors encountered by various compute nodes during node setup.
   */
  @visibility(Lifecycle.Read)
  errors?: ErrorResponse[];

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  @visibility(Lifecycle.Read)
  currentNodeCount?: int32;

  /**
   * The target number of compute nodes for the compute. If the allocationState is resizing, this property denotes the target node count for the ongoing resize operation. If the allocationState is steady, this property denotes the target node count for the previous resize operation.
   */
  @visibility(Lifecycle.Read)
  targetNodeCount?: int32;

  /**
   * Counts of various node states on the compute.
   */
  @visibility(Lifecycle.Read)
  nodeStateCounts?: NodeStateCounts;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  enableNodePublicIp?: boolean = true;
}

/**
 * Virtual Machine image for Windows AML Compute
 */
model VirtualMachineImage {
  /**
   * Virtual Machine image path
   */
  id: string;
}

/**
 * Settings for user account that gets created on each on the nodes of a compute.
 */
model UserAccountCredentials {
  /**
   * Name of the administrator user account which can be used to SSH to nodes.
   */
  adminUserName: string;

  /**
   * SSH public key of the administrator user account.
   */
  adminUserSshPublicKey?: string;

  /**
   * Password of the administrator user account.
   */
  adminUserPassword?: string;
}

/**
 * Counts of various compute node states on the amlCompute.
 */
model NodeStateCounts {
  /**
   * Number of compute nodes in idle state.
   */
  @visibility(Lifecycle.Read)
  idleNodeCount?: int32;

  /**
   * Number of compute nodes which are running jobs.
   */
  @visibility(Lifecycle.Read)
  runningNodeCount?: int32;

  /**
   * Number of compute nodes which are being prepared.
   */
  @visibility(Lifecycle.Read)
  preparingNodeCount?: int32;

  /**
   * Number of compute nodes which are in unusable state.
   */
  @visibility(Lifecycle.Read)
  unusableNodeCount?: int32;

  /**
   * Number of compute nodes which are leaving the amlCompute.
   */
  @visibility(Lifecycle.Read)
  leavingNodeCount?: int32;

  /**
   * Number of compute nodes which are in preempted state.
   */
  @visibility(Lifecycle.Read)
  preemptedNodeCount?: int32;
}

/**
 * Properties(top level) of AmlCompute
 */
model AmlCompute extends Compute {
  /**
   * Properties of AmlCompute
   */
  properties?: AmlComputeProperties;

  /**
   * The type of compute
   */
  computeType: "AmlCompute";
}

/**
 * Compute Instance properties
 */
model ComputeInstanceProperties {
  /**
   * Virtual Machine Size
   */
  vmSize?: string;

  /**
   * Virtual network subnet resource ID the compute nodes belong to.
   */
  subnet?: ResourceId;

  /**
   * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
   */
  applicationSharingPolicy?: ApplicationSharingPolicy = ApplicationSharingPolicy.Shared;

  /**
   * Specifies policy and settings for SSH access.
   */
  sshSettings?: ComputeInstanceSshSettings;

  /**
   * Describes all connectivity endpoints available for this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  connectivityEndpoints?: ComputeInstanceConnectivityEndpoints;

  /**
   * Describes available applications and their endpoints on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  applications?: ComputeInstanceApplication[];

  /**
   * Describes information on user who created this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  createdBy?: ComputeInstanceCreatedBy;

  /**
   * Collection of errors encountered on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  errors?: ErrorResponse[];

  /**
   * The current state of this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  state?: ComputeInstanceState;

  /**
   * The Compute Instance Authorization type. Available values are personal (default).
   */
  computeInstanceAuthorizationType?: ComputeInstanceAuthorizationType = ComputeInstanceAuthorizationType.personal;

  /**
   * Settings for a personal compute instance.
   */
  personalComputeInstanceSettings?: PersonalComputeInstanceSettings;

  /**
   * Details of customized scripts to execute for setting up the cluster.
   */
  setupScripts?: SetupScripts;

  /**
   * The last operation on ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  lastOperation?: ComputeInstanceLastOperation;
}

/**
 * Specifies policy and settings for SSH access.
 */
model ComputeInstanceSshSettings {
  /**
   * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
   */
  sshPublicAccess?: SshPublicAccess = SshPublicAccess.Disabled;

  /**
   * Describes the admin user name.
   */
  @visibility(Lifecycle.Read)
  adminUserName?: string;

  /**
   * Describes the port for connecting through SSH.
   */
  @visibility(Lifecycle.Read)
  sshPort?: int32;

  /**
   * Specifies the SSH rsa public key file as a string. Use "ssh-keygen -t rsa -b 2048" to generate your SSH key pairs.
   */
  adminPublicKey?: string;
}

/**
 * Defines all connectivity endpoints and properties for an ComputeInstance.
 */
model ComputeInstanceConnectivityEndpoints {
  /**
   * Public IP Address of this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * Private IP Address of this ComputeInstance (local to the VNET in which the compute instance is deployed).
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;
}

/**
 * Defines an Aml Instance application and its connectivity endpoint URI.
 */
model ComputeInstanceApplication {
  /**
   * Name of the ComputeInstance application.
   */
  displayName?: string;

  /**
   * Application' endpoint URI.
   */
  endpointUri?: string;
}

/**
 * Describes information on user who created this ComputeInstance.
 */
model ComputeInstanceCreatedBy {
  /**
   * Name of the user.
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * Uniquely identifies user' Azure Active Directory organization.
   */
  @visibility(Lifecycle.Read)
  userOrgId?: string;

  /**
   * Uniquely identifies the user within his/her organization.
   */
  @visibility(Lifecycle.Read)
  userId?: string;
}

/**
 * Settings for a personal compute instance.
 */
model PersonalComputeInstanceSettings {
  /**
   * A user explicitly assigned to a personal compute instance.
   */
  assignedUser?: AssignedUser;
}

/**
 * A user that can be assigned to a compute instance.
 */
model AssignedUser {
  /**
   * User’s AAD Object Id.
   */
  objectId: string;

  /**
   * User’s AAD Tenant Id.
   */
  tenantId: string;
}

/**
 * Details of customized scripts to execute for setting up the cluster.
 */
model SetupScripts {
  /**
   * Customized setup scripts
   */
  scripts?: ScriptsToExecute;
}

/**
 * Customized setup scripts
 */
model ScriptsToExecute {
  /**
   * Script that's run every time the machine starts.
   */
  startupScript?: ScriptReference;

  /**
   * Script that's run only once during provision of the compute.
   */
  creationScript?: ScriptReference;
}

/**
 * Script reference
 */
model ScriptReference {
  /**
   * The storage source of the script: inline, workspace.
   */
  scriptSource?: string;

  /**
   * The location of scripts in the mounted volume.
   */
  scriptData?: string;

  /**
   * Optional command line arguments passed to the script to run.
   */
  scriptArguments?: string;

  /**
   * Optional time period passed to timeout command.
   */
  timeout?: string;
}

/**
 * The last operation on ComputeInstance.
 */
model ComputeInstanceLastOperation {
  /**
   * Name of the last operation.
   */
  operationName?: OperationName;

  /**
   * Time of the last operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  operationTime?: utcDateTime;

  /**
   * Operation status.
   */
  operationStatus?: OperationStatus;
}

/**
 * Properties(top level) of ComputeInstance
 */
model ComputeInstance extends Compute {
  /**
   * Properties of ComputeInstance
   */
  properties?: ComputeInstanceProperties;

  /**
   * The type of compute
   */
  computeType: "ComputeInstance";
}

/**
 * A Machine Learning compute based on Azure Virtual Machines.
 */
model VirtualMachine extends Compute {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: VirtualMachineProperties;

  /**
   * The type of compute
   */
  computeType: "VirtualMachine";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualMachineProperties {
  /**
   * Virtual Machine size
   */
  virtualMachineSize?: string;

  /**
   * Port open for ssh connections.
   */
  sshPort?: int32;

  /**
   * Public IP address of the virtual machine.
   */
  address?: string;

  /**
   * Admin credentials for virtual machine
   */
  administratorAccount?: VirtualMachineSshCredentials;

  /**
   * Indicates whether this compute will be used for running notebooks.
   */
  isNotebookInstanceCompute?: boolean;
}

/**
 * Admin credentials for virtual machine
 */
model VirtualMachineSshCredentials {
  /**
   * Username of admin account
   */
  username?: string;

  /**
   * Password of admin account
   */
  password?: string;

  /**
   * Public key data
   */
  publicKeyData?: string;

  /**
   * Private key data
   */
  privateKeyData?: string;
}

/**
 * HDInsight compute properties
 */
model HDInsightProperties {
  /**
   * Port open for ssh connections on the master node of the cluster.
   */
  sshPort?: int32;

  /**
   * Public IP address of the master node of the cluster.
   */
  address?: string;

  /**
   * Admin credentials for master node of the cluster
   */
  administratorAccount?: VirtualMachineSshCredentials;
}

/**
 * A HDInsight compute.
 */
model HDInsight extends Compute {
  /**
   * HDInsight compute properties
   */
  properties?: HDInsightProperties;

  /**
   * The type of compute
   */
  computeType: "HDInsight";
}

/**
 * A DataFactory compute.
 */
model DataFactory extends Compute {
  /**
   * The type of compute
   */
  computeType: "DataFactory";
}

/**
 * Properties of Databricks
 */
model DatabricksProperties {
  /**
   * Databricks access token
   */
  databricksAccessToken?: string;

  /**
   * Workspace Url
   */
  workspaceUrl?: string;
}

/**
 * A DataFactory compute.
 */
model Databricks extends Compute {
  /**
   * Properties of Databricks
   */
  properties?: DatabricksProperties;

  /**
   * The type of compute
   */
  computeType: "Databricks";
}

/**
 * A DataLakeAnalytics compute.
 */
model DataLakeAnalytics extends Compute {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: DataLakeAnalyticsProperties;

  /**
   * The type of compute
   */
  computeType: "DataLakeAnalytics";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DataLakeAnalyticsProperties {
  /**
   * DataLake Store Account Name
   */
  dataLakeStoreAccountName?: string;
}

/**
 * A SynapseSpark compute.
 */
model SynapseSpark extends Compute {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: SynapseSparkProperties;

  /**
   * The type of compute
   */
  computeType: "SynapseSpark";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SynapseSparkProperties {
  /**
   * Auto scale properties.
   */
  autoScaleProperties?: AutoScaleProperties;

  /**
   * Auto pause properties.
   */
  autoPauseProperties?: AutoPauseProperties;

  /**
   * Spark version.
   */
  sparkVersion?: string;

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  nodeCount?: int32;

  /**
   * Node size.
   */
  nodeSize?: string;

  /**
   * Node size family.
   */
  nodeSizeFamily?: string;

  /**
   * Azure subscription identifier.
   */
  subscriptionId?: string;

  /**
   * Name of the resource group in which workspace is located.
   */
  resourceGroup?: string;

  /**
   * Name of Azure Machine Learning workspace.
   */
  workspaceName?: string;

  /**
   * Pool name.
   */
  poolName?: string;
}

/**
 * Auto scale properties
 */
model AutoScaleProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  minNodeCount?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  maxNodeCount?: int32;
}

/**
 * Auto pause properties
 */
model AutoPauseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delayInMinutes?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled?: boolean;
}

/**
 * Service principal credentials.
 */
model ServicePrincipalCredentials {
  /**
   * Client Id
   */
  clientId: string;

  /**
   * Client secret
   */
  clientSecret: string;
}

/**
 * Properties of AksComputeSecrets
 */
model AksComputeSecretsProperties {
  /**
   * Content of kubeconfig file that can be used to connect to the Kubernetes cluster.
   */
  userKubeConfig?: string;

  /**
   * Content of kubeconfig file that can be used to connect to the Kubernetes cluster.
   */
  adminKubeConfig?: string;

  /**
   * Image registry pull secret.
   */
  imagePullSecretName?: string;
}

/**
 * Secrets related to a Machine Learning compute based on AKS.
 */
model AksComputeSecrets extends ComputeSecrets {
  ...AksComputeSecretsProperties;

  /**
   * The type of compute
   */
  computeType: "AKS";
}

/**
 * Secrets related to a Machine Learning compute based on AKS.
 */
model VirtualMachineSecrets extends ComputeSecrets {
  /**
   * Admin credentials for virtual machine.
   */
  administratorAccount?: VirtualMachineSshCredentials;

  /**
   * The type of compute
   */
  computeType: "VirtualMachine";
}

/**
 * Properties of Databricks Compute Secrets
 */
model DatabricksComputeSecretsProperties {
  /**
   * access token for databricks account.
   */
  databricksAccessToken?: string;
}

/**
 * Secrets related to a Machine Learning compute based on Databricks.
 */
model DatabricksComputeSecrets extends ComputeSecrets {
  ...DatabricksComputeSecretsProperties;

  /**
   * The type of compute
   */
  computeType: "Databricks";
}

/**
 * The resource requirements for the container (cpu and memory).
 */
model ContainerResourceRequirements {
  /**
   * The minimum amount of CPU cores to be used by the container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  cpu?: float64;

  /**
   * The maximum amount of CPU cores allowed to be used by the container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  cpuLimit?: float64;

  /**
   * The minimum amount of memory (in GB) to be used by the container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  memoryInGB?: float64;

  /**
   * The maximum amount of memory (in GB) allowed to be used by the container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  memoryInGBLimit?: float64;

  /**
   * The number of GPU cores in the container.
   */
  gpu?: int32;

  /**
   * The number of FPGA PCIE devices exposed to the container. Must be multiple of 2.
   */
  fpga?: int32;
}
