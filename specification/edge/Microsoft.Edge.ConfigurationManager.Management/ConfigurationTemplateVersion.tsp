import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./ConfigurationTemplate.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Configuration Template Version Properties")
model ConfigurationTemplateVersionProperties {
  @doc("Configuration values")
  configurations: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Configuration Template Version Resource")
@parentResource(ConfigurationTemplate)
@resource("versions")
model ConfigurationTemplateVersion
  is ProxyResource<ConfigurationTemplateVersionProperties> {
  ...ResourceNameParameter<
    ConfigurationTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface ConfigurationTemplateVersions {
  @doc("Get a Configuration Template Version Resource")
  get is ArmResourceRead<ConfigurationTemplateVersion>;

  @doc("List Configuration Template Version Resources")
  listByConfigurationTemplate is ArmResourceListByParent<ConfigurationTemplateVersion>;
}
