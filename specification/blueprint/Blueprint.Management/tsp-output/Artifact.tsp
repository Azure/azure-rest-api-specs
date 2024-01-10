import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Blueprint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Blueprint;
// FIXME: Artifact has no properties property
@doc("Represents a blueprint artifact.")
@parentResource(Blueprint)
model Artifact is ProxyResource<{}> {
  @doc("Name of the blueprint artifact.")
  @key("artifactName")
  @segment("artifacts")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Artifacts {
  @doc("Get a blueprint artifact.")
  get is ArmResourceRead<Artifact>;

  @doc("Create or update blueprint artifact.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Artifact>;

  @doc("Delete a blueprint artifact.")
  delete is ArmResourceDeleteSync<Artifact>;

  @doc("List artifacts for a given blueprint definition.")
  list is ArmResourceListByParent<Artifact>;
}
