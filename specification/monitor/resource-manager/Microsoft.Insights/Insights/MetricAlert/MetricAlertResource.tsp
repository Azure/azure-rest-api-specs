import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.MetricAlert;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

alias MetricAlertResourcesOps = Azure.ResourceManager.Legacy.RoutedOperations<
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
  @tag("MetricAlerts")
  get is ArmResourceRead<
    MetricAlertResource,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Create or update an metric alert definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("MetricAlerts")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MetricAlertResource,
    Response = ArmResourceUpdatedResponse<MetricAlertResource>,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Update an metric alert definition.
   */
  @patch(#{ implicitOptionality: false })
  @tag("MetricAlerts")
  update is ArmCustomPatchSync<
    MetricAlertResource,
    PatchModel = MetricAlertResourcePatch,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Delete an alert rule definition.
   */
  @tag("MetricAlerts")
  delete is ArmResourceDeleteSync<
    MetricAlertResource,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Retrieve alert rule definitions in a resource group.
   */
  @tag("MetricAlerts")
  listByResourceGroup is ArmResourceListByParent<
    MetricAlertResource,
    Response = ArmResponse<MetricAlertResourceCollection>,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Retrieve alert rule definitions in a subscription.
   */
  @tag("MetricAlerts")
  listBySubscription is ArmListBySubscription<
    MetricAlertResource,
    Response = ArmResponse<MetricAlertResourceCollection>,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Retrieve an alert rule status.
   */
  @list
  @get
  @action("status")
  @tag("MetricAlertsStatus")
  list is ArmResourceActionSync<
    MetricAlertResource,
    void,
    ArmResponse<MetricAlertStatusCollection>,
    Error = Microsoft.Common.ErrorResponse
  >;

  /**
   * Retrieve an alert rule status.
   */
  @list
  @get
  @tag("MetricAlertsStatus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}")
  listByName is MetricAlertResourcesOps.ActionSync<
    MetricAlertResource,
    void,
    ArmResponse<MetricAlertStatusCollection>,
    OverrideErrorType = Microsoft.Common.ErrorResponse
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
