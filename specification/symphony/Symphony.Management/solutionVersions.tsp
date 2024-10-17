import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of a SolutionVersion resource.")
model SolutionVersionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A list of components.")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("The display name of the SolutionVersion resource.")
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata information of the SolutionVersion resource.")
  metadata?: Record<string>;
}

@doc("A SolutionVersion resource belonging to a Solution resource.")
@resource("versions")
@parentResource(Solution)
model SolutionVersion is TrackedResource<SolutionVersionProperties> {
  @doc("Name of SolutionVersion resource.")
  @maxLength(90)
  @minLength(1)
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  @madeOptional(Versions.v2024_08_01_preview)
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface SolutionVersions {
  @doc("Returns details of specified SolutionVersion resource.")
  get is Azure.ResourceManager.ArmResourceRead<SolutionVersion>;
  @doc("Creates new or updates existing SolutionVersion resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<SolutionVersion>;
  @doc("Updates existing SolutionVersion resource.")
  update is ArmCustomPatchAsync<SolutionVersion>;
  @doc("Deletes specified SolutionVersion resource.")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionVersion>;
  @doc("Returns a collection of SolutionVersion resources belonging to a Solution resource.")
  listBySolution is ArmResourceListByParent<SolutionVersion>;
}
