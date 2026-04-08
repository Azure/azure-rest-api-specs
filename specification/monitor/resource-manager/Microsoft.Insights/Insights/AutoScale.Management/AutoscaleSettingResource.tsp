import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The autoscale setting resource.
 */
model AutoscaleSettingResource
  is Azure.ResourceManager.TrackedResource<AutoscaleSetting, false> {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AutoscaleSettings_Get")
  @tag("AutoscaleSettings")
  get is ArmResourceRead<
    AutoscaleSettingResource,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Creates or updates an autoscale setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AutoscaleSettings_CreateOrUpdate")
  @tag("AutoscaleSettings")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AutoscaleSettingResource,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Updates an existing AutoscaleSettingsResource. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AutoscaleSettings_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AutoscaleSettingResource,
    PatchModel = AutoscaleSettingResourcePatch,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Deletes and autoscale setting
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AutoscaleSettings_Delete")
  @tag("AutoscaleSettings")
  delete is ArmResourceDeleteSync<
    AutoscaleSettingResource,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Lists the autoscale settings for a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AutoscaleSettings_ListByResourceGroup")
  @tag("AutoscaleSettings")
  listByResourceGroup is ArmResourceListByParent<
    AutoscaleSettingResource,
    Response = ArmResponse<AutoscaleSettingResourceCollection>,
    Error = AutoscaleErrorResponse
  >;

  /**
   * Lists the autoscale settings for a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AutoscaleSettings_ListBySubscription")
  @tag("AutoscaleSettings")
  listBySubscription is ArmListBySubscription<
    AutoscaleSettingResource,
    Response = ArmResponse<AutoscaleSettingResourceCollection>,
    Error = AutoscaleErrorResponse
  >;

  /**
   * get predictive autoscale metric future data
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PredictiveMetric_Get")
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
      @query("timespan")
      timespan: string;

      /**
       * The interval (i.e. timegrain) of the query.
       */
      @query("interval")
      interval: duration;

      /**
       * Metric namespace to query metric definitions for.
       */
      @query("metricNamespace")
      metricNamespace: string;

      /**
       * The names of the metrics (comma separated) to retrieve. Special case: If a metricname itself has a comma in it then use %2 to indicate it. Eg: 'Metric,Name1' should be **'Metric%2Name1'**
       */
      @query("metricName")
      metricName: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       */
      @query("aggregation")
      aggregation: string;
    },
    Error = AutoscaleErrorResponse
  >;
}

@@doc(AutoscaleSettingResource.name, "The autoscale setting name.");
@@doc(AutoscaleSettingResource.properties,
  "The autoscale setting of the resource."
);
@@doc(AutoscaleSettingResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@doc(AutoscaleSettingResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
