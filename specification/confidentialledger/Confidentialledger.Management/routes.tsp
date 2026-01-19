import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ConfidentialLedger;

/**
 * To check whether a resource name is available.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
op checkNameAvailability is ArmProviderActionSync<
  Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;
