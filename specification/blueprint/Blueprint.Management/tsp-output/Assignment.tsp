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
 * Represents a blueprint assignment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(AssignmentProperties)
@includeInapplicableMetadataInPayload(false)
model Assignment extends ExtensionResourceBase {
  /**
   * Name of the blueprint assignment.
   */
  @path
  @key("assignmentName")
  @segment("blueprintAssignments")
  name: string;

  /**
   * Properties for blueprint assignment object.
   */
  @extension("x-ms-client-flatten", true)
  properties: AssignmentProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Assignments {
  /**
   * Get a blueprint assignment.
   */
  get is ArmResourceRead<Assignment>;

  /**
   * Create or update a blueprint assignment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Assignment>;

  /**
   * Delete a blueprint assignment.
   */
  delete is ArmResourceDeleteSync<
    Assignment,
    {
      ...BaseParameters<Assignment>;

      /**
       * When deleteBehavior=all, the resources that were created by the blueprint assignment will be deleted.
       */
      @query("deleteBehavior")
      deleteBehavior?: AssignmentDeleteBehavior;
    }
  >;

  /**
   * List blueprint assignments within a subscription or a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Assignments_List")
  list is ArmResourceListByParent<Assignment>;

  /**
   * Get Blueprints service SPN objectId
   */
  whoIsBlueprint is ArmResourceActionSync<
    Assignment,
    void,
    WhoIsBlueprintContract
  >;
}

@@projectedName(Assignments.createOrUpdate::parameters.resource,
  "json",
  "assignment"
);
@@extension(Assignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "assignment"
);
@@doc(Assignments.createOrUpdate::parameters.resource,
  "Blueprint assignment object to save."
);
