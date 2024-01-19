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

namespace Microsoft.Insights;
@doc("An Activity Log Alert rule resource.")
model ActivityLogAlertResource is TrackedResource<AlertRuleProperties> {
  @doc("The name of the Activity Log Alert rule.")
  @path
  @key("activityLogAlertName")
  @segment("activityLogAlerts")
  name: string;
}

@armResourceOperations
interface ActivityLogAlertResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an Activity Log Alert rule.")
  @operationId("ActivityLogAlerts_Get")
  get is ArmResourceRead<ActivityLogAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new Activity Log Alert rule or update an existing one.")
  @operationId("ActivityLogAlerts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActivityLogAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates 'tags' and 'enabled' fields in an existing Alert rule. This method is used to update the Alert rule tags, and to enable or disable the Alert rule. To update other fields use CreateOrUpdate operation.")
  @operationId("ActivityLogAlerts_Update")
  update is ArmCustomPatchSync<ActivityLogAlertResource, AlertRulePatchObject>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an Activity Log Alert rule.")
  @operationId("ActivityLogAlerts_Delete")
  delete is ArmResourceDeleteSync<ActivityLogAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of all Activity Log Alert rules in a resource group.")
  @operationId("ActivityLogAlerts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ActivityLogAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of all Activity Log Alert rules in a subscription.")
  @operationId("ActivityLogAlerts_ListBySubscriptionId")
  listBySubscriptionId is ArmListBySubscription<ActivityLogAlertResource>;
}

@@projectedName(ActivityLogAlertResources.createOrUpdate::parameters.resource,
  "json",
  "activityLogAlertRule"
);
@@extension(ActivityLogAlertResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "activityLogAlertRule"
);
@@doc(ActivityLogAlertResources.createOrUpdate::parameters.resource,
  "The Activity Log Alert rule to create or use for the update."
);
@@projectedName(ActivityLogAlertResources.update::parameters.properties,
  "json",
  "activityLogAlertRulePatch"
);
@@extension(ActivityLogAlertResources.update::parameters.properties,
  "x-ms-client-name",
  "activityLogAlertRulePatch"
);
@@doc(ActivityLogAlertResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
