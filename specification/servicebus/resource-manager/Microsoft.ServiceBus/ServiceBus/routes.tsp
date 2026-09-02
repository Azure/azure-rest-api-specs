import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
interface NamespacesOperationGroup {
  /**
   * Check the give namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
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
