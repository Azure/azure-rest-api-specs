import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Non-standard resource operation. SKU model is defined by ARM."
interface SkusOperationGroup {
  @doc("Lists the Microsoft.DevCenter SKUs available in a subscription.")
  @autoRoute
  @get
  @list
  @action("skus")
  listBySubscription is ArmProviderActionSync<
    Response = SkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Non-standard resource operation."
interface OperationStatusesOperationGroup {
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "This is a valid response per operation status contract."
  @doc("Gets the current status of an async operation.")
  @summary("Get Operation Status")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    @doc("The ID of an ongoing async operation.")
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | (AcceptedResponse & {
    @body
    _: OperationStatus;

    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    @header
    location?: string;
  }) | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Non-standard resource operation."
interface UsagesOperationGroup {
  @doc("Lists the current usages and limits in this location for the provided subscription.")
  @autoRoute
  @list
  @get
  @action("usages")
  listByLocation is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Non-standard resource operation."
interface CheckNameAvailabilityOperationGroup {
  @doc("Check the availability of name for resource.")
  @autoRoute
  @action("checkNameAvailability")
  execute is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Non-standard resource operation."
interface CheckScopedNameAvailabilityOperationGroup {
  @doc("Check the availability of name for resource.")
  @autoRoute
  @action("checkScopedNameAvailability")
  execute is ArmProviderActionSync<
    Request = CheckScopedNameAvailabilityRequest,
    Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
