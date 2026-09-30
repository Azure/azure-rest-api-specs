import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RunHistory;

/** Common path prefix for metric workspace operations. */
/** Metric operations. */
interface Metrics {
  /** Get full fidelity metric. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/full")
  @post
  getFullFidelityMetric is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The full fidelity metric request. */
      @body body: RetrieveFullFidelityMetricRequest;
    },
    MetricV2
  >;

  /** List metrics. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/list")
  @post
  listMetric is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The list metrics request. */
      @body body: ListMetrics;
    },
    PaginatedMetricDefinitionList
  >;

  /** Get sampled metric. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/sample")
  @post
  getSampledMetric is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The sampled metric request. */
      @body body: GetSampledMetricRequest;
    },
    MetricSample
  >;

  /** Post run metrics in batch. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/batch")
  @post
  postRunMetrics is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The batch of metrics to post. */
      @body body: BatchIMetricV2;
    },
    PostRunMetricsResult
  >;

  /** Delete metrics by run ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/deleteMetrics")
  @delete
  deleteMetricsByRunId is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;
    },
    LongRunningNullResponse | void
  >;

  /** Delete metrics by data container ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentId}/containers/{dataContainerId}/deleteMetrics")
  @delete
  deleteMetricsByDataContainerId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The data container ID. */
      @path dataContainerId: string;
    },
    LongRunningNullResponse | void
  >;

  /** List generic resource metrics (Azure Monitor). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/metric/v2.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/azuremonitor/list")
  @post
  listGenericResourceMetrics is Operation<
    {
      ...WorkspacePathParams;

      /** The list generic resource metrics request. */
      @body body: ListGenericResourceMetrics;
    },
    PaginatedMetricDefinitionList
  >;
}
