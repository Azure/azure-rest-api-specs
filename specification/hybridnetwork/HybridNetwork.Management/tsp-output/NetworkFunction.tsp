import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("Network function resource response.")
model NetworkFunction is TrackedResource<NetworkFunctionPropertiesFormat> {
  @doc("The name of the network function resource.")
  @path
  @key("networkFunctionName")
  @segment("networkFunctions")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkFunctions {
  @doc("Gets information about the specified network function resource.")
  get is ArmResourceRead<NetworkFunction>;
  @doc("Creates or updates a network function resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFunction>;
  @doc("Updates the tags for the network function resource.")
  updateTags is ArmTagsPatchSync<NetworkFunction>;
  @doc("Deletes the specified network function resource.")
  delete is ArmResourceDeleteAsync<NetworkFunction>;
  @doc("Lists all the network function resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkFunction>;
  @doc("Lists all the network functions in a subscription.")
  listBySubscription is ArmListBySubscription<NetworkFunction>;
  @doc("Execute a request to services on a containerized network function.")
  executeRequest is ArmResourceActionAsync<
    NetworkFunction,
    ExecuteRequestParameters,
    void
  >;
}
