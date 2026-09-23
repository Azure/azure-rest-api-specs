import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RunHistory;

/** Event operations. */
interface Events {
  /** Post an event for a run. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/events")
  @post
  post is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The event to post. */
      @body body: BaseEvent;
    },
    void
  >;

  /** Batch post events. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/batch/events")
  @post
  batchPost is Operation<
    {
      ...WorkspacePathParams;

      /** The batch event command. */
      @body body: BatchEventCommand;
    },
    BatchEventCommandResult
  >;

  /** Post an event for a run by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/events")
  @post
  postByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The event to post. */
      @body body: BaseEvent;
    },
    void
  >;

  /** Batch post events by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/batch/events")
  @post
  batchPostByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The batch event command. */
      @body body: BatchEventCommand;
    },
    BatchEventCommandResult
  >;

  /** Post an event for a run by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/events")
  @post
  postByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The event to post. */
      @body body: BaseEvent;
    },
    void
  >;

  /** Batch post events by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/batch/events")
  @post
  batchPostByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The batch event command. */
      @body body: BatchEventCommand;
    },
    BatchEventCommandResult
  >;
}
