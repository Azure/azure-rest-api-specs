import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Config Template Version Properties")
model ConfigTemplateVersionProperties {
  @doc("Configuration values")
  configurations: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Config Template Version Resource")
@parentResource(ConfigTemplate)
@resource("versions")
model ConfigTemplateVersion is ProxyResource<ConfigTemplateVersionProperties> {
  ...ResourceNameParameter<
    ConfigTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface ConfigTemplateVersions {
  @doc("Get a Config Template Version Resource")
  get is ArmResourceRead<ConfigTemplateVersion>;

  @doc("List Config Template Version Resources")
  listByConfigTemplate is ArmResourceListByParent<ConfigTemplateVersion>;
}
