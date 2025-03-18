import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;

namespace Microsoft.PhysicalNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Network Device Properties")
model NetworkDeviceProperties {
  @doc("The datacenter short code")
  dcCode: string;

  @doc("The device's IPv4 address")
  loopbackIpV4: string;

  @doc("The device's IPv6 address")
  loopbackIpV6: string;

  @doc("The management console's IPv4 address")
  managementIpV4: string;

  @doc("The management console's IPv6 address")
  managementIpV6: string;

  @doc("The device's preferred IP address")
  preferredIp: string;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The datacenter short code's ARM Id string")
  dcCodeArmId: armResourceIdentifier;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The device's IPv4 address's ARM Id string")
  loopbackIpV4ArmId: armResourceIdentifier;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The device's IPv6 address's ARM Id string")
  loopbackIpV6ArmId: armResourceIdentifier;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The management console's IPv4 address's ARM Id string")
  managementIpV4ArmId: armResourceIdentifier;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The management console's IPv6 address's ARM Id string")
  managementIpV6ArmId: armResourceIdentifier;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The device's preferred IP address's ARM Id string")
  preferredIpArmId: armResourceIdentifier;

  @doc("The device's hardware SKU")
  hardwareSku: string;

  @doc("The device's NgsDeviceType")
  deviceType: string;

  @doc("The cluster the device belongs to")
  cluster: string;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The cluster's ARM Id string")
  clusterArmId: armResourceIdentifier;

  @doc("The cloud the device is in")
  cloudType: string;

  @doc("The device's deployment type")
  deploymentType: string;

  @doc("The device's rack location")
  dcRackLocation: string;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, string)
  @doc("The device's rack location's ARM Id string")
  dcRackLocationArmId: armResourceIdentifier;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.removed(Versions.v2025_01_01_preview)
  @doc("The device owner's Service Tree Id")
  serviceTreeId: string;

  @Versioning.added(Versions.v2025_01_01_preview)
  @doc("The device owner's platform Service Tree Id")
  platformServiceTreeId: string;

  @Versioning.added(Versions.v2025_01_01_preview)
  @doc("The device owner's platform Service Tree Id")
  infraServiceTreeId: string;

  @Versioning.added(Versions.v2025_01_01_preview)
  @doc("The device owner's IcM Queue")
  icmQueue: string;

  @Versioning.added(Versions.v2024_09_01_preview)
  @doc("Additional Device Interface IP addresses")
  additionalIps: Array<string>;

  @Versioning.added(Versions.v2024_09_01_preview)
  @Versioning.typeChangedFrom(Versions.v2025_01_01_preview, Array<string>)
  @doc("Additional Device Interface IP address ARM Ids")
  additionalIpsArmId: Array<armResourceIdentifier>;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Provisioning state enum")
union ProvisioningState {
  @doc("The resource action is successful.")
  Succeeded: "Succeeded",

  @doc("The resource action has failed.")
  Failed: "Failed",

  @doc("The resource action has been cancelled.")
  Canceled: "Canceled",

  @doc("The resource provisioning has been accepted.")
  Accepted: "Accepted",

  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being updated.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource has been deleted.")
  Deleted: "Deleted",

  @doc("The resource status is unspecified.")
  NotSpecified: "NotSpecified",

  string,
}
