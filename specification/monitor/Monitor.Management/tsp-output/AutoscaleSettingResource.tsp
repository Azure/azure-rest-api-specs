import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("The autoscale setting resource.")
model AutoscaleSettingResource is TrackedResource<AutoscaleSetting> {
  @doc("The autoscale setting name.")
  @path
  @key("autoscaleSettingName")
  @segment("autoscalesettings")
  name: string;
}

@armResourceOperations
interface AutoscaleSettings {
  @doc("Gets an autoscale setting")
  get is ArmResourceRead<AutoscaleSettingResource>;
  @doc("Creates or updates an autoscale setting.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutoscaleSettingResource>;
  @doc("Updates an existing AutoscaleSettingsResource. To update other fields use the CreateOrUpdate method.")
  update is ArmResourcePatchSync<AutoscaleSettingResource, AutoscaleSetting>;
  @doc("Deletes and autoscale setting")
  delete is ArmResourceDeleteSync<AutoscaleSettingResource>;
  @doc("Lists the autoscale settings for a resource group")
  listByResourceGroup is ArmResourceListByParent<AutoscaleSettingResource>;
  @doc("Lists the autoscale settings for a subscription")
  listBySubscription is ArmListBySubscription<AutoscaleSettingResource>;
}

@armResourceOperations
interface PredictiveMetric {
  @doc("get predictive autoscale metric future data")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Insights/autoscalesettings/{autoscaleSettingName}/predictiveMetrics")
  @get
  Get is Azure.Core.Foundations.Operation<
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

      @doc("The autoscale setting name.")
      @path
      autoscaleSettingName: string;

      @doc("The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.")
      @query("timespan")
      timespan: string;

      @doc("The interval (i.e. timegrain) of the query.")
      @query("interval")
      interval: duration;

      @doc("Metric namespace to query metric definitions for.")
      @query("metricNamespace")
      metricNamespace: string;

      @doc("The names of the metrics (comma separated) to retrieve. Special case: If a metricname itself has a comma in it then use %2 to indicate it. Eg: 'Metric,Name1' should be **'Metric%2Name1'**")
      @query("metricName")
      metricName: string;

      @doc("The list of aggregation types (comma separated) to retrieve.")
      @query("aggregation")
      aggregation: string;
    },
    PredictiveResponse
  >;
}
