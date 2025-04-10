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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface IotHubResourceOperationGroup {
  /**
   * Check if an IoT hub name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check if an IoT hub name is available")
  @operationId("IotHubResource_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = OperationInputs,
    Response = IotHubNameAvailabilityInfo,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceProviderCommonOperationGroup {
  /**
   * Get the number of free and paid iot hubs in the subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get the number of iot hubs in the subscription")
  @operationId("ResourceProviderCommon_GetSubscriptionQuota")
  @autoRoute
  @get
  @action("usages")
  getSubscriptionQuota is ArmProviderActionSync<
    Response = UserSubscriptionQuotaListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
