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
@doc("Solution Metadata Properties")
model SolutionMetadataProperties {
  @doc("Display name of the solution metadata resource")
  @visibility(Lifecycle.Read)
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  displayName?: string;

  @doc("Solution template Id")
  @visibility(Lifecycle.Read)
  solutionTemplateId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/SolutionTemplates";
    }
  ]>;

  @doc("Latest solution template version")
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  @doc("Current solution template version")
  @visibility(Lifecycle.Read)
  currentVersion?: string;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@doc("Solution Metadata Resource attached to a Target or Site")
model SolutionMetadata
  is Azure.ResourceManager.ExtensionResource<SolutionMetadataProperties> {
  @doc("Name of the solution metadata")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("solutionMetadataName")
  @segment("solutionMetadatas")
  name: string;
}

@added(Versions.v2025_08_15_preview)
@added(Versions.v2025_08_01)
@armResourceOperations
interface SolutionMetadatas {
  @doc("Get a Solution resource")
  get is ArmResourceRead<SolutionMetadata>;

  @doc("List Solution resources")
  listByParent is ArmResourceListByParent<SolutionMetadata>;
}
