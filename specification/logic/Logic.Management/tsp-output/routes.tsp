import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Logic;

interface WorkflowRunActionRequestHistoriesOperations {
  /**
   * List a workflow run request history.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/requestHistories")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The workflow name.
       */
      @path
      workflowName: string;

      /**
       * The workflow run name.
       */
      @path
      runName: string;

      /**
       * The workflow action name.
       */
      @path
      actionName: string;
    },
    ResourceListResult<RequestHistory>
  >;

  /**
   * Gets a workflow run request history.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/requestHistories/{requestHistoryName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The workflow name.
       */
      @path
      workflowName: string;

      /**
       * The workflow run name.
       */
      @path
      runName: string;

      /**
       * The workflow action name.
       */
      @path
      actionName: string;

      /**
       * The request history name.
       */
      @path
      requestHistoryName: string;
    },
    RequestHistory
  >;
}

interface WorkflowRunActionScopeRepetitionsOperations {
  /**
   * List the workflow run action scoped repetitions.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/scopeRepetitions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The workflow name.
       */
      @path
      workflowName: string;

      /**
       * The workflow run name.
       */
      @path
      runName: string;

      /**
       * The workflow action name.
       */
      @path
      actionName: string;
    },
    ResourceListResult<WorkflowRunActionRepetitionDefinition>
  >;

  /**
   * Get a workflow run action scoped repetition.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/actions/{actionName}/scopeRepetitions/{repetitionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The workflow name.
       */
      @path
      workflowName: string;

      /**
       * The workflow run name.
       */
      @path
      runName: string;

      /**
       * The workflow action name.
       */
      @path
      actionName: string;

      /**
       * The workflow repetition.
       */
      @path
      repetitionName: string;
    },
    WorkflowRunActionRepetitionDefinition
  >;
}

interface WorkflowRunOperationsOperations {
  /**
   * Gets an operation for a run.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/workflows/{workflowName}/runs/{runName}/operations/{operationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription id.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The workflow name.
       */
      @path
      workflowName: string;

      /**
       * The workflow run name.
       */
      @path
      runName: string;

      /**
       * The workflow operation id.
       */
      @path
      operationId: string;
    },
    WorkflowRun
  >;
}
