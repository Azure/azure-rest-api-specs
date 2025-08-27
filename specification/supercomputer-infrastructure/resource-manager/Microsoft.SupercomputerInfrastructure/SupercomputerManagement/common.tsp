import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** The provisioning state for any topological element in a supercomputer */
@lroStatus
union TopologicalProvisioningState {
  ResourceProvisioningState,

  /** The resource is currently being updated */
  Updating: "Updating",
}

scalar ClusterArmResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/clusters",
    }
  ]>;

scalar DeviceArmResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/switches",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/nics",
    }
  ]>;

scalar LinkArmResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/links",
    }
  ]>;

scalar NodeArmResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/nodes",
    }
  ]>;

scalar DeviceLogicalPortArmResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/deviceLogicalPorts",
    }
  ]>;
