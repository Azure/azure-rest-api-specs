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

namespace Microsoft.Communication;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CommunicationServicesOperationGroup {
  /**
   * Checks that the CommunicationService name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check Name Availability")
  @operationId("CommunicationServices_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityParameters,
    Response = CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EmailServicesOperationGroup {
  /**
   * Get a list of domains that are fully verified in Exchange Online.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List Verified Domains From Exchange Online")
  @operationId("EmailServices_ListVerifiedExchangeOnlineDomains")
  @autoRoute
  listVerifiedExchangeOnlineDomains is ArmProviderActionSync<
    Response = {
      @bodyRoot _: undefined[];
    },
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
