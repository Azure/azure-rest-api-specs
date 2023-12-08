import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("Hybrid configuration group value resource.")
model ConfigurationGroupValue
  is TrackedResource<ConfigurationGroupValuePropertiesFormat> {
  @doc("The name of the configuration group value.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("configurationGroupValueName")
  @segment("configurationGroupValues")
  name: string;
}

@armResourceOperations
interface ConfigurationGroupValues {
  @doc("Gets information about the specified hybrid configuration group values.")
  get is ArmResourceRead<ConfigurationGroupValue>;
  @doc("Creates or updates a hybrid configuration group value.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConfigurationGroupValue>;
  @doc("Updates a hybrid configuration group tags.")
  updateTags is ArmTagsPatchSync<ConfigurationGroupValue>;
  @doc("Deletes the specified hybrid configuration group value.")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigurationGroupValue>;
  @doc("Lists all the hybrid network configurationGroupValues in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ConfigurationGroupValue>;
  @doc("Lists all sites in the configuration group value in a subscription.")
  listBySubscription is ArmListBySubscription<ConfigurationGroupValue>;
}
