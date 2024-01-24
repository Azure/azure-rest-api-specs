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

namespace Microsoft.CostManagement;
/**
 * Scheduled action definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(ScheduledActionProperties)
@includeInapplicableMetadataInPayload(false)
model ScheduledAction extends ProxyResourceBase {
  /**
   * Scheduled action name.
   */
  @path
  @key("name")
  @segment("scheduledActions")
  name: string;

  /**
   * The properties of the scheduled action.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScheduledActionProperties;
}

@armResourceOperations
interface ScheduledActions {
  /**
   * Get the private scheduled action by name.
   */
  get is ArmResourceRead<ScheduledAction>;

  /**
   * Create or update a private scheduled action.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ScheduledAction,
    {
      ...BaseParameters<ScheduledAction>;

      /**
       * ETag of the Entity. Not required when creating an entity. Optional when updating an entity and can be specified to achieve optimistic concurrency.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Delete a private scheduled action.
   */
  delete is ArmResourceDeleteSync<ScheduledAction>;

  /**
   * Processes a private scheduled action.
   */
  run is ArmResourceActionSync<ScheduledAction, void, void>;
}

@@projectedName(ScheduledActions.createOrUpdate::parameters.resource,
  "json",
  "scheduledAction"
);
@@extension(ScheduledActions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "scheduledAction"
);
@@doc(ScheduledActions.createOrUpdate::parameters.resource,
  "Scheduled action to be created or updated."
);
