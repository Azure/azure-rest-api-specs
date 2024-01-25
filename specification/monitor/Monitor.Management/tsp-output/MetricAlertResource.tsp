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
 * The metric alert resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(MetricAlertProperties)
model MetricAlertResource extends TrackedResourceBase {
  /**
   * The name of the rule.
   */
  @path
  @key("ruleName")
  @segment("metricAlerts")
  @visibility("read")
  name: string;

  /**
   * The alert rule properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: MetricAlertProperties;
}

@armResourceOperations
interface MetricAlertResources {
  /**
   * Retrieve an alert rule definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlerts_Get")
  get is ArmResourceRead<MetricAlertResource>;

  /**
   * Create or update an metric alert definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlerts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MetricAlertResource>;

  /**
   * Update an metric alert definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("MetricAlerts_Update")
  update is ArmCustomPatchSync<MetricAlertResource, MetricAlertResourcePatch>;

  /**
   * Delete an alert rule definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlerts_Delete")
  delete is ArmResourceDeleteSync<MetricAlertResource>;

  /**
   * Retrieve alert rule definitions in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlerts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MetricAlertResource>;

  /**
   * Retrieve alert rule definitions in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlerts_ListBySubscription")
  listBySubscription is ArmListBySubscription<MetricAlertResource>;

  /**
   * Retrieve an alert rule status.
   */
  // FIXME: MetricAlertsStatus_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlertsStatus_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status")
  @get
  list is Azure.Core.Foundations.Operation<
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
       * The name of the rule.
       */
      @path
      ruleName: string;
    },
    MetricAlertStatusCollection
  >;

  /**
   * Retrieve an alert rule status.
   */
  // FIXME: MetricAlertsStatus_ListByName could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricAlertsStatus_ListByName")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/metricAlerts/{ruleName}/status/{statusName}")
  @get
  listByName is Azure.Core.Foundations.Operation<
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
       * The name of the rule.
       */
      @path
      ruleName: string;

      /**
       * The name of the status.
       */
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
