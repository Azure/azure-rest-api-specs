import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Rack Properties defines the properties of the resource.")
model NetworkRackProperties {
  ...AnnotationResource;

  @doc("Network Rack SKU name.")
  networkRackType?: NetworkRackType;

  @doc("ARM resource ID of the Network Fabric.")
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("List of network device ARM resource IDs.")
  @visibility(Lifecycle.Read)
  networkDevices?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
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

@doc("Network Rack patch resource definition.")
model NetworkRackPatch is TagsUpdate;

@doc("Network Rack SKU name.")
union NetworkRackType {
  @doc("NetworkRackType-Aggregate")
  Aggregate: "Aggregate",

  @doc("NetworkRackType-Compute")
  Compute: "Compute",

  @doc("NetworkRackType-Combined")
  Combined: "Combined",

  string,
}
