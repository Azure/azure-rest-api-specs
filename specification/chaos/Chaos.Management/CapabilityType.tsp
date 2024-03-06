import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TargetType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Capability Type resource.
 */
@parentResource(TargetType)
model CapabilityType is ProxyResource<CapabilityTypeProperties> {
  /**
   * String that represents a Capability Type resource name.
   */
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityTypeName")
  @segment("capabilityTypes")
  name: string;
}

@armResourceOperations
interface CapabilityTypes {
  /**
   * Get a Capability Type resource for given Target Type and location.
   */
  @armResourceRead(CapabilityType)
  @get
  get(
    ...SubscriptionBaseParameters,
    ...DefaultProviderNamespace,

    /**
     * String that represents a Location resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("locations")
    locationName: string;

    /**
     * String that represents a Target Type resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("targetTypes")
    targetTypeName: string;

    /**
     * String that represents a Capability Type resource name.
     */
    @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
    @path
    @segment("capabilityTypes")
    capabilityTypeName: string;
  ):ArmResponse<CapabilityType> | ErrorResponse;

  /**
   * Get a list of Capability Type resources for given Target Type and location.
   */
  @armResourceList(CapabilityType)
  @get
  @segment("capabilityTypes")
  list(
    ...SubscriptionBaseParameters,
    ...DefaultProviderNamespace,

    /**
     * String that represents a Location resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("locations")
    locationName: string;

    /**
     * String that represents a Target Type resource name.
     */
    @pattern("^[a-zA-Z0-9_\\-\\.]+$")
    @path
    @segment("targetTypes")
    targetTypeName: string;

    /**
     * String that sets the continuation token.
     */
    @query("continuationToken")
    continuationToken?: string;
  ):ArmResponse<CapabilityTypeList> | ErrorResponse;
}

model CapabilityTypeList is Azure.Core.Page<CapabilityType>;