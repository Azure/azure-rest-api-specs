import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace GitHub.Network;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("GitHub.Network networkSettings resource. Represents the network settings needed for vnet injection.")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkSettingsResourceProperties
)
model NetworkSettingsResource
  extends TrackedResource<NetworkSettingsResourceProperties> {
  @doc("Name of the GitHub.Network resource")
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("networkSettingsName")
  @segment("networkSettings")
  @visibility("read")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkSettingsResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of a GitHub.Network networkSettings resource.")
  @operationId("networkSettings_Get")
  get is ArmResourceRead<NetworkSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a GitHub.Network networkSettings resource with the specified create parameters.")
  @operationId("networkSettings_Create")
  create is ArmResourceCreateOrReplaceSync<NetworkSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the properties of an existing GitHub.Network networkSettings resource with the specified update parameters.")
  @parameterVisibility("read")
  @operationId("networkSettings_Update")
  update is ArmResourcePatchSync<
    NetworkSettingsResource,
    NetworkSettingsResourceProperties
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing GitHub.Network networkSettings resource.")
  @operationId("networkSettings_Delete")
  delete is ArmResourceDeleteSync<NetworkSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of all GitHub.Network networkSettings resources.")
  @operationId("networkSettings_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkSettingsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of all GitHub.Network networkSettings resources.")
  @operationId("networkSettings_ListBySubscription")
  listBySubscription is ArmListBySubscription<NetworkSettingsResource>;
}

@@doc(NetworkSettingsResources.create::parameters.resource,
  "GitHub.Network networkSettings resource create parameters."
);
@@projectedName(NetworkSettingsResources.create::parameters.resource,
  "json",
  "networkSettings"
);
@@doc(NetworkSettingsResources.update::parameters.properties,
  "Parameters for updating the properties of the GitHub.Network resource."
);
@@projectedName(NetworkSettingsResources.update::parameters.properties,
  "json",
  "networkSettings"
);
