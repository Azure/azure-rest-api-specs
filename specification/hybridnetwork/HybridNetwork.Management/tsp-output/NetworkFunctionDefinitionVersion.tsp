import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFunctionDefinitionGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("Network function definition version.")
@parentResource(NetworkFunctionDefinitionGroup)
model NetworkFunctionDefinitionVersion
  is TrackedResource<NetworkFunctionDefinitionVersionPropertiesFormat> {
  @doc("The name of the network function definition version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.")
  @maxLength(64)
  @pattern("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$")
  @path
  @key("networkFunctionDefinitionVersionName")
  @segment("networkFunctionDefinitionVersions")
  name: string;
}

@armResourceOperations
interface NetworkFunctionDefinitionVersions {
  @doc("Gets information about a network function definition version.")
  get is ArmResourceRead<NetworkFunctionDefinitionVersion>;
  @doc("Creates or updates a network function definition version.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFunctionDefinitionVersion>;
  @doc("Updates a network function definition version resource.")
  update is ArmTagsPatchSync<NetworkFunctionDefinitionVersion>;
  @doc("Deletes the specified network function definition version.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFunctionDefinitionVersion>;
  @doc("Gets information about a list of network function definition versions under a network function definition group.")
  listByNetworkFunctionDefinitionGroup is ArmResourceListByParent<NetworkFunctionDefinitionVersion>;
  @doc("Update network function definition version state.")
  updateState is ArmResourceActionAsync<
    NetworkFunctionDefinitionVersion,
    NetworkFunctionDefinitionVersionUpdateState,
    NetworkFunctionDefinitionVersionUpdateState
  >;
}
