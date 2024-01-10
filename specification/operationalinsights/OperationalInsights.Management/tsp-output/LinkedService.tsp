import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.OperationalInsights;
@doc("The top level Linked service resource container.")
@parentResource(Workspace)
model LinkedService is ProxyResource<LinkedServiceProperties> {
  @doc("Name of the linked service.")
  @key("linkedServiceName")
  @segment("linkedServices")
  name: string;
}

@armResourceOperations
interface LinkedServices {
  @doc("Gets a linked service instance.")
  get is ArmResourceRead<LinkedService>;

  @doc("Create or update a linked service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LinkedService>;

  @doc("Deletes a linked service instance.")
  delete is ArmResourceDeleteAsync<LinkedService>;

  @doc("Gets the linked services instances in a workspace.")
  listByWorkspace is ArmResourceListByParent<LinkedService>;
}
