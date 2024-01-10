import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("An Activity Log Alert rule resource.")
model ActivityLogAlertResource is TrackedResource<AlertRuleProperties> {
  @doc("The name of the Activity Log Alert rule.")
  @key("activityLogAlertName")
  @segment("activityLogAlerts")
  name: string;
}

@armResourceOperations
@projectedName("client", "ActivityLogAlerts")
interface ActivityLogAlertResources_ActivityLogAlerts {
  @doc("Get an Activity Log Alert rule.")
  get is ArmResourceRead<ActivityLogAlertResource>;

  @doc("Create a new Activity Log Alert rule or update an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActivityLogAlertResource>;

  @doc("Updates 'tags' and 'enabled' fields in an existing Alert rule. This method is used to update the Alert rule tags, and to enable or disable the Alert rule. To update other fields use CreateOrUpdate operation.")
  update is ArmCustomPatchSync<ActivityLogAlertResource, AlertRulePatchObject>;

  @doc("Delete an Activity Log Alert rule.")
  delete is ArmResourceDeleteSync<ActivityLogAlertResource>;

  @doc("Get a list of all Activity Log Alert rules in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ActivityLogAlertResource>;

  @doc("Get a list of all Activity Log Alert rules in a subscription.")
  listBySubscriptionId is ArmListBySubscription<ActivityLogAlertResource>;
}
