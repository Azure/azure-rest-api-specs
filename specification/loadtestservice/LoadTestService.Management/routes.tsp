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

@armResourceOperations
interface LoadTests {
  listBySubscription is ArmListBySubscription<LoadTestResource>;
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  get is ArmResourceRead<LoadTestResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsyncCustom<LoadTestResource>;
  update is ArmCustomPatchAsyncCustom<LoadTestResource, LoadTestProperties>;
  delete is ArmResourceDeleteAsync<LoadTestResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "OperationId in already published GA spec is different from the auto generated one"
  outboundNetworkDependenciesEndpoint is OutboundNetworkDependenciesEndpoint<OutboundEnvironmentEndpointCollection>;
}

@armResourceOperations
interface Quotas {
  @doc("Get the available quota for a quota bucket per region per subscription.")
  get is ArmResourceRead<QuotaResource>;

  @doc("List quotas for a given subscription Id.")
  list is ArmListBySubscription<QuotaResource>;

  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSyncCustom<
    QuotaResource,
    QuotaBucketRequest,
    CheckQuotaAvailabilityResponse
  >;
}
