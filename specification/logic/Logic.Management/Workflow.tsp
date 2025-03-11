import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The workflow type.")
model Workflow is Azure.ResourceManager.TrackedResource<WorkflowProperties> {
  ...ResourceNameParameter<
    Resource = Workflow,
    KeyName = "workflowName",
    SegmentName = "workflows",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Workflows {
  @doc("Gets a workflow.")
  get is ArmResourceRead<Workflow>;

  @doc("Creates or updates a workflow.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workflow>;

  @doc("Updates a workflow.")
  update is ArmCustomPatchSync<Workflow, PatchModel = { ...ArmTagsProperty }>;

  @doc("Deletes a workflow.")
  delete is ArmResourceDeleteSync<Workflow>;

  @doc("Gets a list of workflows by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Workflow,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: State, Trigger, and ReferencedResourceId.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Gets a list of workflows by subscription.")
  listBySubscription is ArmListBySubscription<
    Workflow,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: State, Trigger, and ReferencedResourceId.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Disables a workflow.")
  disable is ArmResourceActionSync<Workflow, void, OkResponse>;

  @doc("Enables a workflow.")
  enable is ArmResourceActionSync<Workflow, void, OkResponse>;

  @doc("Generates the upgraded definition for a workflow.")
  generateUpgradedDefinition is ArmResourceActionSync<
    Workflow,
    GenerateUpgradedDefinitionParameters,
    ArmResponse<Record<unknown>>
  >;

  @doc("Get the workflow callback Url.")
  listCallbackUrl is ArmResourceActionSync<
    Workflow,
    GetCallbackUrlParameters,
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;

  @doc("Gets an OpenAPI definition for the workflow.")
  listSwagger is ArmResourceActionSync<Workflow, void, ArmResponse<Record<unknown>>>;

  @doc("Moves an existing workflow.")
  move is ArmResourceActionAsync<Workflow, WorkflowReference, OkResponse>;

  @doc("Regenerates the callback URL access key for request triggers.")
  regenerateAccessKey is ArmResourceActionSync<
    Workflow,
    RegenerateActionParameter,
    OkResponse
  >;

  @doc("Validates the workflow.")
  @action("validate")
  validateByResourceGroup is ArmResourceActionSync<
    Workflow,
    Workflow,
    OkResponse
  >;
}

@@doc(Workflow.name, "The workflow name.");
@@doc(Workflow.properties, "The workflow properties.");
@@doc(Workflows.createOrUpdate::parameters.resource, "The workflow.");
@@doc(Workflows.generateUpgradedDefinition::parameters.body,
  "Parameters for generating an upgraded definition."
);
@@doc(Workflows.listCallbackUrl::parameters.body,
  "Which callback url to list."
);
@@doc(Workflows.move::parameters.body, "The workflow to move.");
@@doc(Workflows.regenerateAccessKey::parameters.body, "The access key type.");
@@doc(Workflows.validateByResourceGroup::parameters.body, "The workflow.");
