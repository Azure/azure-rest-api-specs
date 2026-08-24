import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./SolutionMetadata.tsp";

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
@doc("Solution Metadata Version Properties")
model SolutionMetadataVersionProperties {
  @doc("Display name of the solution metadata resource")
  @visibility(Lifecycle.Read)
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  parentDisplayName?: string;

  @doc("Solution template version Id")
  @visibility(Lifecycle.Read)
  solutionTemplateVersionId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/SolutionTemplates/Versions";
    }
  ]>;

  @doc("Schema Id for the solution template version at the hierarchy")
  @visibility(Lifecycle.Read)
  schemaId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/SolutionTemplates/Versions/SolutionSchemas";
    }
  ]>;

  @doc("Dynamic Configuration Id for the solution template version")
  @visibility(Lifecycle.Read)
  dynamicConfigurationVersionId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Configurations/DynamicConfigurations/Versions";
    }
  ]>;

  @doc("Configuration status of the solution template version")
  @visibility(Lifecycle.Read)
  configurationStatus?: ConfigurationState;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Configuration State Enums")
union ConfigurationState {
  @doc("Configuration Completed")
  ConfigurationCompleted: "ConfigurationCompleted",

  @doc("Configuration Completed")
  ConfigurationPending: "ConfigurationPending",

  string,
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Solution Metadata Version Resource")
@parentResource(SolutionMetadata)
@resource("versions")
model SolutionMetadataVersion
  is Azure.ResourceManager.ProxyResource<SolutionMetadataVersionProperties> {
  @doc("Name of the solution metadata version")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("solutionMetadataVersionName")
  @segment("SolutionMetadataVersions")
  name: string;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@armResourceOperations
interface SolutionMetadataVersions {
  @doc("Get a Solution resource")
  get is ArmResourceRead<SolutionMetadataVersion>;

  @doc("List Solution resources")
  listByParent is ArmResourceListByParent<SolutionMetadataVersion>;
}
