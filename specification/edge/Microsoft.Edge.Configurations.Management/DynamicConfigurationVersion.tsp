import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./DynamicConfiguration.tsp";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Dynamic Configuration Properties")
model DynamicConfigurationVersionProperties {
  @doc("Values of configuration version")
  values: string;

  @doc("Schema Id for configuration")
  @visibility(Lifecycle.Read)
  schemaId?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Dynamic Configuration Resource")
@parentResource(DynamicConfiguration)
@resource("versions")
model DynamicConfigurationVersion
  is ProxyResource<DynamicConfigurationVersionProperties> {
  ...ResourceNameParameter<
    DynamicConfigurationVersion,
    NamePattern = "^[a-zA-Z0-9.-]{3,24}$"
  >;
}

@armResourceOperations
interface DynamicConfigurationVersions {
  @doc("Get a Dynamic Configuration Version Resource")
  get is ArmResourceRead<DynamicConfigurationVersion>;

  @doc("Create or update a Dynamic Configuration Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DynamicConfigurationVersion>;

  @doc("update a Dynamic Configuration Version Resource")
  update is ArmResourcePatchSync<
    DynamicConfigurationVersion,
    DynamicConfigurationVersionProperties
  >;

  @doc("Delete a Dynamic Configuration Version Resource")
  delete is ArmResourceDeleteSync<DynamicConfigurationVersion>;

  @doc("List Dynamic Configuration Version Resource")
  listByDynamicConfiguration is ArmResourceListByParent<DynamicConfigurationVersion>;
}
