import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NamespacesOperationGroup {
  /**
   * Check the give namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("CheckNameAvailability")
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailability,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ErrorResponse
  >;
}
