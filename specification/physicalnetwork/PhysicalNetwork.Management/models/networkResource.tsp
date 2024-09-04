import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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

  @doc("The device's hardware SKU")
  hardwareSku: string;

  @doc("The device's NgsDeviceType")
  deviceType: string;

  @doc("The cluster the device belongs to")
  cluster: string;

  @doc("The cloud the device is in")
  cloudType: string;

  @doc("The device's deployment type")
  deploymentType: string;

  @doc("The device's rack location")
  dcRackLocation: string;

  @doc("The device owner's Service Tree Id")
  serviceTreeId: string;

  @doc("Provisioning state")
  @visibility("read")
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
