import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("The metric alert resource.")
model MetricAlertResource is TrackedResource<MetricAlertProperties> {
  @doc("The name of the rule.")
  @key("ruleName")
  @segment("metricAlerts")
  name: string;
}

@armResourceOperations
@projectedName("client", "MetricAlerts")
interface MetricAlertResources_MetricAlerts {
  @doc("Retrieve an alert rule definition.")
  get is ArmResourceRead<MetricAlertResource>;

  @doc("Create or update an metric alert definition.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MetricAlertResource>;

  @doc("Update an metric alert definition.")
  update is ArmCustomPatchSync<MetricAlertResource, MetricAlertResourcePatch>;

  @doc("Delete an alert rule definition.")
  delete is ArmResourceDeleteSync<MetricAlertResource>;

  @doc("Retrieve alert rule definitions in a resource group.")
  listByResourceGroup is ArmResourceListByParent<MetricAlertResource>;

  @doc("Retrieve alert rule definitions in a subscription.")
  listBySubscription is ArmListBySubscription<MetricAlertResource>;
}

@armResourceOperations
@projectedName("client", "MetricAlertsStatus")
interface MetricAlertResources_MetricAlertsStatus {
  @doc("Retrieve an alert rule status.")
  // FIXME: MetricAlertsStatus_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status")
  @get
  List is Azure.Core.Foundations.Operation<
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

  @doc("Retrieve an alert rule status.")
  // FIXME: MetricAlertsStatus_ListByName could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}")
  @get
  ListByName is Azure.Core.Foundations.Operation<
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
