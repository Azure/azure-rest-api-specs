import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace AutoScaleApi;
/**
 * The autoscale setting resource.
 */
model AutoscaleSettingResource is Azure.ResourceManager.TrackedResource<
  AutoscaleSetting,
  false
> {
  ...ResourceNameParameter<
    Resource = AutoscaleSettingResource,
    KeyName = "autoscaleSettingName",
    SegmentName = "autoscalesettings",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AutoscaleSettingResources {
  /**
   * Gets an autoscale setting
   */
  @tag("AutoscaleSettings")
  get is ArmResourceRead<
    AutoscaleSettingResource,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Creates or updates an autoscale setting.
   */
  @tag("AutoscaleSettings")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AutoscaleSettingResource,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Updates an existing AutoscaleSettingsResource. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AutoscaleSettingResource,
    PatchModel = AutoscaleSettingResourcePatch,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Deletes and autoscale setting
   */
  @tag("AutoscaleSettings")
  delete is ArmResourceDeleteSync<
    AutoscaleSettingResource,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Lists the autoscale settings for a resource group
   */
  @tag("AutoscaleSettings")
  listByResourceGroup is ArmResourceListByParent<
    AutoscaleSettingResource,
    Response = ArmResponse<AutoscaleSettingResourceCollection>,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Lists the autoscale settings for a subscription
   */
  @tag("AutoscaleSettings")
  listBySubscription is ArmListBySubscription<
    AutoscaleSettingResource,
    Response = ArmResponse<AutoscaleSettingResourceCollection>,
    Error = AutoscaleErrorResponse
  >;

  /**
   * get predictive autoscale metric future data
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable" "Existing predictiveMetricGet retains its response and SDK paging behavior; preserve published compatibility."
  @get
  @action("predictiveMetrics")
  @tag("Metrics")
  predictiveMetricGet is ArmResourceActionSync<
    AutoscaleSettingResource,
    void,
    ArmResponse<PredictiveResponse>,
    Parameters = {
      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing predictiveMetricGet.timespan retains the timespan query parameter; preserve wire compatibility."
      @query("timespan")
      timespan: string;

      /**
       * The interval (i.e. timegrain) of the query.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing predictiveMetricGet.interval retains the interval query parameter; preserve wire compatibility."
      @query("interval")
      interval: duration;

      /**
       * Metric namespace to query metric definitions for.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing predictiveMetricGet.metricNamespace retains the metricNamespace query parameter; preserve wire compatibility."
      @query("metricNamespace")
      metricNamespace: string;

      /**
       * The names of the metrics (comma separated) to retrieve. Special case: If a metricname itself has a comma in it then use %2 to indicate it. Eg: 'Metric,Name1' should be **'Metric%2Name1'**
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing predictiveMetricGet.metricName retains the metricName query parameter; preserve wire compatibility."
      @query("metricName")
      metricName: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing predictiveMetricGet.aggregation retains the aggregation query parameter; preserve wire compatibility."
      @query("aggregation")
      aggregation: string;
    },
    Error = AutoscaleErrorResponse
  >;
}

@@doc(AutoscaleSettingResource.name, "The autoscale setting name.");
@@doc(
  AutoscaleSettingResource.properties,
  "The autoscale setting of the resource."
);
@@doc(
  AutoscaleSettingResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@doc(
  AutoscaleSettingResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
