import "../models/common.tsp";
import "../models/RoutePolicy.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

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
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: RoutePolicyProperties;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("The RoutePolicy properties")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
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
  @action("updateAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    RoutePolicy,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Updated the admin state for this Route Policy.")
  @action("updateAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    RoutePolicy,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
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
@@doc(RoutePolicies.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
