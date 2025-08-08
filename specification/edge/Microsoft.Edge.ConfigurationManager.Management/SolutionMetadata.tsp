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

@added(Versions.v2025_08_01)
@doc("Solution Metadata Properties")
model SolutionMetadataProperties {
  @doc("Solution template Id")
  @visibility(Lifecycle.Read)
  solutionTemplateId?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_01)
@doc("Solution Metadata Resource attached to a Target or Site")
model SolutionMetadata
  is Azure.ResourceManager.ExtensionResource<SolutionMetadataProperties> {
  @doc("Name of the solution metadata")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("solutionMetadataName")
  @segment("solutionMetadatas")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@added(Versions.v2025_08_01)
@armResourceOperations
interface SolutionMetadatas {
  @doc("Get a Solution resource")
  get is ArmResourceRead<SolutionMetadata>;

  @doc("Create or update a Solution Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionMetadata>;

  @doc("Update a Solution Resource")
  update is ArmResourcePatchAsync<SolutionMetadata, SolutionMetadataProperties>;

  @doc("Delete a Solution Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionMetadata>;

  @doc("List Solution resources")
  listByTarget is ArmResourceListByParent<SolutionMetadata>;
}
