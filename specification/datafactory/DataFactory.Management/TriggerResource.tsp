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

alias TriggerRunsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("factories")
    @key
    @maxLength(63)
    @minLength(3)
    @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
    factoryName: string;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("triggers")
    @key
    @maxLength(260)
    @minLength(1)
    @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
    triggerName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface TriggerResources {
  /**
   * Gets a trigger.
   */
  get is ArmResourceRead<
    TriggerResource,
    Parameters = {
      /**
       * ETag of the trigger entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<TriggerResource> | NotModifiedResponse,
    Error = CloudError
  >;

  /**
   * Creates or updates a trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    Response = ArmResourceUpdatedResponse<TriggerResource>,
    Error = CloudError
  >;

  /**
   * Deletes a trigger.
   */
  delete is ArmResourceDeleteSync<TriggerResource, Error = CloudError>;

  /**
   * Lists triggers.
   */
  listByFactory is ArmResourceListByParent<
    TriggerResource,
    Response = ArmResponse<TriggerListResponse>,
    Error = CloudError
  >;

  /**
   * Subscribe event trigger to events.
   */
  subscribeToEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    ArmResponse<TriggerSubscriptionOperationStatus>,
    Error = CloudError
  >;

  /**
   * Get a trigger's event subscription status.
   */
  getEventSubscriptionStatus is ArmResourceActionSync<
    TriggerResource,
    void,
    ArmResponse<TriggerSubscriptionOperationStatus>,
    Error = CloudError
  >;

  /**
   * Unsubscribe event trigger from events.
   */
  unsubscribeFromEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    ArmResponse<TriggerSubscriptionOperationStatus>,
    Error = CloudError
  >;

  /**
   * Starts a trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start is ArmResourceActionAsyncBase<
    TriggerResource,
    void,
    OkResponse & ArmLroLocationHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<TriggerResource>,
    Error = CloudError
  >;

  /**
   * Stops a trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  stop is ArmResourceActionAsyncBase<
    TriggerResource,
    void,
    OkResponse & ArmLroLocationHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<TriggerResource>,
    Error = CloudError
  >;

  /**
   * Rerun single trigger instance by runId.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/rerun")
  rerun is TriggerRunsOps.ActionSync<
    TriggerResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Cancel a single trigger instance by runId.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/triggers/{triggerName}/triggerRuns/{runId}/cancel")
  cancel is TriggerRunsOps.ActionSync<
    TriggerResource,
    void,
    OkResponse,
    Parameters = {
      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    },
    OverrideErrorType = CloudError
  >;
}

@@maxLength(TriggerResource.name, 260);
@@minLength(TriggerResource.name, 1);
@@doc(TriggerResource.name, "The trigger name.");
@@doc(TriggerResource.properties, "Properties of the trigger.");
@@doc(TriggerResources.createOrUpdate::parameters.resource,
  "Trigger resource definition."
);
