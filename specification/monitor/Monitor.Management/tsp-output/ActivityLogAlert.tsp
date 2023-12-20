import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("An Activity Log Alert rule resource.")
model ActivityLogAlert is TrackedResource<AlertRuleProperties> {
  @doc("The name of the Activity Log Alert rule.")
  @path
  @key("activityLogAlertName")
  @segment("activityLogAlerts")
  name: string;
}

@armResourceOperations
interface ActivityLogAlerts {
  @doc("Get an Activity Log Alert rule.")
  get is ArmResourceRead<ActivityLogAlert>;
  @doc("Create a new Activity Log Alert rule or update an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActivityLogAlert>;
  @doc("Updates 'tags' and 'enabled' fields in an existing Alert rule. This method is used to update the Alert rule tags, and to enable or disable the Alert rule. To update other fields use CreateOrUpdate operation.")
  update is ArmResourcePatchSync<ActivityLogAlert, AlertRuleProperties>;
  @doc("Delete an Activity Log Alert rule.")
  delete is ArmResourceDeleteSync<ActivityLogAlert>;
  @doc("Get a list of all Activity Log Alert rules in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ActivityLogAlert>;
  @doc("Get a list of all Activity Log Alert rules in a subscription.")
  listBySubscriptionId is ArmListBySubscription<ActivityLogAlert>;
}
