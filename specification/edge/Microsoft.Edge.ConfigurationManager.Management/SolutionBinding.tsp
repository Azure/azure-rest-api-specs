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

@doc("Solution Binding Properties")
model SolutionBindingProperties {
  @doc("Solution of target binding")
  solution: string;

  @doc("Deployment Target of target binding")
  deploymentTarget: string;

  @doc("Active Deployment Instance of target binding")
  activeSolutionInstance: string;

  @doc("Scope of target binding")
  scope: string;

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
    void,
    SolutionBindingConfiguration
  >;

  @doc("Post request to publish")
  publish is ArmResourceActionAsync<
    SolutionBinding,
    SolutionInstance,
    SolutionInstance
  >;
}
