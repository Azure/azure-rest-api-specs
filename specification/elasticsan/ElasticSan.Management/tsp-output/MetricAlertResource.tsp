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
@doc("The metric alert resource.")
model MetricAlertResource is TrackedResource<MetricAlertProperties> {
  @doc("The name of the rule.")
  @path
  @key("ruleName")
  @segment("metricAlerts")
  name: string;
}

@armResourceOperations
interface MetricAlertResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve an alert rule definition.")
  @operationId("MetricAlerts_Get")
  get is ArmResourceRead<MetricAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update an metric alert definition.")
  @operationId("MetricAlerts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MetricAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an metric alert definition.")
  @operationId("MetricAlerts_Update")
  update is ArmCustomPatchSync<MetricAlertResource, MetricAlertResourcePatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an alert rule definition.")
  @operationId("MetricAlerts_Delete")
  delete is ArmResourceDeleteSync<MetricAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve alert rule definitions in a resource group.")
  @operationId("MetricAlerts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MetricAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve alert rule definitions in a subscription.")
  @operationId("MetricAlerts_ListBySubscription")
  listBySubscription is ArmListBySubscription<MetricAlertResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlertsStatus_List")
  @doc("Retrieve an alert rule status.")
  // FIXME: MetricAlertsStatus_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the rule.")
      @path
      ruleName: string;
    },
    MetricAlertStatusCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlertsStatus_ListByName")
  @doc("Retrieve an alert rule status.")
  // FIXME: MetricAlertsStatus_ListByName could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}")
  @get
  listByName is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the rule.")
      @path
      ruleName: string;

      @doc("The name of the status.")
      @path
      statusName: string;
    },
    MetricAlertStatusCollection
  >;
}

@@projectedName(MetricAlertResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(MetricAlertResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(MetricAlertResources.createOrUpdate::parameters.resource,
  "The parameters of the rule to create or update."
);
@@projectedName(MetricAlertResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(MetricAlertResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(MetricAlertResources.update::parameters.properties,
  "The parameters of the rule to update."
);
