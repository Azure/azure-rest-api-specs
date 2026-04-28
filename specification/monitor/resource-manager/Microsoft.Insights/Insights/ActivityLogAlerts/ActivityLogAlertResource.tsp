import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ActivityLogAlerts;
/**
 * An Activity Log Alert rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ActivityLogAlertResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<AlertRuleProperties> {
  ...ResourceNameParameter<
    Resource = ActivityLogAlertResource,
    KeyName = "activityLogAlertName",
    SegmentName = "activityLogAlerts",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ActivityLogAlertResources {
  /**
   * Get an Activity Log Alert rule.
   */
  get is ArmResourceRead<
    ActivityLogAlertResource,
    Error = ActivityLogAlertErrorResponse
  >;

  /**
   * Create a new Activity Log Alert rule or update an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ActivityLogAlertResource,
    Error = ActivityLogAlertErrorResponse
  >;

  /**
   * Updates 'tags' and 'enabled' fields in an existing Alert rule. This method is used to update the Alert rule tags, and to enable or disable the Alert rule. To update other fields use CreateOrUpdate operation.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ActivityLogAlertResource,
    PatchModel = AlertRulePatchObject,
    Error = ActivityLogAlertErrorResponse
  >;

  /**
   * Delete an Activity Log Alert rule.
   */
  delete is ArmResourceDeleteSync<
    ActivityLogAlertResource,
    Error = ActivityLogAlertErrorResponse
  >;

  /**
   * Get a list of all Activity Log Alert rules in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ActivityLogAlertResource,
    Response = ArmResponse<AlertRuleList>,
    Error = ActivityLogAlertErrorResponse
  >;

  /**
   * Get a list of all Activity Log Alert rules in a subscription.
   */
  listBySubscriptionId is ArmListBySubscription<
    ActivityLogAlertResource,
    Response = ArmResponse<AlertRuleList>,
    Error = ActivityLogAlertErrorResponse
  >;
}

@@doc(ActivityLogAlertResource.name,
  "The name of the Activity Log Alert rule."
);
@@doc(ActivityLogAlertResource.properties,
  "The Activity Log Alert rule properties of the resource."
);
@@doc(ActivityLogAlertResources.createOrUpdate::parameters.resource,
  "The Activity Log Alert rule to create or use for the update."
);
@@doc(ActivityLogAlertResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
