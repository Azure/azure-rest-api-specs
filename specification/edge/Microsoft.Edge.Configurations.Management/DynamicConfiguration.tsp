import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";
import "./ConfigurationModel.tsp";
import "./ConfigurationType.tsp";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Dynamic Configuration Properties")
model DynamicConfigurationProperties {
  @doc("Current Version of dynamic configuration")
  currentVersion: string;

  @doc("Type of dynamic configuration")
  @visibility(Lifecycle.Read)
  dynamicConfigurationType?: ConfigurationType;

  @doc("Type of dynamic configuration model")
  @visibility(Lifecycle.Read)
  dynamicConfigurationModel?: ConfigurationModel;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Dynamic Configuration Resource")
@parentResource(Configuration)
model DynamicConfiguration is ProxyResource<DynamicConfigurationProperties> {
  @doc("Name of the dynamic configuration")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("dynamicConfigurationName")
  @segment("dynamicConfigurations")
  name: string;
}

@armResourceOperations
interface DynamicConfigurations {
  @doc("Get a Dynamic Configuration Resource")
  get is ArmResourceRead<DynamicConfiguration>;

  @doc("Create or update a Dynamic Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DynamicConfiguration>;

  @doc("Update a Dynamic Configuration Resource")
  update is ArmResourcePatchSync<
    DynamicConfiguration,
    DynamicConfigurationProperties
  >;

  @doc("Delete a Dynamic Configuration Resource")
  delete is ArmResourceDeleteSync<DynamicConfiguration>;

  @doc("List Dynamic Configuration Resources")
  listByConfiguration is ArmResourceListByParent<DynamicConfiguration>;
}
