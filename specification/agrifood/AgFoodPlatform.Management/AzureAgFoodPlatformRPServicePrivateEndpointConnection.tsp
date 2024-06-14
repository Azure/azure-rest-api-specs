import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataManagerForAgriculture.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AgFoodPlatform;
@doc("The private endpoint connection resource.")
@parentResource(DataManagerForAgriculture)
model AzureAgFoodPlatformRPServicePrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Private endpoint connection name.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface AzureAgFoodPlatformRPServicePrivateEndpointConnections {
  @doc("Get Private endpoint connection object.")
  get is ArmResourceRead<AzureAgFoodPlatformRPServicePrivateEndpointConnection>;
  @doc("Approves or Rejects a Private endpoint connection request.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AzureAgFoodPlatformRPServicePrivateEndpointConnection>;
  @doc("Delete Private endpoint connection request.")
  delete is ArmResourceDeleteAsync<AzureAgFoodPlatformRPServicePrivateEndpointConnection>;
  @doc("Get list of Private endpoint connections.")
  listByResource is ArmResourceListByParent<AzureAgFoodPlatformRPServicePrivateEndpointConnection>;
}
