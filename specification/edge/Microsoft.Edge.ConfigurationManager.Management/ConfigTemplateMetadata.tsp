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
@doc("ConfigTemplateMetadata Properties")
model ConfigTemplateMetadataProperties {
  @doc("Hierarchy ARM Ids")
  @visibility(Lifecycle.Read)
  hierarchyIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Edge/targets";
    },
    {
      type: "Microsoft.Edge/sites";
    }
  ]>[];

  @doc("Hierarchy Level")
  @visibility(Lifecycle.Read)
  level?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_15_preview)
@doc("SolutionSchema Resource")
@parentResource(ConfigTemplate)
model ConfigTemplateMetadata
  is ProxyResource<ConfigTemplateMetadataProperties> {
  @doc("The name of the ConfigTemplateMetadataProperties")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("configTemplateMetadataName")
  @segment("configTemplateMetadata")
  name: string;

  ...EntityTagProperty;
}

@added(Versions.v2025_08_15_preview)
@armResourceOperations
interface ConfigTemplateMetadatas {
  @doc("Get a ConfigTemplateMetadata Resource")
  get is ArmResourceRead<ConfigTemplateMetadata>;

  @doc("List by ConfigTemplate")
  listByConfigTemplate is ArmResourceListByParent<ConfigTemplateMetadata>;
}
