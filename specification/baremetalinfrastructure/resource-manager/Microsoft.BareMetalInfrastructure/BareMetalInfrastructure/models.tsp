import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.BareMetalInfrastructure;

/**
 * The response of a AzureBareMetalInstance list operation.
 */
model AzureBareMetalInstancesListResult
  is Azure.Core.Page<AzureBareMetalInstance>;

/**
 * The response of a AzureBareMetalStorageInstance list operation.
 */
model AzureBareMetalStorageInstancesListResult
  is Azure.Core.Page<AzureBareMetalStorageInstance>;

/**
 * Status of the operation.
 */
union AsyncOperationStatus {
  string,

  /**
   * Requesting
   */
  Requesting: "Requesting",

  /**
   * Executing
   */
  Executing: "Executing",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Whether to force restart by shutting all processes.
 */
union AzureBareMetalInstanceForcePowerState {
  string,

  /**
   * active
   */
  active: "active",

  /**
   * inactive
   */
  inactive: "inactive",
}

/**
 * Name of the hardware type (vendor and/or their product name)
 */
union AzureBareMetalHardwareTypeNamesEnum {
  string,

  /**
   * Cisco_UCS
   */
  Cisco_UCS: "Cisco_UCS",

  /**
   * HPE
   */
  HPE: "HPE",

  /**
   * SDFLEX
   */
  SDFLEX: "SDFLEX",
}

/**
 * Specifies the Azure Bare Metal Instance SKU.
 */
union AzureBareMetalInstanceSizeNamesEnum {
  string,

  /**
   * S72m
   */
  S72m: "S72m",

  /**
   * S144m
   */
  S144m: "S144m",

  /**
   * S72
   */
  S72: "S72",

  /**
   * S144
   */
  S144: "S144",

  /**
   * S192
   */
  S192: "S192",

  /**
   * S192m
   */
  S192m: "S192m",

  /**
   * S192xm
   */
  S192xm: "S192xm",

  /**
   * S96
   */
  S96: "S96",

  /**
   * S112
   */
  S112: "S112",

  /**
   * S224
   */
  S224: "S224",

  /**
   * S224m
   */
  S224m: "S224m",

  /**
   * S224om
   */
  S224om: "S224om",

  /**
   * S224oo
   */
  S224oo: "S224oo",

  /**
   * S224oom
   */
  S224oom: "S224oom",

  /**
   * S224ooo
   */
  S224ooo: "S224ooo",

  /**
   * S384
   */
  S384: "S384",

  /**
   * S384m
   */
  S384m: "S384m",

  /**
   * S384xm
   */
  S384xm: "S384xm",

  /**
   * S384xxm
   */
  S384xxm: "S384xxm",

  /**
   * S448
   */
  S448: "S448",

  /**
   * S448m
   */
  S448m: "S448m",

  /**
   * S448om
   */
  S448om: "S448om",

  /**
   * S448oo
   */
  S448oo: "S448oo",

  /**
   * S448oom
   */
  S448oom: "S448oom",

  /**
   * S448ooo
   */
  S448ooo: "S448ooo",

  /**
   * S448se
   */
  S448se: "S448se",

  /**
   * S576m
   */
  S576m: "S576m",

  /**
   * S576xm
   */
  S576xm: "S576xm",

  /**
   * S672
   */
  S672: "S672",

  /**
   * S672m
   */
  S672m: "S672m",

  /**
   * S672om
   */
  S672om: "S672om",

  /**
   * S672oo
   */
  S672oo: "S672oo",

  /**
   * S672oom
   */
  S672oom: "S672oom",

  /**
   * S672ooo
   */
  S672ooo: "S672ooo",

  /**
   * S768
   */
  S768: "S768",

  /**
   * S768m
   */
  S768m: "S768m",

  /**
   * S768xm
   */
  S768xm: "S768xm",

  /**
   * S896
   */
  S896: "S896",

  /**
   * S896m
   */
  S896m: "S896m",

  /**
   * S896om
   */
  S896om: "S896om",

  /**
   * S896oo
   */
  S896oo: "S896oo",

  /**
   * S896oom
   */
  S896oom: "S896oom",

  /**
   * S896ooo
   */
  S896ooo: "S896ooo",

  /**
   * S960m
   */
  S960m: "S960m",
}

/**
 * Resource power state
 */
union AzureBareMetalInstancePowerStateEnum {
  string,

  /**
   * starting
   */
  starting: "starting",

  /**
   * started
   */
  started: "started",

  /**
   * stopping
   */
  stopping: "stopping",

  /**
   * stopped
   */
  stopped: "stopped",

  /**
   * restarting
   */
  restarting: "restarting",

  /**
   * unknown
   */
  `unknown`: "unknown",
}

/**
 * State of provisioning of the AzureBareMetalInstance
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing enum from original swagger"
union AzureBareMetalProvisioningStatesEnum {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Migrating
   */
  Migrating: "Migrating",
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
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * State of provisioning of the AzureBareMetalStorageInstance
 */
union ProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Migrating
   */
  Migrating: "Migrating",
}

/**
 * The type of identity used for the Azure Bare Metal Storage Instance. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Azure Bare Metal Storage Instance.
 */
union ResourceIdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * None
   */
  None: "None",
}

/**
 * The OperationStatus object returns the state of an asynchronous operation.
 */
model OperationStatus {
  /**
   * Unique Operation Status Identifier.
   */
  name?: string;

  /**
   * Status of the operation.
   */
  status?: AsyncOperationStatus;

  /**
   * Start Time when the operation was initially executed.
   */
  startTime?: string;

  /**
   * An error from the Azure Bare Metal Infrastructure service.
   */
  error?: OperationStatusError;
}

/**
 * An error from the Azure Bare Metal Infrastructure service.
 */
model OperationStatusError {
  /**
   * Server-defined set of error codes.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;
}

/**
 * The active state empowers the server with the ability to forcefully terminate and halt any existing processes that may be running on the server
 */
model ForceState {
  /**
   * Whether to force restart by shutting all processes.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "Existing property from original swagger"
  forceState?: AzureBareMetalInstanceForcePowerState;
}

/**
 * Describes the properties of an Azure Bare Metal Instance.
 */
model AzureBareMetalInstanceProperties {
  /**
   * Specifies the hardware settings for the Azure Bare Metal Instance.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * Specifies the storage settings for the Azure Bare Metal Instance disks.
   */
  storageProfile?: StorageProfile;

  /**
   * Specifies the operating system settings for the Azure Bare Metal Instance.
   */
  osProfile?: OSProfile;

  /**
   * Specifies the network settings for the Azure Bare Metal Instance.
   */
  networkProfile?: NetworkProfile;

  /**
   * Specifies the Azure Bare Metal Instance unique ID.
   */
  azureBareMetalInstanceId?: string;

  /**
   * Resource power state
   */
  powerState?: AzureBareMetalInstancePowerStateEnum;

  /**
   * Resource proximity placement group
   */
  proximityPlacementGroup?: string;

  /**
   * Hardware revision of an Azure Bare Metal Instance
   */
  hwRevision?: string;

  /**
   * ARM ID of another AzureBareMetalInstance that will share a network with this AzureBareMetalInstance
   */
  partnerNodeId?: string;

  /**
   * State of provisioning of the AzureBareMetalInstance
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AzureBareMetalProvisioningStatesEnum;
}

/**
 * Specifies the hardware settings for the Azure Bare Metal Instance.
 */
model HardwareProfile {
  /**
   * Name of the hardware type (vendor and/or their product name)
   */
  hardwareType?: AzureBareMetalHardwareTypeNamesEnum;

  /**
   * Specifies the Azure Bare Metal Instance SKU.
   */
  azureBareMetalInstanceSize?: AzureBareMetalInstanceSizeNamesEnum;
}

/**
 * Specifies the storage settings for the Azure Bare Metal instance disks.
 */
model StorageProfile {
  /**
   * IP Address to connect to storage.
   */
  nfsIpAddress?: string;

  /**
   * Specifies information about the operating system disk used by bare metal instance.
   */
  @identifiers(#["name"])
  osDisks?: Disk[];
}

/**
 * Specifies the disk information fo the Azure Bare Metal Instance
 */
model Disk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the size of an empty data disk in gigabytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
  diskSizeGB?: int32;

  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM.
   */
  @visibility(Lifecycle.Read)
  lun?: int32;
}

/**
 * Specifies the operating system settings for the Azure Bare Metal instance.
 */
model OSProfile {
  /**
   * Specifies the host OS name of the Azure Bare Metal instance.
   */
  computerName?: string;

  /**
   * This property allows you to specify the type of the OS.
   */
  osType?: string;

  /**
   * Specifies version of operating system.
   */
  version?: string;

  /**
   * Specifies the SSH public key used to access the operating system.
   */
  sshPublicKey?: string;
}

/**
 * Specifies the network settings for the Azure Bare Metal Instance disks.
 */
model NetworkProfile {
  /**
   * Specifies the network interfaces for the Azure Bare Metal Instance.
   */
  @identifiers(#["ipAddress"])
  networkInterfaces?: NetworkInterface[];

  /**
   * Specifies the circuit id for connecting to express route.
   */
  circuitId?: string;
}

/**
 * Specifies the network interfaces of a bare metal resource.
 */
model NetworkInterface {
  /**
   * Specifies the IP address of the network interface.
   */
  ipAddress?: string;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Tags field of the AzureBareMetal/AzureBareMetalStorage instance.
 */
model Tags {
  /**
   * Tags field of the AzureBareMetal/AzureBareMetaStorage instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing property from original swagger"
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "Existing property from original swagger"
  tags?: Record<string>;
}

/**
 * Describes the properties of an AzureBareMetalStorageInstance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing model from original swagger"
model AzureBareMetalStorageInstanceProperties {
  /**
   * Specifies the AzureBareMetaStorageInstance unique ID.
   */
  azureBareMetalStorageInstanceUniqueIdentifier?: string;

  /**
   * Specifies the storage properties for the AzureBareMetalStorage instance.
   */
  storageProperties?: StorageProperties;
}

/**
 * described the storage properties of the azure bare metal storage instance
 */
model StorageProperties {
  /**
   * State of provisioning of the AzureBareMetalStorageInstance
   */
  provisioningState?: ProvisioningState;

  /**
   * the offering type for which the resource is getting provisioned
   */
  offeringType?: string;

  /**
   * the storage protocol for which the resource is getting provisioned
   */
  storageType?: string;

  /**
   * the kind of storage instance
   */
  generation?: string;

  /**
   * the hardware type of the storage instance
   */
  hardwareType?: string;

  /**
   * the workload for which the resource is getting provisioned
   */
  workloadType?: string;

  /**
   * the billing related information for the resource
   */
  storageBillingProperties?: StorageBillingProperties;
}

/**
 * Describes the billing related details of the AzureBareMetalStorageInstance.
 */
model StorageBillingProperties {
  /**
   * the billing mode for the storage instance
   */
  billingMode?: string;

  /**
   * the SKU type that is provisioned
   */
  azureBareMetalStorageInstanceSize?: string;
}

/**
 * Identity for Azure Bare Metal Storage Instance.
 */
model AzureBareMetalStorageInstanceIdentity {
  /**
   * The principal ID of Azure Bare Metal Storage Instance identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID associated with the Azure Bare Metal Storage Instance. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the Azure Bare Metal Storage Instance. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Azure Bare Metal Storage Instance.
   */
  type?: ResourceIdentityType;
}

/**
 * properties of body during PUT/PATCH for an AzureBareMetalStorageInstance.
 */
model AzureBareMetalStorageInstanceBody {
  /**
   * The identity of Azure Bare Metal Storage Instance, if configured.
   */
  identity?: AzureBareMetalStorageInstanceIdentity;

  /**
   * Tags field of the AzureBareMetal/AzureBareMetaStorage instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing property from original swagger"
  tags?: Record<string>;
}
