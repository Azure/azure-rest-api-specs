// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Logic;

@armResourceOperations
interface WorkflowsOperations {
  @doc("Validates the workflow definition.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/locations/{location}/workflows/{workflowName}/validate")
  @post
  @armResourceAction(Workflow)
  validateByLocation(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The workflow.")
    @bodyRoot
    validate: Workflow,
  ): OkResponse | ErrorResponse;
}

@armResourceOperations
interface WorkflowRunsOperations {
  @doc("Gets a list of workflow runs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs")
  @get
  @armResourceRead(WorkflowRun)
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The number of items to be included in the result.")
    @query("$top")
    $top?: int32,

    @doc("The filter to apply on the operation. Options for filters include: Status, StartTime, and ClientTrackingId.")
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ResourceListResult<WorkflowRun>> | ErrorResponse;
}

@armResourceOperations
interface WorkflowRunActionRequestHistoriesOperations {
  @doc("List a workflow run request history.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/requestHistories")
  @get
  @armResourceList(RequestHistory)
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The workflow run name.")
    @path
    runName: string,

    @doc("The workflow action name.")
    @path
    actionName: string,
  ): ArmResponse<ResourceListResult<RequestHistory>> | ErrorResponse;

  @doc("Gets a workflow run request history.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/requestHistories/{requestHistoryName}")
  @get
  @armResourceRead(RequestHistory)
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The workflow run name.")
    @path
    runName: string,

    @doc("The workflow action name.")
    @path
    actionName: string,

    @doc("The request history name.")
    @path
    requestHistoryName: string,
  ): ArmResponse<RequestHistory> | ErrorResponse;
}

@armResourceOperations
interface WorkflowRunActionScopeRepetitionsOperations {
  @doc("List the workflow run action scoped repetitions.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/scopeRepetitions")
  @get
  @armResourceList(WorkflowRunActionRepetitionDefinition)
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The workflow run name.")
    @path
    runName: string,

    @doc("The workflow action name.")
    @path
    actionName: string,
  ): ArmResponse<WorkflowRunActionRepetitionDefinitionCollection> | ErrorResponse;

  @doc("Get a workflow run action scoped repetition.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/scopeRepetitions/{repetitionName}")
  @get
  @armResourceRead(WorkflowRunActionRepetitionDefinition)
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The workflow run name.")
    @path
    runName: string,

    @doc("The workflow action name.")
    @path
    actionName: string,

    @doc("The workflow repetition.")
    @path
    repetitionName: string,
  ): ArmResponse<WorkflowRunActionRepetitionDefinition> | ErrorResponse;
}

@armResourceOperations
interface WorkflowRunOperationsOperations {
  @doc("Gets an operation for a run.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/operations/{operationId}")
  @get
  @armResourceRead(WorkflowRun)
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The workflow name.")
    @path
    workflowName: string,

    @doc("The workflow run name.")
    @path
    runName: string,

    @doc("The workflow operation id.")
    @path
    operationId: string,
  ): ArmResponse<WorkflowRun> | ErrorResponse;
}
