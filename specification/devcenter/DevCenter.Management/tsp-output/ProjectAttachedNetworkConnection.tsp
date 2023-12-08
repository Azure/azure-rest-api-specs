import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents an attached NetworkConnection.")
@parentResource(DevCenterProject)
model ProjectAttachedNetworkConnection
  is ProxyResource<AttachedNetworkConnectionProperties> {
  @doc("The name of the attached NetworkConnection.")
  @path
  @key("attachedNetworkConnectionName")
  @segment("attachednetworks")
  name: string;
}

@armResourceOperations
interface ProjectAttachedNetworkConnections {
  @doc("Gets an attached NetworkConnection.")
  getByProject is ArmResourceRead<ProjectAttachedNetworkConnection>;
  @doc("Lists the attached NetworkConnections for a Project.")
  listByProject is ArmResourceListByParent<
    ProjectAttachedNetworkConnection,
    {
      ...BaseParameters<ProjectAttachedNetworkConnection>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
