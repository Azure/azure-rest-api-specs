import "@azure-tools/typespec-azure-resource-manager";
import "../../../models/exadata/virtualNetworkAddress.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface VirtualNetworkAddresses
  extends OracleChildResource<
      VirtualNetworkAddress,
      VirtualNetworkAddressProperties
    > {
  // TODO: Swagger generator bug, cannot be extracted to interface
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @Autorest.example(
    "./examples/virtualNetworkAddresses_listByParent.json",
    "List Virtual Network Addresses by VM Cluster"
  )
  listByCloudVmCluster is ArmResourceListByParent<VirtualNetworkAddress>;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(VirtualNetworkAddresses.createOrUpdate,
  "./examples/virtualNetworkAddresses_create.json",
  "Create Virtual Network Address"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(VirtualNetworkAddresses.get,
  "./examples/virtualNetworkAddresses_get.json",
  "Get Virtual Network Address"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(VirtualNetworkAddresses.delete,
  "./examples/virtualNetworkAddresses_delete.json",
  "Delete Virtual Network Address"
);
