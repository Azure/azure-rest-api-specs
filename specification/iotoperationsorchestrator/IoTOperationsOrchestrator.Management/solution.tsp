import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsOrchestrator;

@doc("A Solution resource belonging to an Instance resource.")
model Solution is TrackedResource<SolutionProperties> {
  @doc("Name of solution.")
  @key
  @segment("solutions")
  @pattern("^[a-z0-9][a-z0-9-]{1,60}[a-z0-9]$")
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("The properties of a Solution resource.")
model SolutionProperties {
  @doc("A list of components")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("Version of the particular resource.")
  version?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface Solutions {
  get is ArmResourceRead<Solution>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Solution>;
  update is ArmCustomPatchSync<Solution>;
  delete is ArmResourceDeleteWithoutOkAsync<Solution>;
  listByResourceGroup is ArmResourceListByParent<Solution>;
  listBySubscription is ArmListBySubscription<Solution>;
}
