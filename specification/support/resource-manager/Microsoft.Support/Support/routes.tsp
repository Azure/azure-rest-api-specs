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

namespace Microsoft.Support;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SupportTicketsOperationGroup {
  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for support ticket creation for the selected subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SupportTicketsNoSubscriptionOperationGroup {
  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for support ticket creation for the selected subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput
  >;
}
