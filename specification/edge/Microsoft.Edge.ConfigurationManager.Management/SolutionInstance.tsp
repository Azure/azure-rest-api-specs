import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./TargetBinding.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Solution Instance Properties")
model SolutionInstanceProperties {
  @doc("Solution version of solution instance")
  solutionVersion: string;

  @doc("Configuration version of solution instance")
  configurationVersion: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Solution Instance Resource")
@parentResource(TargetBinding)
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
  listByTargetBinding is ArmResourceListByParent<SolutionInstance>;
}
