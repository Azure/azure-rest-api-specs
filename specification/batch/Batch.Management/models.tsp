import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Batch;

/**
 * The container technology to be used.
 */
union ContainerType {
  string,

  /**
   * A Docker compatible container technology will be used to launch the containers.
   */
  DockerCompatible: "DockerCompatible",

  /**
   * A CRI based technology will be used to launch the containers.
   */
  CriCompatible: "CriCompatible",
}

/**
 * Specifies the EncryptionType of the managed disk. It is set to VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob. **Note**: It can be set for only Confidential VMs and required when using Confidential VMs.
 */
union SecurityEncryptionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NonPersistedTPM: "NonPersistedTPM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMGuestStateOnly: "VMGuestStateOnly",
}

/**
 * The paths which will be mounted to container task's container.
 */
union ContainerHostDataPath {
  string,

  /**
   * The path for multi-instances task to shared their files.
   */
  Shared: "Shared",

  /**
   * The path for start task.
   */
  Startup: "Startup",

  /**
   * The path contains all virtual file systems are mounted on this node.
   */
  VfsMounts: "VfsMounts",

  /**
   * The task path.
   */
  Task: "Task",

  /**
   * The job-prep task path.
   */
  JobPrep: "JobPrep",

  /**
   * The applications path.
   */
  Applications: "Applications",
}

/**
 * Type of issue
 */
union IssueType {
  string,

  /**
   * Unknown issue type
   */
  Unknown: "Unknown",

  /**
   * An error occurred while applying the network security perimeter (NSP) configuration.
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * A network connectivity issue is happening on the resource which could be addressed either by adding new resources to the network security perimeter (NSP) or by modifying access rules.
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * An managed identity hasn't been associated with the resource. The resource will still be able to validate inbound traffic from the network security perimeter (NSP) or matching inbound access rules, but it won't be able to perform outbound access as a member of the NSP.
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",
}

/**
 * Severity of the issue.
 */
union Severity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The authentication mode which the Batch service will use to manage the auto-storage account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoStorageAuthenticationMode {
  /**
   * The Batch service will authenticate requests to auto-storage using storage account keys.
   */
  StorageKeys,

  /**
   * The Batch service will authenticate requests to auto-storage using the managed identity assigned to the Batch account.
   */
  BatchAccountManagedIdentity,
}

/**
 * The allocation mode for creating pools in the Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PoolAllocationMode {
  /**
   * Pools will be allocated in subscriptions owned by the Batch service.
   */
  BatchService,

  /**
   * Pools will be allocated in a subscription owned by the user.
   */
  UserSubscription,
}

/**
 * The network access type for operating on the resources in the Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PublicNetworkAccessType {
  /**
   * Enables connectivity to Azure Batch through public DNS.
   */
  Enabled,

  /**
   * Disables public connectivity and enables private connectivity to Azure Batch Service through private endpoint resource.
   */
  Disabled,

  /**
   * Secures connectivity to Azure Batch through NSP configuration.
   */
  SecuredByPerimeter,
}

/**
 * Default action for endpoint access. It is only applicable when publicNetworkAccess is enabled.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum EndpointAccessDefaultAction {
  /**
   * Allow client access.
   */
  Allow,

  /**
   * Deny client access.
   */
  Deny,
}

/**
 * Type of the key source.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeySource {
  /**
   * Batch creates and manages the encryption keys used to protect the account data.
   */
  `Microsoft.Batch`,

  /**
   * The encryption keys used to protect the account data are stored in an external key vault. If this is set then the Batch Account identity must be set to `SystemAssigned` and a valid Key Identifier must also be supplied under the keyVaultProperties.
   */
  `Microsoft.KeyVault`,
}

/**
 * The authentication mode for the Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AuthenticationMode {
  /**
   * The authentication mode using shared keys.
   */
  SharedKey,

  /**
   * The authentication mode using Microsoft Entra ID.
   */
  AAD,

  /**
   * The authentication mode using task authentication tokens.
   */
  TaskAuthenticationToken,
}

/**
 * The type of identity used for the Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  /**
   * Batch account has a system assigned identity with it.
   */
  SystemAssigned,

  /**
   * Batch account has user assigned identities with it.
   */
  UserAssigned,

  /**
   * Batch account has no identity associated with it. Setting `None` in update account will remove existing identities.
   */
  None,
}

/**
 * The provisioned state of the resource
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProvisioningState {
  /**
   * The account is in an invalid state.
   */
  Invalid,

  /**
   * The account is being created.
   */
  Creating,

  /**
   * The account is being deleted.
   */
  Deleting,

  /**
   * The account has been created and is ready for use.
   */
  Succeeded,

  /**
   * The last operation for the account is failed.
   */
  Failed,

  /**
   * The last operation for the account is cancelled.
   */
  Cancelled,
}

/**
 * The provisioning state of the private endpoint connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PrivateEndpointConnectionProvisioningState {
  /**
   * The connection is creating.
   */
  Creating,

  /**
   * The user has requested that the connection status be updated, but the update operation has not yet completed. You may not reference the connection when connecting the Batch account.
   */
  Updating,

  /**
   * The connection is deleting.
   */
  Deleting,

  /**
   * The connection status is final and is ready for use if Status is Approved.
   */
  Succeeded,

  /**
   * The user requested that the connection be updated and it failed. You may retry the update operation.
   */
  Failed,

  /**
   * The user has cancelled the connection creation.
   */
  Cancelled,
}

/**
 * The status of the Batch private endpoint connection
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PrivateLinkServiceConnectionStatus {
  /**
   * The private endpoint connection is approved and can be used to access Batch account
   */
  Approved,

  /**
   * The private endpoint connection is pending and cannot be used to access Batch account
   */
  Pending,

  /**
   * The private endpoint connection is rejected and cannot be used to access Batch account
   */
  Rejected,

  /**
   * The private endpoint connection is disconnected and cannot be used to access Batch account
   */
  Disconnected,
}

/**
 * The type of account key to regenerate.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AccountKeyType {
  /**
   * The primary account key.
   */
  Primary,

  /**
   * The secondary account key.
   */
  Secondary,
}

/**
 * The current state of the application package.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PackageState {
  /**
   * The application package has been created but has not yet been activated.
   */
  Pending,

  /**
   * The application package is ready for use.
   */
  Active,
}

/**
 * Gets the reason that a Batch account name could not be used. The Reason element is only returned if NameAvailable is false.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum NameAvailabilityReason {
  /**
   * The requested name is invalid.
   */
  Invalid,

  /**
   * The requested name is already in use.
   */
  AlreadyExists,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateProvisioningState {
  /**
   * The certificate is available for use in pools.
   */
  Succeeded,

  /**
   * The user has requested that the certificate be deleted, but the delete operation has not yet completed. You may not reference the certificate when creating or updating pools.
   */
  Deleting,

  /**
   * The user requested that the certificate be deleted, but there are pools that still have references to the certificate, or it is still installed on one or more compute nodes. (The latter can occur if the certificate has been removed from the pool, but the node has not yet restarted. Nodes refresh their certificates only when they restart.) You may use the cancel certificate delete operation to cancel the delete, or the delete certificate operation to retry the delete.
   */
  Failed,
}

/**
 * The format of the certificate - either Pfx or Cer. If omitted, the default is Pfx.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateFormat {
  /**
   * The certificate is a PFX (PKCS#12) formatted certificate or certificate chain.
   */
  Pfx,

  /**
   * The certificate is a base64-encoded X.509 certificate.
   */
  Cer,
}

/**
 * The current state of the pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PoolProvisioningState {
  /**
   * The pool is available to run tasks subject to the availability of compute nodes.
   */
  Succeeded,

  /**
   * The user has requested that the pool be deleted, but the delete operation has not yet completed.
   */
  Deleting,
}

/**
 * Whether the pool is resizing.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AllocationState {
  /**
   * The pool is not resizing. There are no changes to the number of nodes in the pool in progress. A pool enters this state when it is created and when no operations are being performed on the pool to change the number of nodes.
   */
  Steady,

  /**
   * The pool is resizing; that is, compute nodes are being added to or removed from the pool.
   */
  Resizing,

  /**
   * The pool was resizing, but the user has requested that the resize be stopped, but the stop request has not yet been completed.
   */
  Stopping,
}

/**
 * The type of caching to enable for the disk.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CachingType {
  /**
   * The caching mode for the disk is not enabled.
   */
  None,

  /**
   * The caching mode for the disk is read only.
   */
  ReadOnly,

  /**
   * The caching mode for the disk is read and write.
   */
  ReadWrite,
}

/**
 * The storage account type for use in creating data disks or OS disk.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StorageAccountType {
  /**
   * The data disk / OS disk should use standard locally redundant storage.
   */
  Standard_LRS,

  /**
   * The data disk / OS disk should use premium locally redundant storage.
   */
  Premium_LRS,

  /**
   * The data disk / OS disk should use standard SSD locally redundant storage.
   */
  StandardSSD_LRS,
}

/**
 * If omitted, no disks on the compute nodes in the pool will be encrypted.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("The disks to encrypt on each compute node.")
enum DiskEncryptionTarget {
  /**
   * The OS Disk on the compute node is encrypted.
   */
  OsDisk,

  /**
   * The temporary disk on the compute node is encrypted. On Linux this encryption applies to other partitions (such as those on mounted data disks) when encryption occurs at boot time.
   */
  TemporaryDisk,
}

/**
 * The default value is regional.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum NodePlacementPolicyType {
  /**
   * All nodes in the pool will be allocated in the same region.
   */
  Regional,

  /**
   * Nodes in the pool will be spread across different zones with best effort balancing.
   */
  Zonal,
}

/**
 * Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SecurityTypes {
  /**
   * Trusted launch protects against advanced and persistent attack techniques.
   */
  trustedLaunch,

  /**
   * Azure confidential computing offers confidential VMs are for tenants with high security and confidentiality requirements. These VMs provide a strong, hardware-enforced boundary to help meet your security needs. You can use confidential VMs for migrations without making changes to your code, with the platform protecting your VM's state from being read or modified.
   */
  confidentialVM,
}

/**
 * Determines what to do with a node and its running task(s) after it has been selected for deallocation.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ComputeNodeDeallocationOption {
  /**
   * Terminate running task processes and requeue the tasks. The tasks will run again when a node is available. Remove nodes as soon as tasks have been terminated.
   */
  Requeue,

  /**
   * Terminate running tasks. The tasks will be completed with failureInfo indicating that they were terminated, and will not run again. Remove nodes as soon as tasks have been terminated.
   */
  Terminate,

  /**
   * Allow currently running tasks to complete. Schedule no new tasks while waiting. Remove nodes when all tasks have completed.
   */
  TaskCompletion,

  /**
   * Deprecated, we encourage you to upload task data to Azure Storage in your task and use `TaskCompletion` instead. Allow currently running tasks to complete, then wait for all task data retention periods to expire. Schedule no new tasks while waiting. Remove nodes when all task retention periods have expired.
   */
  RetainedData,
}

/**
 * This imposes restrictions on which nodes can be assigned to the pool. Enabling this value can reduce the chance of the requested number of nodes to be allocated in the pool. If not specified, this value defaults to 'Disabled'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum InterNodeCommunicationState {
  /**
   * Enable network communication between virtual machines.
   */
  Enabled,

  /**
   * Disable network communication between virtual machines.
   */
  Disabled,
}

/**
 * The scope of dynamic vnet assignment.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DynamicVNetAssignmentScope {
  /**
   * No dynamic VNet assignment is enabled.
   */
  none,

  /**
   * Dynamic VNet assignment is done per-job. If this value is set, the network configuration subnet ID must also be set. This feature requires approval before use, please contact support
   */
  job,
}

/**
 * The protocol of the endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum InboundEndpointProtocol {
  /**
   * Use TCP for the endpoint.
   */
  TCP,

  /**
   * Use UDP for the endpoint.
   */
  UDP,
}

/**
 * The action that should be taken for a specified IP address, subnet range or tag.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum NetworkSecurityGroupRuleAccess {
  /**
   * Allow access.
   */
  Allow,

  /**
   * Deny access.
   */
  Deny,
}

/**
 * The provisioning type for Public IP Addresses for the Batch Pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IPAddressProvisioningType {
  /**
   * A public IP will be created and managed by Batch. There may be multiple public IPs depending on the size of the Pool.
   */
  BatchManaged,

  /**
   * Public IPs are provided by the user and will be used to provision the Compute Nodes.
   */
  UserManaged,

  /**
   * No public IP Address will be created for the Compute Nodes in the Pool.
   */
  NoPublicIPAddresses,
}

/**
 * How tasks should be distributed across compute nodes.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ComputeNodeFillType {
  /**
   * Tasks should be assigned evenly across all nodes in the pool.
   */
  Spread,

  /**
   * As many tasks as possible (taskSlotsPerNode) should be assigned to each node in the pool before any tasks are assigned to the next node in the pool.
   */
  Pack,
}

/**
 * The elevation level of the user.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ElevationLevel {
  /**
   * The user is a standard user without elevated access.
   */
  NonAdmin,

  /**
   * The user is a user with elevated access and operates with full Administrator permissions.
   */
  Admin,
}

/**
 * Specifies login mode for the user. The default value is Interactive.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum LoginMode {
  /**
   * The LOGON32_LOGON_BATCH Win32 login mode. The batch login mode is recommended for long running parallel processes.
   */
  Batch,

  /**
   * The LOGON32_LOGON_INTERACTIVE Win32 login mode. Some applications require having permissions associated with the interactive login mode. If this is the case for an application used in your task, then this option is recommended.
   */
  Interactive,
}

/**
 * The default value is Pool. If the pool is running Windows a value of Task should be specified if stricter isolation between tasks is required. For example, if the task mutates the registry in a way which could impact other tasks, or if certificates have been specified on the pool which should not be accessible by normal tasks but should be accessible by start tasks.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoUserScope {
  /**
   * Specifies that the service should create a new user for the task.
   */
  Task,

  /**
   * Specifies that the task runs as the common auto user account which is created on every node in a pool.
   */
  Pool,
}

/**
 * A flag to indicate where the container task working directory is. The default is 'taskWorkingDirectory'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ContainerWorkingDirectory {
  /**
   * Use the standard Batch service task working directory, which will contain the Task resource files populated by Batch.
   */
  TaskWorkingDirectory,

  /**
   * Using container image defined working directory. Beware that this directory will not contain the resource files downloaded by Batch.
   */
  ContainerImageDefault,
}

/**
 * The default value is currentUser. This property is applicable only for pools configured with Windows compute nodes. For Linux compute nodes, the certificates are stored in a directory inside the task working directory and an environment variable AZ_BATCH_CERTIFICATES_DIR is supplied to the task to query for this location. For certificates with visibility of 'remoteUser', a 'certs' directory is created in the user's home directory (e.g., /home/{user-name}/certs) and certificates are placed in that directory.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateStoreLocation {
  /**
   * Certificates should be installed to the CurrentUser certificate store.
   */
  CurrentUser,

  /**
   * Certificates should be installed to the LocalMachine certificate store.
   */
  LocalMachine,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateVisibility {
  /**
   * The certificate should be visible to the user account under which the start task is run. Note that if AutoUser Scope is Pool for both the StartTask and a Task, this certificate will be visible to the Task as well.
   */
  StartTask,

  /**
   * The certificate should be visible to the user accounts under which job tasks are run.
   */
  Task,

  /**
   * The certificate should be visible to the user accounts under which users remotely access the node.
   */
  RemoteUser,
}

/**
 * Determines how a pool communicates with the Batch service.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum NodeCommunicationMode {
  /**
   * The node communication mode is automatically set by the Batch service.
   */
  Default,

  /**
   * Nodes using the Classic communication mode require inbound TCP communication on ports 29876 and 29877 from the "BatchNodeManagement.{region}" service tag and outbound TCP communication on port 443 to the "Storage.region" and "BatchNodeManagement.{region}" service tags.
   */
  Classic,

  /**
   * Nodes using the Simplified communication mode require outbound TCP communication on port 443 to the "BatchNodeManagement.{region}" service tag. No open inbound ports are required.
   */
  Simplified,
}

/**
 * Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the scale set are automatically updated at the same time.<br /><br /> **Rolling** - Scale set performs updates in batches with an optional pause time in between.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum UpgradeMode {
  /**
   * All virtual machines in the scale set are automatically updated at the same time.
   */
  automatic,

  /**
   * You control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.
   */
  manual,

  /**
   * The existing instances in a scale set are brought down in batches to be upgraded. Once the upgraded batch is complete, the instances will begin taking traffic again and the next batch will begin. This continues until all instances brought up-to-date.
   */
  rolling,
}

/**
 * The type of identity used for the Batch Pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PoolIdentityType {
  /**
   * Batch pool has user assigned identities with it.
   */
  UserAssigned,

  /**
   * Batch pool has no identity associated with it. Setting `None` in update pool will remove existing identities.
   */
  None,
}

/**
 * Parameters supplied to the Create operation.
 */
model BatchAccountCreateParameters {
  /**
   * The region in which to create the account.
   */
  location: string;

  /**
   * The user-specified tags associated with the account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties of the Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BatchAccountCreateProperties;

  /**
   * The identity of the Batch account.
   */
  identity?: BatchAccountIdentity;
}

/**
 * The properties of a Batch account.
 */
model BatchAccountCreateProperties {
  /**
   * The properties related to the auto-storage account.
   */
  autoStorage?: AutoStorageBaseProperties;

  /**
   * The pool allocation mode also affects how clients may authenticate to the Batch Service API. If the mode is BatchService, clients may authenticate using access keys or Microsoft Entra ID. If the mode is UserSubscription, clients must use Microsoft Entra ID. The default is BatchService.
   */
  @summary("The allocation mode to use for creating pools in the Batch account.")
  poolAllocationMode?: PoolAllocationMode;

  /**
   * A reference to the Azure key vault associated with the Batch account.
   */
  keyVaultReference?: KeyVaultReference;

  /**
   * The network access type for operating on the resources in the Batch account.
   */
  @summary("The network access type for accessing Azure Batch account.")
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The network profile only takes effect when publicNetworkAccess is enabled.
   */
  @summary("Network profile for Batch account, which contains network rule settings for each endpoint.")
  networkProfile?: NetworkProfile;

  /**
   * Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.
   */
  @summary("The encryption configuration for the Batch account.")
  encryption?: EncryptionProperties;

  /**
   * List of allowed authentication modes for the Batch account that can be used to authenticate with the data plane. This does not affect authentication with the control plane.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowedAuthenticationModes?: AuthenticationMode[] | null;
}

/**
 * The properties related to the auto-storage account.
 */
model AutoStorageBaseProperties {
  /**
   * The resource ID of the storage account to be used for auto-storage account.
   */
  storageAccountId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The authentication mode which the Batch service will use to manage the auto-storage account.
   */
  authenticationMode?: AutoStorageAuthenticationMode = AutoStorageAuthenticationMode.StorageKeys;

  /**
   * The identity referenced here must be assigned to pools which have compute nodes that need access to auto-storage.
   */
  @summary("The reference to the user assigned identity which compute nodes will use to access auto-storage.")
  nodeIdentityReference?: ComputeNodeIdentityReference;
}

/**
 * The reference to a user assigned identity associated with the Batch pool which a compute node will use.
 */
model ComputeNodeIdentityReference {
  /**
   * The ARM resource id of the user assigned identity.
   */
  resourceId?: string;
}

/**
 * Identifies the Azure key vault associated with a Batch account.
 */
model KeyVaultReference {
  /**
   * The resource ID of the Azure key vault associated with the Batch account.
   */
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * The URL of the Azure key vault associated with the Batch account.
   */
  url: string;
}

/**
 * Network profile for Batch account, which contains network rule settings for each endpoint.
 */
model NetworkProfile {
  /**
   * Network access profile for batchAccount endpoint (Batch account data plane API).
   */
  accountAccess?: EndpointAccessProfile;

  /**
   * Network access profile for nodeManagement endpoint (Batch service managing compute nodes for Batch pools).
   */
  nodeManagementAccess?: EndpointAccessProfile;
}

/**
 * Network access profile for Batch endpoint.
 */
model EndpointAccessProfile {
  /**
   * Default action for endpoint access. It is only applicable when publicNetworkAccess is enabled.
   */
  @summary("The default action when there is no IPRule matched.")
  defaultAction: EndpointAccessDefaultAction;

  /**
   * Array of IP ranges to filter client IP address.
   */
  @identifiers(#["action"])
  ipRules?: IPRule[];
}

/**
 * The action when client IP address is matched.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IPRuleAction {
  /**
   * Allow access for the matched client IP address.
   */
  Allow: "Allow",
}
/**
 * Rule to filter client IP address.
 */
model IPRule {
  /**
   * Action when client IP address is matched.
   */
  action: IPRuleAction;

  /**
   * IPv4 address, or IPv4 address range in CIDR format.
   */
  @summary("The IP address or IP address range to filter")
  value: string;
}

/**
 * Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.
 */
model EncryptionProperties {
  /**
   * Type of the key source.
   */
  keySource?: KeySource;

  /**
   * Additional details when using Microsoft.KeyVault
   */
  keyVaultProperties?: KeyVaultProperties;
}

/**
 * KeyVault configuration when using an encryption KeySource of Microsoft.KeyVault.
 */
model KeyVaultProperties {
  /**
   * Full path to the secret with or without version. Example https://mykeyvault.vault.azure.net/keys/testkey/6e34a81fef704045975661e297a4c053. or https://mykeyvault.vault.azure.net/keys/testkey. To be usable the following prerequisites must be met:
   *
   *  The Batch Account has a System Assigned identity
   *  The account identity has been granted Key/Get, Key/Unwrap and Key/Wrap permissions
   *  The KeyVault has soft-delete and purge protection enabled
   */
  keyIdentifier?: string;
}

/**
 * The identity of the Batch account, if configured. This is used when the user specifies 'Microsoft.KeyVault' as their Batch account encryption configuration or when `ManagedIdentity` is selected as the auto-storage authentication mode.
 */
model BatchAccountIdentity {
  /**
   * The principal id of the Batch account. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the Batch account. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the Batch account.
   */
  type: ResourceIdentityType;

  /**
   * The list of user identities associated with the Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

/**
 * The list of associated user identities.
 */
model UserAssignedIdentities {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Account specific properties.
 */
model BatchAccountProperties {
  /**
   * The account endpoint used to interact with the Batch service.
   */
  @visibility(Lifecycle.Read)
  accountEndpoint?: string;

  /**
   * The endpoint used by compute node to connect to the Batch node management service.
   */
  @visibility(Lifecycle.Read)
  nodeManagementEndpoint?: string;

  /**
   * The provisioned state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The allocation mode for creating pools in the Batch account.
   */
  @visibility(Lifecycle.Read)
  @summary("The allocation mode to use for creating pools in the Batch account.")
  poolAllocationMode?: PoolAllocationMode;

  /**
   * Identifies the Azure key vault associated with a Batch account.
   */
  @visibility(Lifecycle.Read)
  @summary("A reference to the Azure key vault associated with the Batch account.")
  keyVaultReference?: KeyVaultReference;

  /**
   * The network access type for operating on the resources in the Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("The network interface type for accessing Azure Batch service and Batch account operations.")
  publicNetworkAccess?: PublicNetworkAccessType | null = PublicNetworkAccessType.Enabled;

  /**
   * The network profile only takes effect when publicNetworkAccess is enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Network profile for Batch account, which contains network rule settings for each endpoint.")
  networkProfile?: NetworkProfile | null;

  /**
   * List of private endpoint connections associated with the Batch account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[] | null;

  /**
   * Contains information about the auto-storage account associated with a Batch account.
   */
  @visibility(Lifecycle.Read)
  @summary("The properties and status of any auto-storage account associated with the Batch account.")
  autoStorage?: AutoStorageProperties;

  /**
   * Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.
   */
  @visibility(Lifecycle.Read)
  @summary("The encryption configuration for the Batch account.")
  encryption?: EncryptionProperties;

  /**
   * For accounts with PoolAllocationMode set to UserSubscription, quota is managed on the subscription so this value is not returned.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @summary("The dedicated core quota for the Batch account.")
  dedicatedCoreQuota?: int32 | null;

  /**
   * For accounts with PoolAllocationMode set to UserSubscription, quota is managed on the subscription so this value is not returned.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @summary("The Spot/low-priority core quota for the Batch account.")
  lowPriorityCoreQuota?: int32 | null;

  /**
   * A list of the dedicated core quota per Virtual Machine family for the Batch account. For accounts with PoolAllocationMode set to UserSubscription, quota is managed on the subscription so this value is not returned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dedicatedCoreQuotaPerVMFamily?: VirtualMachineFamilyCoreQuota[] | null;

  /**
   * If this flag is true, dedicated core quota is enforced via both the dedicatedCoreQuotaPerVMFamily and dedicatedCoreQuota properties on the account. If this flag is false, dedicated core quota is enforced only via the dedicatedCoreQuota property on the account and does not consider Virtual Machine family.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @summary("A value indicating whether core quotas per Virtual Machine family are enforced for this account")
  dedicatedCoreQuotaPerVMFamilyEnforced?: boolean;

  /**
   * The pool quota for the Batch account.
   */
  @visibility(Lifecycle.Read)
  poolQuota?: int32;

  /**
   * The active job and job schedule quota for the Batch account.
   */
  @visibility(Lifecycle.Read)
  activeJobAndJobScheduleQuota?: int32;

  /**
   * List of allowed authentication modes for the Batch account that can be used to authenticate with the data plane. This does not affect authentication with the control plane.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  allowedAuthenticationModes?: AuthenticationMode[] | null;
}

/**
 * Private endpoint connection properties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The provisioning state of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  /**
   * The private endpoint of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  @summary("The ARM resource identifier of the private endpoint.")
  privateEndpoint?: PrivateEndpoint;

  /**
   * The value has one and only one group id.
   */
  @summary("The group id of the private endpoint connection.")
  @visibility(Lifecycle.Read)
  groupIds?: string[];

  /**
   * The private link service connection state of the private endpoint connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * The private endpoint of the private endpoint connection.
 */
model PrivateEndpoint {
  /**
   * The ARM resource identifier of the private endpoint. This is of the form /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Network/privateEndpoints/{privateEndpoint}.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The private link service connection state of the private endpoint connection
 */
model PrivateLinkServiceConnectionState {
  /**
   * The status of the Batch private endpoint connection
   */
  status: PrivateLinkServiceConnectionStatus;

  /**
   * Description of the private Connection state
   */
  description?: string;

  /**
   * Action required on the private connection state
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * A definition of an Azure resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
model AzureProxyResource {
  /**
   * The ID of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Contains information about the auto-storage account associated with a Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoStorageProperties extends AutoStorageBaseProperties {
  /**
   * The UTC time at which storage keys were last synchronized with the Batch account.
   */
  lastKeySync: utcDateTime;
}

/**
 * A VM Family and its associated core quota for the Batch account.
 */
model VirtualMachineFamilyCoreQuota {
  /**
   * The Virtual Machine family name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The core quota for the VM family for the Batch account.
   */
  @visibility(Lifecycle.Read)
  coreQuota?: int32;
}

/**
 * An error response from the Batch service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * The body of the error response.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Batch service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#["message", "target"])
  details?: CloudErrorBody[];
}

/**
 * Parameters for updating an Azure Batch account.
 */
model BatchAccountUpdateParameters {
  /**
   * The user-specified tags associated with the account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties of the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BatchAccountUpdateProperties;

  /**
   * The identity of the Batch account.
   */
  identity?: BatchAccountIdentity;
}

/**
 * The properties of a Batch account.
 */
model BatchAccountUpdateProperties {
  /**
   * The properties related to the auto-storage account.
   */
  autoStorage?: AutoStorageBaseProperties;

  /**
   * Configures how customer data is encrypted inside the Batch account. By default, accounts are encrypted using a Microsoft managed key. For additional control, a customer-managed key can be used instead.
   */
  @summary("The encryption configuration for the Batch account.")
  encryption?: EncryptionProperties;

  /**
   * List of allowed authentication modes for the Batch account that can be used to authenticate with the data plane. This does not affect authentication with the control plane.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowedAuthenticationModes?: AuthenticationMode[] | null;

  /**
   * The network access type for operating on the resources in the Batch account.
   */
  @summary("The network access type for accessing Azure Batch account.")
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The network profile only takes effect when publicNetworkAccess is enabled.
   */
  @summary("Network profile for Batch account, which contains network rule settings for each endpoint.")
  networkProfile?: NetworkProfile;
}

/**
 * Parameters supplied to the RegenerateKey operation.
 */
model BatchAccountRegenerateKeyParameters {
  /**
   * The type of account key to regenerate.
   */
  keyName: AccountKeyType;
}

/**
 * A set of Azure Batch account keys.
 */
model BatchAccountKeys {
  /**
   * The Batch account name.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * The primary key associated with the account.
   */
  @visibility(Lifecycle.Read)
  primary?: string;

  /**
   * The secondary key associated with the account.
   */
  @visibility(Lifecycle.Read)
  secondary?: string;
}

/**
 * Parameters for an activating an application package.
 */
model ActivateApplicationPackageParameters {
  /**
   * The format of the application package binary file.
   */
  format: string;
}

/**
 * Properties of an application package
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationPackageProperties {
  /**
   * The current state of the application package.
   */
  @visibility(Lifecycle.Read)
  state?: PackageState;

  /**
   * The format of the application package, if the package is active.
   */
  @visibility(Lifecycle.Read)
  format?: string;

  /**
   * The URL for the application package in Azure Storage.
   */
  @visibility(Lifecycle.Read)
  storageUrl?: string;

  /**
   * The UTC time at which the Azure Storage URL will expire.
   */
  @visibility(Lifecycle.Read)
  storageUrlExpiry?: utcDateTime;

  /**
   * The time at which the package was last activated, if the package is active.
   */
  @visibility(Lifecycle.Read)
  lastActivationTime?: utcDateTime;
}

/**
 * The properties associated with the Application.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationProperties {
  /**
   * The display name for the application.
   */
  displayName?: string;

  /**
   * A value indicating whether packages within the application may be overwritten using the same version string.
   */
  allowUpdates?: boolean;

  /**
   * The package to use if a client requests the application but does not specify a version. This property can only be set to the name of an existing package.
   */
  defaultVersion?: string;
}

/**
 * The result of performing list applications.
 */
model ListApplicationsResult is Azure.Core.Page<Application>;

/**
 * The result of performing list application packages.
 */
model ListApplicationPackagesResult is Azure.Core.Page<ApplicationPackage>;

/**
 * Quotas associated with a Batch region for a particular subscription.
 */
model BatchLocationQuota {
  /**
   * The number of Batch accounts that may be created under the subscription in the specified region.
   */
  @visibility(Lifecycle.Read)
  accountQuota?: int32;
}

/**
 * The Batch List supported SKUs operation response.
 */
model SupportedSkusResult is Azure.Core.Page<SupportedSku>;

/**
 * Describes a Batch supported SKU.
 */
model SupportedSku {
  /**
   * The name of the SKU.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The family name of the SKU.
   */
  @visibility(Lifecycle.Read)
  familyName?: string;

  /**
   * A collection of capabilities which this SKU supports.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  capabilities?: SkuCapability[];

  /**
   * The time when Azure Batch service will retire this SKU.
   */
  @visibility(Lifecycle.Read)
  batchSupportEndOfLife?: utcDateTime;
}

/**
 * A SKU capability, such as the number of cores.
 */
model SkuCapability {
  /**
   * The name of the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The value of the feature.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * A REST API operation
 */
model Operation {
  /**
   * This is of the format {provider}/{resource}/{operation}
   */
  @summary("The operation name.")
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The object that describes the operation.
   */
  display?: OperationDisplay;

  /**
   * The intended executor of the operation.
   */
  origin?: string;

  /**
   * Properties of the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

/**
 * The object that describes the operation.
 */
model OperationDisplay {
  /**
   * Friendly name of the resource provider.
   */
  provider?: string;

  /**
   * For example: read, write, delete, or listKeys/action
   */
  @summary("The operation type.")
  operation?: string;

  /**
   * The resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * The friendly name of the operation
   */
  description?: string;
}

/**
 * The result of the request to list operations.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceType {
  /**
   * The resource type for Microsoft.Batch/batchAccounts
   */
  MicrosoftBatchBatchAccounts: "Microsoft.Batch/batchAccounts",
}

/**
 * Parameters for a check name availability request.
 */
model CheckNameAvailabilityParameters {
  /**
   * The name to check for availability
   */
  name: string;

  /**
   * The resource type.
   */
  type: ResourceType;
}

/**
 * The CheckNameAvailability operation response.
 */
model CheckNameAvailabilityResult {
  /**
   * Gets a boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or invalid and cannot be used.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * Gets the reason that a Batch account name could not be used. The Reason element is only returned if NameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  reason?: NameAvailabilityReason;

  /**
   * Gets an error message explaining the Reason value in more detail.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Values returned by the List operation.
 */
model ListCertificatesResult is Azure.Core.Page<Certificate>;

/**
 * Certificate properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificateProperties extends CertificateBaseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("The provisioned state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: CertificateProvisioningState;

  /**
   * The time at which the certificate entered its current state.
   */
  @visibility(Lifecycle.Read)
  provisioningStateTransitionTime?: utcDateTime;

  /**
   * The previous provisioned state of the resource
   */
  @visibility(Lifecycle.Read)
  previousProvisioningState?: CertificateProvisioningState;

  /**
   * The time at which the certificate entered its previous state.
   */
  @visibility(Lifecycle.Read)
  previousProvisioningStateTransitionTime?: utcDateTime;

  /**
   * The public key of the certificate.
   */
  @visibility(Lifecycle.Read)
  publicData?: string;

  /**
   * This is only returned when the certificate provisioningState is 'Failed'.
   */
  @visibility(Lifecycle.Read)
  @summary("The error which occurred while deleting the certificate")
  deleteCertificateError?: DeleteCertificateError;
}

/**
 * An error response from the Batch service.
 */
model DeleteCertificateError {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#["code"])
  details?: DeleteCertificateError[];
}

/**
 * Base certificate properties.
 */
model CertificateBaseProperties {
  /**
   * This must match the first portion of the certificate name. Currently required to be 'SHA1'.
   */
  @summary("The algorithm of the certificate thumbprint.")
  thumbprintAlgorithm?: string;

  /**
   * This must match the thumbprint from the name.
   */
  @summary("The thumbprint of the certificate.")
  thumbprint?: string;

  /**
   * The format of the certificate - either Pfx or Cer. If omitted, the default is Pfx.
   */
  format?: CertificateFormat;
}

/**
 * Contains information about a certificate.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificateCreateOrUpdateParameters extends AzureProxyResource {
  /**
   * The properties associated with the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CertificateCreateOrUpdateProperties;
}

/**
 * Certificate properties for create operations
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificateCreateOrUpdateProperties extends CertificateBaseProperties {
  /**
   * The maximum size is 10KB.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  @summary("The base64-encoded contents of the certificate.")
  data: string;

  /**
   * This must not be specified if the certificate format is Cer.
   */
  @summary("The password to access the certificate's private key.")
  @secret
  password?: string;
}

/**
 * Detector response properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DetectorResponseProperties {
  /**
   * A base64 encoded string that represents the content of a detector.
   */
  value?: string;
}

/**
 * Values returned by the List operation.
 */
model ListPrivateLinkResourcesResult is Azure.Core.Page<PrivateLinkResource>;

/**
 * Private link resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * The group id is used to establish the private link connection.
   */
  @summary("The group id of the private link resource.")
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The list of required members that are used to establish the private link connection.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The list of required zone names for the private DNS resource name
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * Values returned by the List operation.
 */
model ListPrivateEndpointConnectionsResult
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * Values returned by the List operation.
 */
model ListPoolsResult is Azure.Core.Page<Pool>;

/**
 * Pool properties.
 */
model PoolProperties {
  /**
   * The display name need not be unique and can contain any Unicode characters up to a maximum length of 1024.
   */
  @summary("The display name for the pool.")
  displayName?: string;

  /**
   * This is the last time at which the pool level data, such as the targetDedicatedNodes or autoScaleSettings, changed. It does not factor in node-level changes such as a compute node changing state.
   */
  @visibility(Lifecycle.Read)
  @summary("The last modified time of the pool.")
  lastModified?: utcDateTime;

  /**
   * The creation time of the pool.
   */
  @visibility(Lifecycle.Read)
  creationTime?: utcDateTime;

  /**
   * The current state of the pool.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PoolProvisioningState;

  /**
   * The time at which the pool entered its current state.
   */
  @visibility(Lifecycle.Read)
  provisioningStateTransitionTime?: utcDateTime;

  /**
   * Whether the pool is resizing.
   */
  @visibility(Lifecycle.Read)
  allocationState?: AllocationState;

  /**
   * The time at which the pool entered its current allocation state.
   */
  @visibility(Lifecycle.Read)
  allocationStateTransitionTime?: utcDateTime;

  /**
   * For information about available VM sizes, see Sizes for Virtual Machines in Azure (https://learn.microsoft.com/azure/virtual-machines/sizes/overview). Batch supports all Azure VM sizes except STANDARD_A0 and those with premium storage (STANDARD_GS, STANDARD_DS, and STANDARD_DSV2 series).
   */
  @summary("The size of virtual machines in the pool. All VMs in a pool are the same size.")
  vmSize?: string;

  /**
   * Deployment configuration properties.
   */
  @summary("This property describes the virtual machines that the pool nodes will be deployed on.")
  deploymentConfiguration?: DeploymentConfiguration;

  /**
   * The number of dedicated compute nodes currently in the pool.
   */
  @visibility(Lifecycle.Read)
  currentDedicatedNodes?: int32;

  /**
   * The number of Spot/low-priority compute nodes currently in the pool.
   */
  @visibility(Lifecycle.Read)
  currentLowPriorityNodes?: int32;

  /**
   * Defines the desired size of the pool. This can either be 'fixedScale' where the requested targetDedicatedNodes is specified, or 'autoScale' which defines a formula which is periodically reevaluated. If this property is not specified, the pool will have a fixed scale with 0 targetDedicatedNodes.
   */
  @summary("Settings which configure the number of nodes in the pool.")
  scaleSettings?: ScaleSettings;

  /**
   * This property is set only if the pool automatically scales, i.e. autoScaleSettings are used.
   */
  @summary("The results and errors from the last execution of the autoscale formula.")
  @visibility(Lifecycle.Read)
  autoScaleRun?: AutoScaleRun;

  /**
   * This imposes restrictions on which nodes can be assigned to the pool. Enabling this value can reduce the chance of the requested number of nodes to be allocated in the pool. If not specified, this value defaults to 'Disabled'.
   */
  @summary("Whether the pool permits direct communication between nodes.")
  interNodeCommunication?: InterNodeCommunicationState;

  /**
   * The network configuration for a pool.
   */
  @summary("The network configuration for the pool.")
  networkConfiguration?: NetworkConfiguration;

  /**
   * The default value is 1. The maximum value is the smaller of 4 times the number of cores of the vmSize of the pool or 256.
   */
  @summary("The number of task slots that can be used to run concurrent tasks on a single compute node in the pool.")
  taskSlotsPerNode?: int32 = 1;

  /**
   * If not specified, the default is spread.
   */
  @summary("How tasks are distributed across compute nodes in a pool.")
  taskSchedulingPolicy?: TaskSchedulingPolicy;

  /**
   * The list of user accounts to be created on each node in the pool.
   */
  @identifiers(#["name"])
  userAccounts?: UserAccount[];

  /**
   * The Batch service does not assign any meaning to metadata; it is solely for the use of user code.
   */
  @summary("A list of name-value pairs associated with the pool as metadata.")
  @identifiers(#["name"])
  metadata?: MetadataItem[];

  /**
   * In an PATCH (update) operation, this property can be set to an empty object to remove the start task from the pool.
   */
  @summary("A task specified to run on each compute node as it joins the pool.")
  startTask?: StartTask;

  /**
   * For Windows compute nodes, the Batch service installs the certificates to the specified certificate store and location. For Linux compute nodes, the certificates are stored in a directory inside the task working directory and an environment variable AZ_BATCH_CERTIFICATES_DIR is supplied to the task to query for this location. For certificates with visibility of 'remoteUser', a 'certs' directory is created in the user's home directory (e.g., /home/{user-name}/certs) and certificates are placed in that directory.
   *
   * Warning: This property is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
   */
  @summary("The list of certificates to be installed on each compute node in the pool.")
  certificates?: CertificateReference[];

  /**
   * Changes to application package references affect all new compute nodes joining the pool, but do not affect compute nodes that are already in the pool until they are rebooted or reimaged. There is a maximum of 10 application package references on any given pool.
   */
  @summary("The list of application packages to be installed on each compute node in the pool.")
  applicationPackages?: ApplicationPackageReference[];

  /**
   * The list of application licenses must be a subset of available Batch service application licenses. If a license is requested which is not supported, pool creation will fail.
   */
  @summary("The list of application licenses the Batch service will make available on each compute node in the pool.")
  applicationLicenses?: string[];

  /**
   * Describes either the current operation (if the pool AllocationState is Resizing) or the previously completed operation (if the AllocationState is Steady).
   */
  @summary("Contains details about the current or last completed resize operation.")
  @visibility(Lifecycle.Read)
  resizeOperationStatus?: ResizeOperationStatus;

  /**
   * This supports Azure Files, NFS, CIFS/SMB, and Blobfuse.
   */
  @summary("A list of file systems to mount on each node in the pool.")
  @identifiers(#[])
  mountConfiguration?: MountConfiguration[];

  /**
   * If omitted, the default value is Default.
   */
  @summary("Determines how a pool communicates with the Batch service.")
  targetNodeCommunicationMode?: NodeCommunicationMode;

  /**
   * Determines how a pool communicates with the Batch service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  currentNodeCommunicationMode?: NodeCommunicationMode | null;

  /**
   * Describes an upgrade policy - automatic, manual, or rolling.
   */
  @summary("The upgrade policy for the pool.")
  upgradePolicy?: UpgradePolicy;

  /**
   * The user-defined tags to be associated with the Azure Batch Pool. When specified, these tags are propagated to the backing Azure resources associated with the pool. This property can only be specified when the Batch account was created with the poolAllocationMode property set to 'UserSubscription'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("The user-specified tags associated with the pool.")
  resourceTags?: Record<string>;
}

/**
 * Deployment configuration properties.
 */
model DeploymentConfiguration {
  /**
   * The configuration for compute nodes in a pool based on the Azure Virtual Machines infrastructure.
   */
  @summary("The virtual machine configuration for the pool.")
  virtualMachineConfiguration?: VirtualMachineConfiguration;
}

/**
 * The configuration for compute nodes in a pool based on the Azure Virtual Machines infrastructure.
 */
model VirtualMachineConfiguration {
  /**
   * A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.
   */
  @summary("A reference to the Azure Virtual Machines Marketplace Image or the custom Virtual Machine Image to use.")
  imageReference: ImageReference;

  /**
   * The Batch node agent is a program that runs on each node in the pool, and provides the command-and-control interface between the node and the Batch service. There are different implementations of the node agent, known as SKUs, for different operating systems. You must specify a node agent SKU which matches the selected image reference. To get the list of supported node agent SKUs along with their list of verified image references, see the 'List supported node agent SKUs' operation.
   */
  @summary("The SKU of the Batch node agent to be provisioned on compute nodes in the pool.")
  nodeAgentSkuId: string;

  /**
   * This property must not be specified if the imageReference specifies a Linux OS image.
   */
  @summary("Windows operating system settings on the virtual machine.")
  windowsConfiguration?: WindowsConfiguration;

  /**
   * This property must be specified if the compute nodes in the pool need to have empty data disks attached to them.
   */
  @summary("The configuration for data disks attached to the compute nodes in the pool.")
  @identifiers(#["lun"])
  dataDisks?: DataDisk[];

  /**
   * This only applies to images that contain the Windows operating system, and should only be used when you hold valid on-premises licenses for the nodes which will be deployed. If omitted, no on-premises licensing discount is applied. Values are:
   *
   *  Windows_Server - The on-premises license is for Windows Server.
   *  Windows_Client - The on-premises license is for Windows Client.
   *
   */
  @summary("The type of on-premises license to be used when deploying the operating system.")
  licenseType?: string;

  /**
   * If specified, setup is performed on each node in the pool to allow tasks to run in containers. All regular tasks and job manager tasks run on this pool must specify the containerSettings property, and all other tasks may specify it.
   */
  @summary("The container configuration for the pool.")
  containerConfiguration?: ContainerConfiguration;

  /**
   * If specified, encryption is performed on each node in the pool during node provisioning.
   */
  @summary("The disk encryption configuration for the pool.")
  diskEncryptionConfiguration?: DiskEncryptionConfiguration;

  /**
   * This configuration will specify rules on how nodes in the pool will be physically allocated.
   */
  @summary("The node placement configuration for the pool.")
  nodePlacementConfiguration?: NodePlacementConfiguration;

  /**
   * If specified, the extensions mentioned in this configuration will be installed on each node.
   */
  @summary("The virtual machine extension for the pool.")
  @identifiers(#["name", "type"])
  extensions?: VMExtension[];

  /**
   * Contains configuration for ephemeral OSDisk settings.
   */
  @summary("Settings for the operating system disk of the Virtual Machine.")
  osDisk?: OSDisk;

  /**
   * Specifies the security profile settings for the virtual machine or virtual machine scale set.
   */
  securityProfile?: SecurityProfile;

  /**
   * The service artifact reference id in the form of /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}
   */
  @summary("Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version.")
  serviceArtifactReference?: ServiceArtifactReference;
}

/**
 * A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.
 */
model ImageReference {
  /**
   * For example, Canonical or MicrosoftWindowsServer.
   */
  @summary("The publisher of the Azure Virtual Machines Marketplace image.")
  publisher?: string;

  /**
   * For example, UbuntuServer or WindowsServer.
   */
  @summary("The offer type of the Azure Virtual Machines Marketplace image.")
  offer?: string;

  /**
   * For example, 18.04-LTS or 2022-datacenter.
   */
  @summary("The SKU of the Azure Virtual Machines Marketplace image.")
  sku?: string;

  /**
   * A value of 'latest' can be specified to select the latest version of an image. If omitted, the default is 'latest'.
   */
  @summary("The version of the Azure Virtual Machines Marketplace image.")
  version?: string;

  /**
   * This property is mutually exclusive with other properties. The Azure Compute Gallery Image must have replicas in the same region as the Azure Batch account. For information about the firewall settings for the Batch node agent to communicate with the Batch service see https://learn.microsoft.com/azure/batch/batch-api-basics#virtual-network-vnet-and-firewall-configuration.
   */
  @summary("The ARM resource identifier of the Azure Compute Gallery Image. Compute Nodes in the Pool will be created using this Image Id. This is of the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageDefinitionName}/versions/{versionId}.")
  id?: string;

  /**
   * This property is mutually exclusive with other properties and can be fetched from shared gallery image GET call.
   */
  @summary("The shared gallery image unique identifier")
  sharedGalleryImageId?: string;

  /**
   * This property is mutually exclusive with other properties and can be fetched from community gallery image GET call.
   */
  @summary("The community gallery image unique identifier")
  communityGalleryImageId?: string;
}

/**
 * Windows operating system settings to apply to the virtual machine.
 */
model WindowsConfiguration {
  /**
   * If omitted, the default value is true.
   */
  @summary("Whether automatic updates are enabled on the virtual machine.")
  enableAutomaticUpdates?: boolean;
}

/**
 * Settings which will be used by the data disks associated to Compute Nodes in the Pool. When using attached data disks, you need to mount and format the disks from within a VM to use them.
 */
model DataDisk {
  /**
   * The lun is used to uniquely identify each data disk. If attaching multiple disks, each should have a distinct lun. The value must be between 0 and 63, inclusive.
   */
  @summary("The logical unit number.")
  lun: int32;

  /**
   * Values are:
   *
   *  none - The caching mode for the disk is not enabled.
   *  readOnly - The caching mode for the disk is read only.
   *  readWrite - The caching mode for the disk is read and write.
   *
   *  The default value for caching is none. For information about the caching options see: https://blogs.msdn.microsoft.com/windowsazurestorage/2012/06/27/exploring-windows-azure-drives-disks-and-images/.
   */
  @summary("The type of caching to enable for the disk.")
  caching?: CachingType;

  /**
   * The initial disk size in GB when creating new data disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeGB: int32;

  /**
   * If omitted, the default is "Standard_LRS". Values are:
   *
   *  Standard_LRS - The data disk should use standard locally redundant storage.
   *  Premium_LRS - The data disk should use premium locally redundant storage.
   */
  @summary("The storage account type for use in creating data disks or OS disk.")
  storageAccountType?: StorageAccountType;
}

/**
 * The configuration for container-enabled pools.
 */
model ContainerConfiguration {
  /**
   * The container technology to be used.
   */
  type: ContainerType;

  /**
   * This is the full image reference, as would be specified to "docker pull". An image will be sourced from the default Docker registry unless the image is fully qualified with an alternative registry.
   */
  @summary("The collection of container image names.")
  containerImageNames?: string[];

  /**
   * If any images must be downloaded from a private registry which requires credentials, then those credentials must be provided here.
   */
  @identifiers(#["registryServer"])
  @summary("Additional private registries from which containers can be pulled.")
  containerRegistries?: ContainerRegistry[];
}

/**
 * A private container registry.
 */
model ContainerRegistry {
  /**
   * The user name to log into the registry server.
   */
  username?: string;

  /**
   * The password to log into the registry server.
   */
  @secret
  password?: string;

  /**
   * If omitted, the default is "docker.io".
   */
  @summary("The registry URL.")
  registryServer?: string;

  /**
   * The reference to a user assigned identity associated with the Batch pool which a compute node will use.
   */
  @summary("The reference to the user assigned identity to use to access an Azure Container Registry instead of username and password.")
  identityReference?: ComputeNodeIdentityReference;
}

/**
 * The disk encryption configuration applied on compute nodes in the pool. Disk encryption configuration is not supported on Linux pool created with Virtual Machine Image or Azure Compute Gallery Image.
 */
model DiskEncryptionConfiguration {
  /**
   * On Linux pool, only "TemporaryDisk" is supported; on Windows pool, "OsDisk" and "TemporaryDisk" must be specified.
   */
  @summary("The list of disk targets Batch Service will encrypt on the compute node")
  targets?: DiskEncryptionTarget[];
}

/**
 * Allocation configuration used by Batch Service to provision the nodes.
 */
@summary("Node placement configuration for batch pools.")
model NodePlacementConfiguration {
  /**
   * Allocation policy used by Batch Service to provision the nodes. If not specified, Batch will use the regional policy.
   */
  @summary("The placement policy for allocating nodes in the pool.")
  policy?: NodePlacementPolicyType;
}

/**
 * The configuration for virtual machine extensions.
 */
model VMExtension {
  /**
   * The name of the virtual machine extension.
   */
  name: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher: string;

  /**
   * The type of the extensions.
   */
  type: string;

  /**
   * The version of script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * JSON formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: unknown;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  protectedSettings?: unknown;

  /**
   * Collection of extension names after which this extension needs to be provisioned.
   */
  @summary("The collection of extension names.")
  provisionAfterExtensions?: string[];
}

/**
 * Settings for the operating system disk of the virtual machine.
 */
model OSDisk {
  /**
   * Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ephemeralOSDiskSettings?: DiffDiskSettings;

  /**
   * The type of caching to enable for the disk.
   */
  caching?: CachingType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("The managed disk parameters.")
  managedDisk?: ManagedDisk;

  /**
   * The initial disk size in GB when creating new OS disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskSizeGB?: int32;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;
}

/**
 * The location where the OS disk should be placed.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DiffDiskPlacement {
  /**
   * The OS disk will be placed on the cache disk of the VM.
   */
  CacheDisk: "CacheDisk",
}

/**
 * Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.
 */
model DiffDiskSettings {
  /**
   * This property can be used by user in the request to choose which location the operating system should be in. e.g., cache disk space for Ephemeral OS disk provisioning. For more information on Ephemeral OS disk size requirements, please refer to Ephemeral OS disk size requirements for Windows VMs at https://learn.microsoft.com/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements and Linux VMs at https://learn.microsoft.com/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements.
   */
  @summary("Specifies the ephemeral disk placement for operating system disk for all VMs in the pool.")
  placement?: DiffDiskPlacement;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedDisk {
  /**
   * The storage account type for use in creating data disks or OS disk.
   */
  storageAccountType?: StorageAccountType;

  /**
   * Specifies the security profile settings for the managed disk. **Note**: It can only be set for Confidential VMs and is required when using Confidential VMs.
   */
  @summary("Specifies the security profile for the managed disk.")
  securityProfile?: VMDiskSecurityProfile;
}

/**
 * Specifies the security profile settings for the managed disk. **Note**: It can only be set for Confidential VMs and is required when using Confidential VMs.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMDiskSecurityProfile {
  /**
   * Specifies the EncryptionType of the managed disk. It is set to VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob. **Note**: It can be set for only Confidential VMs and required when using Confidential VMs.
   */
  securityEncryptionType?: SecurityEncryptionTypes;
}

/**
 * Specifies the security profile settings for the virtual machine or virtual machine scale set.
 */
model SecurityProfile {
  /**
   * Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings.
   */
  securityType?: SecurityTypes;

  /**
   * This property can be used by user in the request to enable or disable the Host Encryption for the virtual machine or virtual machine scale set. This will enable the encryption for all the disks including Resource/Temp disk at host itself.
   */
  encryptionAtHost?: boolean;

  /**
   * Specifies the security settings like secure boot and vTPM used while creating the virtual machine.
   */
  uefiSettings?: UefiSettings;
}

/**
 * Specifies the security settings like secure boot and vTPM used while creating the virtual machine.
 */
model UefiSettings {
  /**
   * Specifies whether secure boot should be enabled on the virtual machine.
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether vTPM should be enabled on the virtual machine.
   */
  vTpmEnabled?: boolean;
}

/**
 * Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version.
 */
model ServiceArtifactReference {
  /**
   * The service artifact reference id in the form of /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}
   */
  @summary("The service artifact reference id of ServiceArtifactReference")
  id: string;
}

/**
 * Defines the desired size of the pool. This can either be 'fixedScale' where the requested targetDedicatedNodes is specified, or 'autoScale' which defines a formula which is periodically reevaluated. If this property is not specified, the pool will have a fixed scale with 0 targetDedicatedNodes.
 */
@summary("Scale settings for the pool")
model ScaleSettings {
  /**
   * This property and autoScale are mutually exclusive and one of the properties must be specified.
   */
  @summary("Fixed scale settings for the pool.")
  fixedScale?: FixedScaleSettings;

  /**
   * This property and fixedScale are mutually exclusive and one of the properties must be specified.
   */
  @summary("AutoScale settings for the pool.")
  autoScale?: AutoScaleSettings;
}

/**
 * Fixed scale settings for the pool.
 */
model FixedScaleSettings {
  /**
   * The default value is 15 minutes. Timeout values use ISO 8601 format. For example, use PT10M for 10 minutes. The minimum value is 5 minutes. If you specify a value less than 5 minutes, the Batch service rejects the request with an error; if you are calling the REST API directly, the HTTP status code is 400 (Bad Request).
   */
  @summary("The timeout for allocation of compute nodes to the pool.")
  resizeTimeout?: duration = duration.fromISO("PT15M");

  /**
   * At least one of targetDedicatedNodes, targetLowPriorityNodes must be set.
   */
  @summary("The desired number of dedicated compute nodes in the pool.")
  targetDedicatedNodes?: int32;

  /**
   * At least one of targetDedicatedNodes, targetLowPriorityNodes must be set.
   */
  @summary("The desired number of Spot/low-priority compute nodes in the pool.")
  targetLowPriorityNodes?: int32;

  /**
   * If omitted, the default value is Requeue.
   */
  @summary("Determines what to do with a node and its running task(s) if the pool size is decreasing.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  nodeDeallocationOption?: ComputeNodeDeallocationOption;
}

/**
 * AutoScale settings for the pool.
 */
model AutoScaleSettings {
  /**
   * A formula for the desired number of compute nodes in the pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs(
    "https://learn.microsoft.com/azure/batch/batch-automatic-scaling",
    "Create an automatic scaling formula for scaling compute nodes in a Batch pool"
  )
  formula: string;

  /**
   * If omitted, the default value is 15 minutes (PT15M).
   */
  @summary("The time interval at which to automatically adjust the pool size according to the autoscale formula.")
  evaluationInterval?: duration;
}

/**
 * The results and errors from an execution of a pool autoscale formula.
 */
model AutoScaleRun {
  /**
   * The time at which the autoscale formula was last evaluated.
   */
  evaluationTime: utcDateTime;

  /**
   * Each variable value is returned in the form $variable=value, and variables are separated by semicolons.
   */
  @summary("The final values of all variables used in the evaluation of the autoscale formula.")
  results?: string;

  /**
   * An error that occurred when autoscaling a pool.
   */
  @summary("Details of the error encountered evaluating the autoscale formula on the pool, if the evaluation was unsuccessful.")
  error?: AutoScaleRunError;
}

/**
 * An error that occurred when autoscaling a pool.
 */
model AutoScaleRunError {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message: string;

  /**
   * Additional details about the error.
   */
  @identifiers(#["code"])
  details?: AutoScaleRunError[];
}

/**
 * The network configuration for a pool.
 */
model NetworkConfiguration {
  /**
   * The virtual network must be in the same region and subscription as the Azure Batch account. The specified subnet should have enough free IP addresses to accommodate the number of nodes in the pool. If the subnet doesn't have enough free IP addresses, the pool will partially allocate compute nodes and a resize error will occur. The 'MicrosoftAzureBatch' service principal must have the 'Classic Virtual Machine Contributor' Role-Based Access Control (RBAC) role for the specified VNet. The specified subnet must allow communication from the Azure Batch service to be able to schedule tasks on the compute nodes. This can be verified by checking if the specified VNet has any associated Network Security Groups (NSG). If communication to the compute nodes in the specified subnet is denied by an NSG, then the Batch service will set the state of the compute nodes to unusable. If the specified VNet has any associated Network Security Groups (NSG), then a few reserved system ports must be enabled for inbound communication，including ports 29876 and 29877. Also enable outbound connections to Azure Storage on port 443. For more details see: https://learn.microsoft.com/azure/batch/batch-api-basics#virtual-network-vnet-and-firewall-configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs(
    "https://learn.microsoft.com/azure/batch/batch-virtual-network",
    "Create an Azure Batch pool in a virtual network"
  )
  @summary("The ARM resource identifier of the virtual network subnet which the compute nodes of the pool will join. This is of the form /subscriptions/{subscription}/resourceGroups/{group}/providers/{provider}/virtualNetworks/{network}/subnets/{subnet}.")
  subnetId?: string;

  /**
   * The scope of dynamic vnet assignment.
   */
  dynamicVnetAssignmentScope?: DynamicVNetAssignmentScope = DynamicVNetAssignmentScope.none;

  /**
   * The endpoint configuration for a pool.
   */
  @summary("The configuration for endpoints on compute nodes in the Batch pool.")
  endpointConfiguration?: PoolEndpointConfiguration;

  /**
   * The public IP Address configuration of the networking configuration of a Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("The Public IPAddress configuration for Compute Nodes in the Batch Pool.")
  publicIPAddressConfiguration?: PublicIPAddressConfiguration;

  /**
   * Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, which may lead to improved networking performance. For more details, see: https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Whether this pool should enable accelerated networking.")
  @OpenAPI.externalDocs(
    "https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview",
    "Create a VM with Accelerated Networking."
  )
  enableAcceleratedNetworking?: boolean;
}

/**
 * The endpoint configuration for a pool.
 */
model PoolEndpointConfiguration {
  /**
   * The maximum number of inbound NAT pools per Batch pool is 5. If the maximum number of inbound NAT pools is exceeded the request fails with HTTP status code 400. This cannot be specified if the IPAddressProvisioningType is NoPublicIPAddresses.
   */
  @summary("A list of inbound NAT pools that can be used to address specific ports on an individual compute node externally.")
  @identifiers(#["name"])
  inboundNatPools: InboundNatPool[];
}

/**
 * A inbound NAT pool that can be used to address specific ports on compute nodes in a Batch pool externally.
 */
model InboundNatPool {
  /**
   * The name must be unique within a Batch pool, can contain letters, numbers, underscores, periods, and hyphens. Names must start with a letter or number, must end with a letter, number, or underscore, and cannot exceed 77 characters.  If any invalid values are provided the request fails with HTTP status code 400.
   */
  @summary("The name of the endpoint.")
  name: string;

  /**
   * The protocol of the endpoint.
   */
  protocol: InboundEndpointProtocol;

  /**
   * This must be unique within a Batch pool. Acceptable values are between 1 and 65535 except for 29876 and 29877 as these are reserved. If any reserved values are provided the request fails with HTTP status code 400.
   */
  @summary("The port number on the compute node.")
  backendPort: int32;

  /**
   * Acceptable values range between 1 and 65534 except ports from 50000 to 55000 which are reserved. All ranges within a pool must be distinct and cannot overlap. If any reserved or overlapping values are provided the request fails with HTTP status code 400.
   */
  @summary("The first port number in the range of external ports that will be used to provide inbound access to the backendPort on individual compute nodes.")
  frontendPortRangeStart: int32;

  /**
   * Acceptable values range between 1 and 65534 except ports from 50000 to 55000 which are reserved by the Batch service. All ranges within a pool must be distinct and cannot overlap. If any reserved or overlapping values are provided the request fails with HTTP status code 400.
   */
  @summary("The last port number in the range of external ports that will be used to provide inbound access to the backendPort on individual compute nodes.")
  frontendPortRangeEnd: int32;

  /**
   * The maximum number of rules that can be specified across all the endpoints on a Batch pool is 25. If no network security group rules are specified, a default rule will be created to allow inbound access to the specified backendPort. If the maximum number of network security group rules is exceeded the request fails with HTTP status code 400.
   */
  @summary("A list of network security group rules that will be applied to the endpoint.")
  @identifiers(#[])
  networkSecurityGroupRules?: NetworkSecurityGroupRule[];
}

/**
 * A network security group rule to apply to an inbound endpoint.
 */
model NetworkSecurityGroupRule {
  /**
   * Priorities within a pool must be unique and are evaluated in order of priority. The lower the number the higher the priority. For example, rules could be specified with order numbers of 150, 250, and 350. The rule with the order number of 150 takes precedence over the rule that has an order of 250. Allowed priorities are 150 to 4096. If any reserved or duplicate values are provided the request fails with HTTP status code 400.
   */
  @summary("The priority for this rule.")
  priority: int32;

  /**
   * The action that should be taken for a specified IP address, subnet range or tag.
   */
  access: NetworkSecurityGroupRuleAccess;

  /**
   * Valid values are a single IP address (i.e. 10.10.10.10), IP subnet (i.e. 192.168.1.0/24), default tag, or * (for all addresses).  If any other values are provided the request fails with HTTP status code 400.
   */
  @summary("The source address prefix or tag to match for the rule.")
  sourceAddressPrefix: string;

  /**
   * Valid values are '*' (for all ports 0 - 65535) or arrays of ports or port ranges (i.e. 100-200). The ports should in the range of 0 to 65535 and the port ranges or ports can't overlap. If any other values are provided the request fails with HTTP status code 400. Default value will be *.
   */
  @summary("The source port ranges to match for the rule.")
  sourcePortRanges?: string[];
}

/**
 * The public IP Address configuration of the networking configuration of a Pool.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PublicIPAddressConfiguration {
  /**
   * The default value is BatchManaged
   */
  @summary("The provisioning type for Public IP Addresses for the Batch Pool.")
  provision?: IPAddressProvisioningType;

  /**
   * The number of IPs specified here limits the maximum size of the Pool - 100 dedicated nodes or 100 Spot/low-priority nodes can be allocated for each public IP. For example, a pool needing 250 dedicated VMs would need at least 3 public IPs specified. Each element of this collection is of the form: /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Network/publicIPAddresses/{ip}.
   */
  @summary("The list of public IPs which the Batch service will use when provisioning Compute Nodes.")
  ipAddressIds?: string[];
}

/**
 * Specifies how tasks should be distributed across compute nodes.
 */
model TaskSchedulingPolicy {
  /**
   * How tasks should be distributed across compute nodes.
   */
  nodeFillType: ComputeNodeFillType = ComputeNodeFillType.Spread;
}

/**
 * Properties used to create a user on an Azure Batch node.
 */
model UserAccount {
  /**
   * The name of the user account. Names can contain any Unicode characters up to a maximum length of 20.
   */
  name: string;

  /**
   * The password for the user account.
   */
  @secret
  password: string;

  /**
   * nonAdmin - The auto user is a standard user without elevated access. admin - The auto user is a user with elevated access and operates with full Administrator permissions. The default value is nonAdmin.
   */
  @summary("The elevation level of the user.")
  elevationLevel?: ElevationLevel;

  /**
   * This property is ignored if specified on a Windows pool. If not specified, the user is created with the default options.
   */
  @summary("The Linux-specific user configuration for the user account.")
  linuxUserConfiguration?: LinuxUserConfiguration;

  /**
   * This property can only be specified if the user is on a Windows pool. If not specified and on a Windows pool, the user is created with the default options.
   */
  @summary("The Windows-specific user configuration for the user account.")
  windowsUserConfiguration?: WindowsUserConfiguration;
}

/**
 * Properties used to create a user account on a Linux node.
 */
model LinuxUserConfiguration {
  /**
   * The uid and gid properties must be specified together or not at all. If not specified the underlying operating system picks the uid.
   */
  @summary("The user ID of the user account.")
  uid?: int32;

  /**
   * The uid and gid properties must be specified together or not at all. If not specified the underlying operating system picks the gid.
   */
  @summary("The group ID for the user account.")
  gid?: int32;

  /**
   * The private key must not be password protected. The private key is used to automatically configure asymmetric-key based authentication for SSH between nodes in a Linux pool when the pool's enableInterNodeCommunication property is true (it is ignored if enableInterNodeCommunication is false). It does this by placing the key pair into the user's .ssh directory. If not specified, password-less SSH is not configured between nodes (no modification of the user's .ssh directory is done).
   */
  @summary("The SSH private key for the user account.")
  @secret
  sshPrivateKey?: string;
}

/**
 * Properties used to create a user account on a Windows node.
 */
model WindowsUserConfiguration {
  /**
   * Specifies login mode for the user. The default value is Interactive.
   */
  @summary("Login mode for user")
  loginMode?: LoginMode;
}

/**
 * The Batch service does not assign any meaning to this metadata; it is solely for the use of user code.
 */
@summary("A name-value pair associated with a Batch service resource.")
model MetadataItem {
  /**
   * The name of the metadata item.
   */
  name: string;

  /**
   * The value of the metadata item.
   */
  value: string;
}

/**
 * In some cases the start task may be re-run even though the node was not rebooted. Due to this, start tasks should be idempotent and exit gracefully if the setup they're performing has already been done. Special care should be taken to avoid start tasks which create breakaway process or install/launch services from the start task working directory, as this will block Batch from being able to re-run the start task.
 */
@summary("A task which is run when a compute node joins a pool in the Azure Batch service, or when the compute node is rebooted or reimaged.")
model StartTask {
  /**
   * The command line does not run under a shell, and therefore cannot take advantage of shell features such as environment variable expansion. If you want to take advantage of such features, you should invoke the shell in the command line, for example using "cmd /c MyCommand" in Windows or "/bin/sh -c MyCommand" in Linux. Required if any other properties of the startTask are specified.
   */
  @summary("The command line of the start task.")
  commandLine?: string;

  /**
   * A list of files that the Batch service will download to the compute node before running the command line.
   */
  @identifiers(#["httpUrl"])
  resourceFiles?: ResourceFile[];

  /**
   * A list of environment variable settings for the start task.
   */
  @identifiers(#["name"])
  environmentSettings?: EnvironmentSetting[];

  /**
   * If omitted, the task runs as a non-administrative user unique to the task.
   */
  @summary("The user identity under which the start task runs.")
  userIdentity?: UserIdentity;

  /**
   * The Batch service retries a task if its exit code is nonzero. Note that this value specifically controls the number of retries. The Batch service will try the task once, and may then retry up to this limit. For example, if the maximum retry count is 3, Batch tries the task up to 4 times (one initial try and 3 retries). If the maximum retry count is 0, the Batch service does not retry the task. If the maximum retry count is -1, the Batch service retries the task without limit. Default is 0
   */
  @summary("The maximum number of times the task may be retried.")
  maxTaskRetryCount?: int32 = 0;

  /**
   * If true and the start task fails on a compute node, the Batch service retries the start task up to its maximum retry count (maxTaskRetryCount). If the task has still not completed successfully after all retries, then the Batch service marks the compute node unusable, and will not schedule tasks to it. This condition can be detected via the node state and scheduling error detail. If false, the Batch service will not wait for the start task to complete. In this case, other tasks can start executing on the compute node while the start task is still running; and even if the start task fails, new tasks will continue to be scheduled on the node. The default is true.
   */
  @summary("Whether the Batch service should wait for the start task to complete successfully (that is, to exit with exit code 0) before scheduling any tasks on the compute node.")
  waitForSuccess?: boolean;

  /**
   * When this is specified, all directories recursively below the AZ_BATCH_NODE_ROOT_DIR (the root of Azure Batch directories on the node) are mapped into the container, all task environment variables are mapped into the container, and the task command line is executed in the container.
   */
  @summary("The settings for the container under which the start task runs.")
  containerSettings?: TaskContainerSettings;
}

/**
 * A single file or multiple files to be downloaded to a compute node.
 */
model ResourceFile {
  /**
   * The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified.
   */
  @summary("The storage container name in the auto storage account.")
  autoStorageContainerName?: string;

  /**
   * The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified. This URL must be readable and listable from compute nodes. There are three ways to get such a URL for a container in Azure storage: include a Shared Access Signature (SAS) granting read and list permissions on the container, use a managed identity with read and list permissions, or set the ACL for the container to allow public access.
   */
  @summary("The URL of the blob container within Azure Blob Storage.")
  storageContainerUrl?: string;

  /**
   * The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified. If the URL points to Azure Blob Storage, it must be readable from compute nodes. There are three ways to get such a URL for a blob in Azure storage: include a Shared Access Signature (SAS) granting read permissions on the blob, use a managed identity with read permission, or set the ACL for the blob or its container to allow public access.
   */
  @summary("The URL of the file to download.")
  httpUrl?: string;

  /**
   * The property is valid only when autoStorageContainerName or storageContainerUrl is used. This prefix can be a partial filename or a subdirectory. If a prefix is not specified, all the files in the container will be downloaded.
   */
  @summary("The blob prefix to use when downloading blobs from an Azure Storage container. Only the blobs whose names begin with the specified prefix will be downloaded.")
  blobPrefix?: string;

  /**
   * If the httpUrl property is specified, the filePath is required and describes the path which the file will be downloaded to, including the filename. Otherwise, if the autoStorageContainerName or storageContainerUrl property is specified, filePath is optional and is the directory to download the files to. In the case where filePath is used as a directory, any directory structure already associated with the input data will be retained in full and appended to the specified filePath directory. The specified relative path cannot break out of the task's working directory (for example by using '..').
   */
  @summary("The location on the compute node to which to download the file, relative to the task's working directory.")
  filePath?: string;

  /**
   * This property applies only to files being downloaded to Linux compute nodes. It will be ignored if it is specified for a resourceFile which will be downloaded to a Windows node. If this property is not specified for a Linux node, then a default value of 0770 is applied to the file.
   */
  @summary("The file permission mode attribute in octal format.")
  fileMode?: string;

  /**
   * The reference to a user assigned identity associated with the Batch pool which a compute node will use.
   */
  @summary("The reference to the user assigned identity to use to access Azure Blob Storage specified by storageContainerUrl or httpUrl")
  identityReference?: ComputeNodeIdentityReference;
}

/**
 * An environment variable to be set on a task process.
 */
model EnvironmentSetting {
  /**
   * The name of the environment variable.
   */
  name: string;

  /**
   * The value of the environment variable.
   */
  value?: string;
}

/**
 * Specify either the userName or autoUser property, but not both.
 */
@summary("The definition of the user identity under which the task is run.")
model UserIdentity {
  /**
   * The userName and autoUser properties are mutually exclusive; you must specify one but not both.
   */
  @summary("The name of the user identity under which the task is run.")
  userName?: string;

  /**
   * The userName and autoUser properties are mutually exclusive; you must specify one but not both.
   */
  @summary("The auto user under which the task is run.")
  autoUser?: AutoUserSpecification;
}

/**
 * Specifies the parameters for the auto user that runs a task on the Batch service.
 */
model AutoUserSpecification {
  /**
   * The default value is Pool. If the pool is running Windows a value of Task should be specified if stricter isolation between tasks is required. For example, if the task mutates the registry in a way which could impact other tasks, or if certificates have been specified on the pool which should not be accessible by normal tasks but should be accessible by start tasks.
   */
  @summary("The scope for the auto user")
  scope?: AutoUserScope;

  /**
   * The default value is nonAdmin.
   */
  @summary("The elevation level of the user.")
  elevationLevel?: ElevationLevel;
}

/**
 * The container settings for a task.
 */
model TaskContainerSettings {
  /**
   * These additional options are supplied as arguments to the "docker create" command, in addition to those controlled by the Batch Service.
   */
  @summary("Additional options to the container create command.")
  containerRunOptions?: string;

  /**
   * This is the full image reference, as would be specified to "docker pull". If no tag is provided as part of the image name, the tag ":latest" is used as a default.
   */
  @summary("The image to use to create the container in which the task will run.")
  imageName: string;

  /**
   * This setting can be omitted if was already provided at pool creation.
   */
  @summary("The private registry which contains the container image.")
  registry?: ContainerRegistry;

  /**
   * A flag to indicate where the container task working directory is. The default is 'taskWorkingDirectory'.
   */
  workingDirectory?: ContainerWorkingDirectory;

  /**
   * If this array is null or be not present, container task will mount entire temporary disk drive in windows (or AZ_BATCH_NODE_ROOT_DIR in Linux). It won't' mount any data paths into container if this array is set as empty.
   */
  @summary("The paths you want to mounted to container task.")
  @identifiers(#[])
  containerHostBatchBindMounts?: ContainerHostBatchBindMountEntry[];
}

/**
 * The entry of path and mount mode you want to mount into task container.
 */
model ContainerHostBatchBindMountEntry {
  /**
   * The paths which will be mounted to container task's container.
   */
  source?: ContainerHostDataPath;

  /**
   * For Linux, if you mount this path as a read/write mode, this does not mean that all users in container have the read/write access for the path, it depends on the access in host VM. If this path is mounted read-only, all users within the container will not be able to modify the path.
   */
  @summary("Mount this source path as read-only mode or not. Default value is false (read/write mode).")
  isReadOnly?: boolean;
}

/**
 * Warning: This object is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead.
 */
@summary("A reference to a certificate to be installed on compute nodes in a pool. This must exist inside the same account as the pool.")
model CertificateReference {
  /**
   * The fully qualified ID of the certificate to install on the pool. This must be inside the same batch account as the pool.
   */
  id: string;

  /**
   * The default value is currentUser. This property is applicable only for pools configured with Windows compute nodes. For Linux compute nodes, the certificates are stored in a directory inside the task working directory and an environment variable AZ_BATCH_CERTIFICATES_DIR is supplied to the task to query for this location. For certificates with visibility of 'remoteUser', a 'certs' directory is created in the user's home directory (e.g., /home/{user-name}/certs) and certificates are placed in that directory.
   */
  @summary("The location of the certificate store on the compute node into which to install the certificate.")
  storeLocation?: CertificateStoreLocation;

  /**
   * This property is applicable only for pools configured with Windows compute nodes. Common store names include: My, Root, CA, Trust, Disallowed, TrustedPeople, TrustedPublisher, AuthRoot, AddressBook, but any custom store name can also be used. The default value is My.
   */
  @summary("The name of the certificate store on the compute node into which to install the certificate.")
  storeName?: string;

  /**
   * Which user accounts on the compute node should have access to the private data of the certificate.
   */
  visibility?: CertificateVisibility[];
}

/**
 * Link to an application package inside the batch account
 */
model ApplicationPackageReference {
  /**
   * The ID of the application package to install. This must be inside the same batch account as the pool. This can either be a reference to a specific version or the default version if one exists.
   */
  id: string;

  /**
   * If this is omitted, and no default version is specified for this application, the request fails with the error code InvalidApplicationPackageReferences. If you are calling the REST API directly, the HTTP status code is 409.
   */
  @summary("The version of the application to deploy. If omitted, the default version is deployed.")
  version?: string;
}

/**
 * Describes either the current operation (if the pool AllocationState is Resizing) or the previously completed operation (if the AllocationState is Steady).
 */
@summary("Details about the current or last completed resize operation.")
model ResizeOperationStatus {
  /**
   * The desired number of dedicated compute nodes in the pool.
   */
  targetDedicatedNodes?: int32;

  /**
   * The desired number of Spot/low-priority compute nodes in the pool.
   */
  targetLowPriorityNodes?: int32;

  /**
   * The default value is 15 minutes. The minimum value is 5 minutes. If you specify a value less than 5 minutes, the Batch service returns an error; if you are calling the REST API directly, the HTTP status code is 400 (Bad Request).
   */
  @summary("The timeout for allocation of compute nodes to the pool or removal of compute nodes from the pool.")
  resizeTimeout?: duration;

  /**
   * The default value is requeue.
   */
  @summary("Determines what to do with a node and its running task(s) after it has been selected for deallocation.")
  nodeDeallocationOption?: ComputeNodeDeallocationOption;

  /**
   * The time when this resize operation was started.
   */
  startTime?: utcDateTime;

  /**
   * This property is set only if an error occurred during the last pool resize, and only when the pool allocationState is Steady.
   */
  @summary("Details of any errors encountered while performing the last resize on the pool.")
  @identifiers(#["code"])
  errors?: ResizeError[];
}

/**
 * An error that occurred when resizing a pool.
 */
model ResizeError {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message: string;

  /**
   * Additional details about the error.
   */
  @identifiers(#["code"])
  details?: ResizeError[];
}

/**
 * The file system to mount on each node.
 */
model MountConfiguration {
  /**
   * This property is mutually exclusive with all other properties.
   */
  @summary("The Azure Storage Container to mount using blob FUSE on each node.")
  azureBlobFileSystemConfiguration?: AzureBlobFileSystemConfiguration;

  /**
   * This property is mutually exclusive with all other properties.
   */
  @summary("The NFS file system to mount on each node.")
  nfsMountConfiguration?: NFSMountConfiguration;

  /**
   * This property is mutually exclusive with all other properties.
   */
  @summary("The CIFS/SMB file system to mount on each node.")
  cifsMountConfiguration?: CifsMountConfiguration;

  /**
   * This property is mutually exclusive with all other properties.
   */
  @summary("The Azure File Share to mount on each node.")
  azureFileShareConfiguration?: AzureFileShareConfiguration;
}

/**
 * Information used to connect to an Azure Storage Container using Blobfuse.
 */
model AzureBlobFileSystemConfiguration {
  /**
   * The Azure Storage Account name.
   */
  accountName: string;

  /**
   * The Azure Blob Storage Container name.
   */
  containerName: string;

  /**
   * This property is mutually exclusive with both sasKey and identity; exactly one must be specified.
   */
  @summary("The Azure Storage Account key.")
  @secret
  accountKey?: string;

  /**
   * This property is mutually exclusive with both accountKey and identity; exactly one must be specified.
   */
  @summary("The Azure Storage SAS token.")
  @secret
  sasKey?: string;

  /**
   * These are 'net use' options in Windows and 'mount' options in Linux.
   */
  @summary("Additional command line options to pass to the mount command.")
  blobfuseOptions?: string;

  /**
   * All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.
   */
  @summary("The relative path on the compute node where the file system will be mounted")
  relativeMountPath: string;

  /**
   * This property is mutually exclusive with both accountKey and sasKey; exactly one must be specified.
   */
  @summary("The reference to the user assigned identity to use to access containerName")
  identityReference?: ComputeNodeIdentityReference;
}

/**
 * Information used to connect to an NFS file system.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NFSMountConfiguration {
  /**
   * The URI of the file system to mount.
   */
  source: string;

  /**
   * All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.
   */
  @summary("The relative path on the compute node where the file system will be mounted")
  relativeMountPath: string;

  /**
   * These are 'net use' options in Windows and 'mount' options in Linux.
   */
  @summary("Additional command line options to pass to the mount command.")
  mountOptions?: string;
}

/**
 * Information used to connect to a CIFS file system.
 */
model CifsMountConfiguration {
  /**
   * The user to use for authentication against the CIFS file system.
   */
  userName: string;

  /**
   * The URI of the file system to mount.
   */
  source: string;

  /**
   * All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.
   */
  @summary("The relative path on the compute node where the file system will be mounted")
  relativeMountPath: string;

  /**
   * These are 'net use' options in Windows and 'mount' options in Linux.
   */
  @summary("Additional command line options to pass to the mount command.")
  mountOptions?: string;

  /**
   * The password to use for authentication against the CIFS file system.
   */
  @secret
  password: string;
}

/**
 * Information used to connect to an Azure Fileshare.
 */
model AzureFileShareConfiguration {
  /**
   * The Azure Storage account name.
   */
  accountName: string;

  /**
   * This is of the form 'https://{account}.file.core.windows.net/'.
   */
  @summary("The Azure Files URL.")
  azureFileUrl: string;

  /**
   * The Azure Storage account key.
   */
  @secret
  accountKey: string;

  /**
   * All file systems are mounted relative to the Batch mounts directory, accessible via the AZ_BATCH_NODE_MOUNTS_DIR environment variable.
   */
  @summary("The relative path on the compute node where the file system will be mounted")
  relativeMountPath: string;

  /**
   * These are 'net use' options in Windows and 'mount' options in Linux.
   */
  @summary("Additional command line options to pass to the mount command.")
  mountOptions?: string;
}

/**
 * Describes an upgrade policy - automatic, manual, or rolling.
 */
model UpgradePolicy {
  /**
   * Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the scale set are automatically updated at the same time.<br /><br /> **Rolling** - Scale set performs updates in batches with an optional pause time in between.
   */
  mode: UpgradeMode;

  /**
   * The configuration parameters used for performing automatic OS upgrade.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  automaticOSUpgradePolicy?: AutomaticOSUpgradePolicy;

  /**
   * The configuration parameters used while performing a rolling upgrade.
   */
  rollingUpgradePolicy?: RollingUpgradePolicy;
}

/**
 * The configuration parameters used for performing automatic OS upgrade.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutomaticOSUpgradePolicy {
  /**
   * Whether OS image rollback feature should be disabled.
   */
  disableAutomaticRollback?: boolean;

  /**
   * Indicates whether OS upgrades should automatically be applied to scale set instances in a rolling fashion when a newer version of the OS image becomes available. <br /><br /> If this is set to true for Windows based pools, [WindowsConfiguration.enableAutomaticUpdates](https://learn.microsoft.com/rest/api/batchmanagement/pool/create?tabs=HTTP#windowsconfiguration) cannot be set to true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableAutomaticOSUpgrade?: boolean;

  /**
   * Indicates whether rolling upgrade policy should be used during Auto OS Upgrade. Auto OS Upgrade will fallback to the default policy if no policy is defined on the VMSS.
   */
  useRollingUpgradePolicy?: boolean;

  /**
   * Defer OS upgrades on the TVMs if they are running tasks.
   */
  osRollingUpgradeDeferral?: boolean;
}

/**
 * The configuration parameters used while performing a rolling upgrade.
 */
model RollingUpgradePolicy {
  /**
   * Allow VMSS to ignore AZ boundaries when constructing upgrade batches. Take into consideration the Update Domain and maxBatchInstancePercent to determine the batch size. If this field is not set, Azure Azure Batch will not set its default value. The value of enableCrossZoneUpgrade on the created VirtualMachineScaleSet will be decided by the default configurations on VirtualMachineScaleSet. This field is able to be set to true or false only when using NodePlacementConfiguration as Zonal.
   */
  enableCrossZoneUpgrade?: boolean;

  /**
   * The maximum percent of total virtual machine instances that will be upgraded simultaneously by the rolling upgrade in one batch. As this is a maximum, unhealthy instances in previous or future batches can cause the percentage of instances in a batch to decrease to ensure higher reliability. The value of this field should be between 5 and 100, inclusive. If both maxBatchInstancePercent and maxUnhealthyInstancePercent are assigned with value, the value of maxBatchInstancePercent should not be more than maxUnhealthyInstancePercent.
   */
  @maxValue(100)
  @minValue(5)
  maxBatchInstancePercent?: int32;

  /**
   * The maximum percentage of the total virtual machine instances in the scale set that can be simultaneously unhealthy, either as a result of being upgraded, or by being found in an unhealthy state by the virtual machine health checks before the rolling upgrade aborts. This constraint will be checked prior to starting any batch. The value of this field should be between 5 and 100, inclusive. If both maxBatchInstancePercent and maxUnhealthyInstancePercent are assigned with value, the value of maxBatchInstancePercent should not be more than maxUnhealthyInstancePercent.
   */
  @maxValue(100)
  @minValue(5)
  maxUnhealthyInstancePercent?: int32;

  /**
   * The maximum percentage of upgraded virtual machine instances that can be found to be in an unhealthy state. This check will happen after each batch is upgraded. If this percentage is ever exceeded, the rolling update aborts. The value of this field should be between 0 and 100, inclusive.
   */
  @maxValue(100)
  @minValue(0)
  maxUnhealthyUpgradedInstancePercent?: int32;

  /**
   * The wait time between completing the update for all virtual machines in one batch and starting the next batch. The time duration should be specified in ISO 8601 format.
   */
  pauseTimeBetweenBatches?: string;

  /**
   * Upgrade all unhealthy instances in a scale set before any healthy instances.
   */
  prioritizeUnhealthyInstances?: boolean;

  /**
   * Rollback failed instances to previous model if the Rolling Upgrade policy is violated.
   */
  rollbackFailedInstancesOnPolicyBreach?: boolean;
}

/**
 * The identity of the Batch pool, if configured. If the pool identity is updated during update an existing pool, only the new vms which are created after the pool shrinks to 0 will have the updated identities
 */
model BatchPoolIdentity {
  /**
   * The type of identity used for the Batch Pool.
   */
  type: PoolIdentityType;

  /**
   * The list of user identities associated with the Batch pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentities>;
}

/**
 * Values returned by the List operation.
 */
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * A collection of related endpoints from the same service for which the Batch service requires outbound access.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service that the Batch service connects to.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * The endpoints for this service to which the Batch service makes outbound calls.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["domainName"])
  endpoints?: EndpointDependency[];
}

/**
 * A domain name and connection details used to access a dependency.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * Human-readable supplemental information about the dependency and when it is applicable.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The list of connection details for this endpoint.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["port"])
  endpointDetails?: EndpointDetail[];
}

/**
 * Details about the connection between the Batch service and the endpoint.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  @visibility(Lifecycle.Read)
  port?: int32;
}

model DetectorListResult is Azure.Core.Page<DetectorResponse>;

model OperationListResult is Azure.Core.Page<Operation>;

model BatchAccountListResult is Azure.Core.Page<BatchAccount>;
@@identifiers(BatchAccountListResult.value, #["/properties/accountEndpoint"]);
@@summary(OperationListResult.value,
  "The list of operations supported by the resource provider."
);
@@summary(OperationListResult.nextLink,
  "The URL to get the next set of operation list results if there are any."
);
@@summary(OperationListResult,
  "Result of the request to list REST API operations. It contains a list of operations and a URL nextLink to get the next set of results."
);
@@identifiers(OperationListResult.value, #["name"]);
@@visibility(OutboundEnvironmentEndpointCollection.value, Lifecycle.Read);
@@identifiers(SupportedSkusResult.value, #["name"]);
@@Azure.ClientGenerator.Core.clientName(CifsMountConfiguration,
  "CIFSMountConfiguration"
);
