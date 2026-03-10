import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Tool tracked resource")
model Tool is TrackedResource<ToolProperties> {
  ...ResourceNameParameter<Tool>;
}

@doc("Discovery Tool list item properties")
model ToolProperties {
  ...DiscoveryResourceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Environment variables to make available")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  environmentVariables?: Record<string>;

  ...WithDefinitionContent;
}

@doc("Updatable properties for Tool (all fields optional for PATCH)")
model ToolUpdateProperties {
  @doc("The version of a resource definition")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  version?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Environment variables to make available")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  environmentVariables?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Need flexibly content to match various use-cases"
  @doc("The JSON content for defining a resource")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  definitionContent?: Record<unknown>;
}

@doc("Update model for Tool PATCH operations")
model ToolUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: ToolUpdateProperties;
}

@armResourceOperations
interface Tools {
  get is ArmResourceRead<Tool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Tool>;
  update is ArmCustomPatchAsync<Tool, ToolUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<Tool>;
  listByResourceGroup is ArmResourceListByParent<Tool>;
  listBySubscription is ArmListBySubscription<Tool>;
}
