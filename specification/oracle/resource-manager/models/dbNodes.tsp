import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Oracle.Database;

@doc("The DbNode resource belonging to vmCluster")
@parentResource(CloudVmCluster)
model DbNode is ProxyResource<DbNodeProperties> {
  @doc("DbNode OCID.")
  @key("dbnodeocid")
  @segment("dbNodes")
  @path
  name: Ocid;
}

// https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/datatypes/DbNodeSummary
@doc("The properties of DbNodeResource")
model DbNodeProperties {
  @doc("DbNode OCID")
  @visibility("read")
  ocid: Ocid;

  @doc("Additional information about the planned maintenance.")
  @visibility("read")
  additionalDetails?: string;

  @doc("The OCID of the backup IP address associated with the database node.")
  @visibility("read")
  backupIpId?: Ocid;

  @doc("The OCID of the second backup VNIC.")
  @visibility("read")
  backupVnic2Id?: Ocid;

  @doc("The OCID of the backup VNIC.")
  @visibility("read")
  backupVnicId?: Ocid;

  @doc("The number of CPU cores enabled on the Db node.")
  @visibility("read")
  cpuCoreCount?: int32;

  @doc("The allocated local node storage in GBs on the Db node.")
  @visibility("read")
  dbNodeStorageSizeInGbs?: int32;

  @doc("The OCID of the Exacc Db server associated with the database node.")
  @visibility("read")
  dbServerId?: Ocid;

  @doc("The OCID of the DB system.")
  @visibility("read")
  dbSystemId: Ocid;

  @doc("The name of the Fault Domain the instance is contained in.")
  @minLength(1)
  @maxLength(255)
  @visibility("read")
  faultDomain?: string;

  @doc("The OCID of the host IP address associated with the database node.")
  @visibility("read")
  hostIpId?: Ocid;

  @doc("The host name for the database node.")
  @visibility("read")
  hostname?: string;

  @doc("The current state of the database node.")
  @visibility("read")
  lifecycleState?: DbNodeProvisioningState;

  @doc("Lifecycle details of Db Node.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("The type of database node maintenance.")
  @visibility("read")
  maintenanceType?: DbNodeMaintenanceType;

  @doc("The allocated memory in GBs on the Db node.")
  @visibility("read")
  memorySizeInGbs?: int32;

  @doc("The size (in GB) of the block storage volume allocation for the DB system. This attribute applies only for virtual machine DB systems.")
  @visibility("read")
  softwareStorageSizeInGb?: int32;

  @doc("The date and time that the database node was created.")
  @visibility("read")
  timeCreated?: utcDateTime;

  @doc("End date and time of maintenance window.")
  @visibility("read")
  timeMaintenanceWindowEnd?: utcDateTime;

  @doc("Start date and time of maintenance window.")
  @visibility("read")
  timeMaintenanceWindowStart?: utcDateTime;

  @doc("The OCID of the second VNIC.")
  @visibility("read")
  vnic2Id?: Ocid;

  @doc("The OCID of the VNIC.")
  @visibility("read")
  vnicId?: Ocid;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The type of database node maintenance.")
enum DbNodeMaintenanceType {
  @doc("Provisioning value")
  VmdbRebootMigration,
}

@doc("DnNode provisioning state enum")
enum DbNodeProvisioningState {
  @doc("PROVISIONING value")
  Provisioning,

  @doc("AVAILABLE value")
  Available,

  @doc("UPDATING value")
  Updating,

  @doc("STOPPING value")
  Stopping,

  @doc("STOPPED value")
  Stopped,

  @doc("STARTING value")
  Starting,

  @doc("TERMINATING value")
  Terminating,

  @doc("TERMINATED value")
  Terminated,

  @doc("FAILED value")
  Failed,
}


@doc("DbNode action enum")
enum DbNodeActionEnum {
  @doc("Start DbNode")
  Start,

  @doc("Stop DbNode")
  Stop,

  @doc("Soft reset DbNode")
  SoftReset,

  @doc("Reset DbNode")
  Reset,
}

@doc("DbNode action object")
model DbNodeAction {
   @doc("Db action")
   action: DbNodeActionEnum
}