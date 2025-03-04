import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./State.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Capability, to match in Solution Templates & Targets")
model Capability {
  @doc("Name of Capability")
  name: string;

  @doc("Description of Capability")
  description: string;

  @doc("State of resource")
  state?: ResourceState;
}

@doc("Hierarchy, to tag Sites / Hierarchy Provider nodes with what they represent")
model Hierarchy {
  @doc("Name of Hierarchy")
  name: string;

  @doc("Description of Hierarchy")
  description: string;
}

@doc("Context Properties")
model ContextProperties {
  @doc("List of Capabilities")
  @Azure.ResourceManager.identifiers(#[])
  capabilities: Capability[];

  @doc("List of Hierarchies")
  @Azure.ResourceManager.identifiers(#[])
  hierarchies: Hierarchy[];

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Context Resource")
model Context is Azure.ResourceManager.TrackedResource<ContextProperties> {
  @doc("The name of the Context.")
  @maxLength(61)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("contextName")
  @segment("contexts")
  name: string;
}

@armResourceOperations
interface Contexts {
  @doc("Get Context Resource")
  get is ArmResourceRead<Context>;

  @doc("Create or update Context Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Context>;

  @doc("update an Context Resource")
  update is ArmResourcePatchAsync<Context, ContextProperties>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Context>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Context>;

  @doc("Delete Context Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Context>;

  @doc("Post request to resolve configuration")
  resolve is ArmResourceActionAsync<
    Context,
    WorkflowTemplateReviewParameter,
    WorkflowVersion
  >;

  @doc("Post request to review configuration")
  review is ArmResourceActionAsync<
    Context,
    WorkflowTemplateReviewParameter,
    WorkflowVersion
  >;

  @doc("Post request to publish")
  publish is ArmResourceActionAsync<
    Context,
    WorkflowVersionParameter,
    WorkflowVersion
  >;

  @doc("Post request to execute")
  execute is ArmResourceActionAsync<
    Context,
    WorkflowExecuteParameter,
    Execution
  >;
}

@doc("Workflow Version Parameter")
model WorkflowVersionParameter {
  @doc("Workflow Name")
  workflowName?: string;

  @doc("Workflow Version Name")
  workflowVersion: string;

  @doc("Review ID")
  reviewId: string;
}

@doc("Workflow Template Review Parameter")
model WorkflowTemplateReviewParameter {
  @doc("Workflow Template Name")
  workflowTemplateName?: string;

  @doc("Workflow Template Version Name")
  workflowTemplateVersion: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("Stage to Target Map")
  stageTargetMap: Record<unknown>;
}

@doc("Workflow Template Execute Parameter")
model WorkflowExecuteParameter {
  @doc("Workflow Name")
  workflow?: string;

  @doc("Workflow Version Name")
  workflowVersion: string;

  @doc("Workflow first stage")
  stage?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("Inputs from execution")
  inputs?: Record<unknown>;
}
