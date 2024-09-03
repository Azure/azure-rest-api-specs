import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./CapabilityList.tsp";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Configuration Link")
model ConfigurationLink {
  @doc("Hierarchy Type of Configuration Link")
  hierarchyType: string;

  @doc("Configuration Id of Configuration Link")
  configurationId: string;
}

@doc("Solution Properties")
model SolutionProperties {
  @doc("Current Version of solution")
  @visibility("read")
  currentVersion: string;

  @doc("List of capabilities")
  @extension("x-ms-identifiers", [])
  capabilities: Capability[];

  @doc("Description of solution")
  description: string;

  @doc("List of configuration links")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  configurationLinks?: ConfigurationLink[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Resource")
model Solution is TrackedResource<SolutionProperties> {
  ...ResourceNameParameter<Solution>;
}

@armResourceOperations
interface Solutions {
  @doc("Get a Solution resource")
  get is ArmResourceRead<Solution>;

  @doc("Create or update a Solution resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Solution>;

  @doc("update a Solution resource")
  update is ArmResourcePatchSync<Solution, SolutionProperties>;

  @doc("Delete a Solution resource")
  delete is ArmResourceDeleteSync<Solution>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Solution>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Solution>;
}
