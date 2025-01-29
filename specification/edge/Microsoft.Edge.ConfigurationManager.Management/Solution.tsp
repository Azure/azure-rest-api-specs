import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Target.tsp";
import "./ProvisioningState.tsp";
import "./AvailableSolutionTemplateVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Solution Properties")
model SolutionProperties {
  @doc("Solution template Id")
  @visibility("read")
  solutionTemplateId: string;

  @doc("List of latest revisions for available solution template versions")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  availableSolutionTemplateVersions?: AvailableSolutionTemplateVersion[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Resource")
@parentResource(Target)
model Solution is Azure.ResourceManager.ProxyResource<SolutionProperties> {
  @doc("Name of the solution")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("solutionName")
  @segment("solutions")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@armResourceOperations
interface Solutions {
  @doc("Get a Solution resource")
  get is ArmResourceRead<Solution>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Solution>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Solution>;
}
