import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Packet Broker Properties defines the properties of the resource.")
model NetworkPacketBrokerProperties {
  @doc("ARM resource ID of the Network Fabric.")
  @visibility("read", "create")
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of ARM resource IDs of Network Devices [NPB].")
  @visibility("read")
  networkDeviceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  @doc("List of network interfaces across NPB devices that are used to mirror source traffic.")
  @visibility("read")
  sourceInterfaceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];

  @doc("List of network Tap IDs configured on NPB.")
  @visibility("read")
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("List of neighbor group IDs configured on NPB.")
  @visibility("read")
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("Details of the last operation performed on the resource")
  @visibility("read")
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The NetworkPacketBroker patch resource definition.")
model NetworkPacketBrokerPatch is TagsUpdate;
