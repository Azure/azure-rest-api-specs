import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exascale/exadbVmCluster.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Autorest;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
@armResourceOperations
interface ExadbVmClusters
  extends OracleTrackedResource<ExadbVmCluster, ExadbVmClusterProperties> {
  @doc("Remove VMs from the VM Cluster")
  removeVms is ArmResourceActionAsync<
    ExadbVmCluster,
    RemoveVirtualMachineFromExadbVmClusterDetails,
    ExadbVmCluster
  >;
}
