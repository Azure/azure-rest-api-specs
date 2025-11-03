import "./Commons.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Configuration Properties")
model ConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Configuration Resource")
model Configuration is TrackedResource<ConfigurationProperties> {
  @doc("Name of the Configuration")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;
}

@armResourceOperations
interface Configurations {
  @doc("Get a Configuration Resource")
  get is ArmResourceRead<Configuration>;

  @doc("Create or update a Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Configuration>;

  @doc("Update a Configuration Resource")
  update is ArmResourcePatchAsync<Configuration, ConfigurationProperties>;

  @doc("Delete a Configuration Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Configuration>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Configuration>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Configuration>;
}

@doc("ConfigurationReference Resource")
model ConfigurationReference
  is ExtensionResource<ConfigurationReferenceProperties> {
  ...ResourceNameParameter<ConfigurationReference, NamePattern = "^default$">;
}

@doc("Properties for ConfigurationReference Resource")
model ConfigurationReferenceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("ArmId of Configuration resource")
  configurationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Configurations";
    }
  ]>;
}

@armResourceOperations
interface ConfigurationReferences {
  get is ArmResourceRead<ConfigurationReference>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationReference>;
  update is ArmResourcePatchSync<
    ConfigurationReference,
    ConfigurationReferenceProperties
  >;
  delete is ArmResourceDeleteSync<ConfigurationReference>;
  list is ArmResourceListByParent<ConfigurationReference>;
}
