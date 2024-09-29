import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionBinding.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Solution Instance State")
union State {
  @doc("Solution Instance is ready to deploy")
  ReadyToDeploy: "ReadyToDeploy",

  @doc("Solution Instance is deploying")
  Deploying: "Deploying",

  @doc("Solution Instance is deployed")
  Deployed: "Deployed",

  @doc("Solution Instance failed to deploy")
  Failed: "Failed",

  @doc("Solution Instance is undeployed")
  Undeployed: "Undeployed",

  string,
}

@doc("Solution Instance Properties")
model SolutionInstanceProperties {
  @doc("Solution version of solution instance")
  solutionVersionId: string;

  @doc("Configuration version of solution instance")
  solutionBindingConfigurationId: string;

  @doc("State of solution instance")
  @visibility("read")
  state?: State;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Instance Resource")
@parentResource(SolutionBinding)
model SolutionInstance is ProxyResource<SolutionInstanceProperties> {
  ...ResourceNameParameter<SolutionInstance>;
}

@armResourceOperations
interface SolutionInstances {
  @doc("Get a Solution Instance Resource")
  get is ArmResourceRead<SolutionInstance>;

  @doc("Create or update a Solution Instance Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionInstance>;

  @doc("update a Solution Instance Resource")
  update is ArmResourcePatchSync<SolutionInstance, SolutionInstanceProperties>;

  @doc("Delete a Solution Instance Resource")
  delete is ArmResourceDeleteSync<SolutionInstance>;

  @doc("List Solution Instance Resources")
  listBySolutionBinding is ArmResourceListByParent<SolutionInstance>;
}
