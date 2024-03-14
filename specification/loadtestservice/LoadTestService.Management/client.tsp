import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Microsoft.LoadTestService;
using Azure.ResourceManager;

@useDependency(Microsoft.LoadTestService.APIVersions.v2022_12_01)
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Customizations;

@@clientName(LoadTests.update::parameters.properties,
  "LoadTestResourcePatchRequestBody"
);
@@clientName(Quotas.checkAvailability::parameters.body, "QuotaBucketRequest");
@@clientName(LoadTests.createOrUpdate::parameters.resource, "LoadTestResource");

@client({
  name: "LoadTestClient",
  service: Microsoft.LoadTestService,
})
@armResourceOperations
interface LoadTests {
  listBySubscription is Microsoft.LoadTestService.LoadTests.listBySubscription;

  listByResourceGroup is Microsoft.LoadTestService.LoadTests.listByResourceGroup;

  get is Microsoft.LoadTestService.LoadTests.get;

  createOrUpdate is Microsoft.LoadTestService.LoadTests.createOrUpdate;

  update is Microsoft.LoadTestService.LoadTests.update;

  delete is Microsoft.LoadTestService.LoadTests.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Operation id already published"
  outboundNetworkDependenciesEndpoints is Microsoft.LoadTestService.LoadTests.outboundNetworkDependenciesEndpoints;
}

@client({
  name: "QuotasClient",
  service: Microsoft.LoadTestService,
})
@armResourceOperations
interface Quotas {
  get is Microsoft.LoadTestService.Quotas.get;

  list is Microsoft.LoadTestService.Quotas.list;

  checkAvailability is Microsoft.LoadTestService.Quotas.checkAvailability;
}

@client({
  name: "OperationsClient",
  service: Microsoft.LoadTestService,
})
@armResourceOperations
interface Operations {
  list is Microsoft.LoadTestService.Operations.list;
}
