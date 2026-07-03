import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;
/**
 * ExpressRouteProviderPort resource.
 */
@subscriptionResource
@featureFile(Features.expressRoute)
model ExpressRouteProviderPort
  is TrackedResourceWithOptionalLocationInstance<ExpressRouteProviderPortProperties> {
  @visibility(Lifecycle.Read)
  @path
  @key("providerport")
  @segment("expressRouteProviderPorts")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@featureFile(Features.expressRoute)
@armResourceOperations
interface ExpressRouteProviderPorts {
  /**
   * Retrieves detail of a provider port.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ExpressRouteProviderPort")
  expressRouteProviderPort is ArmResourceRead<
    ExpressRouteProviderPort,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Retrieves all the ExpressRouteProviderPorts in a subscription.
   */
  list is Legacy.ArmListSinglePageByParent<
    ExpressRouteProviderPort,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=location eq '{state}'.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ExpressRouteProviderPortListResult,
    Error = CloudError
  >;
}

@@doc(ExpressRouteProviderPort.name, "The name of the provider port.");
@@doc(
  ExpressRouteProviderPort.properties,
  "Properties of the express route Service Provider Port."
);
