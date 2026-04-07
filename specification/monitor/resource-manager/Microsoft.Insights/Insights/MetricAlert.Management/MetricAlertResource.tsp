import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The metric alert resource.
 */
model MetricAlertResource
  is Azure.ResourceManager.TrackedResource<MetricAlertProperties, false> {
  ...ResourceNameParameter<
    Resource = MetricAlertResource,
    KeyName = "ruleName",
    SegmentName = "metricAlerts",
    NamePattern = ""
  >;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

alias MetricAlertResourcesiOps = Azure.ResourceManager.Legacy.RoutedOperations<
  MetricAlertResourcesParentParameters,
  MetricAlertResourcesParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}",
  }
>;

alias MetricAlertResourcesParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   * The name of the rule.
   */
  @path
  @segment("metricAlerts")
  ruleName: string;
};

alias MetricAlertResourcesParameters = {
  /**
   * The name of the status.
   */
  @path
  @segment("status")
  statusName: string;
};

@armResourceOperations(#{ omitTags: true, allowStaticRoutes: true })
interface MetricAlertResources {
  /**
   * Retrieve an alert rule definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlerts_Get")
  @tag("MetricAlerts")
  get is ArmResourceRead<MetricAlertResource, Error = ErrorResponse>;

  /**
   * Create or update an metric alert definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MetricAlerts_CreateOrUpdate")
  @tag("MetricAlerts")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MetricAlertResource,
    Response = ArmResourceUpdatedResponse<MetricAlertResource>,
    Error = ErrorResponse
  >;

  /**
   * Update an metric alert definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlerts_Update")
  @patch(#{ implicitOptionality: false })
  @tag("MetricAlerts")
  update is ArmCustomPatchSync<
    MetricAlertResource,
    PatchModel = MetricAlertResourcePatch,
    Error = ErrorResponse
  >;

  /**
   * Delete an alert rule definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlerts_Delete")
  @tag("MetricAlerts")
  delete is ArmResourceDeleteSync<MetricAlertResource, Error = ErrorResponse>;

  /**
   * Retrieve alert rule definitions in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlerts_ListByResourceGroup")
  @tag("MetricAlerts")
  listByResourceGroup is ArmResourceListByParent<
    MetricAlertResource,
    Response = ArmResponse<MetricAlertResourceCollection>,
    Error = ErrorResponse
  >;

  /**
   * Retrieve alert rule definitions in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlerts_ListBySubscription")
  @tag("MetricAlerts")
  listBySubscription is ArmListBySubscription<
    MetricAlertResource,
    Response = ArmResponse<MetricAlertResourceCollection>,
    Error = ErrorResponse
  >;

  /**
   * Retrieve an alert rule status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlertsStatus_List")
  @list
  @get
  @action("status")
  @tag("MetricAlertsStatus")
  list is ArmResourceActionSync<
    MetricAlertResource,
    void,
    ArmResponse<MetricAlertStatusCollection>,
    Error = ErrorResponse
  >;

  /**
   * Retrieve an alert rule status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MetricAlertsStatus_ListByName")
  @list
  @get
  @tag("MetricAlertsStatus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}")
  listByName is MetricAlertResourcesiOps.ActionSync<
    MetricAlertResource,
    void,
    ArmResponse<MetricAlertStatusCollection>,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(MetricAlertResource.name, "The name of the rule.");
@@doc(MetricAlertResource.properties,
  "The alert rule properties of the resource."
);
@@doc(MetricAlertResources.createOrUpdate::parameters.resource,
  "The parameters of the rule to create or update."
);
@@doc(MetricAlertResources.update::parameters.properties,
  "The parameters of the rule to update."
);
