import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
scalar ExascaleDbNodeResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/exadbVmCluster/dbNode",
    }
  ]>;

@added(Versions.v20241201_preview)
@doc("The DbNode resource belonging to ExadbVmCluster")
@parentResource(ExadbVmCluster)
model ExascaleDbNode is ProxyResource<ExascaleDbNodeProperties> {
  ...ResourceNameParameter<
    ExascaleDbNode,
    SegmentName = "dbNodes",
    NamePattern = ".*"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20241201_preview)
@doc("The properties of DbNodeResource")
model ExascaleDbNodeProperties {
  @doc("DbNode OCID")
  ocid: Ocid;

  @doc("Additional information about the planned maintenance.")
  additionalDetails?: string;

  @doc("The number of CPU cores enabled on the Db node.")
  cpuCoreCount?: int32;

  @doc("The allocated local node storage in GBs on the Db node.")
  dbNodeStorageSizeInGbs?: int32;

  @doc("The name of the Fault Domain the instance is contained in.")
  @minLength(1)
  @maxLength(255)
  faultDomain?: string;

  @doc("The host name for the database node.")
  hostname?: string;

  @doc("The current state of the database node.")
  lifecycleState?: DbNodeProvisioningState;

  @doc("The type of database node maintenance.")
  maintenanceType?: string;

  @doc("The allocated memory in GBs on the Db node.")
  memorySizeInGbs?: int32;

  @doc("The size (in GB) of the block storage volume allocation for the DB system. This attribute applies only for virtual machine DB systems.")
  softwareStorageSizeInGb?: int32;

  @doc("End date and time of maintenance window.")
  timeMaintenanceWindowEnd?: utcDateTime;

  @doc("Start date and time of maintenance window.")
  timeMaintenanceWindowStart?: utcDateTime;

  @doc("The total number of CPU cores reserved on the Db node.")
  totalCpuCoreCount?: int32;
}

@added(Versions.v20241201_preview)
@doc("ExascaleDbNode action response")
model DbActionResponse {
  @doc("ExascaleDbNode provisioning state")
  provisioningState?: AzureResourceProvisioningState;
}
