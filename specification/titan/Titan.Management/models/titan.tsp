import "./common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
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
  @key("deviceName")
  @visibility("read")
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@doc("Compute Device Properties")
model ComputeDeviceProperties {
  @doc("The parent device name")
  @visibility("read")
  deviceName: string;

  @doc("The parent device type")
  @visibility("read")
  deviceType: string;

  @doc("The short datacenter code where the physical device is located as surfaced by Network Graph Service (NGS). Ex: BN1 ")
  @visibility("read")
  dcCode: string;

  @doc("The onboarding group as surfaced by Network Graph Service (NGS). ")
  @visibility("read")
  deploymentType: string;

  @doc("If the NgsDeviceType is a chassis manager or rack manager, the location of the rack. Unknown otherwise. Surfaced by Network Graph Service (NGS).")
  @visibility("read")
  dcRackLocation: string;

  @doc("Whether the device is for production. Surfaced by Network Graph Service (NGS).")
  @visibility("read")
  function: string;

  @doc("Unique asset tag of the machine as reported by Hardware Inventory System.")
  @visibility("read")
  assetTag: string;

  @doc("The main (or front-end) IP address of the machine at the time of the snapshot.")
  @visibility("read")
  ipAddress: string;

  @doc("Represents the logical state of the machine as it goes through the hardware lifecycle.")
  @visibility("read")
  lifeCycleState: string;

  @doc("The network MAC address of the machine.")
  @visibility("read")
  macAddress: string;

  @doc("The name of the machine.")
  @visibility("read")
  machineName: string;

  @doc("A device that connects to the network. One of: Server, ChassisManager, RackManager.")
  @visibility("read")
  machineType: string;

  @doc("The name of the physical structure the machine is on.")
  @visibility("read")
  rackName: string;

  @doc("Unique serial number of the machine as reported by Hardware Inventory System.")
  @visibility("read")
  serialNumber: string;

  @doc("If the machine type is a server, the environment in which workloads are run. One of: Baremetal, VM, Container.")
  @visibility("read")
  workloadType: string;

  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface ComputeDevices {
  get is ArmResourceRead<ComputeDeviceResource>;
  list is ArmResourceListByParent<ComputeDeviceResource>;
}
