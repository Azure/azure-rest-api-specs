import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevCenter;
@doc("Represents an attached NetworkConnection.")
@parentResource(Project)
model AttachedNetworkConnection
  is ProxyResource<AttachedNetworkConnectionProperties> {
  @doc("The name of the attached NetworkConnection.")
  @key("attachedNetworkConnectionName")
  @segment("attachednetworks")
  name: string;
}

@armResourceOperations
interface AttachedNetworks {
  @doc("Gets an attached NetworkConnection.")
  getByProject is ArmResourceRead<AttachedNetworkConnection>;
  @doc("Lists the attached NetworkConnections for a Project.")
  listByProject is ArmResourceListByParent<
    AttachedNetworkConnection,
    {
      ...BaseParameters<AttachedNetworkConnection>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
