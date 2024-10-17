import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of a Solution resource.")
model SolutionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Solution resource.")
@resource("solutions")
model Solution is TrackedResource<SolutionProperties> {
  @doc("Name of solution.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("solutionName")
  @segment("solutions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Solutions {
  @doc("Returns details of specified Solution resource.")
  get is Azure.ResourceManager.ArmResourceRead<Solution>;
  @doc("Creates new or updates existing Solution resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Solution>;
  @doc("Updates existing Solution resource.")
  update is ArmCustomPatchAsync<Solution>;
  @doc("Deletes specified Solution resource.")
  delete is ArmResourceDeleteWithoutOkAsync<Solution>;
  @doc("Returns a collection of Solution resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Solution>;
  @doc("Lists Solutions resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Solution>;
}
