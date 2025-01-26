import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace GitHub.Network;

@doc("GitHub.Network networkSettings resource. Represents the network settings needed for vnet injection.")
@includeInapplicableMetadataInPayload(false)
model NetworkSettingsResource
  is Azure.ResourceManager.TrackedResource<NetworkSettingsResourceProperties> {
  @doc("Name of the GitHub.Network resource")
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("networkSettingsName")
  @segment("networkSettings")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface NetworkSettingsResources {
  @doc("Retrieves the properties of a GitHub.Network networkSettings resource.")
  get is ArmResourceRead<NetworkSettingsResource>;

  @doc("Creates a GitHub.Network networkSettings resource with the specified create parameters.")
  create is ArmResourceCreateOrReplaceSync<NetworkSettingsResource>;

  @doc("Updates the properties of an existing GitHub.Network networkSettings resource with the specified update parameters.")
  update is ArmResourcePatchSync<
    NetworkSettingsResource,
    NetworkSettingsResourceProperties
  >;

  @doc("Deletes an existing GitHub.Network networkSettings resource.")
  delete is ArmResourceDeleteSync<NetworkSettingsResource>;

  @doc("Retrieves the properties of all GitHub.Network networkSettings resources.")
  listByResourceGroup is ArmResourceListByParent<NetworkSettingsResource>;

  @doc("Retrieves the properties of all GitHub.Network networkSettings resources.")
  listBySubscription is ArmListBySubscription<NetworkSettingsResource>;
}

@@doc(NetworkSettingsResources.create::parameters.resource,
  "GitHub.Network networkSettings resource create parameters."
);
@@Azure.ClientGenerator.Core.clientName(NetworkSettingsResources.create::parameters.resource,
  "networkSettings"
);

@@doc(NetworkSettingsResources.update::parameters.properties,
  "Parameters for updating the properties of the GitHub.Network resource."
);
@@Azure.ClientGenerator.Core.clientName(NetworkSettingsResources.update::parameters.properties,
  "networkSettings"
);

@@Azure.ClientGenerator.Core.clientName(NetworkSettingsResources,
  "networkSettings"
);
