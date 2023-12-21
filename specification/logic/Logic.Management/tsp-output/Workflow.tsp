import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The workflow type.")
model Workflow is TrackedResource<WorkflowProperties> {
  @doc("The workflow name.")
  @path
  @key("workflowName")
  @segment("workflows")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Workflows {
  @doc("Gets a workflow.")
  get is ArmResourceRead<Workflow>;
  @doc("Creates or updates a workflow.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workflow>;
  @doc("Deletes a workflow.")
  delete is ArmResourceDeleteSync<Workflow>;
  @doc("Gets a list of workflows by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Workflow,
    {
      ...BaseParameters<Workflow>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: State, Trigger, and ReferencedResourceId.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Gets a list of workflows by subscription.")
  listBySubscription is ArmListBySubscription<Workflow>;
  @doc("Disables a workflow.")
  disable is ArmResourceActionSync<Workflow, void, void>;
  @doc("Enables a workflow.")
  enable is ArmResourceActionSync<Workflow, void, void>;
  @doc("Generates the upgraded definition for a workflow.")
  generateUpgradedDefinition is ArmResourceActionSync<
    Workflow,
    GenerateUpgradedDefinitionParameters,
    AnyObject
  >;
  @doc("Get the workflow callback Url.")
  listCallbackUrl is ArmResourceActionSync<
    Workflow,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
  @doc("Gets an OpenAPI definition for the workflow.")
  listSwagger is ArmResourceActionSync<Workflow, void, AnyObject>;
  @doc("Moves an existing workflow.")
  move is ArmResourceActionAsync<Workflow, WorkflowReference, void>;
  @doc("Regenerates the callback URL access key for request triggers.")
  regenerateAccessKey is ArmResourceActionSync<
    Workflow,
    RegenerateActionParameter,
    void
  >;
  @doc("Validates the workflow.")
  validateByResourceGroup is ArmResourceActionSync<Workflow, Workflow, void>;
}
