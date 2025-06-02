import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exadata/virtualNetworkAddress.tsp";

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
  listByParent is ArmResourceListByParent<VirtualNetworkAddress>;
}
