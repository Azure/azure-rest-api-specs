import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WorkspaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Easm;
@doc("Label details")
@parentResource(WorkspaceResource)
model LabelResource is ProxyResource<LabelResourceProperties> {
  @doc("The name of the Label.")
  @key("labelName")
  @segment("labels")
  name: string;
}

@armResourceOperations
@projectedName("client", "Labels")
interface LabelResources_Labels {
  @doc("Returns a label in the given workspace.")
  getByWorkspace is ArmResourceRead<LabelResource>;

  @doc("Create or update a Label.")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<LabelResource>;

  @doc("Update a Label.")
  update is ArmCustomPatchSync<LabelResource, LabelPatchResource>;

  @doc("Delete a Label.")
  delete is ArmResourceDeleteWithoutOkAsync<LabelResource>;

  @doc("Returns a list of labels in the given workspace.")
  listByWorkspace is ArmResourceListByParent<LabelResource>;
}
