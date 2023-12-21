import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LoadTesting;
@doc("LoadTest details")
model LoadTestResource is TrackedResource<LoadTestProperties> {
  @doc("Load Test name.")
  @path
  @key("loadTestName")
  @segment("loadTests")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface LoadTests {
  @doc("Get a LoadTest resource.")
  get is ArmResourceRead<LoadTestResource>;
  @doc("Create or update LoadTest resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LoadTestResource>;
  @doc("Update a loadtest resource.")
  update is ArmResourcePatchAsync<LoadTestResource, LoadTestProperties>;
  @doc("Delete a LoadTest resource.")
  delete is ArmResourceDeleteAsync<LoadTestResource>;
  @doc("Lists loadtest resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  @doc("Lists loadtests resources in a subscription.")
  listBySubscription is ArmListBySubscription<LoadTestResource>;
  @doc("Lists the endpoints that agents may call as part of load testing.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/loadTests/{loadTestName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Load Test name.")
      @path
      loadTestName: string;
    },
    OutboundEnvironmentEndpointCollection
  >;
}
