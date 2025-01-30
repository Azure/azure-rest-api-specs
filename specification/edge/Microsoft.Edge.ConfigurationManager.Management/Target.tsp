import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionVersion.tsp";

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
  @doc("Solution Template Name")
  solutionTemplate: string;

  @doc("Solution Template Version Name")
  solutionTemplateVersion: string;
}

@doc("Solution Version Parameter")
model SolutionVersionParameter {
  @doc("Solution Name")
  solution: string;

  @doc("Solution Version Name")
  solutionVersion: string;

  @doc("Review ID")
  reviewId: string;
}

@doc("Target Properties")
model TargetProperties {
  @doc("Description of target")
  description: string;

  @doc("Display name of target")
  displayName: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("target spec")
  targetSpecification: Record<unknown>;

  @doc("List of capabilities")
  capabilities: string[];

  @doc("Hierarchy Level")
  hierarchyLevel: string;

  @doc("Scope of the target resource")
  solutionScope?: string;

  @doc("Is this resource deprecated")
  @visibility("read")
  isDeprecated?: boolean;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Param that indicates if the delete should be forced")
model ForceDeleteParameter {
  @doc("Force delete")
  @query
  forceDelete?: boolean = false;
}

@doc("Target Resource")
model Target is Azure.ResourceManager.TrackedResource<TargetProperties> {
  @doc("Name of the target")
  @maxLength(61)
  @minLength(3)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
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
  update is ArmResourcePatchAsync<Target, TargetProperties>;

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
  deploy is ArmResourceActionAsync<Target, SolutionVersion, Instance>;

  @doc("Post request to resolve configuration")
  resolve is ArmResourceActionAsync<
    Target,
    SolutionTemplateParameter,
    ResolvedConfiguration
  >;

  @doc("Post request to review configuration")
  review is ArmResourceActionAsync<
    Target,
    SolutionTemplateParameter,
    SolutionVersion
  >;

  @doc("Post request to publish")
  publish is ArmResourceActionAsync<
    Target,
    SolutionVersionParameter,
    SolutionVersion
  >;

  @doc("Deprecate resource")
  deprecate is ArmResourceActionNoResponseContentAsync<Target, void>;
}
