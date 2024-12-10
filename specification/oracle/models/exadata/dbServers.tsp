import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Oracle.Database;

@doc("DbServer resource model")
@parentResource(CloudExadataInfrastructure)
model DbServer is ProxyResource<DbServerProperties> {
  @key("dbserverocid")
  @doc("DbServer OCID.")
  @segment("dbServers")
  @path
  @pattern(".*")
  name: Ocid;
}

@doc("DB Server patching status enum")
union DbServerPatchingStatus {
  @doc("Patching scheduled")
  Scheduled: "Scheduled",

  @doc("Patching in progress")
  MaintenanceInProgress: "MaintenanceInProgress",

  @doc("Patching failed")
  Failed: "Failed",

  @doc("Patching completed")
  Complete: "Complete",

  string,
}

@doc("DbServer Patching Properties")
model DbServerPatchingDetails {
  @doc("Estimated Patch Duration")
  @visibility("read")
  @minValue(1)
  @maxValue(3000)
  estimatedPatchDuration?: int32;

  @doc("Patching Status")
  @visibility("read")
  patchingStatus?: DbServerPatchingStatus;

  @doc("Time Patching Ended")
  @visibility("read")
  timePatchingEnded?: utcDateTime;

  @doc("Time Patching Started")
  @visibility("read")
  timePatchingStarted?: utcDateTime;
}

// https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/datatypes/DbServerSummary
@doc("DbServer resource properties")
model DbServerProperties {
  @doc("Db server name.")
  @visibility("read")
  ocid?: Ocid;

  @doc("The name for the Db Server.")
  @minLength(1)
  @maxLength(255)
  @visibility("read")
  displayName?: string;

  @doc("The OCID of the compartment.")
  @visibility("read")
  compartmentId?: Ocid;

  @doc("The OCID of the Exadata infrastructure.")
  @visibility("read")
  exadataInfrastructureId?: Ocid;

  @doc("The number of CPU cores enabled on the Db server.")
  @visibility("read")
  cpuCoreCount?: int32;

  @doc("dbServerPatching details of the Db server.")
  @visibility("read")
  dbServerPatchingDetails?: DbServerPatchingDetails;

  @doc("The total memory available in GBs.")
  @visibility("read")
  maxMemoryInGbs?: int32;

  @doc("The allocated local node storage in GBs on the Db server.")
  @visibility("read")
  dbNodeStorageSizeInGbs?: int32;

  @doc("The OCID of the VM Clusters associated with the Db server.")
  @visibility("read")
  vmClusterIds?: Ocid[];

  @doc("The OCID of the Db nodes associated with the Db server.")
  @visibility("read")
  dbNodeIds?: Ocid[];

  @doc("Lifecycle details of dbServer.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("DbServer provisioning state.")
  @visibility("read")
  lifecycleState?: DbServerProvisioningState;

  @doc("The total number of CPU cores available.")
  @visibility("read")
  maxCpuCount?: int32;

  @doc("The list of OCIDs of the Autonomous VM Clusters associated with the Db server.")
  @visibility("read")
  autonomousVmClusterIds?: Ocid[];

  @doc("The list of OCIDs of the Autonomous Virtual Machines associated with the Db server.")
  @visibility("read")
  autonomousVirtualMachineIds?: Ocid[];

  @doc("The total max dbNode storage in GBs.")
  @visibility("read")
  maxDbNodeStorageInGbs?: int32;

  @doc("The total memory size in GBs.")
  @visibility("read")
  memorySizeInGbs?: int32;

  @doc("The shape of the Db server. The shape determines the amount of CPU, storage, and memory resources available.")
  @visibility("read")
  @minLength(1)
  @maxLength(255)
  shape?: string;

  @doc("The date and time that the Db Server was created.")
  @visibility("read")
  timeCreated?: utcDateTime;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("DbServerProvisioningState enum")
union DbServerProvisioningState {
  @doc("Indicates that resource in Creating state")
  Creating: "Creating",

  @doc("Indicates that resource in Available state")
  Available: "Available",

  @doc("Indicates that resource in Unavailable state")
  Unavailable: "Unavailable",

  @doc("Indicates that resource in Deleting state")
  Deleting: "Deleting",

  @doc("Indicates that resource in Deleted state")
  Deleted: "Deleted",

  @doc("Indicates that resource maintenance in progress state")
  MaintenanceInProgress: "MaintenanceInProgress",

  string,
}
