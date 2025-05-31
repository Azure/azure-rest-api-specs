import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exadata/vmcluster.tsp";
import "../../models/exadata/privateIpAddresses.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface CloudVmClusters
  extends OracleTrackedResource<CloudVmCluster, CloudVmClusterProperties> {
  @doc("Add VMs to the VM Cluster")
  addVms is ArmResourceActionAsync<
    CloudVmCluster,
    AddRemoveDbNode,
    CloudVmCluster
  >;

  @doc("Remove VMs from the VM Cluster")
  removeVms is ArmResourceActionAsync<
    CloudVmCluster,
    AddRemoveDbNode,
    CloudVmCluster
  >;

  @doc("List Private IP Addresses by the provided filter")
  listPrivateIpAddresses is ArmResourceActionSync<
    CloudVmCluster,
    PrivateIpAddressesFilter,
    Array<PrivateIpAddressProperties>
  >;
}
