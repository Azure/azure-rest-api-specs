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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface groups provider-level actions (checkNameAvailability) that are not tied to a single ARM resource type; retained to match the published API routing."
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface groups subscription-level provider actions (usage/quota) that are not tied to a single ARM resource type; retained to match the published API routing."
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
