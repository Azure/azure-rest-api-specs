import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Available Orchestrator types")
union OrchestratorType {
  @doc("Toolchain Orchestrator type")
  TO: "TO",

  string,
}

@doc("Solution Template Version Properties")
model SolutionTemplateVersionProperties {
  @doc("Config expressions for this solution version")
  configurations: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("App components spec")
  specification: Record<unknown>;

  @doc("Orchestrator type")
  orchestratorType: OrchestratorType;

  @doc("List of capabilities")
  @visibility("read")
  capabilities: string[];

  @doc("Is this resource deprecated")
  @visibility("read")
  isDeprecated?: boolean;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Template Version Resource")
@parentResource(SolutionTemplate)
@resource("versions")
model SolutionTemplateVersion
  is ProxyResource<SolutionTemplateVersionProperties> {
  ...ResourceNameParameter<
    SolutionTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface SolutionTemplateVersions {
  @doc("Get a Solution Template Version Resource")
  get is ArmResourceRead<SolutionTemplateVersion>;

  @doc("Delete a Solution Template Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionTemplateVersion>;

  @doc("Deprecate resource")
  deprecate is ArmResourceActionNoResponseContentAsync<
    SolutionTemplateVersion,
    void
  >;

  @doc("List Solution Template Version Resources")
  listBySolutionTemplate is ArmResourceListByParent<SolutionTemplateVersion>;
}
