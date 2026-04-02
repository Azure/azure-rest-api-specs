import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RunHistory;

/** Common path prefix for history workspace operations. */
/** Run operations. */
interface Runs {
  /** Get a run by run ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}")
  @get
  get is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;
    },
    Run
  >;

  /** Create a run. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}")
  @post
  add is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The run to create. */
      @body body: CreateRun;
    },
    Run
  >;

  /** Add or modify a run. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}")
  @patch(#{ implicitOptionality: true })
  addOrModifyExperiment is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The run to add or modify. */
      @body body: CreateRun;
    },
    Run
  >;

  /** Get child runs. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/children")
  @list
  @get
  getChild is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** Allows for filtering the collection of resources. */
      @query("$filter") filter?: string;

      /** The continuation token to use for getting the next set of resources. */
      @query("$continuationtoken") continuationtoken?: string;

      /** The comma separated list of resource properties to use for sorting. */
      @query("$orderby") orderby?: string;

      /** The sort order of the list. */
      @query("$sortorder") sortorder?: string;

      /** The maximum number of items in the resource collection to be included in the result. */
      @query("$top") top?: int32;

      /** Whether to include count. */
      @query("$count") count?: boolean;
    },
    PaginatedRunList
  >;

  /** Get run details. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/details")
  @get
  getDetails is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;
    },
    RunDetails
  >;

  /** Delete run tags. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/tags")
  @delete
  deleteTags is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;
    },
    Run
  >;

  /** Delete run services. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/services")
  @delete
  deleteRunServices is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The services to delete. */
      @body body: DeleteRunServices;
    },
    Run
  >;

  /** Add or modify run service instances. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/serviceinstances/{nodeId}")
  @patch(#{ implicitOptionality: true })
  addOrModifyRunServiceInstances is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The node ID. */
      @path nodeId: string;

      /** The service instances to add or modify. */
      @body body: AddOrModifyRunServiceInstancesRequest;
    },
    RunServiceInstances
  >;

  /** Get run service instances. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/serviceinstances/{nodeId}")
  @get
  getRunServiceInstances is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The node ID. */
      @path nodeId: string;
    },
    RunServiceInstances
  >;

  /** Get run data. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/rundata")
  @post
  getRunData is Operation<
    {
      ...WorkspacePathParams;

      /** The run data request. */
      @body body: GetRunDataRequest;
    },
    GetRunDataResult
  >;

  /** Batch get run data. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/batchrundata")
  @post
  batchGetRunData is Operation<
    {
      ...WorkspacePathParams;

      /** The batch request. */
      @body body: BatchRunDataRequest;
    },
    BatchRunDataResult
  >;

  /** List runs by compute. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/runs")
  @list
  @get
  listByCompute is Operation<
    {
      ...WorkspacePathParams;

      /** The compute name. */
      @path computeName: string;

      /** Allows for filtering the collection of resources. */
      @query("$filter") filter?: string;

      /** The continuation token to use for getting the next set of resources. */
      @query("$continuationtoken") continuationtoken?: string;

      /** The comma separated list of resource properties to use for sorting. */
      @query("$orderby") orderby?: string;

      /** The sort order of the list. */
      @query("$sortorder") sortorder?: string;

      /** The maximum number of items in the resource collection to be included in the result. */
      @query("$top") top?: int32;

      /** Whether to include count. */
      @query("$count") count?: boolean;
    },
    PaginatedRunList
  >;

  // ============================================================
  // Runs by experiment ID
  // ============================================================

  /** Get a run by experiment ID and run ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}")
  @get
  getByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;
    },
    Run
  >;

  /** Add or modify a run by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}")
  @patch(#{ implicitOptionality: true })
  addOrModifyByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The run to add or modify. */
      @body body: CreateRun;
    },
    Run
  >;

  /** Get child runs by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/children")
  @list
  @get
  getChildByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** Allows for filtering the collection of resources. */
      @query("$filter") filter?: string;

      /** The continuation token to use for getting the next set of resources. */
      @query("$continuationtoken") continuationtoken?: string;

      /** The comma separated list of resource properties to use for sorting. */
      @query("$orderby") orderby?: string;

      /** The sort order of the list. */
      @query("$sortorder") sortorder?: string;

      /** The maximum number of items in the resource collection to be included in the result. */
      @query("$top") top?: int32;

      /** Whether to include count. */
      @query("$count") count?: boolean;
    },
    PaginatedRunList
  >;

  /** Get run details by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/details")
  @get
  getDetailsByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;
    },
    RunDetails
  >;

  /** Cancel a run by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/cancel")
  @post
  cancelRunWithUriByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The reason for cancellation. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
      @query CancelationReason?: string;
    },
    Run
  >;

  /** Delete run tags by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/tags")
  @delete
  deleteTagsByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;
    },
    Run
  >;

  /** Modify or delete run tags by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/tags")
  @patch(#{ implicitOptionality: true })
  modifyOrDeleteTagsByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The tags to modify or delete. */
      @body body: DeleteOrModifyTags;
    },
    Run
  >;

  /** Delete run services by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/services")
  @delete
  deleteRunServicesByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The services to delete. */
      @body body: DeleteRunServices;
    },
    Run
  >;

  /** Get runs by IDs by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/runIds")
  @post
  getByIdsByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run IDs. */
      @body body: GetRunsByIds;
    },
    BatchRunResult
  >;

  /** Get runs by query by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs:query")
  @post
  getByQueryByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The query parameters. */
      @body body: QueryParams;
    },
    PaginatedRunList
  >;

  /** Batch add or modify runs by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/batch/runs")
  @patch(#{ implicitOptionality: true })
  batchAddOrModifyByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The batch add or modify request. */
      @body body: BatchAddOrModifyRunRequest;
    },
    BatchRunResult
  >;

  // ============================================================
  // Runs by experiment name
  // ============================================================

  /** Get a run by experiment name and run ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}")
  @get
  getByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;
    },
    Run
  >;

  /** Add or modify a run by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}")
  @patch(#{ implicitOptionality: true })
  addOrModifyByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The run to add or modify. */
      @body body: CreateRun;
    },
    Run
  >;

  /** Get child runs by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/children")
  @list
  @get
  getChildByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** Allows for filtering the collection of resources. */
      @query("$filter") filter?: string;

      /** The continuation token to use for getting the next set of resources. */
      @query("$continuationtoken") continuationtoken?: string;

      /** The comma separated list of resource properties to use for sorting. */
      @query("$orderby") orderby?: string;

      /** The sort order of the list. */
      @query("$sortorder") sortorder?: string;

      /** The maximum number of items in the resource collection to be included in the result. */
      @query("$top") top?: int32;

      /** Whether to include count. */
      @query("$count") count?: boolean;
    },
    PaginatedRunList
  >;

  /** Get run details by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/details")
  @get
  getDetailsByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;
    },
    RunDetails
  >;

  /** Cancel a run by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/cancel")
  @post
  cancelRunWithUriByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The reason for cancellation. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
      @query CancelationReason?: string;
    },
    Run
  >;

  /** Delete run tags by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/tags")
  @delete
  deleteTagsByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;
    },
    Run
  >;

  /** Modify or delete run tags by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/tags")
  @patch(#{ implicitOptionality: true })
  modifyOrDeleteTagsByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The tags to modify or delete. */
      @body body: DeleteOrModifyTags;
    },
    Run
  >;

  /** Delete run services by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/services")
  @delete
  deleteRunServicesByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The services to delete. */
      @body body: DeleteRunServices;
    },
    Run
  >;

  /** Get runs by IDs by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/runIds")
  @post
  getByIdsByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run IDs. */
      @body body: GetRunsByIds;
    },
    BatchRunResult
  >;

  /** Get runs by query by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs:query")
  @post
  getByQueryByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The query parameters. */
      @body body: QueryParams;
    },
    PaginatedRunList
  >;

  /** Batch add or modify runs by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/batch/runs")
  @patch(#{ implicitOptionality: true })
  batchAddOrModifyByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The batch add or modify request. */
      @body body: BatchAddOrModifyRunRequest;
    },
    BatchRunResult
  >;
}
