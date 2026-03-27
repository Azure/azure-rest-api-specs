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
 * Definition of the ExpressRoutePorts peering location resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@subscriptionResource
@summary("ExpressRoutePorts Peering Location")
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRoutePortsLocation extends Resource {
  properties?: ExpressRoutePortsLocationPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("locationName")
  @segment("ExpressRoutePortsLocations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
interface ExpressRoutePortsLocations {
  /**
   * Retrieves a single ExpressRoutePort peering location, including the list of available bandwidths available at said peering location.
   */
  get is ArmResourceRead<
    ExpressRoutePortsLocation,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Retrieves all ExpressRoutePort peering locations. Does not return available bandwidths for each location. Available bandwidths can only be obtained when retrieving a specific peering location.
   */
  list is ArmResourceListByParent<
    ExpressRoutePortsLocation,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ExpressRoutePortsLocationListResult,
    Error = CloudError
  >;
}

@@doc(ExpressRoutePortsLocation.name,
  "Name of the requested ExpressRoutePort peering location."
);
@@doc(ExpressRoutePortsLocation.properties,
  "ExpressRoutePort peering location properties."
);
