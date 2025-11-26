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
@subscriptionResource
model ExpressRoutePortsLocation
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ExpressRoutePortsLocationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRoutePortsLocation,
    KeyName = "locationName",
    SegmentName = "ExpressRoutePortsLocations",
    NamePattern = ""
  >;
}

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
    Error = CloudError
  >;
}

@@doc(ExpressRoutePortsLocation.name,
  "Name of the requested ExpressRoutePort peering location."
);
@@doc(ExpressRoutePortsLocation.properties,
  "ExpressRoutePort peering location properties."
);
