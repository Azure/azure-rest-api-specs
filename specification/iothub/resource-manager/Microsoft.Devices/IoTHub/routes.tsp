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

namespace Microsoft.Devices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface IotHubResourceOperationGroup {
  /**
   * Check if an IoT hub name is available.
   */
  @summary("Check if an IoT hub name is available")
  @tag("POST")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = OperationInputs,
    Response = IotHubNameAvailabilityInfo,
    Scope = SubscriptionActionScope,
    Error = ErrorDetails
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ResourceProviderCommonOperationGroup {
  /**
   * Get the number of free and paid iot hubs in the subscription
   */
  @summary("Get the number of iot hubs in the subscription")
  @tag("GET")
  @autoRoute
  @get
  @action("usages")
  getSubscriptionQuota is ArmProviderActionSync<
    Response = UserSubscriptionQuotaListResult,
    Scope = SubscriptionActionScope,
    Error = ErrorDetails
  >;
}
