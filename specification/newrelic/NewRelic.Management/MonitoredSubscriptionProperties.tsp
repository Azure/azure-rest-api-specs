import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NewRelicMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace NewRelic.Observability;
/**
 * The request to update subscriptions needed to be monitored by the NewRelic monitor resource.
 */
@parentResource(NewRelicMonitorResource)
model MonitoredSubscriptionProperties
  is Azure.ResourceManager.ProxyResource<SubscriptionList> {
  ...ResourceNameParameter<
    Resource = MonitoredSubscriptionProperties,
    KeyName = "configurationName",
    SegmentName = "monitoredSubscriptions",
    NamePattern = "",
    Type = ConfigurationName
  >;
}

@armResourceOperations
interface MonitoredSubscriptions {
  /**
   * Lists all the subscriptions currently being monitored by the NewRelic monitor resource.
   */
  get is ArmResourceRead<MonitoredSubscriptionProperties>;

  /**
   * Add subscriptions to be monitored by the New Relic monitor resource, enabling observability and monitoring.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MonitoredSubscriptionProperties,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update subscriptions to be monitored by the New Relic monitor resource, ensuring optimal observability and performance
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    MonitoredSubscriptionProperties,
    PatchModel = MonitoredSubscriptionProperties,
    OptionalRequestBody = true
  >;

  /**
   * Delete subscriptions being monitored by the New Relic monitor resource, removing their observability and monitoring capabilities
   */
  delete is ArmResourceDeleteWithoutOkAsync<MonitoredSubscriptionProperties>;

  /**
   * Lists all the subscriptions currently being monitored by the NewRelic monitor resource.
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
  "The request to update subscriptions needed to be monitored by the NewRelic monitor resource."
);
@@doc(MonitoredSubscriptions.createOrUpdate::parameters.resource, "");
@@doc(MonitoredSubscriptions.update::parameters.properties, "");
