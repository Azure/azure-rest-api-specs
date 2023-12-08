import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EasmWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DefenderEasm;
@doc("Label details")
@parentResource(EasmWorkspace)
model EasmLabel is ProxyResource<LabelResourceProperties> {
  @doc("The name of the Label.")
  @path
  @key("labelName")
  @segment("labels")
  name: string;
}

@armResourceOperations
interface EasmLabels {
  @doc("Returns a label in the given workspace.")
  getByWorkspace is ArmResourceRead<EasmLabel>;
  @doc("Create or update a Label.")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<EasmLabel>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Update a Label.")
  update is ArmCustomPatchSync<EasmLabel, LabelPatchResource>;
  @doc("Delete a Label.")
  delete is ArmResourceDeleteWithoutOkAsync<EasmLabel>;
  @doc("Returns a list of labels in the given workspace.")
  listByWorkspace is ArmResourceListByParent<EasmLabel>;
}
