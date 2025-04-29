import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Elastic;
/**
 * The request to update subscriptions needed to be monitored by the Elastic monitor resource.
 */
@parentResource(ElasticMonitorResource)
model MonitoredSubscriptionProperties
  is Azure.ResourceManager.ProxyResource<SubscriptionList> {
  ...ResourceNameParameter<
    Resource = MonitoredSubscriptionProperties,
    KeyName = "configurationName",
    SegmentName = "monitoredSubscriptions",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface MonitoredSubscriptions {
  /**
   * List all the subscriptions currently being monitored by the Elastic monitor resource.
   */
  get is ArmResourceRead<MonitoredSubscriptionProperties>;

  /**
   * Add the subscriptions that should be monitored by the Elastic monitor resource.
   */
  createorUpdate is ArmResourceCreateOrReplaceAsync<
    MonitoredSubscriptionProperties,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the subscriptions that are being monitored by the Elastic monitor resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    MonitoredSubscriptionProperties,
    PatchModel = MonitoredSubscriptionProperties
  >;

  /**
   * Updates the subscriptions that are being monitored by the Elastic monitor resource
   */
  delete is ArmResourceDeleteWithoutOkAsync<MonitoredSubscriptionProperties>;

  /**
   * List all the subscriptions currently being monitored by the Elastic monitor resource.
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
  "The request to update subscriptions needed to be monitored by the Elastic monitor resource."
);
@@doc(MonitoredSubscriptions.createorUpdate::parameters.resource, "");
@@doc(MonitoredSubscriptions.update::parameters.properties, "");
