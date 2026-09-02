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

namespace Microsoft.NotificationHubs;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NamespacesOperationGroup {
  /**
   * Checks the availability of the given service namespace across all Azure subscriptions. This is useful because the domain name is created based on the service namespace name.
   */
  @summary("Checks the availability of the given service namespace across all Azure subscriptions. This is useful because the domain name is created based on the service namespace name.")
  @autoRoute
  @action("checkNamespaceAvailability")
  checkAvailability is ArmProviderActionSync<
    Request = CheckAvailabilityParameters,
    Response = CheckAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
