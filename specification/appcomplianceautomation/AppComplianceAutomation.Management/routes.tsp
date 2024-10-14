import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./models/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.AppComplianceAutomation;

interface Operations extends Azure.ResourceManager.Operations {}

alias PlaceholderResource = Azure.ResourceManager.Foundations.ProxyResource;

alias ArmProviderActionAsync<
  Request extends {} | void,
  Response extends {} | void,
  Parameters extends {} = {},
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader &
    Azure.Core.Foundations.RetryAfterHeader
> = Azure.ResourceManager.ArmResourceActionAsync<
  PlaceholderResource,
  Request,
  Response | ArmAcceptedLroResponse<"Accepted", LroHeaders>,
  BaseParameters = ApiVersionParameter,
  Parameters = Parameters,
  LroHeaders = ArmLroLocationHeader<Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>>
>;

alias ArmProviderActionSync<
  Request extends {} | void,
  Response extends {} | void,
  Parameters extends {} = {}
> = Azure.ResourceManager.ArmResourceActionSync<
  PlaceholderResource,
  Request,
  Response,
  BaseParameters = ApiVersionParameter,
  Parameters = Parameters
>;

@armResourceOperations
@tag("AppComplianceAutomation")
interface ProviderActions {
  @doc("Check if the given name is available for a report.")
  checkNameAvailability is ArmProviderActionSync<
    Azure.ResourceManager.Foundations.CheckNameAvailabilityRequest,
    Azure.ResourceManager.Foundations.CheckNameAvailabilityResponse
  >;

  @doc("Get the count of reports.")
  getCollectionCount is ArmProviderActionSync<
    GetCollectionCountRequest,
    GetCollectionCountResponse
  >;

  @doc("Get the resource overview status.")
  getOverviewStatus is ArmProviderActionSync<
    GetOverviewStatusRequest,
    GetOverviewStatusResponse
  >;

  @doc("Onboard given subscriptions to Microsoft.AppComplianceAutomation provider.")
  onboard is ArmProviderActionAsync<OnboardRequest, OnboardResponse>;

  @doc("Trigger quick evaluation for the given subscriptions.")
  triggerEvaluation is ArmProviderActionAsync<
    TriggerEvaluationRequest,
    TriggerEvaluationResponse
  >;

  @doc("List the storage accounts which are in use by related reports")
  listInUseStorageAccounts is ArmProviderActionSync<
    ListInUseStorageAccountsRequest,
    ListInUseStorageAccountsResponse
  >;
}
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(ArmProviderActionAsync::parameters.body,
  "application/json",
  "parameters"
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(ArmProviderActionSync::parameters.body,
  "application/json",
  "parameters"
);
