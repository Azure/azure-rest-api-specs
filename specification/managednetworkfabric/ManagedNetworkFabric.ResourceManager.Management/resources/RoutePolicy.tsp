import "../models/common.tsp";
import "../models/RoutePolicy.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The RoutePolicy resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model RoutePolicy extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Route Policy.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("routePolicyName")
  @segment("routePolicies")
  @visibility(Lifecycle.Read)
  name: string;

  /** The RoutePolicy properties */
  properties: RoutePolicyProperties;
}

@armResourceOperations
interface RoutePolicies {
  @doc("Implements Route Policy GET method.")
  get is ArmResourceRead<RoutePolicy>;

  @doc("Implements Route Policy PUT method.")
  create is ArmResourceCreateOrReplaceAsync<RoutePolicy>;

  @doc("API to update certain properties of the Route Policy resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<RoutePolicy, RoutePolicyPatch>;

  @doc("Implements Route Policy DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<RoutePolicy>;

  @doc("Implements RoutePolicies list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<RoutePolicy>;

  @doc("Implements RoutePolicies list by subscription GET method.")
  listBySubscription is ArmListBySubscription<RoutePolicy>;

  @doc("Updated the admin state for this Route Policy.")
  updateAdministrativeState is ArmResourceActionAsync<
    RoutePolicy,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    RoutePolicy,
    void,
    ValidateConfigurationResponse
  >;

  @doc("Commits the configuration of the given resources.")
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
