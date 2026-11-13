import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,

  /** Migration name is invalid. */
  Invalid: "Invalid",

  /** Migration name already exists. */
  AlreadyExists: "AlreadyExists",
}

/**
 * Availability of a name.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NameAvailabilityModel
  extends Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse {
  /**
   * Name for which validity and availability was checked.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of resource. It can be 'Microsoft.DBforPostgreSQL/flexibleServers' or 'Microsoft.DBforPostgreSQL/flexibleServers/virtualendpoints'.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NameAvailabilityOperationGroup {
  /**
   * Checks the validity and availability of the given name, to assign it to a new server or to use it as the base name of a new pair of virtual endpoints.
   */
  @autoRoute
  @action("checkNameAvailability")
  checkGlobally is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = NameAvailabilityModel,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Check the availability of name for resource
   */
  @autoRoute
  @action("checkNameAvailability")
  checkWithLocation is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = NameAvailabilityModel,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
