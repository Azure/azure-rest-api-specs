import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Packet Broker Properties defines the properties of the resource.
 */
model NetworkPacketBrokerProperties {
  /**
   * ARM resource ID of the Network Fabric.
   */
  @visibility("read", "create")
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * List of ARM resource IDs of Network Devices [NPB].
   */
  @visibility("read")
  networkDeviceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  /**
   * List of network interfaces across NPB devices that are used to mirror source traffic.
   */
  @visibility("read")
  sourceInterfaceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];

  /**
   * List of network Tap IDs configured on NPB.
   */
  @visibility("read")
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  /**
   * List of neighbor group IDs configured on NPB.
   */
  @visibility("read")
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The NetworkPacketBroker patch resource definition.
 */
model NetworkPacketBrokerPatch is TagsUpdate;
