import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.BareMetalInfrastructure;

/**
 * Status of the operation.
 */
union AsyncOperationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Requesting: "Requesting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Executing: "Executing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Whether to force restart by shutting all processes.
 */
union AzureBareMetalInstanceForcePowerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  active: "active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  inactive: "inactive",
}

/**
 * Name of the hardware type (vendor and/or their product name)
 */
union AzureBareMetalHardwareTypeNamesEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cisco_UCS: "Cisco_UCS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HPE: "HPE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SDFLEX: "SDFLEX",
}

/**
 * Specifies the Azure Bare Metal Instance SKU.
 */
union AzureBareMetalInstanceSizeNamesEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S72m: "S72m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S144m: "S144m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S72: "S72",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S144: "S144",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S192: "S192",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S192m: "S192m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S192xm: "S192xm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S96: "S96",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S112: "S112",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S224: "S224",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S224m: "S224m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S224om: "S224om",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S224oo: "S224oo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S224oom: "S224oom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S224ooo: "S224ooo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S384: "S384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S384m: "S384m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S384xm: "S384xm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S384xxm: "S384xxm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448: "S448",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448m: "S448m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448om: "S448om",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448oo: "S448oo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448oom: "S448oom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448ooo: "S448ooo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S448se: "S448se",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S576m: "S576m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S576xm: "S576xm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S672: "S672",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S672m: "S672m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S672om: "S672om",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S672oo: "S672oo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S672oom: "S672oom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S672ooo: "S672ooo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S768: "S768",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S768m: "S768m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S768xm: "S768xm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S896: "S896",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S896m: "S896m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S896om: "S896om",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S896oo: "S896oo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S896oom: "S896oom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S896ooo: "S896ooo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S960m: "S960m",
}

/**
 * Resource power state
 */
union AzureBareMetalInstancePowerStateEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  starting: "starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  started: "started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  stopping: "stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  stopped: "stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restarting: "restarting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `unknown`: "unknown",
}

/**
 * State of provisioning of the AzureBareMetalInstance
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union AzureBareMetalProvisioningStatesEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrating: "Migrating",
}

/**
 * State of provisioning of the AzureBareMetalStorageInstance
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrating: "Migrating",
}

/**
 * The type of identity used for the Azure Bare Metal Storage Instance. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Azure Bare Metal Storage Instance.
 */
union ResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @OpenAPI.extension("x-ms-identifiers", #["name"])
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
  @OpenAPI.extension("x-ms-identifiers", #["ipAddress"])
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Tags field of the AzureBareMetal/AzureBareMetalStorage instance.
 */
model Tags {
  /**
   * Tags field of the AzureBareMetal/AzureBareMetaStorage instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Describes the properties of an AzureBareMetalStorageInstance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}
