import "./models.tsp";
import "./customOperation.tsp";
import "@azure-tools/typespec-providerhub";
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

@@projectedName(LoadTests.createOrUpdate::parameters.resource,
  "client",
  "LoadTestResource"
);

@@projectedName(LoadTests.createOrUpdate::parameters.resource,
  "json",
  "LoadTestResource"
);

@@projectedName(LoadTests.update::parameters.properties,
  "client",
  "LoadTestResourcePatchRequestBody"
);

@@projectedName(LoadTests.update::parameters.properties,
  "json",
  "LoadTestResourcePatchRequestBody"
);

@@projectedName(Quotas.checkAvailability::parameters.body,
  "json",
  "QuotaBucketRequest"
);

@@projectedName(Quotas.checkAvailability::parameters.body,
  "client",
  "QuotaBucketRequest"
);

@armResourceOperations
interface LoadTests {
  @extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  listBySubscription is ArmListBySubscription<
    LoadTestResource,
    Response = LoadTestResourcePageList
  >;
  @extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  listByResourceGroup is ArmResourceListByParent<
    LoadTestResource,
    Response = LoadTestResourcePageList
  >;
  get is ArmResourceRead<LoadTestResource>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LoadTestResource,
    LroHeaders = AzureAsyncOperationHeader
  >;

  update is ArmCustomPatchAsync<
    LoadTestResource,
    LoadTestResourcePatchRequestBody,
    LroHeaders = AzureAsyncOperationHeader
  >;

  delete is ArmResourceDeleteAsync<LoadTestResource>;

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

  @extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @doc("List quotas for a given subscription Id.")
  list is ArmListBySubscription<QuotaResource, Response = QuotaResourceList>;

  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSync<
    QuotaResource,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}
