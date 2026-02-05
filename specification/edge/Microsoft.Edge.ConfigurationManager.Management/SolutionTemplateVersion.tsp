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
  @doc("Default type")
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
  orchestratorType?: OrchestratorType;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Solution Template Version Resource. Contains configurations that use expressions which can be resolved hierarchically along with edge specifications.")
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

@doc("Bulk deploy solution parameter")
model BulkDeploySolutionParameter {
  @doc("Targets to which solution needs to be deployed")
  @Azure.ResourceManager.identifiers(#[])
  targets: BulkDeployTargetDetails[];
}

@doc("Bulk deploy target details")
model BulkDeployTargetDetails {
  @doc("ArmId of Target Solution Version")
  solutionVersionId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Targets/Solutions/Versions";
    }
  ]>;
}

@doc("Bulk publish solution parameter")
model BulkPublishSolutionParameter {
  @doc("Targets to which solution needs to be published")
  @Azure.ResourceManager.identifiers(#[])
  targets: BulkPublishTargetDetails[];

  @doc("Name of the solution instance")
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Solution dependencies")
  @Azure.ResourceManager.identifiers(#[])
  solutionDependencies?: SolutionDependencyParameter[];

  @added(Versions.v2025_08_01)
  @doc("Configuration of solution")
  solutionConfiguration?: string;
}

@doc("Bulk publish target details")
model BulkPublishTargetDetails {
  @doc("ArmId of Target")
  targetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Targets";
    }
  ]>;

  @doc("Name of the solution instance")
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @added(Versions.v2025_08_01)
  @doc("ArmId of Target Solution Version")
  solutionVersionId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Targets/Solutions/Versions";
    }
  ]>;

  @added(Versions.v2025_08_01)
  @doc("Configuration of solution")
  solutionConfiguration?: string;
}

@added(Versions.v2025_08_01)
@doc("Bulk publish solution parameter")
model BulkReviewSolutionParameter {
  @doc("Targets to which solution needs to be published")
  @Azure.ResourceManager.identifiers(#[])
  targets: BulkReviewTargetDetails[];

  @doc("Name of the solution instance")
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Solution dependencies")
  @Azure.ResourceManager.identifiers(#[])
  solutionDependencies?: SolutionDependencyParameter[];

  @doc("Configuration of solution")
  solutionConfiguration?: string;
}

@added(Versions.v2025_08_01)
@doc("Bulk publish target details")
model BulkReviewTargetDetails {
  @doc("ArmId of Target")
  targetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Targets";
    }
  ]>;

  @doc("Name of the solution instance")
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Configuration of solution")
  solutionConfiguration?: string;
}

@armResourceOperations
interface SolutionTemplateVersions {
  @doc("Get a Solution Template Version Resource")
  get is ArmResourceRead<SolutionTemplateVersion>;

  @doc("List Solution Template Version Resources")
  listBySolutionTemplate is ArmResourceListByParent<SolutionTemplateVersion>;

  @doc("Post request for bulk deploy")
  bulkDeploySolution is ArmResourceActionNoResponseContentAsync<
    SolutionTemplateVersion,
    BulkDeploySolutionParameter
  >;

  @doc("Post request for bulk publish")
  bulkPublishSolution is ArmResourceActionNoResponseContentAsync<
    SolutionTemplateVersion,
    BulkPublishSolutionParameter
  >;

  @added(Versions.v2025_08_01)
  @doc("Post request for bulk review")
  bulkReviewSolution is ArmResourceActionNoResponseContentAsync<
    SolutionTemplateVersion,
    BulkReviewSolutionParameter
  >;
}
