import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Blueprint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Blueprint;
@doc("Represents a published blueprint.")
@parentResource(Blueprint)
model PublishedBlueprint is ProxyResource<PublishedBlueprintProperties> {
  @doc("Version of the published blueprint definition.")
  @path
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

@@projectedName(PublishedBlueprints.create::parameters.resource,
  "json",
  "publishedBlueprint"
);
@@extension(PublishedBlueprints.create::parameters.resource,
  "x-ms-client-name",
  "publishedBlueprint"
);
@@doc(PublishedBlueprints.create::parameters.resource,
  "Published Blueprint to create or update."
);
