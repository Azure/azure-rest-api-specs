
using OpenAPI;
@doc("Class for host properties.")
model VmwareHostProperties {
  @doc("Gets the timestamp marking VMware host creation.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last updated on the VMware host.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the data stores.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  datastores?: VmwareDatastore[];

  @doc("Gets the V-center ID.")
  @visibility("read")
  vcenterId?: string;

  @doc("Gets the instance UUID of the vmware host.")
  @visibility("read")
  uuid?: string;

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Second level object returned as part of VMware host REST resource.")
model VmwareDatastore {
  @doc("Data store UUID.")
  @visibility("read")
  uuid?: string;

  @doc("Capacity of the data store.")
  @visibility("read")
  capacityInGb?: float32;

  @doc("Free space of the data store.")
  @visibility("read")
  freeSpaceInGb?: float32;

  @doc("Type of the data store.")
  @visibility("read")
  type?: VMwareDatastoreType;

  @doc("Symbolic name of the data store.")
  @visibility("read")
  symbolicName?: string;
}

@doc("vmware datastore type")
@knownValues(VMwareDatastoreTypeValues)
scalar VMwareDatastoreType extends string;
@doc("vmware datastore type")
enum VMwareDatastoreTypeValues {
  "Unknown",
  Cifs: "CIFS",
  "NFS",
  "NFS41",
  Pmem: "PMEM",
  Vffs: "VFFS",
  Vmfs: "VMFS",
  Vsan: "VSAN",
  Vvol: "VVOL",
}
