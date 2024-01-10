import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridNetwork;
@doc("Network function definition group resource.")
@parentResource(Publisher)
model NetworkFunctionDefinitionGroup
  is TrackedResource<NetworkFunctionDefinitionGroupPropertiesFormat> {
  @doc("The name of the network function definition group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("networkFunctionDefinitionGroupName")
  @segment("networkFunctionDefinitionGroups")
  name: string;
}

@armResourceOperations
interface NetworkFunctionDefinitionGroups {
  @doc("Gets information about the specified networkFunctionDefinition group.")
  get is ArmResourceRead<NetworkFunctionDefinitionGroup>;

  @doc("Creates or updates a network function definition group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFunctionDefinitionGroup>;

  @doc("Updates a network function definition group resource.")
  update is ArmCustomPatchSync<NetworkFunctionDefinitionGroup, TagsObject>;

  @doc("Deletes a specified network function definition group.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFunctionDefinitionGroup>;

  @doc("Gets information of the network function definition groups under a publisher.")
  listByPublisher is ArmResourceListByParent<NetworkFunctionDefinitionGroup>;
}
