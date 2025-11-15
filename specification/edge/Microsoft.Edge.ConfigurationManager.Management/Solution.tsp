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

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("Solution Properties")
model SolutionProperties {
  @doc("Solution template Id")
  @visibility(Lifecycle.Read)
  solutionTemplateId?: string;

  @added(Versions.v2025_08_01)
  @doc("Display name of the solution")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("List of latest revisions for available solution template versions")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  availableSolutionTemplateVersions?: AvailableSolutionTemplateVersion[];

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The type used for update operations of the Solution. */
model SolutionUpdate {
  @doc("The resource-specific properties for this resource.")
  properties?: SolutionUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("The updatable properties of the Solution.")
model SolutionUpdateProperties {}

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Update a Solution Resource")
  update is ArmCustomPatchAsync<Solution, PatchModel = SolutionUpdate>;

  @doc("Delete a Solution Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Solution>;

  @doc("List Solution resources")
  listByTarget is ArmResourceListByParent<Solution>;
}
