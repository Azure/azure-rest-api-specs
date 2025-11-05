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

scalar ClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/clusters",
    }
  ]>;

scalar DeviceResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/switches",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/racks/nics",
    }
  ]>;

scalar LinkResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/links",
    }
  ]>;

scalar NodeResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/racks/nodes",
    }
  ]>;

scalar DeviceLogicalPortResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/deviceLogicalPorts",
    }
  ]>;

scalar MaintenanceRequestResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/maintenanceRequests",
    }
  ]>;

scalar RackResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/racks",
    }
  ]>;

scalar ReportableWithinMaintenanceRequestResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/clusters",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/switches",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/racks/nics",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/links",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/racks/nodes",
    },
    {
      type: "Microsoft.SupercomputerInfrastructure/supercomputers/deviceLogicalPorts",
    },
    {
      type: "Microsoft.Compute/virtualMachines",
    }
  ]>;

scalar WorkloadImpactResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Impact/workloadImpacts",
    }
  ]>;
