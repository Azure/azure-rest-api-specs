import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Logic;

interface WorkflowRunActionRequestHistoriesOperations {
  @doc("List a workflow run request history.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/requestHistories")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The workflow name.")
      @path
      workflowName: string;

      @doc("The workflow run name.")
      @path
      runName: string;

      @doc("The workflow action name.")
      @path
      actionName: string;
    },
    ResourceListResult<RequestHistory>
  >;

  @doc("Gets a workflow run request history.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/requestHistories/{requestHistoryName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The workflow name.")
      @path
      workflowName: string;

      @doc("The workflow run name.")
      @path
      runName: string;

      @doc("The workflow action name.")
      @path
      actionName: string;

      @doc("The request history name.")
      @path
      requestHistoryName: string;
    },
    RequestHistory
  >;
}

interface WorkflowRunActionScopeRepetitionsOperations {
  @doc("List the workflow run action scoped repetitions.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/scopeRepetitions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The workflow name.")
      @path
      workflowName: string;

      @doc("The workflow run name.")
      @path
      runName: string;

      @doc("The workflow action name.")
      @path
      actionName: string;
    },
    ResourceListResult<WorkflowRunActionRepetitionDefinition>
  >;

  @doc("Get a workflow run action scoped repetition.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/scopeRepetitions/{repetitionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The workflow name.")
      @path
      workflowName: string;

      @doc("The workflow run name.")
      @path
      runName: string;

      @doc("The workflow action name.")
      @path
      actionName: string;

      @doc("The workflow repetition.")
      @path
      repetitionName: string;
    },
    WorkflowRunActionRepetitionDefinition
  >;
}

interface WorkflowRunOperationsOperations {
  @doc("Gets an operation for a run.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/operations/{operationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription id.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The workflow name.")
      @path
      workflowName: string;

      @doc("The workflow run name.")
      @path
      runName: string;

      @doc("The workflow operation id.")
      @path
      operationId: string;
    },
    WorkflowRun
  >;
}
