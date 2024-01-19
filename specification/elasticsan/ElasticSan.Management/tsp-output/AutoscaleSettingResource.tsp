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
@doc("The autoscale setting resource.")
model AutoscaleSettingResource is TrackedResource<AutoscaleSetting> {
  @doc("The autoscale setting name.")
  @path
  @key("autoscaleSettingName")
  @segment("autoscalesettings")
  name: string;
}

@armResourceOperations
interface AutoscaleSettingResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an autoscale setting")
  @operationId("AutoscaleSettings_Get")
  get is ArmResourceRead<AutoscaleSettingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an autoscale setting.")
  @operationId("AutoscaleSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutoscaleSettingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing AutoscaleSettingsResource. To update other fields use the CreateOrUpdate method.")
  @operationId("AutoscaleSettings_Update")
  update is ArmCustomPatchSync<
    AutoscaleSettingResource,
    AutoscaleSettingResourcePatch
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes and autoscale setting")
  @operationId("AutoscaleSettings_Delete")
  delete is ArmResourceDeleteSync<AutoscaleSettingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the autoscale settings for a resource group")
  @operationId("AutoscaleSettings_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AutoscaleSettingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the autoscale settings for a subscription")
  @operationId("AutoscaleSettings_ListBySubscription")
  listBySubscription is ArmListBySubscription<AutoscaleSettingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PredictiveMetric_Get")
  @doc("get predictive autoscale metric future data")
  // FIXME: PredictiveMetric_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Insights/autoscalesettings/{autoscaleSettingName}/predictiveMetrics")
  @get
  get is Azure.Core.Foundations.Operation<
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

@@projectedName(AutoscaleSettingResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AutoscaleSettingResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AutoscaleSettingResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@projectedName(AutoscaleSettingResources.update::parameters.properties,
  "json",
  "autoscaleSettingResource"
);
@@extension(AutoscaleSettingResources.update::parameters.properties,
  "x-ms-client-name",
  "autoscaleSettingResource"
);
@@doc(AutoscaleSettingResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
