import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Packet Broker Properties defines the properties of the resource.")
model NetworkPacketBrokerProperties {
  @doc("ARM resource ID of the Network Fabric.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of ARM resource IDs of Network Devices [NPB].")
  @visibility(Lifecycle.Read)
  networkDeviceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  @doc("List of network interfaces across NPB devices that are used to mirror source traffic.")
  @visibility(Lifecycle.Read)
  sourceInterfaceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];

  @doc("List of network Tap IDs configured on NPB.")
  @visibility(Lifecycle.Read)
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("List of neighbor group IDs configured on NPB.")
  @visibility(Lifecycle.Read)
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The NetworkPacketBroker patch resource definition.")
model NetworkPacketBrokerPatch is TagsUpdate;
