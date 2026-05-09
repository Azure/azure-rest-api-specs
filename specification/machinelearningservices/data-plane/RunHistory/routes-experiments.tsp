import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RunHistory;

/** Experiment operations. */
interface Experiments {
  /** Get an experiment by name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}")
  @get
  get is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;
    },
    Experiment
  >;

  /** Create an experiment. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}")
  @post
  create is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;
    },
    Experiment
  >;

  /** Get an experiment by ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}")
  @get
  getById is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;
    },
    Experiment
  >;

  /** Update an experiment. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}")
  @patch(#{ implicitOptionality: true })
  update is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The experiment modifications. */
      @body body: ModifyExperiment;
    },
    Experiment
  >;

  /** Delete an experiment. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}")
  @delete
  delete is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;
    },
    LongRunningNullResponse | void
  >;

  /** Get experiments by query. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments:query")
  @post
  getByQuery is Operation<
    {
      ...WorkspacePathParams;

      /** Whether to return only URL-safe experiment names. */
      @query urlSafeExperimentNamesOnly?: boolean;

      /** The query parameters. */
      @body body: ExperimentQueryParams;
    },
    PaginatedExperimentList
  >;

  /** Delete experiment tags. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/tags:delete")
  @post
  deleteTags is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The tags to delete. */
      @body body: DeleteTagsCommand;
    },
    DeleteExperimentTagsResult
  >;

  /** Get metric details by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/metrics/{metricId}")
  @get
  getMetricDetailsByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The metric ID. */
      @path metricId: string;
    },
    RunMetric
  >;

  /** Get metric details by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/metrics/{metricId}")
  @get
  getMetricDetailsByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The metric ID. */
      @path metricId: string;
    },
    RunMetric
  >;
}
