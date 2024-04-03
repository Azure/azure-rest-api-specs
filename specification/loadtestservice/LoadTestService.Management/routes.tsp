import "./models.tsp";
import "./customOperation.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LoadTestService;

interface Operations extends Azure.ResourceManager.Operations {}

@@encodedName(LoadTests.createOrUpdate::parameters.resource,
  "application/json",
  "LoadTestResource"
);

@@encodedName(LoadTests.update::parameters.properties,
  "application/json",
  "LoadTestResourcePatchRequestBody"
);

@@encodedName(Quotas.checkAvailability::parameters.body,
  "application/json",
  "QuotaBucketRequest"
);

@armResourceOperations
interface LoadTests {
  listBySubscription is ArmListBySubscription<LoadTestResource>;

  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  get is ArmResourceRead<LoadTestResource>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LoadTestResource,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API"
  update is ArmResourcePatchAsync<
    LoadTestResource,
    LoadTestProperties,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "OperationID already published."
  @operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
  @doc("Lists the endpoints that agents may call as part of load testing.")
  outboundNetworkDependenciesEndpoints is CustomOperations.ArmResourceActionSyncCustomGet<
    LoadTestResource,
    void,
    OutboundEnvironmentEndpointCollection
  >;
}

@armResourceOperations
interface Quotas {
  @doc("Get the available quota for a quota bucket per region per subscription.")
  get is ArmResourceRead<QuotaResource>;

  @doc("List quotas for a given subscription Id.")
  list is ArmListBySubscription<QuotaResource>;

  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSync<
    QuotaResource,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}
