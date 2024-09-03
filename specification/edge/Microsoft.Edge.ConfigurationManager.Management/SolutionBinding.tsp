import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionInstance.tsp";
import "./SolutionBindingConfiguration.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Configured Solution Version")
model ConfiguredSolutionVersion {
  @doc("Solution Version")
  solutionVersion: string;

  @doc("Latest Configuration Revision")
  latestConfigRevision: string;
}

@doc("Solution Configuration Parameter")
model SolutionConfigurationParameter {
  @doc("Solution Version")
  solutionVersion: string;
}

@doc("Solution Binding Properties")
model SolutionBindingProperties {
  @doc("Solution of solution binding")
  solution: string;

  @doc("Deployment Target of solution binding")
  deploymentTarget: string;

  @doc("Active Solution Instance of solution binding")
  activeSolutionInstance: string;

  @doc("Scope of solution binding")
  scope: string;

  @doc("Array of configured solution versions")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  configuredSolutionVersions?: ConfiguredSolutionVersion[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Binding Resource")
model SolutionBinding is TrackedResource<SolutionBindingProperties> {
  ...ResourceNameParameter<SolutionBinding>;
}

@armResourceOperations
interface SolutionBindings {
  @doc("Get a Solution Binding Resource")
  get is ArmResourceRead<SolutionBinding>;

  @doc("Create or update a Solution Binding Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionBinding>;

  @doc("update a Solution Binding Resource")
  update is ArmResourcePatchSync<SolutionBinding, SolutionBindingProperties>;

  @doc("Delete a Solution Binding Resource")
  delete is ArmResourceDeleteSync<SolutionBinding>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<SolutionBinding>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<SolutionBinding>;

  @doc("Post request to deploy")
  deploy is ArmResourceActionNoResponseContentAsync<
    SolutionBinding,
    SolutionInstance
  >;

  @doc("Post request to resolve configuration")
  resolveConfiguration is ArmResourceActionAsync<
    SolutionBinding,
    SolutionConfigurationParameter,
    SolutionBindingConfiguration
  >;

  @doc("Post request to publish")
  publish is ArmResourceActionAsync<
    SolutionBinding,
    SolutionInstance,
    SolutionInstance
  >;
}
