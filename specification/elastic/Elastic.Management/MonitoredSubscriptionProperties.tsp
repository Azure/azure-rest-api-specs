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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface MonitoredCreateOrUpdateResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("monitors")
        @pattern("^.*$")
        monitorName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("monitoredSubscriptions")
        @pattern("^.*$")
        configurationName: string,
      }
    > {}

@armResourceOperations
interface MonitoredSubscriptions {
  /**
   * Get detailed information about all subscriptions currently being monitored by the Elastic monitor resource.
   */
  get is ArmResourceRead<MonitoredSubscriptionProperties>;

  /**
   * Add subscriptions to be monitored by the Elastic monitor resource, enabling observability and monitoring.
   */
  createorUpdate is MonitoredCreateOrUpdateResourceOps.CreateOrUpdateAsync<
    MonitoredSubscriptionProperties,
    LroHeaders = ArmLroLocationHeader<FinalResult = MonitoredSubscriptionProperties> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Update subscriptions to be monitored by the Elastic monitor resource, ensuring optimal observability and performance.
   */
  @patch(#{ implicitOptionality: false })
  update is MonitoredCreateOrUpdateResourceOps.CustomPatchAsync<
    MonitoredSubscriptionProperties,
    PatchModel = MonitoredSubscriptionProperties,
    OptionalRequestBody = true
  >;

  /**
   * Delete subscriptions being monitored by the Elastic monitor resource, removing their observability and monitoring capabilities.
   */
  delete is ArmResourceDeleteWithoutOkAsync<MonitoredSubscriptionProperties>;

  /**
   * List all subscriptions currently being monitored by the Elastic monitor resource, helping you manage observability.
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
