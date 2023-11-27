import "./models.tsp";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.LoadTestService.Draft;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface LoadTests {
  listBySubscription is ArmListBySubscription<LoadTestResource>;
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  get is ArmResourceRead<LoadTestResource>; 
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LoadTestResource>;
  update is ArmResourcePatchAsync<LoadTestResource, LoadTestProperties>;
  delete is ArmResourceDeleteAsync<LoadTestResource>;
  
}

@armResourceOperations
interface Quotas {
  @doc("Get quota by name.")
  get is ArmResourceRead<QuotaResource>;

  @doc("List quotas for a given subscription Id.")
  listBySubscription is ArmListBySubscription<QuotaResource>;
}