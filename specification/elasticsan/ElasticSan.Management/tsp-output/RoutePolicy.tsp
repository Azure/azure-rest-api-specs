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
@doc("The RoutePolicy resource definition.")
model RoutePolicy is TrackedResource<RoutePolicyProperties> {
  @doc("Name of the Route Policy.")
  @path
  @key("routePolicyName")
  @segment("routePolicies")
  name: string;
}

@armResourceOperations
interface RoutePolicies {
  @doc("Implements Route Policy GET method.")
  get is ArmResourceRead<RoutePolicy>;

  @doc("Implements Route Policy PUT method.")
  create is ArmResourceCreateOrUpdateAsync<
    RoutePolicy,
    BaseParameters<RoutePolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the Route Policy resource.")
  update is ArmCustomPatchAsync<
    RoutePolicy,
    RoutePolicyPatch,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  @doc("Implements Route Policy DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    RoutePolicy,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  @doc("Implements RoutePolicies list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<RoutePolicy>;

  @doc("Implements RoutePolicies list by subscription GET method.")
  listBySubscription is ArmListBySubscription<RoutePolicy>;

  @doc("Updated the admin state for this Route Policy.")
  updateAdministrativeState is ArmResourceActionAsync<
    RoutePolicy,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    ValidateConfigurationResponse,
    BaseParameters<RoutePolicy>,
    ArmLroLocationHeader
  >;

  @doc("Commits the configuration of the given resources.")
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
