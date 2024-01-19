import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Represents a software data")
model Software is ProxyResource<SoftwareProperties> {
  @doc("Name of the installed software.")
  @path
  @key("softwareName")
  @segment("softwareInventories")
  name: string;
}

@armResourceOperations
@projectedName("client", "Software")
interface SoftwareOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a single software data of the virtual machine.")
  @operationId("SoftwareInventories_Get")
  get is ArmResourceRead<Software>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the software inventory of the virtual machine.")
  @operationId("SoftwareInventories_ListByExtendedResource")
  listByExtendedResource is ArmResourceListByParent<Software>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the software inventory of all virtual machines in the subscriptions.")
  @operationId("SoftwareInventories_ListBySubscription")
  listBySubscription is ArmListBySubscription<Software>;
}
