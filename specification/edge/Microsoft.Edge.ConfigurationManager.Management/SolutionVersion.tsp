import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./Solution.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Solution Version Properties")
model HelmSolutionProperties {
  @doc("Helm Chart URI of helm solution")
  helmChartUri: string;

  @doc("Helm Chart Version of helm solution")
  helmChartVersion: string;

  @doc("Configuration template of helm solution")
  configurationTemplate: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Available solution version types")
union SolutionVersionType {
  @doc("Helm solution version")
  Helm: "Helm",

  string,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("Solution Version Resource")
@parentResource(Solution)
@resource("versions")
@discriminator("kind")
model SolutionVersion is ProxyResource<{}> {
  ...ResourceNameParameter<SolutionVersion>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("Kind of solution version")
  kind: SolutionVersionType;
}

@doc("Helm Solution Properties")
model HelmSolution extends SolutionVersion {
  @doc("properties of helm solution")
  properties: HelmSolutionProperties;

  @doc("Kind of solution version")
  kind: SolutionVersionType.Helm;
}

@armResourceOperations
interface SolutionVersions {
  @doc("Get a Solution Version Resource")
  get is ArmResourceRead<SolutionVersion>;

  @doc("Create or update a Solution Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionVersion>;

  @doc("Delete a Solution Version Resource")
  delete is ArmResourceDeleteSync<SolutionVersion>;

  @doc("List Solution Version Resources")
  listBySolution is ArmResourceListByParent<SolutionVersion>;
}
