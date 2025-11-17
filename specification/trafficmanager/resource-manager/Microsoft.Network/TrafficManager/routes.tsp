// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProfilesOperationGroup {
  /**
   * Checks the availability of a Traffic Manager Relative DNS name.
   */
  @autoRoute
  @action("checkTrafficManagerNameAvailability")
  checkTrafficManagerRelativeDnsNameAvailability is ArmProviderActionSync<
    Request = CheckTrafficManagerRelativeDnsNameAvailabilityParameters,
    Response = TrafficManagerNameAvailability,
    Error = CloudError
  >;
  /**
   * Checks the availability of a Traffic Manager Relative DNS name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Profiles_checkTrafficManagerNameAvailabilityV2")
  @autoRoute
  checkTrafficManagerNameAvailabilityV2 is ArmProviderActionSync<
    Request = CheckTrafficManagerRelativeDnsNameAvailabilityParameters,
    Response = TrafficManagerNameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = CloudError
  >;
}
