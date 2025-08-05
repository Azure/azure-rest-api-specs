import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Datadog;
/**
 * The request to update subscriptions needed to be monitored by the Datadog monitor resource.
 */
@parentResource(DatadogMonitorResource)
model MonitoredSubscriptionProperties
  is Azure.ResourceManager.ProxyResource<SubscriptionList> {
  ...ResourceNameParameter<
    Resource = MonitoredSubscriptionProperties,
    KeyName = "configurationName",
    SegmentName = "monitoredSubscriptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MonitoredSubscriptionsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Monitor resource name
         */
        @path
        @segment("monitors")
        monitorName: string,
      },
      {
        /**
         * The configuration name. Only 'default' value is supported.
         */
        @path
        @segment("monitoredSubscriptions")
        configurationName: string,
      },
      ErrorResponse
    > {}

@armResourceOperations
interface MonitoredSubscriptions {
  /**
   * List the subscriptions currently being monitored by the Datadog monitor resource.
   */
  get is ArmResourceRead<MonitoredSubscriptionProperties>;

  /**
   * Add the subscriptions that should be monitored by the Datadog monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createorUpdate is MonitoredSubscriptionsOps.CreateOrUpdateAsync<
    MonitoredSubscriptionProperties,
    Response = ArmResourceUpdatedResponse<MonitoredSubscriptionProperties> | ArmResourceCreatedResponse<
      MonitoredSubscriptionProperties,
      ArmLroLocationHeader<FinalResult = MonitoredSubscriptionProperties> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    OptionalRequestBody = true
  >;

  /**
   * Updates the subscriptions that are being monitored by the Datadog monitor resource
   */
  @patch(#{ implicitOptionality: false })
  update is MonitoredSubscriptionsOps.CustomPatchAsync<
    MonitoredSubscriptionProperties,
    PatchModel = MonitoredSubscriptionProperties,
    OptionalRequestBody = true
  >;

  /**
   * Updates the subscriptions that are being monitored by the Datadog monitor resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    MonitoredSubscriptionProperties,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List the subscriptions currently being monitored by the Datadog monitor resource.
   */
  list is ArmResourceListByParent<
    MonitoredSubscriptionProperties,
    Response = ArmResponse<MonitoredSubscriptionPropertiesList>
  >;
}

@@doc(MonitoredSubscriptionProperties.name,
  "The configuration name. Only 'default' value is supported."
);
@@doc(MonitoredSubscriptionProperties.properties,
  "The request to update subscriptions needed to be monitored by the Datadog monitor resource."
);
@@doc(MonitoredSubscriptions.createorUpdate::parameters.resource, "");
@@doc(MonitoredSubscriptions.update::parameters.properties, "");
