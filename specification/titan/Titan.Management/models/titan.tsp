import "./common.tsp";
import "./commonmodelslib/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
namespace Microsoft.Titan;

interface Operations extends Azure.ResourceManager.Operations {}

alias resourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{1,58}[a-zA-Z0-9]$";

@doc("Compute Device resource")
@parentResource(TenantLocationResource)
model ComputeDeviceResource is ProxyResource<ComputeDeviceProperties> {
  @doc("The parent resource name")
  @segment("computeDevices")
  @key("computeDevice")
  @visibility(Lifecycle.Read)
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@doc("Compute Device Properties")
model ComputeDeviceProperties {
  @doc("The device type")
  @visibility(Lifecycle.Read)
  deviceType: DeviceType;

  @doc("The short datacenter code where the physical device is located as surfaced by Network Graph Service (NGS). Ex: BN1 ")
  @visibility(Lifecycle.Read)
  dcCode: string;

  @doc("The onboarding group as surfaced by Network Graph Service (NGS). ")
  @visibility(Lifecycle.Read)
  deploymentType: DeploymentType;

  @doc("If the NgsDeviceType is a chassis manager or rack manager, the location of the rack. Unknown otherwise. Surfaced by Network Graph Service (NGS).")
  @visibility(Lifecycle.Read)
  dcRackLocation: string;

  @doc("Whether the device is for production. Surfaced by Network Graph Service (NGS).")
  @visibility(Lifecycle.Read)
  function: string;

  @doc("Unique asset tag of the machine as reported by Hardware Inventory System.")
  @visibility(Lifecycle.Read)
  assetTag: string;

  @doc("The main (or front-end) IP address of the machine at the time of the snapshot.")
  @visibility(Lifecycle.Read)
  ipAddress: string;

  @doc("Represents the logical state of the machine as it goes through the hardware lifecycle.")
  @visibility(Lifecycle.Read)
  lifeCycleState: string;

  @doc("The network MAC address of the machine.")
  @visibility(Lifecycle.Read)
  macAddress: string;

  @doc("The name of the machine.")
  @visibility(Lifecycle.Read)
  machineName: string;

  @doc("The name of the physical structure the machine is on.")
  @visibility(Lifecycle.Read)
  rackName: string;

  @doc("Unique serial number of the machine as reported by Hardware Inventory System.")
  @visibility(Lifecycle.Read)
  serialNumber: string;

  @removed(Versions.v2025_03_01_preview)
  @doc("If the machine type is a server, the environment in which workloads are run. One of: Baremetal, VM, Container.")
  @visibility(Lifecycle.Read)
  workloadType: WorkloadType;

  @added(Versions.v2025_03_01_preview)
  @doc("The machine type.")
  @visibility(Lifecycle.Read)
  machineType: string;

  @added(Versions.v2025_03_01_preview)
  @doc("Management Type only reported for Device Manager devices.")
  @visibility(Lifecycle.Read)
  deviceManagerManagementType?: string;

  @doc("The status of the last operation")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @added(Versions.v2025_06_01_preview)
  @doc("Unique Id of the device")
  @visibility(Lifecycle.Read)
  nodeId?: string;

  @added(Versions.v2025_06_01_preview)
  @doc("The cluster where the device is located")
  @visibility(Lifecycle.Read)
  clusterName?: string;
}

@armResourceOperations
interface ComputeDevices {
  get is ArmResourceRead<ComputeDeviceResource>;
  list is ArmResourceListByParent<ComputeDeviceResource>;
}

@parentResource(TenantLocationResource)
@doc("Private IPAddressProperties.")
@added(Versions.v2025_03_01_preview)
model PrivateIpAddressProperties
  is Microsoft.Inventory.CommonTypes.PrivateIpAddressPropertiesBase;

@parentResource(TenantLocationResource)
@added(Versions.v2025_03_01_preview)
model PrivateIpAddress is ProxyResource<PrivateIpAddressProperties> {
  ...ResourceNameParameter<
    PrivateIpAddress,
    KeyName = "privateIpAddress",
    NamePattern = "^[a-zA-Z0-9-.]{3,32}$"
  >;
}

@armResourceOperations
@added(Versions.v2025_03_01_preview)
interface PrivateIpAddresses {
  get is ArmResourceRead<PrivateIpAddress>;
  list is ArmResourceListByParent<PrivateIpAddress>;
}

@added(Versions.v2025_03_01_preview)
@doc("Public IPAddressProperties.")
model PublicIpAddressProperties
  is Microsoft.Inventory.CommonTypes.PublicIpAddressPropertiesBase;

@parentResource(TenantLocationResource)
@added(Versions.v2025_03_01_preview)
model PublicIpAddress is ProxyResource<PublicIpAddressProperties> {
  ...ResourceNameParameter<
    PublicIpAddress,
    KeyName = "publicIpAddress",
    NamePattern = "^[a-zA-Z0-9-.]{3,32}$"
  >;
}

@armResourceOperations
@added(Versions.v2025_03_01_preview)
interface PublicIpAddresses {
  get is ArmResourceRead<PublicIpAddress>;
  list is ArmResourceListByParent<PublicIpAddress>;
}
