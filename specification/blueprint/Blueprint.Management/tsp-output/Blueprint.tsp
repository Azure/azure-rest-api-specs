import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Blueprint;
/**
 * Represents a Blueprint definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(BlueprintProperties)
model Blueprint extends ExtensionResourceBase {
  /**
   * Name of the blueprint definition.
   */
  @path
  @key("blueprintName")
  @segment("blueprints")
  @visibility("read")
  name: string;

  /**
   * Detailed properties for blueprint definition.
   */
  @extension("x-ms-client-flatten", true)
  properties: BlueprintProperties;
}

@armResourceOperations
interface Blueprints {
  /**
   * Get a blueprint definition.
   */
  get is ArmResourceRead<Blueprint>;

  /**
   * Create or update a blueprint definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Blueprint>;

  /**
   * Delete a blueprint definition.
   */
  delete is ArmResourceDeleteSync<Blueprint>;

  /**
   * List blueprint definitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Blueprints_List")
  list is ArmResourceListByParent<Blueprint>;

  /**
   * List published versions of given blueprint definition.
   */
  // FIXME: PublishedBlueprints_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PublishedBlueprints_List")
  @route("/{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions")
  @get
  listPub is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the resource. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}').
       */
      @path
      resourceScope: string;

      /**
       * Name of the blueprint definition.
       */
      @path
      blueprintName: string;
    },
    PublishedBlueprintList
  >;
}

@@projectedName(Blueprints.createOrUpdate::parameters.resource,
  "json",
  "blueprint"
);
@@extension(Blueprints.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "blueprint"
);
@@doc(Blueprints.createOrUpdate::parameters.resource, "Blueprint definition.");
