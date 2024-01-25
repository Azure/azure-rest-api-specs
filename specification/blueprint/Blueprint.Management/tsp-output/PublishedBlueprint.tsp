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
/**
 * Represents a published blueprint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Blueprint)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(PublishedBlueprintProperties)
model PublishedBlueprint extends ProxyResourceBase {
  /**
   * Version of the published blueprint definition.
   */
  @path
  @key("versionId")
  @segment("versions")
  @visibility("read")
  name: string;

  /**
   * Detailed properties for published blueprint.
   */
  @extension("x-ms-client-flatten", true)
  properties: PublishedBlueprintProperties;
}

@armResourceOperations
interface PublishedBlueprints {
  /**
   * Get a published version of a blueprint definition.
   */
  get is ArmResourceRead<PublishedBlueprint>;

  /**
   * Publish a new version of the blueprint definition with the latest artifacts. Published blueprint definitions are immutable.
   */
  create is ArmResourceCreateOrReplaceSync<PublishedBlueprint>;

  /**
   * Delete a published version of a blueprint definition.
   */
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
