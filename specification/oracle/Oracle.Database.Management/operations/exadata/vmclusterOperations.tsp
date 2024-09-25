import "@azure-tools/typespec-azure-resource-manager";
import "../../../models/exadata/vmcluster.tsp";
import "../../../models/exadata/privateIpAddresses.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface CloudVmClusters
  extends OracleTrackedResource<CloudVmCluster, CloudVmClusterProperties> {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("Add VMs to the VM Cluster")
  @Autorest.example(
    "./examples/vmClusters_addVms.json",
    "Add VMs to VM Cluster"
  )
  addVms is ArmResourceActionAsync<
    CloudVmCluster,
    AddRemoveDbNode,
    CloudVmCluster
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("Remove VMs from the VM Cluster")
  @Autorest.example(
    "./examples/vmClusters_removeVms.json",
    "Remove VMs from VM Cluster"
  )
  removeVms is ArmResourceActionAsync<
    CloudVmCluster,
    AddRemoveDbNode,
    CloudVmCluster
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("List Private IP Addresses by the provided filter")
  @Autorest.example(
    "./examples/vmClusters_listPrivateIpAddresses.json",
    "List Private IP Addresses for VM Cluster"
  )
  listPrivateIpAddresses is ArmResourceActionSync<
    CloudVmCluster,
    PrivateIpAddressesFilter,
    Array<PrivateIpAddressProperties>
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(CloudVmClusters.listBySubscription,
  "./examples/vmClusters_listBySubscription.json",
  "List VM Clusters by subscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(CloudVmClusters.createOrUpdate,
  "./examples/vmClusters_create.json",
  "Create VM Cluster"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(CloudVmClusters.get,
  "./examples/vmClusters_get.json",
  "Get VM Cluster"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(CloudVmClusters.update,
  "./examples/vmClusters_patch.json",
  "Patch VM Cluster"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(CloudVmClusters.delete,
  "./examples/vmClusters_delete.json",
  "Delete VM Cluster"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(CloudVmClusters.listByResourceGroup,
  "./examples/vmClusters_listByResourceGroup.json",
  "List VM Clusters by resource group"
);
