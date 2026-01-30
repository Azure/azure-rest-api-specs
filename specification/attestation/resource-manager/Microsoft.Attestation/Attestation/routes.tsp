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

namespace Microsoft.Attestation;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AttestationProvidersOperationGroup {
  /**
   * Get the default provider
   */
  @autoRoute
  @get
  @action("defaultProviders")
  listDefault is ArmProviderActionSync<
    Response = AttestationProviderListResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = CloudError
  >;
  /**
   * Get the default provider by location.
   */
  @autoRoute
  @get
  @action("defaultProvider")
  getDefaultByLocation is ArmProviderActionSync<
    Response = AttestationProvider,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}
