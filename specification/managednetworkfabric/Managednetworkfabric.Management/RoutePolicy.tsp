import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The RoutePolicy resource definition.
 */
model RoutePolicy
  is Azure.ResourceManager.TrackedResource<RoutePolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = RoutePolicy,
    KeyName = "routePolicyName",
    SegmentName = "routePolicies",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<RoutePolicy, PatchModel = RoutePolicyPatch>;

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
    ArmResponse<CommonPostActionResponseForDeviceUpdate>
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    ArmResponse<ValidateConfigurationResponse>
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(RoutePolicy.name, "Name of the Route Policy.");
@@doc(RoutePolicy.properties, "Resource properties.");
@@doc(RoutePolicies.create::parameters.resource, "Request payload.");
@@doc(RoutePolicies.update::parameters.properties,
  "Route Policy properties to update."
);
@@doc(RoutePolicies.updateAdministrativeState::parameters.body,
  "Request payload."
);
