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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Legacy"
@doc("Solution Version Resource")
@parentResource(Solution)
@resource("versions")
model SolutionVersion is ProxyResource<HelmSolutionProperties> {
  ...ResourceNameParameter<
    SolutionVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("Kind of solution version")
  kind: "Helm";
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
