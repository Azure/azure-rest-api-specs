import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Trigger resource type.
 */
@parentResource(Factory)
model TriggerResource is Azure.ResourceManager.ProxyResource<Trigger, false> {
  ...ResourceNameParameter<
    Resource = TriggerResource,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = "^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface TriggerResources {
  /**
   * Gets a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_Get")
  get is ArmResourceRead<
    TriggerResource,
    Parameters = {
      /**
       * ETag of the trigger entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Triggers_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    TriggerResource,
    Parameters = {
      /**
       * ETag of the trigger entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<TriggerResource>
  >;

  /**
   * Deletes a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_Delete")
  delete is ArmResourceDeleteSync<TriggerResource>;

  /**
   * Lists triggers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_ListByFactory")
  listByFactory is ArmResourceListByParent<
    TriggerResource,
    Response = ArmResponse<TriggerListResponse>
  >;

  /**
   * Subscribe event trigger to events.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_SubscribeToEvents")
  subscribeToEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    ArmResponse<TriggerSubscriptionOperationStatus>
  >;

  /**
   * Get a trigger's event subscription status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_GetEventSubscriptionStatus")
  getEventSubscriptionStatus is ArmResourceActionSync<
    TriggerResource,
    void,
    ArmResponse<TriggerSubscriptionOperationStatus>
  >;

  /**
   * Unsubscribe event trigger from events.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_UnsubscribeFromEvents")
  unsubscribeFromEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    ArmResponse<TriggerSubscriptionOperationStatus>
  >;

  /**
   * Starts a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_Start")
  start is ArmResourceActionAsyncBase<
    TriggerResource,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<TriggerResource>
  >;

  /**
   * Stops a trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Triggers_Stop")
  stop is ArmResourceActionAsyncBase<
    TriggerResource,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<TriggerResource>
  >;

  /**
   * Rerun single trigger instance by runId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TriggerRuns_Rerun")
  rerun is ArmResourceActionSync<
    TriggerResource,
    void,
    OkResponse,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TriggerRuns_Cancel")
  cancel is ArmResourceActionSync<
    TriggerResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    }
  >;
}

@@maxLength(TriggerResource.name, 260);
@@minLength(TriggerResource.name, 1);
@@doc(TriggerResource.name, "The trigger name.");
@@doc(TriggerResource.properties, "Properties of the trigger.");
@@doc(TriggerResources.createOrUpdate::parameters.resource,
  "Trigger resource definition."
);
