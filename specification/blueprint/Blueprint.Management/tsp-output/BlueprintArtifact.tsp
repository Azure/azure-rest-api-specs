import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Blueprint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Blueprint;
// FIXME: BlueprintArtifact has no properties property
@doc("Represents a blueprint artifact.")
@parentResource(Blueprint)
model BlueprintArtifact is ProxyResource<{}> {
  @doc("Name of the blueprint artifact.")
  @path
  @key("artifactName")
  @segment("artifacts")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface BlueprintArtifacts {
  @doc("Get a blueprint artifact.")
  get is ArmResourceRead<BlueprintArtifact>;
  @doc("Create or update blueprint artifact.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BlueprintArtifact>;
  @doc("Delete a blueprint artifact.")
  delete is ArmResourceDeleteSync<BlueprintArtifact>;
  @doc("List artifacts for a given blueprint definition.")
  list is ArmResourceListByParent<BlueprintArtifact>;
}
