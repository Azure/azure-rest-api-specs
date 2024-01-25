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
/**
 * The autoscale setting resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AutoscaleSetting)
model AutoscaleSettingResource extends TrackedResourceBase {
  /**
   * The autoscale setting name.
   */
  @path
  @key("autoscaleSettingName")
  @segment("autoscalesettings")
  @visibility("read")
  name: string;

  /**
   * The autoscale setting of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: AutoscaleSetting;
}

@armResourceOperations
interface AutoscaleSettingResources {
  /**
   * Gets an autoscale setting
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutoscaleSettings_Get")
  get is ArmResourceRead<AutoscaleSettingResource>;

  /**
   * Creates or updates an autoscale setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutoscaleSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutoscaleSettingResource>;

  /**
   * Updates an existing AutoscaleSettingsResource. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AutoscaleSettings_Update")
  update is ArmCustomPatchSync<
    AutoscaleSettingResource,
    AutoscaleSettingResourcePatch
  >;

  /**
   * Deletes and autoscale setting
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutoscaleSettings_Delete")
  delete is ArmResourceDeleteSync<AutoscaleSettingResource>;

  /**
   * Lists the autoscale settings for a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutoscaleSettings_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AutoscaleSettingResource>;

  /**
   * Lists the autoscale settings for a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutoscaleSettings_ListBySubscription")
  listBySubscription is ArmListBySubscription<AutoscaleSettingResource>;

  /**
   * get predictive autoscale metric future data
   */
  // FIXME: PredictiveMetric_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PredictiveMetric_Get")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Insights/autoscalesettings/{autoscaleSettingName}/predictiveMetrics")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The autoscale setting name.
       */
      @path
      autoscaleSettingName: string;

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
