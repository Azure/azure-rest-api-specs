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
@doc("Represents a published blueprint.")
@parentResource(Blueprint)
model PublishedBlueprint is ProxyResource<PublishedBlueprintProperties> {
  @doc("Version of the published blueprint definition.")
  @key("versionId")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface PublishedBlueprints {
  @doc("Get a published version of a blueprint definition.")
  get is ArmResourceRead<PublishedBlueprint>;
  @doc("Publish a new version of the blueprint definition with the latest artifacts. Published blueprint definitions are immutable.")
  create is ArmResourceCreateOrReplaceSync<PublishedBlueprint>;
  @doc("Delete a published version of a blueprint definition.")
  delete is ArmResourceDeleteSync<PublishedBlueprint>;
}
