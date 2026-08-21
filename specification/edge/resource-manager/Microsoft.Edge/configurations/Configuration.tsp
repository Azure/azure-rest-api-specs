import "./Commons.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Configuration Properties")
model ConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Managed Resources Configuration.")
  @removed(Versions.v2025_06_01)
  @removed(Versions.v2024_09_01_preview)
  @added(Versions.v2025_12_01_preview)
  managedResourcesConfiguration?: ManagedResourcesConfiguration;

  @doc("Managed On Behalf Of Configuration.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_06_01)
  @removed(Versions.v2024_09_01_preview)
  @added(Versions.v2025_12_01_preview)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;
}

@doc("Managed Resources Configuration.")
@removed(Versions.v2025_06_01)
@removed(Versions.v2024_09_01_preview)
@added(Versions.v2025_12_01_preview)
model ManagedResourcesConfiguration {
  @doc("Flag indicating whether managed resources are enabled or not")
  enabled: boolean = false;

  @doc("Name of the resource group to be used for managed resources. If not provided, a new resource group will be created with name format 'ManagedResources-<configurationName>-<randomString>'.")
  managedResourceGroupNameOverride?: string;

  @doc("ResourceId of provisioned Managed resource group. This will not be set if 'enabled' is false.")
  @visibility(Lifecycle.Read)
  managedResourceGroupId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Resources/resourceGroups";
    }
  ]>;

  @doc("Metadata for additional identities.")
  additionalIdentitiesMetadata?: AdditionalIdentitiesMetadata[];
}

@doc("Metadata for additional identities.")
@removed(Versions.v2025_06_01)
@removed(Versions.v2024_09_01_preview)
@added(Versions.v2025_12_01_preview)
model AdditionalIdentitiesMetadata {
  @doc("Object ID (GUID) of the service principal for the additional identity.")
  servicePrincipalObjectId: string;

  @doc("Name for the additional identity.")
  name: AdditionalIdentityName;
}

@doc("Allowed names for additional identities.")
@removed(Versions.v2025_06_01)
@removed(Versions.v2024_09_01_preview)
@added(Versions.v2025_12_01_preview)
union AdditionalIdentityName {
  @doc("Name of AzureLocal for additional identity.")
  AzureLocal: "AzureLocal",

  string,
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
  @removed(Versions.v2025_12_01_preview)
  @renamedFrom(Versions.v2025_12_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateSync is ArmResourceCreateOrReplaceSync<Configuration>;

  @doc("Create or update a Configuration Resource")
  @added(Versions.v2025_12_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Configuration>;

  @doc("Update a Configuration Resource")
  @removed(Versions.v2025_12_01_preview)
  @renamedFrom(Versions.v2025_12_01_preview, "update")
  @sharedRoute
  updateSync is ArmResourcePatchSync<Configuration, ConfigurationProperties>;

  @doc("Update a Configuration Resource")
  @added(Versions.v2025_12_01_preview)
  @sharedRoute
  update is ArmResourcePatchAsync<Configuration, ConfigurationProperties>;

  @doc("Delete a Configuration Resource")
  @removed(Versions.v2025_12_01_preview)
  @renamedFrom(Versions.v2025_12_01_preview, "delete")
  @sharedRoute
  deleteSync is ArmResourceDeleteSync<Configuration>;

  @doc("Delete a Configuration Resource")
  @added(Versions.v2025_12_01_preview)
  @sharedRoute
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
