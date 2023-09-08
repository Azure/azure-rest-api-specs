import "./../LiftrBase/main.tsp";

import "@typespec/versioning";

using TypeSpec.Versioning;
using LiftrBase;

@versioned(LiftrBase.Storage.Versions)
namespace LiftrBase.Storage;

@doc("Namespace version enum.")
enum Versions {
  @doc("Version 1 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2023-06-01-preview",
}

@doc("Base storage resource properties that can be extended for storage arm resources.")
model BaseStorageResourceProperties is BaseResourceProperties {
  @doc("Subnet Id for Vnet injection.")
  @visibility("read", "create")
  subnetId: string;

  @doc("Azure Availability Zone to create the Pool in.")
  @visibility("read", "create")
  availabilityZone?: string;

  @doc("Bandwidth provisioned by customer in bytes/second.")
  @visibility("read", "create", "update")
  provisionedBandwidth?: int64;

  @doc("iSCSI standard.")
  @visibility("read")
  iscsi?: Iscsi;

  @doc("Azure VmWare Service Properties.")
  @visibility("read", "create", "update")
  avs?: AzureVmwareService;
}

@doc("iSCSI is a storage networking standard.")
model Iscsi {
  @doc("iSCSI IP/port pairs used for establishing connections and exchanging data.")
  @visibility("read")
  ips?: Ip[];
}

@doc("Azure VmWare Service properties. VASA is vSphere Storage APIs for Storage Awareness.")
model AzureVmwareService {
  @doc("VASA Provider user name.")
  @visibility("read")
  vasaProviderUsername?: string;

  @doc("VASA Provider URL.")
  @visibility("read")
  vasaProviderUrls?: string[];

  @doc("Array of iSCSI endpoint and IQN.")
  @visibility("read")
  vasaIscsiEndpoints?: VasaIscsiEndpoint[];

  @doc("Password for VASA service login.")
  @visibility("create", "update")
  @secret
  vasaProviderPassword: string;
}

@doc("Describes iSCSI endpoint and IQN.")
model VasaIscsiEndpoint {
  @doc("iSCSI IP address.")
  address: string;

  @doc("iSCSI TCP port.")
  port: int32;

  @doc("iSCSI Qualified Name.")
  iqn: string;
}
