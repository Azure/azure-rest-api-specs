import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionVersion.tsp";
import "./State.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Resolved Configuration")
model ResolvedConfiguration {
  @doc("Resolved Configuration as string")
  configuration: string;
}

@doc("Solution Template Parameter")
model SolutionTemplateParameter {
  @doc("Solution Template Version ARM Id")
  solutionTemplateVersionId: string;

  @doc("Solution Instance Name")
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Solution Dependencies")
  @Azure.ResourceManager.identifiers(#[])
  solutionDependencies?: SolutionDependencyParameter[];
}

@doc("Solution Version Parameter")
model SolutionVersionParameter {
  @doc("Solution Version ARM Id")
  solutionVersionId: string;
}

@doc("Update External Validation Status Parameter")
model UpdateExternalValidationStatusParameter {
  @doc("Solution Version Id")
  solutionVersionId: string;

  @doc("Error Details if any failure is there")
  errorDetails?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("External validation id")
  externalValidationId: string;

  @doc("Validation Status of external validation")
  validationStatus: ValidationStatus;
}

@doc("Solution Dependency Context")
model SolutionDependencyParameter {
  @doc("Solution Version Id")
  solutionVersionId?: string;

  @doc("Solution Template Id")
  solutionTemplateId?: string;

  @doc("Solution Template Version")
  solutionTemplateVersion?: string;

  @doc("Solution Instance Name")
  @maxLength(24)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Target Id")
  targetId?: string;

  @doc("Solution dependencies")
  @Azure.ResourceManager.identifiers(#[])
  dependencies?: SolutionDependencyParameter[];
}

@doc("Install Solution Parameter")
model InstallSolutionParameter {
  @doc("Solution Version ARM Id")
  solutionVersionId: string;
}

@doc("Uninstall Solution Parameter")
model UninstallSolutionParameter {
  @doc("Solution Template ARM Id")
  solutionTemplateId: string;

  @doc("Solution Instance Name")
  solutionInstanceName?: string;
}

@doc("Install Solution Parameter")
model RemoveRevisionParameter {
  @doc("Solution Template ARM Id")
  solutionTemplateId: string;

  @doc("Solution Version Name")
  solutionVersion: string;
}

@doc("Target Properties")
model TargetProperties {
  @doc("Description of target")
  description: string;

  @doc("Display name of target")
  displayName: string;

  @doc("ArmId of Context")
  contextId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/contexts";
    }
  ]>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("target spec")
  targetSpecification: Record<unknown>;

  @doc("List of capabilities")
  capabilities: string[];

  @doc("Hierarchy Level")
  hierarchyLevel: string;

  @doc("Status of target")
  @visibility(Lifecycle.Read)
  status?: DeploymentStatus;

  @doc("Scope of the target resource")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  solutionScope?: string;

  @doc("State of resource")
  state?: ResourceState;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Param that indicates if the delete should be forced")
model ForceDeleteParameter {
  @doc("Force delete")
  @query
  forceDelete?: boolean = false;
}

@doc("Target Resource. Represents a resource to be deployed on the edge.")
model Target is Azure.ResourceManager.TrackedResource<TargetProperties> {
  @doc("Name of the target")
  @maxLength(61)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;

  ...EntityTagProperty;
  ...ExtendedLocationProperty;
}

@armResourceOperations
interface Targets {
  @doc("Get a Target Resource")
  get is ArmResourceRead<Target>;

  @doc("Create or update a Target Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Target>;

  @doc("update a Target Resource")
  update is ArmCustomPatchAsync<
    Target,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Target,
      TargetProperties
    >
  >;

  @doc("Delete a Target Resource")
  delete is ArmResourceDeleteWithoutOkAsync<
    Target,
    {
      ...DefaultBaseParameters<Target>;
      ...ForceDeleteParameter;
    }
  >;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Target>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Target>;

  @doc("Post request to deploy")
  installSolution is ArmResourceActionNoResponseContentAsync<
    Target,
    InstallSolutionParameter
  >;

  @doc("Post request to uninstall")
  uninstallSolution is ArmResourceActionNoResponseContentAsync<
    Target,
    UninstallSolutionParameter
  >;

  @doc("Post request to remove solution version revision")
  removeRevision is ArmResourceActionNoResponseContentAsync<
    Target,
    RemoveRevisionParameter
  >;

  @doc("Post request to resolve configuration")
  resolveConfiguration is ArmResourceActionAsync<
    Target,
    SolutionTemplateParameter,
    ResolvedConfiguration
  >;

  @doc("Post request to review configuration")
  reviewSolutionVersion is ArmResourceActionAsync<
    Target,
    SolutionTemplateParameter,
    SolutionVersion
  >;

  @doc("Post request to publish")
  publishSolutionVersion is ArmResourceActionAsync<
    Target,
    SolutionVersionParameter,
    SolutionVersion
  >;

  @doc("Post request to update external validation status")
  updateExternalValidationStatus is ArmResourceActionAsync<
    Target,
    UpdateExternalValidationStatusParameter,
    SolutionVersion
  >;

  @added(Versions.v2025_08_01)
  @doc("Post request to unstage solution version")
  unstageSolutionVersion is ArmResourceActionAsync<
    Target,
    SolutionVersionParameter,
    SolutionVersion
  >;
}
