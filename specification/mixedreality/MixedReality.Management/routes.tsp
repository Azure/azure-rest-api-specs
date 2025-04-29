// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MixedReality;

interface MixedRealityOperationGroup {
  /**
   * Check Name Availability for local uniqueness
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
  @autoRoute
  @action("checkNameAvailability")
  @operationId("CheckNameAvailabilityLocal")
  checkNameAvailabilityLocal is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
