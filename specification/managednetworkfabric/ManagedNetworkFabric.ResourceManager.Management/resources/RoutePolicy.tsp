import "../models/common.tsp";
import "../models/RoutePolicy.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The RoutePolicy resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model RoutePolicy extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Route Policy.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("routePolicyName")
  @segment("routePolicies")
  @visibility("read")
  name: string;

  /** The RoutePolicy properties */
  properties: RoutePolicyProperties;
}

@armResourceOperations
interface RoutePolicies {
  /**
   * Implements Route Policy GET method.
   */
  get is ArmResourceRead<RoutePolicy>;

  /**
   * Implements Route Policy PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<RoutePolicy>;

  /**
   * API to update certain properties of the Route Policy resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<RoutePolicy, RoutePolicyPatch>;

  /**
   * Implements Route Policy DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<RoutePolicy>;

  /**
   * Implements RoutePolicies list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<RoutePolicy>;

  /**
   * Implements RoutePolicies list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<RoutePolicy>;

  /**
   * Updated the admin state for this Route Policy.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    RoutePolicy,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    ValidateConfigurationResponse
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(RoutePolicies.create::parameters.resource, "Request payload.");
@@doc(RoutePolicies.update::parameters.properties,
  "Route Policy properties to update."
);
@@doc(RoutePolicies.updateAdministrativeState::parameters.body,
  "Request payload."
);
