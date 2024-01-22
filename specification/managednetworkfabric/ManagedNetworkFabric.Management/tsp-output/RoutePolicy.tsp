import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The RoutePolicy resource definition.
 */
model RoutePolicy is TrackedResource<RoutePolicyProperties> {
  /**
   * Name of the Route Policy.
   */
  @path
  @key("routePolicyName")
  @segment("routePolicies")
  name: string;
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
  create is ArmResourceCreateOrReplaceAsync<
    RoutePolicy,
    BaseParameters<RoutePolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the Route Policy resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    RoutePolicy,
    RoutePolicyPatch,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Implements Route Policy DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    RoutePolicy,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Implements RoutePolicies list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RoutePolicies_ListByResourceGroup")
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
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Validates the configuration of the resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    ValidateConfigurationResponse,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Commits the configuration of the given resources.
   */
  commitConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;
}

@@projectedName(RoutePolicies.create::parameters.resource, "json", "body");
@@extension(RoutePolicies.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(RoutePolicies.create::parameters.resource, "Request payload.");
@@projectedName(RoutePolicies.update::parameters.properties, "json", "body");
@@extension(RoutePolicies.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(RoutePolicies.update::parameters.properties,
  "Route Policy properties to update."
);
@@doc(RoutePolicies.updateAdministrativeState::parameters.body,
  "Request payload."
);
