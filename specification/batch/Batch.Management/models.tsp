import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Batch;

interface Operations extends Azure.ResourceManager.Operations {}

enum ContainerType {
  @doc("A Docker compatible container technology will be used to launch the containers.")
  DockerCompatible,
  @doc("A CRI based technology will be used to launch the containers.")
  CriCompatible,
}
@Azure.Core.fixed
enum AutoStorageAuthenticationMode {
  @doc("The Batch service will authenticate requests to auto-storage using storage account keys.")
  StorageKeys,
  @doc("The Batch service will authenticate requests to auto-storage using the managed identity assigned to the Batch account.")
  BatchAccountManagedIdentity,
}
@Azure.Core.fixed
enum PoolAllocationMode {
  @doc("Pools will be allocated in subscriptions owned by the Batch service.")
  BatchService,
  @doc("Pools will be allocated in a subscription owned by the user.")
  UserSubscription,
}
@Azure.Core.fixed
enum PublicNetworkAccessType {
  @doc("Enables connectivity to Azure Batch through public DNS.") Enabled,
  @doc("Disables public connectivity and enables private connectivity to Azure Batch Service through private endpoint resource.")
  Disabled,
}
@Azure.Core.fixed
enum EndpointAccessDefaultAction {
  @doc("Allow client access.") Allow,
  @doc("Deny client access.") Deny,
}
@Azure.Core.fixed
enum KeySource {
  @doc("Batch creates and manages the encryption keys used to protect the account data.")
  `Microsoft.Batch`,
  @doc("The encryption keys used to protect the account data are stored in an external key vault. If this is set then the Batch Account identity must be set to `SystemAssigned` and a valid Key Identifier must also be supplied under the keyVaultProperties.")
  `Microsoft.KeyVault`,
}
@Azure.Core.fixed
enum AuthenticationMode {
  @doc("The authentication mode using shared keys.") SharedKey,
  @doc("The authentication mode using Microsoft Entra ID.") AAD,
  @doc("The authentication mode using task authentication tokens.")
  TaskAuthenticationToken,
}
@Azure.Core.fixed
enum ResourceIdentityType {
  @doc("Batch account has a system assigned identity with it.") SystemAssigned,
  @doc("Batch account has user assigned identities with it.") UserAssigned,
  @doc("Batch account has no identity associated with it. Setting `None` in update account will remove existing identities.")
  None,
}
@Azure.Core.fixed
enum ProvisioningState {
  @doc("The account is in an invalid state.") Invalid,
  @doc("The account is being created.") Creating,
  @doc("The account is being deleted.") Deleting,
  @doc("The account has been created and is ready for use.") Succeeded,
  @doc("The last operation for the account is failed.") Failed,
  @doc("The last operation for the account is cancelled.") Cancelled,
}
@Azure.Core.fixed
enum PrivateEndpointConnectionProvisioningState {
  @doc("The connection is creating.") Creating,
  @doc("The user has requested that the connection status be updated, but the update operation has not yet completed. You may not reference the connection when connecting the Batch account.")
  Updating,
  @doc("The connection is deleting.") Deleting,
  @doc("The connection status is final and is ready for use if Status is Approved.")
  Succeeded,
  @doc("The user requested that the connection be updated and it failed. You may retry the update operation.")
  Failed,
  @doc("The user has cancelled the connection creation.") Cancelled,
}
@Azure.Core.fixed
enum PrivateLinkServiceConnectionStatus {
  @doc("The private endpoint connection is approved and can be used to access Batch account")
  Approved,
  @doc("The private endpoint connection is pending and cannot be used to access Batch account")
  Pending,
  @doc("The private endpoint connection is rejected and cannot be used to access Batch account")
  Rejected,
  @doc("The private endpoint connection is disconnected and cannot be used to access Batch account")
  Disconnected,
}
@Azure.Core.fixed
enum AccountKeyType {
  @doc("The primary account key.") Primary,
  @doc("The secondary account key.") Secondary,
}
@Azure.Core.fixed
enum PackageState {
  @doc("The application package has been created but has not yet been activated.")
  Pending,
  @doc("The application package is ready for use.") Active,
}
@Azure.Core.fixed
enum NameAvailabilityReason {
  @doc("The requested name is invalid.") Invalid,
  @doc("The requested name is already in use.") AlreadyExists,
}
@Azure.Core.fixed
enum CertificateProvisioningState {
  @doc("The certificate is available for use in pools.") Succeeded,
  @doc("The user has requested that the certificate be deleted, but the delete operation has not yet completed. You may not reference the certificate when creating or updating pools.")
  Deleting,
  @doc("The user requested that the certificate be deleted, but there are pools that still have references to the certificate, or it is still installed on one or more compute nodes. (The latter can occur if the certificate has been removed from the pool, but the node has not yet restarted. Nodes refresh their certificates only when they restart.) You may use the cancel certificate delete operation to cancel the delete, or the delete certificate operation to retry the delete.")
  Failed,
}
@Azure.Core.fixed
enum CertificateFormat {
  @doc("The certificate is a PFX (PKCS#12) formatted certificate or certificate chain.")
  Pfx,
  @doc("The certificate is a base64-encoded X.509 certificate.") Cer,
}
@Azure.Core.fixed
enum PoolProvisioningState {
  @doc("The pool is available to run tasks subject to the availability of compute nodes.")
  Succeeded,
  @doc("The user has requested that the pool be deleted, but the delete operation has not yet completed.")
  Deleting,
}
@Azure.Core.fixed
enum AllocationState {
  @doc("The pool is not resizing. There are no changes to the number of nodes in the pool in progress. A pool enters this state when it is created and when no operations are being performed on the pool to change the number of nodes.")
  Steady,
  @doc("The pool is resizing; that is, compute nodes are being added to or removed from the pool.")
  Resizing,
  @doc("The pool was resizing, but the user has requested that the resize be stopped, but the stop request has not yet been completed.")
  Stopping,
}
@Azure.Core.fixed
enum CachingType {
  @doc("The caching mode for the disk is not enabled.") None,
  @doc("The caching mode for the disk is read only.") ReadOnly,
  @doc("The caching mode for the disk is read and write.") ReadWrite,
}
@Azure.Core.fixed
enum StorageAccountType {
  @doc("The data disk / OS disk should use standard locally redundant storage.")
  Standard_LRS,
  @doc("The data disk / OS disk should use premium locally redundant storage.")
  Premium_LRS,
  @doc("The data disk / OS disk should use standard SSD locally redundant storage.")
  StandardSSD_LRS,
}
@Azure.Core.fixed
enum DiskEncryptionTarget {
  @doc("The OS Disk on the compute node is encrypted.") OsDisk,
  @doc("The temporary disk on the compute node is encrypted. On Linux this encryption applies to other partitions (such as those on mounted data disks) when encryption occurs at boot time.")
  TemporaryDisk,
}
@Azure.Core.fixed
enum NodePlacementPolicyType {
  @doc("All nodes in the pool will be allocated in the same region.") Regional,
  @doc("Nodes in the pool will be spread across different zones with best effort balancing.")
  Zonal,
}
@Azure.Core.fixed
enum ComputeNodeDeallocationOption {
  @doc("Terminate running task processes and requeue the tasks. The tasks will run again when a node is available. Remove nodes as soon as tasks have been terminated.")
  Requeue,
  @doc("Terminate running tasks. The tasks will be completed with failureInfo indicating that they were terminated, and will not run again. Remove nodes as soon as tasks have been terminated.")
  Terminate,
  @doc("Allow currently running tasks to complete. Schedule no new tasks while waiting. Remove nodes when all tasks have completed.")
  TaskCompletion,
  @doc("Allow currently running tasks to complete, then wait for all task data retention periods to expire. Schedule no new tasks while waiting. Remove nodes when all task retention periods have expired.")
  RetainedData,
}
@Azure.Core.fixed
enum InterNodeCommunicationState {
  @doc("Enable network communication between virtual machines.") Enabled,
  @doc("Disable network communication between virtual machines.") Disabled,
}
@Azure.Core.fixed
enum DynamicVNetAssignmentScope {
  @doc("No dynamic VNet assignment is enabled.") none,
  @doc("Dynamic VNet assignment is done per-job. If this value is set, the network configuration subnet ID must also be set. This feature requires approval before use, please contact support")
  job,
}
@Azure.Core.fixed
enum InboundEndpointProtocol {
  @doc("Use TCP for the endpoint.") TCP,
  @doc("Use UDP for the endpoint.") UDP,
}
@Azure.Core.fixed
enum NetworkSecurityGroupRuleAccess {
  @doc("Allow access.") Allow,
  @doc("Deny access.") Deny,
}
@Azure.Core.fixed
enum IPAddressProvisioningType {
  @doc("A public IP will be created and managed by Batch. There may be multiple public IPs depending on the size of the Pool.")
  BatchManaged,
  @doc("Public IPs are provided by the user and will be used to provision the Compute Nodes.")
  UserManaged,
  @doc("No public IP Address will be created for the Compute Nodes in the Pool.")
  NoPublicIPAddresses,
}
@Azure.Core.fixed
enum ComputeNodeFillType {
  @doc("Tasks should be assigned evenly across all nodes in the pool.") Spread,
  @doc("As many tasks as possible (taskSlotsPerNode) should be assigned to each node in the pool before any tasks are assigned to the next node in the pool.")
  Pack,
}
@Azure.Core.fixed
enum ElevationLevel {
  @doc("The user is a standard user without elevated access.") NonAdmin,
  @doc("The user is a user with elevated access and operates with full Administrator permissions.")
  Admin,
}
@Azure.Core.fixed
enum LoginMode {
  @doc("The LOGON32_LOGON_BATCH Win32 login mode. The batch login mode is recommended for long running parallel processes.")
  Batch,
  @doc("The LOGON32_LOGON_INTERACTIVE Win32 login mode. Some applications require having permissions associated with the interactive login mode. If this is the case for an application used in your task, then this option is recommended.")
  Interactive,
}
@Azure.Core.fixed
enum AutoUserScope {
  @doc("Specifies that the service should create a new user for the task.")
  Task,
  @doc("Specifies that the task runs as the common auto user account which is created on every node in a pool.")
  Pool,
}
@Azure.Core.fixed
enum ContainerWorkingDirectory {
  @doc("Use the standard Batch service task working directory, which will contain the Task resource files populated by Batch.")
  TaskWorkingDirectory,
  @doc("Using container image defined working directory. Beware that this directory will not contain the resource files downloaded by Batch.")
  ContainerImageDefault,
}
@Azure.Core.fixed
enum CertificateStoreLocation {
  @doc("Certificates should be installed to the CurrentUser certificate store.")
  CurrentUser,
  @doc("Certificates should be installed to the LocalMachine certificate store.")
  LocalMachine,
}
@Azure.Core.fixed
enum CertificateVisibility {
  @doc("The certificate should be visible to the user account under which the start task is run. Note that if AutoUser Scope is Pool for both the StartTask and a Task, this certificate will be visible to the Task as well.")
  StartTask,
  @doc("The certificate should be visible to the user accounts under which job tasks are run.")
  Task,
  @doc("The certificate should be visible to the user accounts under which users remotely access the node.")
  RemoteUser,
}
@Azure.Core.fixed
enum NodeCommunicationMode {
  @doc("The node communication mode is automatically set by the Batch service.")
  Default,
  @doc("Nodes using the Classic communication mode require inbound TCP communication on ports 29876 and 29877 from the \"BatchNodeManagement.{region}\" service tag and outbound TCP communication on port 443 to the \"Storage.region\" and \"BatchNodeManagement.{region}\" service tags.")
  Classic,
  @doc("Nodes using the Simplified communication mode require outbound TCP communication on port 443 to the \"BatchNodeManagement.{region}\" service tag. No open inbound ports are required.")
  Simplified,
}
@Azure.Core.fixed
enum PoolIdentityType {
  @doc("Batch pool has user assigned identities with it.") UserAssigned,
  @doc("Batch pool has no identity associated with it. Setting `None` in update pool will remove existing identities.")
  None,
}

@doc("Parameters supplied to the Create operation.")
model BatchAccountCreateParameters {
  @doc("The region in which to create the account.")
  location: string;

  @doc("The user-specified tags associated with the account.")
  tags?: Record<string>;

  @doc("The properties of the Batch account.")
  properties?: BatchAccountCreateProperties;

  @doc("The identity of the Batch account.")
  identity?: BatchAccountIdentity;
}

@doc("The properties of a Batch account.")
model BatchAccountCreateProperties {
  @doc("The properties related to the auto-storage account.")
  autoStorage?: AutoStorageBaseProperties;

  @doc("The pool allocation mode also affects how clients may authenticate to the Batch Service API. If the mode is BatchService, clients may authenticate using access keys or Microsoft Entra ID. If the mode is UserSubscription, clients must use Microsoft Entra ID. The default is BatchService.")
  poolAllocationMode?: PoolAllocationMode;

  @doc("A reference to the Azure key vault associated with the Batch account.")
  keyVaultReference?: KeyVaultReference;

  @doc("If not specified, the default value is 'enabled'.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("The network profile only takes effect when publicNetworkAccess is enabled.")
  networkProfile?: NetworkProfile;

  @doc("Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.")
  encryption?: EncryptionProperties;

  @doc("List of allowed authentication modes for the Batch account that can be used to authenticate with the data plane. This does not affect authentication with the control plane.")
  allowedAuthenticationModes?: AuthenticationMode[];
}

@doc("The properties related to the auto-storage account.")
model AutoStorageBaseProperties {
  @doc("The resource ID of the storage account to be used for auto-storage account.")
  storageAccountId: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The authentication mode which the Batch service will use to manage the auto-storage account.")
  authenticationMode?: AutoStorageAuthenticationMode;

  @doc("The identity referenced here must be assigned to pools which have compute nodes that need access to auto-storage.")
  nodeIdentityReference?: ComputeNodeIdentityReference;
}

@doc("The reference to a user assigned identity associated with the Batch pool which a compute node will use.")
model ComputeNodeIdentityReference {
  @doc("The ARM resource id of the user assigned identity.")
  resourceId?: string;
}

@doc("Identifies the Azure key vault associated with a Batch account.")
model KeyVaultReference {
  @doc("The resource ID of the Azure key vault associated with the Batch account.")
  id: ResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @doc("The URL of the Azure key vault associated with the Batch account.")
  url: string;
}

@doc("Network profile for Batch account, which contains network rule settings for each endpoint.")
model NetworkProfile {
  @doc("Network access profile for batchAccount endpoint (Batch account data plane API).")
  accountAccess?: EndpointAccessProfile;

  @doc("Network access profile for nodeManagement endpoint (Batch service managing compute nodes for Batch pools).")
  nodeManagementAccess?: EndpointAccessProfile;
}

@doc("Network access profile for Batch endpoint.")
model EndpointAccessProfile {
  @doc("Default action for endpoint access. It is only applicable when publicNetworkAccess is enabled.")
  defaultAction: EndpointAccessDefaultAction;

  @doc("Array of IP ranges to filter client IP address.")
  ipRules?: IPRule[];
}

@doc("Rule to filter client IP address.")
model IPRule {
  @doc("Action when client IP address is matched.")
  action: "Allow";

  @doc("IPv4 address, or IPv4 address range in CIDR format.")
  value: string;
}

@doc("Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.")
model EncryptionProperties {
  @doc("Type of the key source.")
  keySource?: KeySource;

  @doc("Additional details when using Microsoft.KeyVault")
  keyVaultProperties?: KeyVaultProperties;
}

@doc("KeyVault configuration when using an encryption KeySource of Microsoft.KeyVault.")
model KeyVaultProperties {
  @doc("""
Full path to the secret with or without version. Example https://mykeyvault.vault.azure.net/keys/testkey/6e34a81fef704045975661e297a4c053. or https://mykeyvault.vault.azure.net/keys/testkey. To be usable the following prerequisites must be met:

 The Batch Account has a System Assigned identity
 The account identity has been granted Key/Get, Key/Unwrap and Key/Wrap permissions
 The KeyVault has soft-delete and purge protection enabled
""")
  keyIdentifier?: string;
}

@doc("The identity of the Batch account, if configured. This is used when the user specifies 'Microsoft.KeyVault' as their Batch account encryption configuration or when `ManagedIdentity` is selected as the auto-storage authentication mode.")
model BatchAccountIdentity {
  @doc("The principal id of the Batch account. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id associated with the Batch account. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the Batch account.")
  type: ResourceIdentityType;

  @doc("The list of user identities associated with the Batch account.")
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

@doc("The list of associated user identities.")
model UserAssignedIdentities {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Account specific properties.")
model BatchAccountProperties {
  @doc("The account endpoint used to interact with the Batch service.")
  @visibility("read")
  accountEndpoint?: string;

  @doc("The endpoint used by compute node to connect to the Batch node management service.")
  @visibility("read")
  nodeManagementEndpoint?: string;

  @doc("The provisioned state of the resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The allocation mode for creating pools in the Batch account.")
  @visibility("read")
  poolAllocationMode?: PoolAllocationMode;

  @doc("Identifies the Azure key vault associated with a Batch account.")
  @visibility("read")
  keyVaultReference?: KeyVaultReference;

  @doc("If not specified, the default value is 'enabled'.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("The network profile only takes effect when publicNetworkAccess is enabled.")
  networkProfile?: NetworkProfile;

  @doc("List of private endpoint connections associated with the Batch account")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Contains information about the auto-storage account associated with a Batch account.")
  @visibility("read")
  autoStorage?: AutoStorageProperties;

  @doc("Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.")
  @visibility("read")
  encryption?: EncryptionProperties;

  @doc("For accounts with PoolAllocationMode set to UserSubscription, quota is managed on the subscription so this value is not returned.")
  @visibility("read")
  dedicatedCoreQuota?: int32;

  @doc("For accounts with PoolAllocationMode set to UserSubscription, quota is managed on the subscription so this value is not returned.")
  @visibility("read")
  lowPriorityCoreQuota?: int32;

  @doc("A list of the dedicated core quota per Virtual Machine family for the Batch account. For accounts with PoolAllocationMode set to UserSubscription, quota is managed on the subscription so this value is not returned.")
  @visibility("read")
  dedicatedCoreQuotaPerVMFamily?: VirtualMachineFamilyCoreQuota[];

  @doc("If this flag is true, dedicated core quota is enforced via both the dedicatedCoreQuotaPerVMFamily and dedicatedCoreQuota properties on the account. If this flag is false, dedicated core quota is enforced only via the dedicatedCoreQuota property on the account and does not consider Virtual Machine family.")
  @visibility("read")
  dedicatedCoreQuotaPerVMFamilyEnforced?: boolean;

  @doc("The pool quota for the Batch account.")
  @visibility("read")
  poolQuota?: int32;

  @doc("The active job and job schedule quota for the Batch account.")
  @visibility("read")
  activeJobAndJobScheduleQuota?: int32;

  @doc("List of allowed authentication modes for the Batch account that can be used to authenticate with the data plane. This does not affect authentication with the control plane.")
  @visibility("read")
  allowedAuthenticationModes?: AuthenticationMode[];
}

@doc("Private endpoint connection properties.")
model PrivateEndpointConnectionProperties {
  @doc("The provisioning state of the private endpoint connection.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  @doc("The private endpoint of the private endpoint connection.")
  @visibility("read")
  privateEndpoint?: PrivateEndpoint;

  @doc("The value has one and only one group id.")
  @visibility("read")
  groupIds?: string[];

  @doc("The private link service connection state of the private endpoint connection")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("The private endpoint of the private endpoint connection.")
model PrivateEndpoint {
  @doc("The ARM resource identifier of the private endpoint. This is of the form /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Network/privateEndpoints/{privateEndpoint}.")
  @visibility("read")
  id?: string;
}

@doc("The private link service connection state of the private endpoint connection")
model PrivateLinkServiceConnectionState {
  @doc("The status of the Batch private endpoint connection")
  status: PrivateLinkServiceConnectionStatus;

  @doc("Description of the private Connection state")
  description?: string;

  @doc("Action required on the private connection state")
  @visibility("read")
  actionsRequired?: string;
}

@doc("Contains information about the auto-storage account associated with a Batch account.")
model AutoStorageProperties {
  ...AutoStorageBaseProperties;

  @doc("The UTC time at which storage keys were last synchronized with the Batch account.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeySync: utcDateTime;
}

@doc("A VM Family and its associated core quota for the Batch account.")
model VirtualMachineFamilyCoreQuota {
  @doc("The Virtual Machine family name.")
  @visibility("read")
  name?: string;

  @doc("The core quota for the VM family for the Batch account.")
  @visibility("read")
  coreQuota?: int32;
}

@doc("An error response from the Batch service.")
@error
model CloudError {
  @doc("The body of the error response.")
  error?: CloudErrorBody;
}

@doc("An error response from the Batch service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("Parameters supplied to the RegenerateKey operation.")
model BatchAccountRegenerateKeyParameters {
  @doc("The type of account key to regenerate.")
  keyName: AccountKeyType;
}

@doc("A set of Azure Batch account keys.")
model BatchAccountKeys {
  @doc("The Batch account name.")
  @visibility("read")
  accountName?: string;

  @doc("The primary key associated with the account.")
  @visibility("read")
  primary?: string;

  @doc("The secondary key associated with the account.")
  @visibility("read")
  secondary?: string;
}

@doc("Parameters for an activating an application package.")
model ActivateApplicationPackageParameters {
  @doc("The format of the application package binary file.")
  format: string;
}

@doc("Properties of an application package")
model ApplicationPackageProperties {
  @doc("The current state of the application package.")
  @visibility("read")
  state?: PackageState;

  @doc("The format of the application package, if the package is active.")
  @visibility("read")
  format?: string;

  @doc("The URL for the application package in Azure Storage.")
  @visibility("read")
  storageUrl?: string;

  @doc("The UTC time at which the Azure Storage URL will expire.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  storageUrlExpiry?: utcDateTime;

  @doc("The time at which the package was last activated, if the package is active.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivationTime?: utcDateTime;
}

@doc("The properties associated with the Application.")
model ApplicationProperties {
  @doc("The display name for the application.")
  displayName?: string;

  @doc("A value indicating whether packages within the application may be overwritten using the same version string.")
  allowUpdates?: boolean;

  @doc("The package to use if a client requests the application but does not specify a version. This property can only be set to the name of an existing package.")
  defaultVersion?: string;
}

@doc("Quotas associated with a Batch region for a particular subscription.")
model BatchLocationQuota {
  @doc("The number of Batch accounts that may be created under the subscription in the specified region.")
  @visibility("read")
  accountQuota?: int32;
}

@doc("The Batch List supported SKUs operation response.")
model SupportedSkusResult is Azure.Core.Page<SupportedSku>;

@doc("Describes a Batch supported SKU.")
model SupportedSku {
  @doc("The name of the SKU.")
  @visibility("read")
  name?: string;

  @doc("The family name of the SKU.")
  @visibility("read")
  familyName?: string;

  @doc("A collection of capabilities which this SKU supports.")
  @visibility("read")
  capabilities?: SkuCapability[];
}

@doc("A SKU capability, such as the number of cores.")
model SkuCapability {
  @doc("The name of the feature.")
  @visibility("read")
  name?: string;

  @doc("The value of the feature.")
  @visibility("read")
  value?: string;
}

@doc("Parameters for a check name availability request.")
model CheckNameAvailabilityParameters {
  @doc("The name to check for availability")
  name: string;

  @doc("The resource type.")
  type: "Microsoft.Batch/batchAccounts";
}

@doc("The CheckNameAvailability operation response.")
model CheckNameAvailabilityResult {
  @doc("Gets a boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or invalid and cannot be used.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("Gets the reason that a Batch account name could not be used. The Reason element is only returned if NameAvailable is false.")
  @visibility("read")
  reason?: NameAvailabilityReason;

  @doc("Gets an error message explaining the Reason value in more detail.")
  @visibility("read")
  message?: string;
}

@doc("Certificate properties.")
model CertificateProperties {
  ...CertificateBaseProperties;

  @visibility("read")
  provisioningState?: CertificateProvisioningState;

  @doc("The time at which the certificate entered its current state.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStateTransitionTime?: utcDateTime;

  @doc("The previous provisioned state of the resource")
  @visibility("read")
  previousProvisioningState?: CertificateProvisioningState;

  @doc("The time at which the certificate entered its previous state.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  previousProvisioningStateTransitionTime?: utcDateTime;

  @doc("The public key of the certificate.")
  @visibility("read")
  publicData?: string;

  @doc("This is only returned when the certificate provisioningState is 'Failed'.")
  @visibility("read")
  deleteCertificateError?: DeleteCertificateError;
}

@doc("An error response from the Batch service.")
model DeleteCertificateError {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: DeleteCertificateError[];
}

@doc("Base certificate properties.")
model CertificateBaseProperties {
  @doc("This must match the first portion of the certificate name. Currently required to be 'SHA1'.")
  thumbprintAlgorithm?: string;

  @doc("This must match the thumbprint from the name.")
  thumbprint?: string;

  @doc("The format of the certificate - either Pfx or Cer. If omitted, the default is Pfx.")
  format?: CertificateFormat;
}

@doc("Detector response properties.")
model DetectorResponseProperties {
  @doc("A base64 encoded string that represents the content of a detector.")
  value?: string;
}

@doc("Private link resource properties.")
model PrivateLinkResourceProperties {
  @doc("The group id is used to establish the private link connection.")
  @visibility("read")
  groupId?: string;

  @doc("The list of required members that are used to establish the private link connection.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The list of required zone names for the private DNS resource name")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("Pool properties.")
model PoolProperties {
  @doc("The display name need not be unique and can contain any Unicode characters up to a maximum length of 1024.")
  displayName?: string;

  @doc("This is the last time at which the pool level data, such as the targetDedicatedNodes or autoScaleSettings, changed. It does not factor in node-level changes such as a compute node changing state.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("The creation time of the pool.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The current state of the pool.")
  @visibility("read")
  provisioningState?: PoolProvisioningState;

  @doc("The time at which the pool entered its current state.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  provisioningStateTransitionTime?: utcDateTime;

  @doc("Whether the pool is resizing.")
  @visibility("read")
  allocationState?: AllocationState;

  @doc("The time at which the pool entered its current allocation state.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  allocationStateTransitionTime?: utcDateTime;

  @doc("For information about available sizes of virtual machines for Cloud Services pools (pools created with cloudServiceConfiguration), see Sizes for Cloud Services (https://azure.microsoft.com/documentation/articles/cloud-services-sizes-specs/). Batch supports all Cloud Services VM sizes except ExtraSmall. For information about available VM sizes for pools using images from the Virtual Machines Marketplace (pools created with virtualMachineConfiguration) see Sizes for Virtual Machines (Linux) (https://azure.microsoft.com/documentation/articles/virtual-machines-linux-sizes/) or Sizes for Virtual Machines (Windows) (https://azure.microsoft.com/documentation/articles/virtual-machines-windows-sizes/). Batch supports all Azure VM sizes except STANDARD_A0 and those with premium storage (STANDARD_GS, STANDARD_DS, and STANDARD_DSV2 series).")
  vmSize?: string;

  @doc("Using CloudServiceConfiguration specifies that the nodes should be creating using Azure Cloud Services (PaaS), while VirtualMachineConfiguration uses Azure Virtual Machines (IaaS).")
  deploymentConfiguration?: DeploymentConfiguration;

  @doc("The number of dedicated compute nodes currently in the pool.")
  @visibility("read")
  currentDedicatedNodes?: int32;

  @doc("The number of Spot/low-priority compute nodes currently in the pool.")
  @visibility("read")
  currentLowPriorityNodes?: int32;

  @doc("Defines the desired size of the pool. This can either be 'fixedScale' where the requested targetDedicatedNodes is specified, or 'autoScale' which defines a formula which is periodically reevaluated. If this property is not specified, the pool will have a fixed scale with 0 targetDedicatedNodes.")
  scaleSettings?: ScaleSettings;

  @doc("This property is set only if the pool automatically scales, i.e. autoScaleSettings are used.")
  @visibility("read")
  autoScaleRun?: AutoScaleRun;

  @doc("This imposes restrictions on which nodes can be assigned to the pool. Enabling this value can reduce the chance of the requested number of nodes to be allocated in the pool. If not specified, this value defaults to 'Disabled'.")
  interNodeCommunication?: InterNodeCommunicationState;

  @doc("The network configuration for a pool.")
  networkConfiguration?: NetworkConfiguration;

  @doc("The default value is 1. The maximum value is the smaller of 4 times the number of cores of the vmSize of the pool or 256.")
  taskSlotsPerNode?: int32;

  @doc("If not specified, the default is spread.")
  taskSchedulingPolicy?: TaskSchedulingPolicy;

  @doc("The list of user accounts to be created on each node in the pool.")
  userAccounts?: UserAccount[];

  @doc("The Batch service does not assign any meaning to metadata; it is solely for the use of user code.")
  metadata?: MetadataItem[];

  @doc("In an PATCH (update) operation, this property can be set to an empty object to remove the start task from the pool.")
  startTask?: StartTask;

  @doc("""
For Windows compute nodes, the Batch service installs the certificates to the specified certificate store and location. For Linux compute nodes, the certificates are stored in a directory inside the task working directory and an environment variable AZ_BATCH_CERTIFICATES_DIR is supplied to the task to query for this location. For certificates with visibility of 'remoteUser', a 'certs' directory is created in the user's home directory (e.g., /home/{user-name}/certs) and certificates are placed in that directory.

Warning: This property is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
""")
  certificates?: CertificateReference[];

  @doc("Changes to application package references affect all new compute nodes joining the pool, but do not affect compute nodes that are already in the pool until they are rebooted or reimaged. There is a maximum of 10 application package references on any given pool.")
  applicationPackages?: ApplicationPackageReference[];

  @doc("The list of application licenses must be a subset of available Batch service application licenses. If a license is requested which is not supported, pool creation will fail.")
  applicationLicenses?: string[];

  @doc("Describes either the current operation (if the pool AllocationState is Resizing) or the previously completed operation (if the AllocationState is Steady).")
  @visibility("read")
  resizeOperationStatus?: ResizeOperationStatus;

  @doc("This supports Azure Files, NFS, CIFS/SMB, and Blobfuse.")
  mountConfiguration?: MountConfiguration[];

  @doc("If omitted, the default value is Default.")
  targetNodeCommunicationMode?: NodeCommunicationMode;

  @doc("Determines how a pool communicates with the Batch service.")
  @visibility("read")
  currentNodeCommunicationMode?: NodeCommunicationMode;

  @doc("The user-defined tags to be associated with the Azure Batch Pool. When specified, these tags are propagated to the backing Azure resources associated with the pool. This property can only be specified when the Batch account was created with the poolAllocationMode property set to 'UserSubscription'.")
  resourceTags?: Record<string>;
}

@doc("Deployment configuration properties.")
model DeploymentConfiguration {
  @doc("This property and virtualMachineConfiguration are mutually exclusive and one of the properties must be specified. This property cannot be specified if the Batch account was created with its poolAllocationMode property set to 'UserSubscription'.")
  cloudServiceConfiguration?: CloudServiceConfiguration;

  @doc("This property and cloudServiceConfiguration are mutually exclusive and one of the properties must be specified.")
  virtualMachineConfiguration?: VirtualMachineConfiguration;
}

@doc("The configuration for nodes in a pool based on the Azure Cloud Services platform.")
model CloudServiceConfiguration {
  @doc("Possible values are: 2 - OS Family 2, equivalent to Windows Server 2008 R2 SP1. 3 - OS Family 3, equivalent to Windows Server 2012. 4 - OS Family 4, equivalent to Windows Server 2012 R2. 5 - OS Family 5, equivalent to Windows Server 2016. 6 - OS Family 6, equivalent to Windows Server 2019. For more information, see Azure Guest OS Releases (https://azure.microsoft.com/documentation/articles/cloud-services-guestos-update-matrix/#releases).")
  osFamily: string;

  @doc("The default value is * which specifies the latest operating system version for the specified OS family.")
  osVersion?: string;
}

@doc("The configuration for compute nodes in a pool based on the Azure Virtual Machines infrastructure.")
model VirtualMachineConfiguration {
  @doc("A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.")
  imageReference: ImageReference;

  @doc("The Batch node agent is a program that runs on each node in the pool, and provides the command-and-control interface between the node and the Batch service. There are different implementations of the node agent, known as SKUs, for different operating systems. You must specify a node agent SKU which matches the selected image reference. To get the list of supported node agent SKUs along with their list of verified image references, see the 'List supported node agent SKUs' operation.")
  nodeAgentSkuId: string;

  @doc("This property must not be specified if the imageReference specifies a Linux OS image.")
  windowsConfiguration?: WindowsConfiguration;

  @doc("This property must be specified if the compute nodes in the pool need to have empty data disks attached to them.")
  dataDisks?: DataDisk[];

  @doc("""
This only applies to images that contain the Windows operating system, and should only be used when you hold valid on-premises licenses for the nodes which will be deployed. If omitted, no on-premises licensing discount is applied. Values are:

 Windows_Server - The on-premises license is for Windows Server.
 Windows_Client - The on-premises license is for Windows Client.

""")
  licenseType?: string;

  @doc("If specified, setup is performed on each node in the pool to allow tasks to run in containers. All regular tasks and job manager tasks run on this pool must specify the containerSettings property, and all other tasks may specify it.")
  containerConfiguration?: ContainerConfiguration;

  @doc("If specified, encryption is performed on each node in the pool during node provisioning.")
  diskEncryptionConfiguration?: DiskEncryptionConfiguration;

  @doc("This configuration will specify rules on how nodes in the pool will be physically allocated.")
  nodePlacementConfiguration?: NodePlacementConfiguration;

  @doc("If specified, the extensions mentioned in this configuration will be installed on each node.")
  extensions?: VMExtension[];

  @doc("Contains configuration for ephemeral OSDisk settings.")
  osDisk?: OSDisk;

  @doc("Specifies the security profile settings for the virtual machine or virtual machine scale set.")
  securityProfile?: SecurityProfile;

  @doc("The service artifact reference id in the form of /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}")
  serviceArtifactReference?: ServiceArtifactReference;
}

@doc("A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.")
model ImageReference {
  @doc("For example, Canonical or MicrosoftWindowsServer.")
  publisher?: string;

  @doc("For example, UbuntuServer or WindowsServer.")
  offer?: string;

  @doc("For example, 18.04-LTS or 2022-datacenter.")
  sku?: string;

  @doc("A value of 'latest' can be specified to select the latest version of an image. If omitted, the default is 'latest'.")
  version?: string;

  @doc("This property is mutually exclusive with other properties. The Azure Compute Gallery Image must have replicas in the same region as the Azure Batch account. For information about the firewall settings for the Batch node agent to communicate with the Batch service see https://docs.microsoft.com/en-us/azure/batch/batch-api-basics#virtual-network-vnet-and-firewall-configuration.")
  id?: string;
}

@doc("Windows operating system settings to apply to the virtual machine.")
model WindowsConfiguration {
  @doc("If omitted, the default value is true.")
  enableAutomaticUpdates?: boolean;
}

@doc("Settings which will be used by the data disks associated to Compute Nodes in the Pool. When using attached data disks, you need to mount and format the disks from within a VM to use them.")
model DataDisk {
  @doc("The lun is used to uniquely identify each data disk. If attaching multiple disks, each should have a distinct lun. The value must be between 0 and 63, inclusive.")
  lun: int32;

  @doc("""
Values are:

 none - The caching mode for the disk is not enabled.
 readOnly - The caching mode for the disk is read only.
 readWrite - The caching mode for the disk is read and write.

 The default value for caching is none. For information about the caching options see: https://blogs.msdn.microsoft.com/windowsazurestorage/2012/06/27/exploring-windows-azure-drives-disks-and-images/.
""")
  caching?: CachingType;

  @doc("The initial disk size in GB when creating new data disk.")
  diskSizeGB: int32;

  @doc("""
If omitted, the default is \"Standard_LRS\". Values are:

 Standard_LRS - The data disk should use standard locally redundant storage.
 Premium_LRS - The data disk should use premium locally redundant storage.
""")
  storageAccountType?: StorageAccountType;
}

@doc("The configuration for container-enabled pools.")
model ContainerConfiguration {
  @doc("The container technology to be used.")
  type: ContainerType;

  @doc("This is the full image reference, as would be specified to \"docker pull\". An image will be sourced from the default Docker registry unless the image is fully qualified with an alternative registry.")
  containerImageNames?: string[];

  @doc("If any images must be downloaded from a private registry which requires credentials, then those credentials must be provided here.")
  containerRegistries?: ContainerRegistry[];
}

@doc("A private container registry.")
model ContainerRegistry {
  @doc("The user name to log into the registry server.")
  @projectedName("json", "username")
  userName?: string;

  @doc("The password to log into the registry server.")
  password?: string;

  @doc("If omitted, the default is \"docker.io\".")
  registryServer?: string;

  @doc("The reference to a user assigned identity associated with the Batch pool which a compute node will use.")
  identityReference?: ComputeNodeIdentityReference;
}

@doc("The disk encryption configuration applied on compute nodes in the pool. Disk encryption configuration is not supported on Linux pool created with Virtual Machine Image or Azure Compute Gallery Image.")
model DiskEncryptionConfiguration {
  @doc("On Linux pool, only \"TemporaryDisk\" is supported; on Windows pool, \"OsDisk\" and \"TemporaryDisk\" must be specified.")
  targets?: DiskEncryptionTarget[];
}

@doc("Allocation configuration used by Batch Service to provision the nodes.")
model NodePlacementConfiguration {
  @doc("Allocation policy used by Batch Service to provision the nodes. If not specified, Batch will use the regional policy.")
  policy?: NodePlacementPolicyType;
}

@doc("The configuration for virtual machine extensions.")
model VMExtension {
  @doc("The name of the virtual machine extension.")
  name: string;

  @doc("The name of the extension handler publisher.")
  publisher: string;

  @doc("The type of the extensions.")
  type: string;

  @doc("The version of script handler.")
  typeHandlerVersion?: string;

  @doc("Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.")
  autoUpgradeMinorVersion?: boolean;

  @doc("Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.")
  enableAutomaticUpgrade?: boolean;

  @doc("JSON formatted public settings for the extension.")
  settings?: Record<unknown>;

  @doc("The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all. ")
  protectedSettings?: Record<unknown>;

  @doc("Collection of extension names after which this extension needs to be provisioned.")
  provisionAfterExtensions?: string[];
}

@doc("Settings for the operating system disk of the virtual machine.")
model OSDisk {
  @doc("Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.")
  ephemeralOSDiskSettings?: DiffDiskSettings;

  @doc("The type of caching to enable for the disk.")
  caching?: CachingType;

  managedDisk?: ManagedDisk;

  @doc("The initial disk size in GB when creating new OS disk.")
  diskSizeGB?: int32;

  @doc("Specifies whether writeAccelerator should be enabled or disabled on the disk.")
  writeAcceleratorEnabled?: boolean;
}

@doc("Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.")
model DiffDiskSettings {
  @doc("This property can be used by user in the request to choose which location the operating system should be in. e.g., cache disk space for Ephemeral OS disk provisioning. For more information on Ephemeral OS disk size requirements, please refer to Ephemeral OS disk size requirements for Windows VMs at https://docs.microsoft.com/en-us/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements and Linux VMs at https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements.")
  placement?: "CacheDisk";
}

model ManagedDisk {
  @doc("The storage account type for use in creating data disks or OS disk.")
  storageAccountType?: StorageAccountType;
}

@doc("Specifies the security profile settings for the virtual machine or virtual machine scale set.")
model SecurityProfile {
  @doc("Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings.")
  securityType?: "trustedLaunch";

  @doc("This property can be used by user in the request to enable or disable the Host Encryption for the virtual machine or virtual machine scale set. This will enable the encryption for all the disks including Resource/Temp disk at host itself.")
  encryptionAtHost?: boolean;

  @doc("Specifies the security settings like secure boot and vTPM used while creating the virtual machine.")
  uefiSettings?: UefiSettings;
}

@doc("Specifies the security settings like secure boot and vTPM used while creating the virtual machine.")
model UefiSettings {
  @doc("Specifies whether secure boot should be enabled on the virtual machine.")
  secureBootEnabled?: boolean;

  @doc("Specifies whether vTPM should be enabled on the virtual machine.")
  vTpmEnabled?: boolean;
}

@doc("Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version.")
model ServiceArtifactReference {
  @doc("The service artifact reference id in the form of /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}")
  id: string;
}

@doc("Defines the desired size of the pool. This can either be 'fixedScale' where the requested targetDedicatedNodes is specified, or 'autoScale' which defines a formula which is periodically reevaluated. If this property is not specified, the pool will have a fixed scale with 0 targetDedicatedNodes.")
model ScaleSettings {
  @doc("This property and autoScale are mutually exclusive and one of the properties must be specified.")
  fixedScale?: FixedScaleSettings;

  @doc("This property and fixedScale are mutually exclusive and one of the properties must be specified.")
  autoScale?: AutoScaleSettings;
}

@doc("Fixed scale settings for the pool.")
model FixedScaleSettings {
  @doc("The default value is 15 minutes. Timeout values use ISO 8601 format. For example, use PT10M for 10 minutes. The minimum value is 5 minutes. If you specify a value less than 5 minutes, the Batch service rejects the request with an error; if you are calling the REST API directly, the HTTP status code is 400 (Bad Request).")
  resizeTimeout?: duration;

  @doc("At least one of targetDedicatedNodes, targetLowPriorityNodes must be set.")
  targetDedicatedNodes?: int32;

  @doc("At least one of targetDedicatedNodes, targetLowPriorityNodes must be set.")
  targetLowPriorityNodes?: int32;

  @doc("If omitted, the default value is Requeue.")
  @visibility("create", "update")
  nodeDeallocationOption?: ComputeNodeDeallocationOption;
}

@doc("AutoScale settings for the pool.")
model AutoScaleSettings {
  @doc("A formula for the desired number of compute nodes in the pool.")
  formula: string;

  @doc("If omitted, the default value is 15 minutes (PT15M).")
  evaluationInterval?: duration;
}

@doc("The results and errors from an execution of a pool autoscale formula.")
model AutoScaleRun {
  @doc("The time at which the autoscale formula was last evaluated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  evaluationTime: utcDateTime;

  @doc("Each variable value is returned in the form $variable=value, and variables are separated by semicolons.")
  results?: string;

  @doc("An error that occurred when autoscaling a pool.")
  error?: AutoScaleRunError;
}

@doc("An error that occurred when autoscaling a pool.")
model AutoScaleRunError {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message: string;

  @doc("Additional details about the error.")
  details?: AutoScaleRunError[];
}

@doc("The network configuration for a pool.")
model NetworkConfiguration {
  @doc("The virtual network must be in the same region and subscription as the Azure Batch account. The specified subnet should have enough free IP addresses to accommodate the number of nodes in the pool. If the subnet doesn't have enough free IP addresses, the pool will partially allocate compute nodes and a resize error will occur. The 'MicrosoftAzureBatch' service principal must have the 'Classic Virtual Machine Contributor' Role-Based Access Control (RBAC) role for the specified VNet. The specified subnet must allow communication from the Azure Batch service to be able to schedule tasks on the compute nodes. This can be verified by checking if the specified VNet has any associated Network Security Groups (NSG). If communication to the compute nodes in the specified subnet is denied by an NSG, then the Batch service will set the state of the compute nodes to unusable. If the specified VNet has any associated Network Security Groups (NSG), then a few reserved system ports must be enabled for inbound communication. For pools created with a virtual machine configuration, enable ports 29876 and 29877, as well as port 22 for Linux and port 3389 for Windows. For pools created with a cloud service configuration, enable ports 10100, 20100, and 30100. Also enable outbound connections to Azure Storage on port 443. For cloudServiceConfiguration pools, only 'classic' VNETs are supported. For more details see: https://docs.microsoft.com/en-us/azure/batch/batch-api-basics#virtual-network-vnet-and-firewall-configuration")
  subnetId?: string;

  @doc("The scope of dynamic vnet assignment.")
  dynamicVnetAssignmentScope?: DynamicVNetAssignmentScope;

  @doc("Pool endpoint configuration is only supported on pools with the virtualMachineConfiguration property.")
  endpointConfiguration?: PoolEndpointConfiguration;

  @doc("This property is only supported on Pools with the virtualMachineConfiguration property.")
  publicIPAddressConfiguration?: PublicIPAddressConfiguration;

  @doc("Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, which may lead to improved networking performance. For more details, see: https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview.")
  enableAcceleratedNetworking?: boolean;
}

@doc("The endpoint configuration for a pool.")
model PoolEndpointConfiguration {
  @doc("The maximum number of inbound NAT pools per Batch pool is 5. If the maximum number of inbound NAT pools is exceeded the request fails with HTTP status code 400. This cannot be specified if the IPAddressProvisioningType is NoPublicIPAddresses.")
  inboundNatPools: InboundNatPool[];
}

@doc("A inbound NAT pool that can be used to address specific ports on compute nodes in a Batch pool externally.")
model InboundNatPool {
  @doc("The name must be unique within a Batch pool, can contain letters, numbers, underscores, periods, and hyphens. Names must start with a letter or number, must end with a letter, number, or underscore, and cannot exceed 77 characters.  If any invalid values are provided the request fails with HTTP status code 400.")
  name: string;

  @doc("The protocol of the endpoint.")
  protocol: InboundEndpointProtocol;

  @doc("This must be unique within a Batch pool. Acceptable values are between 1 and 65535 except for 22, 3389, 29876 and 29877 as these are reserved. If any reserved values are provided the request fails with HTTP status code 400.")
  backendPort: int32;

  @doc("Acceptable values range between 1 and 65534 except ports from 50000 to 55000 which are reserved. All ranges within a pool must be distinct and cannot overlap. If any reserved or overlapping values are provided the request fails with HTTP status code 400.")
  frontendPortRangeStart: int32;

  @doc("Acceptable values range between 1 and 65534 except ports from 50000 to 55000 which are reserved by the Batch service. All ranges within a pool must be distinct and cannot overlap. If any reserved or overlapping values are provided the request fails with HTTP status code 400.")
  frontendPortRangeEnd: int32;

  @doc("The maximum number of rules that can be specified across all the endpoints on a Batch pool is 25. If no network security group rules are specified, a default rule will be created to allow inbound access to the specified backendPort. If the maximum number of network security group rules is exceeded the request fails with HTTP status code 400.")
  networkSecurityGroupRules?: NetworkSecurityGroupRule[];
}

@doc("A network security group rule to apply to an inbound endpoint.")
model NetworkSecurityGroupRule {
  @doc("Priorities within a pool must be unique and are evaluated in order of priority. The lower the number the higher the priority. For example, rules could be specified with order numbers of 150, 250, and 350. The rule with the order number of 150 takes precedence over the rule that has an order of 250. Allowed priorities are 150 to 4096. If any reserved or duplicate values are provided the request fails with HTTP status code 400.")
  priority: int32;

  @doc("The action that should be taken for a specified IP address, subnet range or tag.")
  access: NetworkSecurityGroupRuleAccess;

  @doc("Valid values are a single IP address (i.e. 10.10.10.10), IP subnet (i.e. 192.168.1.0/24), default tag, or * (for all addresses).  If any other values are provided the request fails with HTTP status code 400.")
  sourceAddressPrefix: string;

  @doc("Valid values are '*' (for all ports 0 - 65535) or arrays of ports or port ranges (i.e. 100-200). The ports should in the range of 0 to 65535 and the port ranges or ports can't overlap. If any other values are provided the request fails with HTTP status code 400. Default value will be *.")
  sourcePortRanges?: string[];
}

@doc("The public IP Address configuration of the networking configuration of a Pool.")
model PublicIPAddressConfiguration {
  @doc("The default value is BatchManaged")
  provision?: IPAddressProvisioningType;

  @doc("The number of IPs specified here limits the maximum size of the Pool - 100 dedicated nodes or 100 Spot/low-priority nodes can be allocated for each public IP. For example, a pool needing 250 dedicated VMs would need at least 3 public IPs specified. Each element of this collection is of the form: /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Network/publicIPAddresses/{ip}.")
  ipAddressIds?: string[];
}

@doc("Specifies how tasks should be distributed across compute nodes.")
model TaskSchedulingPolicy {
  @doc("How tasks should be distributed across compute nodes.")
  nodeFillType: ComputeNodeFillType;
}

@doc("Properties used to create a user on an Azure Batch node.")
model UserAccount {
  @doc("The name of the user account. Names can contain any Unicode characters up to a maximum length of 20.")
  name: string;

  @doc("The password for the user account.")
  password: string;

  @doc("nonAdmin - The auto user is a standard user without elevated access. admin - The auto user is a user with elevated access and operates with full Administrator permissions. The default value is nonAdmin.")
  elevationLevel?: ElevationLevel;

  @doc("This property is ignored if specified on a Windows pool. If not specified, the user is created with the default options.")
  linuxUserConfiguration?: LinuxUserConfiguration;

  @doc("This property can only be specified if the user is on a Windows pool. If not specified and on a Windows pool, the user is created with the default options.")
  windowsUserConfiguration?: WindowsUserConfiguration;
}

@doc("Properties used to create a user account on a Linux node.")
model LinuxUserConfiguration {
  @doc("The uid and gid properties must be specified together or not at all. If not specified the underlying operating system picks the uid.")
  uid?: int32;

  @doc("The uid and gid properties must be specified together or not at all. If not specified the underlying operating system picks the gid.")
  gid?: int32;

  @doc("The private key must not be password protected. The private key is used to automatically configure asymmetric-key based authentication for SSH between nodes in a Linux pool when the pool's enableInterNodeCommunication property is true (it is ignored if enableInterNodeCommunication is false). It does this by placing the key pair into the user's .ssh directory. If not specified, password-less SSH is not configured between nodes (no modification of the user's .ssh directory is done).")
  sshPrivateKey?: string;
}

@doc("Properties used to create a user account on a Windows node.")
model WindowsUserConfiguration {
  @doc("Specifies login mode for the user. The default value for VirtualMachineConfiguration pools is interactive mode and for CloudServiceConfiguration pools is batch mode.")
  loginMode?: LoginMode;
}

@doc("The Batch service does not assign any meaning to this metadata; it is solely for the use of user code.")
model MetadataItem {
  @doc("The name of the metadata item.")
  name: string;

  @doc("The value of the metadata item.")
  value: string;
}

@doc("In some cases the start task may be re-run even though the node was not rebooted. Due to this, start tasks should be idempotent and exit gracefully if the setup they're performing has already been done. Special care should be taken to avoid start tasks which create breakaway process or install/launch services from the start task working directory, as this will block Batch from being able to re-run the start task.")
model StartTask {
  @doc("The command line does not run under a shell, and therefore cannot take advantage of shell features such as environment variable expansion. If you want to take advantage of such features, you should invoke the shell in the command line, for example using \"cmd /c MyCommand\" in Windows or \"/bin/sh -c MyCommand\" in Linux. Required if any other properties of the startTask are specified.")
  commandLine?: string;

  @doc("A list of files that the Batch service will download to the compute node before running the command line.")
  resourceFiles?: ResourceFile[];

  @doc("A list of environment variable settings for the start task.")
  environmentSettings?: EnvironmentSetting[];

  @doc("If omitted, the task runs as a non-administrative user unique to the task.")
  userIdentity?: UserIdentity;

  @doc("The Batch service retries a task if its exit code is nonzero. Note that this value specifically controls the number of retries. The Batch service will try the task once, and may then retry up to this limit. For example, if the maximum retry count is 3, Batch tries the task up to 4 times (one initial try and 3 retries). If the maximum retry count is 0, the Batch service does not retry the task. If the maximum retry count is -1, the Batch service retries the task without limit. Default is 0")
  maxTaskRetryCount?: int32;

  @doc("If true and the start task fails on a compute node, the Batch service retries the start task up to its maximum retry count (maxTaskRetryCount). If the task has still not completed successfully after all retries, then the Batch service marks the compute node unusable, and will not schedule tasks to it. This condition can be detected via the node state and scheduling error detail. If false, the Batch service will not wait for the start task to complete. In this case, other tasks can start executing on the compute node while the start task is still running; and even if the start task fails, new tasks will continue to be scheduled on the node. The default is true.")
  waitForSuccess?: boolean;

  @doc("When this is specified, all directories recursively below the AZ_BATCH_NODE_ROOT_DIR (the root of Azure Batch directories on the node) are mapped into the container, all task environment variables are mapped into the container, and the task command line is executed in the container.")
  containerSettings?: TaskContainerSettings;
}

@doc("A single file or multiple files to be downloaded to a compute node.")
model ResourceFile {
  @doc("The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified.")
  autoStorageContainerName?: string;

  @doc("The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified. This URL must be readable and listable from compute nodes. There are three ways to get such a URL for a container in Azure storage: include a Shared Access Signature (SAS) granting read and list permissions on the container, use a managed identity with read and list permissions, or set the ACL for the container to allow public access.")
  storageContainerUrl?: string;

  @doc("The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified. If the URL points to Azure Blob Storage, it must be readable from compute nodes. There are three ways to get such a URL for a blob in Azure storage: include a Shared Access Signature (SAS) granting read permissions on the blob, use a managed identity with read permission, or set the ACL for the blob or its container to allow public access.")
  httpUrl?: string;

  @doc("The property is valid only when autoStorageContainerName or storageContainerUrl is used. This prefix can be a partial filename or a subdirectory. If a prefix is not specified, all the files in the container will be downloaded.")
  blobPrefix?: string;

  @doc("If the httpUrl property is specified, the filePath is required and describes the path which the file will be downloaded to, including the filename. Otherwise, if the autoStorageContainerName or storageContainerUrl property is specified, filePath is optional and is the directory to download the files to. In the case where filePath is used as a directory, any directory structure already associated with the input data will be retained in full and appended to the specified filePath directory. The specified relative path cannot break out of the task's working directory (for example by using '..').")
  filePath?: string;

  @doc("This property applies only to files being downloaded to Linux compute nodes. It will be ignored if it is specified for a resourceFile which will be downloaded to a Windows node. If this property is not specified for a Linux node, then a default value of 0770 is applied to the file.")
  fileMode?: string;

  @doc("The reference to a user assigned identity associated with the Batch pool which a compute node will use.")
  identityReference?: ComputeNodeIdentityReference;
}

@doc("An environment variable to be set on a task process.")
model EnvironmentSetting {
  @doc("The name of the environment variable.")
  name: string;

  @doc("The value of the environment variable.")
  value?: string;
}

@doc("Specify either the userName or autoUser property, but not both.")
model UserIdentity {
  @doc("The userName and autoUser properties are mutually exclusive; you must specify one but not both.")
  userName?: string;

  @doc("The userName and autoUser properties are mutually exclusive; you must specify one but not both.")
  autoUser?: AutoUserSpecification;
}

@doc("Specifies the parameters for the auto user that runs a task on the Batch service.")
model AutoUserSpecification {
  @doc("The default value is Pool. If the pool is running Windows a value of Task should be specified if stricter isolation between tasks is required. For example, if the task mutates the registry in a way which could impact other tasks, or if certificates have been specified on the pool which should not be accessible by normal tasks but should be accessible by start tasks.")
  scope?: AutoUserScope;

  @doc("The default value is nonAdmin.")
  elevationLevel?: ElevationLevel;
}

@doc("The container settings for a task.")
model TaskContainerSettings {
  @doc("These additional options are supplied as arguments to the \"docker create\" command, in addition to those controlled by the Batch Service.")
  containerRunOptions?: string;

  @doc("This is the full image reference, as would be specified to \"docker pull\". If no tag is provided as part of the image name, the tag \":latest\" is used as a default.")
  imageName: string;

  @doc("This setting can be omitted if was already provided at pool creation.")
  registry?: ContainerRegistry;

  @doc("A flag to indicate where the container task working directory is. The default is 'taskWorkingDirectory'.")
  workingDirectory?: ContainerWorkingDirectory;
}

@doc("Warning: This object is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.")
model CertificateReference {
  @doc("The fully qualified ID of the certificate to install on the pool. This must be inside the same batch account as the pool.")
  id: string;

  @doc("The default value is currentUser. This property is applicable only for pools configured with Windows nodes (that is, created with cloudServiceConfiguration, or with virtualMachineConfiguration using a Windows image reference). For Linux compute nodes, the certificates are stored in a directory inside the task working directory and an environment variable AZ_BATCH_CERTIFICATES_DIR is supplied to the task to query for this location. For certificates with visibility of 'remoteUser', a 'certs' directory is created in the user's home directory (e.g., /home/{user-name}/certs) and certificates are placed in that directory.")
  storeLocation?: CertificateStoreLocation;

  @doc("This property is applicable only for pools configured with Windows nodes (that is, created with cloudServiceConfiguration, or with virtualMachineConfiguration using a Windows image reference). Common store names include: My, Root, CA, Trust, Disallowed, TrustedPeople, TrustedPublisher, AuthRoot, AddressBook, but any custom store name can also be used. The default value is My.")
  storeName?: string;

  @doc("Which user accounts on the compute node should have access to the private data of the certificate.")
  visibility?: CertificateVisibility[];
}

@doc("Link to an application package inside the batch account")
model ApplicationPackageReference {
  @doc("The ID of the application package to install. This must be inside the same batch account as the pool. This can either be a reference to a specific version or the default version if one exists.")
  id: string;

  @doc("If this is omitted, and no default version is specified for this application, the request fails with the error code InvalidApplicationPackageReferences. If you are calling the REST API directly, the HTTP status code is 409.")
  version?: string;
}

@doc("Describes either the current operation (if the pool AllocationState is Resizing) or the previously completed operation (if the AllocationState is Steady).")
model ResizeOperationStatus {
  @doc("The desired number of dedicated compute nodes in the pool.")
  targetDedicatedNodes?: int32;

  @doc("The desired number of Spot/low-priority compute nodes in the pool.")
  targetLowPriorityNodes?: int32;

  @doc("The default value is 15 minutes. The minimum value is 5 minutes. If you specify a value less than 5 minutes, the Batch service returns an error; if you are calling the REST API directly, the HTTP status code is 400 (Bad Request).")
  resizeTimeout?: duration;

  @doc("The default value is requeue.")
  nodeDeallocationOption?: ComputeNodeDeallocationOption;

  @doc("The time when this resize operation was started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("This property is set only if an error occurred during the last pool resize, and only when the pool allocationState is Steady.")
  errors?: ResizeError[];
}

@doc("An error that occurred when resizing a pool.")
model ResizeError {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message: string;

  @doc("Additional details about the error.")
  details?: ResizeError[];
}

@doc("The file system to mount on each node.")
model MountConfiguration {
  @doc("This property is mutually exclusive with all other properties.")
  azureBlobFileSystemConfiguration?: AzureBlobFileSystemConfiguration;

  @doc("This property is mutually exclusive with all other properties.")
  nfsMountConfiguration?: NFSMountConfiguration;

  @doc("This property is mutually exclusive with all other properties.")
  cifsMountConfiguration?: CifsMountConfiguration;

  @doc("This property is mutually exclusive with all other properties.")
  azureFileShareConfiguration?: AzureFileShareConfiguration;
}

@doc("Information used to connect to an Azure Storage Container using Blobfuse.")
model AzureBlobFileSystemConfiguration {
  @doc("The Azure Storage Account name.")
  accountName: string;

  @doc("The Azure Blob Storage Container name.")
  containerName: string;

  @doc("This property is mutually exclusive with both sasKey and identity; exactly one must be specified.")
  accountKey?: string;

  @doc("This property is mutually exclusive with both accountKey and identity; exactly one must be specified.")
  sasKey?: string;

  @doc("These are 'net use' options in Windows and 'mount' options in Linux.")
  blobfuseOptions?: string;

  @doc("All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.")
  relativeMountPath: string;

  @doc("This property is mutually exclusive with both accountKey and sasKey; exactly one must be specified.")
  identityReference?: ComputeNodeIdentityReference;
}

@doc("Information used to connect to an NFS file system.")
model NFSMountConfiguration {
  @doc("The URI of the file system to mount.")
  source: string;

  @doc("All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.")
  relativeMountPath: string;

  @doc("These are 'net use' options in Windows and 'mount' options in Linux.")
  mountOptions?: string;
}

@doc("Information used to connect to a CIFS file system.")
model CifsMountConfiguration {
  @doc("The user to use for authentication against the CIFS file system.")
  userName: string;

  @doc("The URI of the file system to mount.")
  source: string;

  @doc("All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.")
  relativeMountPath: string;

  @doc("These are 'net use' options in Windows and 'mount' options in Linux.")
  mountOptions?: string;

  @doc("The password to use for authentication against the CIFS file system.")
  password: string;
}

@doc("Information used to connect to an Azure Fileshare.")
model AzureFileShareConfiguration {
  @doc("The Azure Storage account name.")
  accountName: string;

  @doc("This is of the form 'https://{account}.file.core.windows.net/'.")
  azureFileUrl: string;

  @doc("The Azure Storage account key.")
  accountKey: string;

  @doc("All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.")
  relativeMountPath: string;

  @doc("These are 'net use' options in Windows and 'mount' options in Linux.")
  mountOptions?: string;
}

@doc("The identity of the Batch pool, if configured. If the pool identity is updated during update an existing pool, only the new vms which are created after the pool shrinks to 0 will have the updated identities")
model BatchPoolIdentity {
  @doc("The type of identity used for the Batch Pool.")
  type: PoolIdentityType;

  @doc("The list of user identities associated with the Batch pool.")
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

@doc("Values returned by the List operation.")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("A collection of related endpoints from the same service for which the Batch service requires outbound access.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service that the Batch service connects to.")
  @visibility("read")
  category?: string;

  @doc("The endpoints for this service to which the Batch service makes outbound calls.")
  @visibility("read")
  endpoints?: EndpointDependency[];
}

@doc("A domain name and connection details used to access a dependency.")
model EndpointDependency {
  @doc("The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.")
  @visibility("read")
  domainName?: string;

  @doc("Human-readable supplemental information about the dependency and when it is applicable.")
  @visibility("read")
  description?: string;

  @doc("The list of connection details for this endpoint.")
  @visibility("read")
  endpointDetails?: EndpointDetail[];
}

@doc("Details about the connection between the Batch service and the endpoint.")
model EndpointDetail {
  @doc("The port an endpoint is connected to.")
  @visibility("read")
  port?: int32;
}
