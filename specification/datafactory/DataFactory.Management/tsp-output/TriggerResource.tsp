import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Trigger resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@includeInapplicableMetadataInPayload(false)
model TriggerResource extends SubResource {
  /**
   * The trigger name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("triggerName")
  @segment("triggers")
  @visibility("read")
  name: string;

  /**
   * Properties of the trigger.
   */
  @extension("x-ms-client-flatten", true)
  properties: Trigger;
}

@armResourceOperations
interface TriggerResources {
  /**
   * Gets a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_Get")
  get is ArmResourceRead<
    TriggerResource,
    {
      ...BaseParameters<TriggerResource>;

      /**
       * ETag of the trigger entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    TriggerResource,
    {
      ...BaseParameters<TriggerResource>;

      /**
       * ETag of the trigger entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_Delete")
  delete is ArmResourceDeleteSync<TriggerResource>;

  /**
   * Lists triggers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_ListByFactory")
  listByFactory is ArmResourceListByParent<TriggerResource>;

  /**
   * Subscribe event trigger to events.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_SubscribeToEvents")
  subscribeToEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    TriggerSubscriptionOperationStatus
  >;

  /**
   * Get a trigger's event subscription status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_GetEventSubscriptionStatus")
  getEventSubscriptionStatus is ArmResourceActionSync<
    TriggerResource,
    void,
    TriggerSubscriptionOperationStatus
  >;

  /**
   * Unsubscribe event trigger from events.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_UnsubscribeFromEvents")
  unsubscribeFromEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    TriggerSubscriptionOperationStatus
  >;

  /**
   * Starts a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_Start")
  start is ArmResourceActionAsync<TriggerResource, void, void>;

  /**
   * Stops a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_Stop")
  stop is ArmResourceActionAsync<TriggerResource, void, void>;

  /**
   * Rerun single trigger instance by runId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TriggerRuns_Rerun")
  rerun is ArmResourceActionSync<
    TriggerResource,
    void,
    void,
    {
      ...BaseParameters<TriggerResource>;

      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    }
  >;

  /**
   * Cancel a single trigger instance by runId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TriggerRuns_Cancel")
  cancel is ArmResourceActionSync<
    TriggerResource,
    void,
    void,
    {
      ...BaseParameters<TriggerResource>;

      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    }
  >;
}

@@projectedName(TriggerResources.createOrUpdate::parameters.resource,
  "json",
  "trigger"
);
@@extension(TriggerResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "trigger"
);
@@doc(TriggerResources.createOrUpdate::parameters.resource,
  "Trigger resource definition."
);
