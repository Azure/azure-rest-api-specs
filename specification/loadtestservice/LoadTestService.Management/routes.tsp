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

@@encodedName(LoadTests.createOrUpdate::parameters.resource,
  "application/json",
  "LoadTestResource"
);

@@OpenAPI.extension(LoadTests.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "LoadTestResource"
);

@@encodedName(LoadTests.update::parameters.properties,
  "application/json",
  "LoadTestResourcePatchRequestBody"
);

@@OpenAPI.extension(LoadTests.update::parameters.properties,
  "x-ms-client-name",
  "LoadTestResourcePatchRequestBody"
);

@@encodedName(Quotas.checkAvailability::parameters.body,
  "application/json",
  "QuotaBucketRequest"
);

@@OpenAPI.extension(Quotas.checkAvailability::parameters.body,
  "x-ms-client-name",
  "QuotaBucketRequest"
);

@armResourceOperations
interface LoadTests {
  
  listBySubscription is ArmListBySubscription<
    LoadTestResource
  >;
  
  listByResourceGroup is ArmResourceListByParent<
    LoadTestResource
  >;
  get is ArmResourceRead<LoadTestResource>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LoadTestResource,
    LroHeaders = AzureAsyncOperationHeader
  >;

  update is ArmResourcePatchAsync<
    LoadTestResource,
    LoadTestProperties,
    LroHeaders = AzureAsyncOperationHeader>;

  delete is ArmResourceDeleteWithoutOkAsync<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "OperationID already published."
  @operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
  @doc("Lists the endpoints that agents may call as part of load testing.")
  @extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
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
