// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.MixedReality;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CheckNameAvailabilityLocalOperationGroup {
  /**
   * Check Name Availability for local uniqueness
   */
  @autoRoute
  @action("checkNameAvailability")
  checkNameAvailabilityLocal is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
