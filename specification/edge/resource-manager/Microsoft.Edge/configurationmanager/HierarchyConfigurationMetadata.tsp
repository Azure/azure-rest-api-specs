import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Target.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "ResourceProvisioningState is not needed since this resource is created via ARB and directly pushed to ARG"
@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Hierarchy Configuration Metadata Properties")
model HierarchyConfigurationMetadataProperties {
  @doc("Display name of the hierarchy configuration metadata resource")
  @visibility(Lifecycle.Read)
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  displayName?: string;

  @doc("Configuration template Id")
  @visibility(Lifecycle.Read)
  configTemplateId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/ConfigTemplates";
    }
  ]>;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Hierarchy Configuration Metadata Resource attached to a Target or Site")
model HierarchyConfigurationMetadata
  is Azure.ResourceManager.ExtensionResource<HierarchyConfigurationMetadataProperties> {
  @doc("Name of the hierarchy configuration metadata")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("hierarchyConfigurationMetadataName")
  @segment("hierarchyConfigurationMetadatas")
  name: string;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@armResourceOperations
interface HierarchyConfigurationMetadatas {
  @doc("Get a Hierarchy Configuration Metadata resource")
  get is ArmResourceRead<HierarchyConfigurationMetadata>;

  @doc("List Solution resources")
  listByParent is ArmResourceListByParent<HierarchyConfigurationMetadata>;
}
