import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./State.tsp";
import "./Job.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Solution Version Properties")
model SolutionVersionProperties {
  @doc("Solution Template Version Id")
  @visibility(Lifecycle.Read)
  solutionTemplateVersionId?: string;

  @doc("Revision number of resolved config for this solution version")
  @visibility(Lifecycle.Read)
  revision?: int32;

  @doc("Name of applicable target's display name")
  @visibility(Lifecycle.Read)
  targetDisplayName?: string;

  @doc("Resolved configuration values")
  @visibility(Lifecycle.Read)
  configuration?: string;

  @doc("Configuration on the line level across all solution template versions")
  @visibility(Lifecycle.Read)
  targetLevelConfiguration?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("App components spec")
  specification: Record<unknown>;

  @doc("Review id of resolved config for this solution version")
  @visibility(Lifecycle.Read)
  reviewId?: string;

  @doc("External validation id")
  @visibility(Lifecycle.Read)
  externalValidationId?: string;

  @doc("State of solution instance")
  @visibility(Lifecycle.Read)
  state?: State;

  @doc("Solution instance name")
  @visibility(Lifecycle.Read)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Solution Dependency Context")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  solutionDependencies?: SolutionDependency[];

  @doc("Error Details if any failure is there")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The URI for tracking the latest action performed on this solution version.")
  @visibility(Lifecycle.Read)
  latestActionTrackingUri?: string;

  @doc("The type of the latest action performed on this solution version.")
  @visibility(Lifecycle.Read)
  actionType?: JobType;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Solution Version Resource. It has the resolved configuration along with edge specification.")
@parentResource(Solution)
@resource("versions")
model SolutionVersion
  is Azure.ResourceManager.ProxyResource<SolutionVersionProperties> {
  // Name will be set to solutionTemplateVersion-revision
  @doc("Name of the solution version")
  @maxLength(61)
  @minLength(7)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("solutionVersionName")
  @segment("solutionVersions")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@doc("Solution Dependency Context")
model SolutionDependency {
  @doc("Solution Version Id")
  solutionVersionId: string;

  @doc("Solution Instance Name")
  @maxLength(24)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  solutionInstanceName?: string;

  @doc("Solution Template Version Id")
  solutionTemplateVersionId: string;

  @doc("Target Id")
  targetId: string;

  @doc("Solution dependencies")
  @Azure.ResourceManager.identifiers(#[])
  dependencies?: SolutionDependency[];
}

@armResourceOperations
interface SolutionVersions {
  @doc("Get a Solution Version Resource")
  get is ArmResourceRead<SolutionVersion>;

  @doc("Create or update a Solution Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionVersion>;

  @doc("Update a Solution Version Resource")
  update is ArmResourcePatchAsync<SolutionVersion, SolutionVersionProperties>;

  @doc("Delete a Solution Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionVersion>;

  @doc("List Solution Version Resources")
  listBySolution is ArmResourceListByParent<SolutionVersion>;
}
