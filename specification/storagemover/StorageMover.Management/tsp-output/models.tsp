import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.StorageMover;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ProvisioningState {
  Succeeded,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AgentStatus {
  Registering,
  Offline,
  Online,
  Executing,
  RequiresAttention,
  Unregistering,
}

enum EndpointType {
  AzureStorageBlobContainer,
  NfsMount,
  AzureStorageSmbFileShare,
  SmbMount,
}

enum CopyMode {
  Additive,
  Mirror,
}

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

enum JobRunScanStatus {
  NotStarted,
  Scanning,
  Completed,
}

enum NfsVersion {
  NFSauto,
  NFSv3,
  NFSv4,
}

enum CredentialType {
  AzureKeyVaultSmb,
}

@doc("The resource specific properties for the Storage Mover resource.")
model StorageMoverProperties {
  @doc("A description for the Storage Mover.")
  description?: string;

  @doc("The provisioning state of this resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
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

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The Storage Mover resource.")
model StorageMoverUpdateParameters {
  @doc("The resource specific properties for the Storage Mover resource.")
  properties?: StorageMoverUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("The resource specific properties for the Storage Mover resource.")
model StorageMoverUpdateProperties {
  @doc("A description for the Storage Mover.")
  description?: string;
}

model AgentProperties {
  @doc("A description for the Agent.")
  description?: string;

  @doc("The Agent version.")
  @visibility("read")
  agentVersion?: string;

  @doc("The fully qualified resource ID of the Hybrid Compute resource for the Agent.")
  @visibility("read", "create")
  arcResourceId: string;

  @doc("The VM UUID of the Hybrid Compute resource for the Agent.")
  @visibility("read", "create")
  arcVmUuid: string;

  @doc("The Agent status.")
  @visibility("read")
  agentStatus?: AgentStatus;

  @doc("The last updated time of the Agent status.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusUpdate?: utcDateTime;

  @doc("Local IP address reported by the Agent.")
  @visibility("read")
  localIPAddress?: string;

  @doc("Available memory reported by the Agent, in MB.")
  @visibility("read")
  memoryInMB?: int32;

  @doc("Available compute cores reported by the Agent.")
  @visibility("read")
  numberOfCores?: int32;

  @doc("Uptime of the Agent in seconds.")
  @visibility("read")
  uptimeInSeconds?: int32;

  @visibility("read")
  errorDetails?: AgentPropertiesErrorDetails;

  @doc("The provisioning state of this resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model AgentPropertiesErrorDetails {
  @doc("Error code reported by Agent")
  code?: string;

  @doc("Expanded description of reported error code")
  message?: string;
}

@doc("The Agent resource.")
model AgentUpdateParameters {
  properties?: AgentUpdateProperties;
}

model AgentUpdateProperties {
  @doc("A description for the Agent.")
  description?: string;
}

@doc("The resource specific properties for the Storage Mover resource.")
@discriminator("endpointType")
model EndpointBaseProperties {
  @doc("A description for the Endpoint.")
  description?: string;

  @doc("The provisioning state of this resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The Endpoint resource.")
model EndpointBaseUpdateParameters {
  @doc("The Endpoint resource, which contains information about file sources and targets.")
  properties?: EndpointBaseUpdateProperties;
}

@doc("The Endpoint resource, which contains information about file sources and targets.")
@discriminator("endpointType")
model EndpointBaseUpdateProperties {
  @doc("A description for the Endpoint.")
  description?: string;
}

@doc("Project properties.")
model ProjectProperties {
  @doc("A description for the Project.")
  description?: string;

  @doc("The provisioning state of this resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The Project resource.")
model ProjectUpdateParameters {
  @doc("Project properties.")
  properties?: ProjectUpdateProperties;
}

@doc("Project properties.")
model ProjectUpdateProperties {
  @doc("A description for the Project.")
  description?: string;
}

@doc("Job definition properties.")
model JobDefinitionProperties {
  @doc("A description for the Job Definition.")
  description?: string;

  @doc("Strategy to use for copy.")
  copyMode: CopyMode;

  @doc("The name of the source Endpoint.")
  @visibility("read", "create")
  sourceName: string;

  @doc("Fully qualified resource ID of the source Endpoint.")
  @visibility("read")
  sourceResourceId?: string;

  @doc("The subpath to use when reading from the source Endpoint.")
  @visibility("read", "create")
  sourceSubpath?: string;

  @doc("The name of the target Endpoint.")
  @visibility("read", "create")
  targetName: string;

  @doc("Fully qualified resource ID of the target Endpoint.")
  @visibility("read")
  targetResourceId?: string;

  @doc("The subpath to use when writing to the target Endpoint.")
  @visibility("read", "create")
  targetSubpath?: string;

  @doc("The name of the Job Run in a non-terminal state, if exists.")
  @visibility("read")
  latestJobRunName?: string;

  @doc("The fully qualified resource ID of the Job Run in a non-terminal state, if exists.")
  @visibility("read")
  latestJobRunResourceId?: string;

  @doc("The current status of the Job Run in a non-terminal state, if exists.")
  @visibility("read")
  latestJobRunStatus?: JobRunStatus;

  @doc("Name of the Agent to assign for new Job Runs of this Job Definition.")
  agentName?: string;

  @doc("Fully qualified resource id of the Agent to assign for new Job Runs of this Job Definition.")
  @visibility("read")
  agentResourceId?: string;

  @doc("The provisioning state of this resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The Job Definition resource.")
model JobDefinitionUpdateParameters {
  @doc("Job definition properties.")
  properties?: JobDefinitionUpdateProperties;
}

@doc("Job definition properties.")
model JobDefinitionUpdateProperties {
  @doc("A description for the Job Definition.")
  description?: string;

  @doc("Strategy to use for copy.")
  copyMode?: CopyMode;

  @doc("Name of the Agent to assign for new Job Runs of this Job Definition.")
  agentName?: string;
}

@doc("Response that identifies a Job Run.")
model JobRunResourceId {
  @doc("Fully qualified resource id of the Job Run.")
  @visibility("read")
  jobRunResourceId?: string;
}

@doc("Job run properties.")
model JobRunProperties {
  @doc("The state of the job execution.")
  @visibility("read")
  status?: JobRunStatus;

  @doc("The status of Agent's scanning of source.")
  @visibility("read")
  scanStatus?: JobRunScanStatus;

  @doc("Name of the Agent assigned to this run.")
  @visibility("read")
  agentName?: string;

  @doc("Fully qualified resource id of the Agent assigned to this run.")
  @visibility("read")
  agentResourceId?: string;

  @doc("Start time of the run. Null if no Agent reported that the job has started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionStartTime?: utcDateTime;

  @doc("End time of the run. Null if Agent has not reported that the job has ended.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionEndTime?: utcDateTime;

  @doc("The last updated time of the Job Run.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusUpdate?: utcDateTime;

  @doc("Number of items scanned so far in source.")
  @visibility("read")
  itemsScanned?: int32;

  @doc("Number of items that will not be transferred, as they are excluded by user configuration.")
  @visibility("read")
  itemsExcluded?: int32;

  @doc("Number of items that will not be transferred, as they are unsupported on target.")
  @visibility("read")
  itemsUnsupported?: int32;

  @doc("Number of items that will not be transferred, as they are already found on target (e.g. mirror mode).")
  @visibility("read")
  itemsNoTransferNeeded?: int32;

  @doc("Number of items that were attempted to transfer and failed.")
  @visibility("read")
  itemsFailed?: int32;

  @doc("Number of items successfully transferred to target.")
  @visibility("read")
  itemsTransferred?: int32;

  @doc("Bytes of data scanned so far in source.")
  @visibility("read")
  bytesScanned?: int32;

  @doc("Bytes of data that will not be transferred, as they are excluded by user configuration.")
  @visibility("read")
  bytesExcluded?: int32;

  @doc("Bytes of data that will not be transferred, as they are unsupported on target.")
  @visibility("read")
  bytesUnsupported?: int32;

  @doc("Bytes of data that will not be transferred, as they are already found on target (e.g. mirror mode).")
  @visibility("read")
  bytesNoTransferNeeded?: int32;

  @doc("Bytes of data that were attempted to transfer and failed.")
  @visibility("read")
  bytesFailed?: int32;

  @doc("Bytes of data successfully transferred to target.")
  @visibility("read")
  bytesTransferred?: int32;

  @doc("Name of source Endpoint resource. This resource may no longer exist.")
  @visibility("read")
  sourceName?: string;

  @doc("Fully qualified resource id of source Endpoint. This id may no longer exist.")
  @visibility("read")
  sourceResourceId?: string;

  @doc("Copy of source Endpoint resource's properties at time of Job Run creation.")
  @visibility("read")
  sourceProperties?: Record<unknown>;

  @doc("Name of target Endpoint resource. This resource may no longer exist.")
  @visibility("read")
  targetName?: string;

  @doc("Fully qualified resource id of of Endpoint. This id may no longer exist.")
  @visibility("read")
  targetResourceId?: string;

  @doc("Copy of Endpoint resource's properties at time of Job Run creation.")
  @visibility("read")
  targetProperties?: Record<unknown>;

  @doc("Copy of parent Job Definition's properties at time of Job Run creation.")
  @visibility("read")
  jobDefinitionProperties?: Record<unknown>;

  @doc("Error details.")
  @visibility("read")
  error?: JobRunError;

  @doc("The provisioning state of this resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Error type")
model JobRunError {
  @doc("Error code of the given entry.")
  code?: string;

  @doc("Error message of the given entry.")
  message?: string;

  @doc("Target of the given error entry.")
  target?: string;
}

@doc("The properties of Azure Storage blob container endpoint.")
model AzureStorageBlobContainerEndpointProperties
  extends EndpointBaseProperties {
  @doc("The Azure Resource ID of the storage account that is the target destination.")
  storageAccountResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The name of the Storage blob container that is the target destination.")
  @visibility("read", "create")
  blobContainerName: string;

  @doc("The Endpoint resource type.")
  endpointType: "AzureStorageBlobContainer";
}

model AzureStorageBlobContainerEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  @doc("The Endpoint resource type.")
  endpointType: "AzureStorageBlobContainer";
}

@doc("The properties of NFS share endpoint.")
model NfsMountEndpointProperties extends EndpointBaseProperties {
  @doc("The host name or IP address of the server exporting the file system.")
  @visibility("read", "create")
  host: string;

  @doc("The NFS protocol version.")
  @visibility("read", "create")
  nfsVersion?: NfsVersion;

  @doc("The directory being exported from the server.")
  @visibility("read", "create")
  export: string;

  @doc("The Endpoint resource type.")
  endpointType: "NfsMount";
}

model NfsMountEndpointUpdateProperties extends EndpointBaseUpdateProperties {
  @doc("The Endpoint resource type.")
  endpointType: "NfsMount";
}

@doc("The properties of Azure Storage SMB file share endpoint.")
model AzureStorageSmbFileShareEndpointProperties
  extends EndpointBaseProperties {
  @doc("The Azure Resource ID of the storage account.")
  @visibility("read", "create")
  storageAccountResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The name of the Azure Storage file share.")
  @visibility("read", "create")
  fileShareName: string;

  @doc("The Endpoint resource type.")
  endpointType: "AzureStorageSmbFileShare";
}

@doc("The properties of Azure Storage SMB file share endpoint to update.")
model AzureStorageSmbFileShareEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  @doc("The Endpoint resource type.")
  endpointType: "AzureStorageSmbFileShare";
}

@doc("The properties of SMB share endpoint.")
model SmbMountEndpointProperties extends EndpointBaseProperties {
  @doc("The host name or IP address of the server exporting the file system.")
  @visibility("read", "create")
  host: string;

  @doc("The name of the SMB share being exported from the server.")
  @visibility("read", "create")
  shareName: string;

  @doc("The Azure Key Vault secret URIs which store the required credentials to access the SMB share.")
  credentials?: AzureKeyVaultSmbCredentials;

  @doc("The Endpoint resource type.")
  endpointType: "SmbMount";
}

@doc("The Azure Key Vault secret URIs which store the credentials.")
model AzureKeyVaultSmbCredentials extends Credentials {
  @doc("The Azure Key Vault secret URI which stores the username. Use empty string to clean-up existing value.")
  usernameUri?: string;

  @doc("The Azure Key Vault secret URI which stores the password. Use empty string to clean-up existing value.")
  passwordUri?: string;

  @doc("The Credentials type.")
  type: "AzureKeyVaultSmb";
}

@doc("The Credentials.")
@discriminator("type")
model Credentials {}

@doc("The properties of SMB share endpoint to update.")
model SmbMountEndpointUpdateProperties extends EndpointBaseUpdateProperties {
  @doc("The Azure Key Vault secret URIs which store the required credentials to access the SMB share.")
  credentials?: AzureKeyVaultSmbCredentials;

  @doc("The Endpoint resource type.")
  endpointType: "SmbMount";
}
