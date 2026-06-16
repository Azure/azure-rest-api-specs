import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * The request to update subscriptions needed to be monitored by the Dynatrace monitor resource.
 */
@singleton("default")
@parentResource(MonitorResource)
model MonitoredSubscriptionProperties
  is Azure.ResourceManager.ProxyResource<SubscriptionList> {
  ...ResourceNameParameter<
    Resource = MonitoredSubscriptionProperties,
    KeyName = "monitoredSubscription",
    SegmentName = "monitoredSubscriptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MonitoredSubscriptions {
  /**
   * List the subscriptions currently being monitored by the Dynatrace monitor resource.
   */
  get is ArmResourceRead<MonitoredSubscriptionProperties>;

  /**
   * Add the subscriptions that should be monitored by the Dynatrace monitor resource.
   */
  createOrUpdate is Legacy.CreateOrReplaceAsync<
    MonitoredSubscriptionProperties,
    LroHeaders = ArmLroLocationHeader<FinalResult = MonitoredSubscriptionProperties> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Updates the subscriptions that are being monitored by the Dynatrace monitor resource
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    MonitoredSubscriptionProperties,
    PatchModel = MonitoredSubscriptionProperties,
    OptionalRequestBody = true
  >;

  /**
   * Updates the subscriptions that are being monitored by the Dynatrace monitor resource
   */
  delete is ArmResourceDeleteWithoutOkAsync<MonitoredSubscriptionProperties>;

  /**
   * List the subscriptions currently being monitored by the Dynatrace monitor resource.
   */
  list is ArmResourceListByParent<
    MonitoredSubscriptionProperties,
    Response = ArmResponse<MonitoredSubscriptionPropertiesList>
  >;
}

@@doc(MonitoredSubscriptionProperties.name, "");
@@doc(MonitoredSubscriptionProperties.properties,
  "The request to update subscriptions needed to be monitored by the Dynatrace monitor resource."
);
@@doc(MonitoredSubscriptions.createOrUpdate::parameters.resource, "");
@@doc(MonitoredSubscriptions.update::parameters.properties, "");
