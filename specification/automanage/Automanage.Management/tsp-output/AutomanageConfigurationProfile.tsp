import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automanage;
@doc("Definition of the configuration profile.")
model AutomanageConfigurationProfile
  is TrackedResource<ConfigurationProfileProperties> {
  @doc("The configuration profile name.")
  @path
  @key("configurationProfileName")
  @segment("configurationProfiles")
  name: string;
}

@armResourceOperations
interface AutomanageConfigurationProfiles {
  @doc("Get information about a configuration profile")
  get is ArmResourceRead<AutomanageConfigurationProfile>;
  @doc("Creates a configuration profile")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomanageConfigurationProfile>;
  @doc("Updates a configuration profile")
  update is ArmResourcePatchSync<
    AutomanageConfigurationProfile,
    ConfigurationProfileProperties
  >;
  @doc("Delete a configuration profile")
  delete is ArmResourceDeleteSync<AutomanageConfigurationProfile>;
  @doc("Retrieve a list of configuration profile within a given resource group")
  listByResourceGroup is ArmResourceListByParent<AutomanageConfigurationProfile>;
  @doc("Retrieve a list of configuration profile within a subscription")
  listBySubscription is ArmListBySubscription<AutomanageConfigurationProfile>;
}
