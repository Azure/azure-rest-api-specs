import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

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
@doc("Hierarchy Configuration Metadata Version Properties")
model HierarchyConfigurationMetadataVersionProperties {
  @doc("Display name of the hierarchy configuration metadata resource")
  @visibility(Lifecycle.Read)
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  parentDisplayName?: string;

  @doc("Configuration template version Id")
  @visibility(Lifecycle.Read)
  configTemplateVersionId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/ConfigTemplates/Versions";
    }
  ]>;

  @doc("Schema Id for the config template version at the hierarchy")
  @visibility(Lifecycle.Read)
  schemaId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/ConfigTemplates/Versions/ConfigTemplateSchemas";
    }
  ]>;

  @doc("Dynamic Configuration Id for the config template version")
  @visibility(Lifecycle.Read)
  dynamicConfigurationVersionId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Configurations/DynamicConfigurations/Versions";
    }
  ]>;

  @doc("Configuration status of the config template version")
  @visibility(Lifecycle.Read)
  configurationStatus?: ConfigTemplateConfigurationState;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Configuration State Enums")
union ConfigTemplateConfigurationState {
  @doc("Configuration Completed")
  ConfigurationCompleted: "ConfigurationCompleted",

  @doc("Configuration Completed")
  ConfigurationPending: "ConfigurationPending",

  string,
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Configuration Metadata Version Resource")
@parentResource(HierarchyConfigurationMetadata)
@resource("versions")
model HierarchyConfigurationMetadataVersion
  is Azure.ResourceManager.ProxyResource<HierarchyConfigurationMetadataVersionProperties> {
  @doc("Name of the hierarchy configuration metadata version")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("hierarchyConfigurationMetadataVersionName")
  @segment("HierarchyConfigurationMetadataVersions")
  name: string;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@armResourceOperations
interface HierarchyConfigurationMetadataVersions {
  @doc("Get a Hierarchy Configuration Metadata Version resource")
  get is ArmResourceRead<HierarchyConfigurationMetadataVersion>;

  @doc("List Hierarchy Configuration Metadata Version resources")
  listByParent is ArmResourceListByParent<HierarchyConfigurationMetadataVersion>;
}
