import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StorageMover;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state of this resource.
 */
enum ProvisioningState {
  Succeeded,
}

/**
 * The Agent status.
 */
enum AgentStatus {
  Registering,
  Offline,
  Online,
  Executing,
  RequiresAttention,
  Unregistering,
}

/**
 * The Endpoint resource type.
 */
enum EndpointType {
  AzureStorageBlobContainer,
  NfsMount,
  AzureStorageSmbFileShare,
  SmbMount,
}

/**
 * Strategy to use for copy.
 */
enum CopyMode {
  Additive,
  Mirror,
}

/**
 * The current status of the Job Run in a non-terminal state, if exists.
 */
enum JobRunStatus {
  Queued,
  Started,
  Running,
  CancelRequested,
  Canceling,
  Canceled,
  Failed,
  Succeeded,
}

/**
 * The status of Agent's scanning of source.
 */
enum JobRunScanStatus {
  NotStarted,
  Scanning,
  Completed,
}

/**
 * The NFS protocol version.
 */
enum NfsVersion {
  NFSauto,
  NFSv3,
  NFSv4,
}

/**
 * The Credentials type.
 */
enum CredentialType {
  AzureKeyVaultSmb,
}

/**
 * The resource specific properties for the Storage Mover resource.
 */
model StorageMoverProperties {
  /**
   * A description for the Storage Mover.
   */
  description?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The Storage Mover resource.
 */
model StorageMoverUpdateParameters {
  /**
   * The resource specific properties for the Storage Mover resource.
   */
  properties?: StorageMoverUpdateProperties;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * The resource specific properties for the Storage Mover resource.
 */
model StorageMoverUpdateProperties {
  /**
   * A description for the Storage Mover.
   */
  description?: string;
}

model AgentProperties {
  /**
   * A description for the Agent.
   */
  description?: string;

  /**
   * The Agent version.
   */
  @visibility("read")
  agentVersion?: string;

  /**
   * The fully qualified resource ID of the Hybrid Compute resource for the Agent.
   */
  @visibility("read", "create")
  arcResourceId: string;

  /**
   * The VM UUID of the Hybrid Compute resource for the Agent.
   */
  @visibility("read", "create")
  arcVmUuid: string;

  /**
   * The Agent status.
   */
  @visibility("read")
  agentStatus?: AgentStatus;

  /**
   * The last updated time of the Agent status.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusUpdate?: utcDateTime;

  /**
   * Local IP address reported by the Agent.
   */
  @visibility("read")
  localIPAddress?: string;

  /**
   * Available memory reported by the Agent, in MB.
   */
  @visibility("read")
  memoryInMB?: int64;

  /**
   * Available compute cores reported by the Agent.
   */
  @visibility("read")
  numberOfCores?: int64;

  /**
   * Uptime of the Agent in seconds.
   */
  @visibility("read")
  uptimeInSeconds?: int64;

  @visibility("read")
  errorDetails?: AgentPropertiesErrorDetails;

  /**
   * The provisioning state of this resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model AgentPropertiesErrorDetails {
  /**
   * Error code reported by Agent
   */
  code?: string;

  /**
   * Expanded description of reported error code
   */
  message?: string;
}

/**
 * The Agent resource.
 */
model AgentUpdateParameters {
  properties?: AgentUpdateProperties;
}

model AgentUpdateProperties {
  /**
   * A description for the Agent.
   */
  description?: string;
}

/**
 * The resource specific properties for the Storage Mover resource.
 */
@discriminator("endpointType")
model EndpointBaseProperties {
  /**
   * A description for the Endpoint.
   */
  description?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The Endpoint resource.
 */
model EndpointBaseUpdateParameters {
  /**
   * The Endpoint resource, which contains information about file sources and targets.
   */
  properties?: EndpointBaseUpdateProperties;
}

/**
 * The Endpoint resource, which contains information about file sources and targets.
 */
@discriminator("endpointType")
model EndpointBaseUpdateProperties {
  /**
   * A description for the Endpoint.
   */
  description?: string;
}

/**
 * Project properties.
 */
model ProjectProperties {
  /**
   * A description for the Project.
   */
  description?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The Project resource.
 */
model ProjectUpdateParameters {
  /**
   * Project properties.
   */
  properties?: ProjectUpdateProperties;
}

/**
 * Project properties.
 */
model ProjectUpdateProperties {
  /**
   * A description for the Project.
   */
  description?: string;
}

/**
 * Job definition properties.
 */
model JobDefinitionProperties {
  /**
   * A description for the Job Definition.
   */
  description?: string;

  /**
   * Strategy to use for copy.
   */
  copyMode: CopyMode;

  /**
   * The name of the source Endpoint.
   */
  @visibility("read", "create")
  sourceName: string;

  /**
   * Fully qualified resource ID of the source Endpoint.
   */
  @visibility("read")
  sourceResourceId?: string;

  /**
   * The subpath to use when reading from the source Endpoint.
   */
  @visibility("read", "create")
  sourceSubpath?: string;

  /**
   * The name of the target Endpoint.
   */
  @visibility("read", "create")
  targetName: string;

  /**
   * Fully qualified resource ID of the target Endpoint.
   */
  @visibility("read")
  targetResourceId?: string;

  /**
   * The subpath to use when writing to the target Endpoint.
   */
  @visibility("read", "create")
  targetSubpath?: string;

  /**
   * The name of the Job Run in a non-terminal state, if exists.
   */
  @visibility("read")
  latestJobRunName?: string;

  /**
   * The fully qualified resource ID of the Job Run in a non-terminal state, if exists.
   */
  @visibility("read")
  latestJobRunResourceId?: string;

  /**
   * The current status of the Job Run in a non-terminal state, if exists.
   */
  @visibility("read")
  latestJobRunStatus?: JobRunStatus;

  /**
   * Name of the Agent to assign for new Job Runs of this Job Definition.
   */
  agentName?: string;

  /**
   * Fully qualified resource id of the Agent to assign for new Job Runs of this Job Definition.
   */
  @visibility("read")
  agentResourceId?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The Job Definition resource.
 */
model JobDefinitionUpdateParameters {
  /**
   * Job definition properties.
   */
  properties?: JobDefinitionUpdateProperties;
}

/**
 * Job definition properties.
 */
model JobDefinitionUpdateProperties {
  /**
   * A description for the Job Definition.
   */
  description?: string;

  /**
   * Strategy to use for copy.
   */
  copyMode?: CopyMode;

  /**
   * Name of the Agent to assign for new Job Runs of this Job Definition.
   */
  agentName?: string;
}

/**
 * Response that identifies a Job Run.
 */
model JobRunResourceId {
  /**
   * Fully qualified resource id of the Job Run.
   */
  @visibility("read")
  jobRunResourceId?: string;
}

/**
 * Job run properties.
 */
model JobRunProperties {
  /**
   * The state of the job execution.
   */
  @visibility("read")
  status?: JobRunStatus;

  /**
   * The status of Agent's scanning of source.
   */
  @visibility("read")
  scanStatus?: JobRunScanStatus;

  /**
   * Name of the Agent assigned to this run.
   */
  @visibility("read")
  agentName?: string;

  /**
   * Fully qualified resource id of the Agent assigned to this run.
   */
  @visibility("read")
  agentResourceId?: string;

  /**
   * Start time of the run. Null if no Agent reported that the job has started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionStartTime?: utcDateTime;

  /**
   * End time of the run. Null if Agent has not reported that the job has ended.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionEndTime?: utcDateTime;

  /**
   * The last updated time of the Job Run.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusUpdate?: utcDateTime;

  /**
   * Number of items scanned so far in source.
   */
  @visibility("read")
  itemsScanned?: int64;

  /**
   * Number of items that will not be transferred, as they are excluded by user configuration.
   */
  @visibility("read")
  itemsExcluded?: int64;

  /**
   * Number of items that will not be transferred, as they are unsupported on target.
   */
  @visibility("read")
  itemsUnsupported?: int64;

  /**
   * Number of items that will not be transferred, as they are already found on target (e.g. mirror mode).
   */
  @visibility("read")
  itemsNoTransferNeeded?: int64;

  /**
   * Number of items that were attempted to transfer and failed.
   */
  @visibility("read")
  itemsFailed?: int64;

  /**
   * Number of items successfully transferred to target.
   */
  @visibility("read")
  itemsTransferred?: int64;

  /**
   * Bytes of data scanned so far in source.
   */
  @visibility("read")
  bytesScanned?: int64;

  /**
   * Bytes of data that will not be transferred, as they are excluded by user configuration.
   */
  @visibility("read")
  bytesExcluded?: int64;

  /**
   * Bytes of data that will not be transferred, as they are unsupported on target.
   */
  @visibility("read")
  bytesUnsupported?: int64;

  /**
   * Bytes of data that will not be transferred, as they are already found on target (e.g. mirror mode).
   */
  @visibility("read")
  bytesNoTransferNeeded?: int64;

  /**
   * Bytes of data that were attempted to transfer and failed.
   */
  @visibility("read")
  bytesFailed?: int64;

  /**
   * Bytes of data successfully transferred to target.
   */
  @visibility("read")
  bytesTransferred?: int64;

  /**
   * Name of source Endpoint resource. This resource may no longer exist.
   */
  @visibility("read")
  sourceName?: string;

  /**
   * Fully qualified resource id of source Endpoint. This id may no longer exist.
   */
  @visibility("read")
  sourceResourceId?: string;

  /**
   * Copy of source Endpoint resource's properties at time of Job Run creation.
   */
  @visibility("read")
  sourceProperties?: Record<unknown>;

  /**
   * Name of target Endpoint resource. This resource may no longer exist.
   */
  @visibility("read")
  targetName?: string;

  /**
   * Fully qualified resource id of of Endpoint. This id may no longer exist.
   */
  @visibility("read")
  targetResourceId?: string;

  /**
   * Copy of Endpoint resource's properties at time of Job Run creation.
   */
  @visibility("read")
  targetProperties?: Record<unknown>;

  /**
   * Copy of parent Job Definition's properties at time of Job Run creation.
   */
  @visibility("read")
  jobDefinitionProperties?: Record<unknown>;

  /**
   * Error details.
   */
  @visibility("read")
  error?: JobRunError;

  /**
   * The provisioning state of this resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Error type
 */
model JobRunError {
  /**
   * Error code of the given entry.
   */
  code?: string;

  /**
   * Error message of the given entry.
   */
  message?: string;

  /**
   * Target of the given error entry.
   */
  target?: string;
}

/**
 * The properties of Azure Storage blob container endpoint.
 */
model AzureStorageBlobContainerEndpointProperties
  extends EndpointBaseProperties {
  /**
   * The Azure Resource ID of the storage account that is the target destination.
   */
  storageAccountResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Storage blob container that is the target destination.
   */
  @visibility("read", "create")
  blobContainerName: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageBlobContainer";
}

model AzureStorageBlobContainerEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageBlobContainer";
}

/**
 * The properties of NFS share endpoint.
 */
model NfsMountEndpointProperties extends EndpointBaseProperties {
  /**
   * The host name or IP address of the server exporting the file system.
   */
  @visibility("read", "create")
  host: string;

  /**
   * The NFS protocol version.
   */
  @visibility("read", "create")
  nfsVersion?: NfsVersion;

  /**
   * The directory being exported from the server.
   */
  @visibility("read", "create")
  export: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "NfsMount";
}

model NfsMountEndpointUpdateProperties extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "NfsMount";
}

/**
 * The properties of Azure Storage SMB file share endpoint.
 */
model AzureStorageSmbFileShareEndpointProperties
  extends EndpointBaseProperties {
  /**
   * The Azure Resource ID of the storage account.
   */
  @visibility("read", "create")
  storageAccountResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Azure Storage file share.
   */
  @visibility("read", "create")
  fileShareName: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageSmbFileShare";
}

/**
 * The properties of Azure Storage SMB file share endpoint to update.
 */
model AzureStorageSmbFileShareEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageSmbFileShare";
}

/**
 * The properties of SMB share endpoint.
 */
model SmbMountEndpointProperties extends EndpointBaseProperties {
  /**
   * The host name or IP address of the server exporting the file system.
   */
  @visibility("read", "create")
  host: string;

  /**
   * The name of the SMB share being exported from the server.
   */
  @visibility("read", "create")
  shareName: string;

  /**
   * The Azure Key Vault secret URIs which store the required credentials to access the SMB share.
   */
  credentials?: AzureKeyVaultSmbCredentials;

  /**
   * The Endpoint resource type.
   */
  endpointType: "SmbMount";
}

/**
 * The Azure Key Vault secret URIs which store the credentials.
 */
model AzureKeyVaultSmbCredentials extends Credentials {
  /**
   * The Azure Key Vault secret URI which stores the username. Use empty string to clean-up existing value.
   */
  usernameUri?: string;

  /**
   * The Azure Key Vault secret URI which stores the password. Use empty string to clean-up existing value.
   */
  passwordUri?: string;

  /**
   * The Credentials type.
   */
  type: "AzureKeyVaultSmb";
}

/**
 * The Credentials.
 */
@discriminator("type")
model Credentials {}

/**
 * The properties of SMB share endpoint to update.
 */
model SmbMountEndpointUpdateProperties extends EndpointBaseUpdateProperties {
  /**
   * The Azure Key Vault secret URIs which store the required credentials to access the SMB share.
   */
  credentials?: AzureKeyVaultSmbCredentials;

  /**
   * The Endpoint resource type.
   */
  endpointType: "SmbMount";
}
