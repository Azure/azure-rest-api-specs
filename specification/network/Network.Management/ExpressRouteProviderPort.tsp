import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * ExpressRouteProviderPort resource.
 */
@subscriptionResource
model ExpressRouteProviderPort
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ExpressRouteProviderPortProperties> {
  ...ResourceNameParameter<
    Resource = ExpressRouteProviderPort,
    KeyName = "providerport",
    SegmentName = "expressRouteProviderPorts",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ExpressRouteProviderPorts {
  /**
   * Retrieves detail of a provider port.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteProviderPort")
  expressRouteProviderPort is ArmResourceRead<
    ExpressRouteProviderPort,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Retrieves all the ExpressRouteProviderPorts in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteProviderPortsLocation_List")
  list is ArmResourceListByParent<
    ExpressRouteProviderPort,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=location eq '{state}'.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(ExpressRouteProviderPort.name, "The name of the provider port.");
@@doc(ExpressRouteProviderPort.properties,
  "Properties of the express route Service Provider Port."
);
