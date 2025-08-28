import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./ConfigTemplateVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@added(Versions.v2025_08_15_preview)
@doc("ConfigTemplateSchema Properties")
model ConfigTemplateSchemaProperties {
  @doc("Value of schema")
  @visibility(Lifecycle.Read)
  value?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_15_preview)
@doc("SolutionSchema Resource")
@parentResource(ConfigTemplateVersion)
model ConfigTemplateSchema is ProxyResource<ConfigTemplateSchemaProperties> {
  @doc("The name of the ConfigTemplateSchemaProperties")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("configTemplateSchemaName")
  @segment("configTemplateSchema")
  name: string;

  ...EntityTagProperty;
}

@added(Versions.v2025_08_15_preview)
@armResourceOperations
interface ConfigTemplateSchemas {
  @doc("Get a ConfigTemplateSchema Resource")
  get is ArmResourceRead<ConfigTemplateSchema>;

  @doc("List by ConfigTemplateVersion")
  listByConfigTemplateVersion is ArmResourceListByParent<ConfigTemplateSchema>;
}
