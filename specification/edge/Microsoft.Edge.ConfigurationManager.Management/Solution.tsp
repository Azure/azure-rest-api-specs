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
  @visibility(Lifecycle.Read)
  solutionTemplateId?: string;

  @doc("List of latest revisions for available solution template versions")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  availableSolutionTemplateVersions?: AvailableSolutionTemplateVersion[];

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Solution Resource attached to a Target")
@parentResource(Target)
model Solution is Azure.ResourceManager.ProxyResource<SolutionProperties> {
  @doc("Name of the solution")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
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

  @doc("Create or update a Solution Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Solution>;

  @doc("Update a Solution Resource")
  update is ArmResourcePatchAsync<Solution, SolutionProperties>;

  @doc("Delete a Solution Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Solution>;

  @doc("List Solution resources")
  listByTarget is ArmResourceListByParent<Solution>;
}
