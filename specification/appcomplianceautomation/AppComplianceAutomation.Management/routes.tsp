import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./models/models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.AppComplianceAutomation;

alias PlaceholderResource = {
  id: string;
  type: string;
};

alias ArmProviderActionAsync<
  Request extends {} | void,
  Response extends {} | void,
  Parameters extends {} = {},
  LroHeaders extends {} = {}
> = ArmResourceActionAsync<
  PlaceholderResource,
  Request,
  Response,
  BaseParameters = ApiVersionParameter,
  Parameters = Parameters,
  LroHeaders = ArmLroLocationHeader<Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>>
>;

alias ArmProviderActionSync<
  Request extends {} | void,
  Response extends {} | void,
  Parameters extends {} = {}
> = ArmResourceActionSync<
  PlaceholderResource,
  Request,
  Response,
  BaseParameters = ApiVersionParameter,
  Parameters = Parameters
>;

@armResourceOperations
@tag("AppComplianceAutomation")
interface ProviderActions {
  @Autorest.example(
    "./examples/Reports_CheckNameAvailability.json",
    "Reports_CheckNameAvailability"
  )
  @doc("Check if the given name is available for a report.")
  checkNameAvailability is ArmProviderActionSync<
    CheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse
  >;

  @Autorest.example(
    "./examples/Reports_GetCollectionCount.json",
    "Reports_GetCollectionCount"
  )
  @doc("Get the count of reports.")
  getCollectionCount is ArmProviderActionSync<
    GetCollectionCountRequest,
    GetCollectionCountResponse
  >;

  @Autorest.example(
    "./examples/Reports_GetOverviewStatus.json",
    "Reports_GetOverviewStatus"
  )
  @doc("Get the resource overview status.")
  getOverviewStatus is ArmProviderActionSync<
    GetOverviewStatusRequest,
    GetOverviewStatusResponse
  >;

  @Autorest.example("./examples/Onboard.json", "Onboard")
  @doc("Onboard given subscriptions to Microsoft.AppComplianceAutomation provider.")
  onboard is ArmProviderActionAsync<OnboardRequest, OnboardResponse>;

  @Autorest.example("./examples/TriggerEvaluation.json", "TriggerEvaluation")
  triggerEvaluation is ArmProviderActionAsync<
    TriggerEvaluationRequest,
    TriggerEvaluationResponse
  >;

  @Autorest.example(
    "./examples/ListInUseStorageAccountsWithSubscriptions.json",
    "ListInUseStorageAccountsWithSubscriptions"
  )
  @Autorest.example(
    "./examples/ListInUseStorageAccountsWithoutSubscriptions.json",
    "ListInUseStorageAccountsWithoutSubscriptions"
  )
  @doc("List the storage accounts which are in use by related reports")
  listInUseStorageAccounts is ArmProviderActionSync<
    ListInUseStorageAccountsRequest,
    ListInUseStorageAccountsResponse
  >;
}

@tag("AppComplianceAutomation")
interface Operations extends Azure.ResourceManager.Operations {}

@@projectedName(ArmProviderActionAsync::parameters.body, "json", "parameters");
