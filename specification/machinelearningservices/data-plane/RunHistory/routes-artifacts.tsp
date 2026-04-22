import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RunHistory;

/** Run artifact operations. */
interface RunArtifacts {
  // ============================================================
  // Artifacts by experiment ID
  // ============================================================

  /** List artifacts in container by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts")
  @list
  @get
  listInContainerByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedArtifactList
  >;

  /** Get artifact SAS URI by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts/artifacturi")
  @get
  getSasUriByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;
    },
    void
  >;

  /** Batch create empty artifacts by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts/batch/metadata")
  @post
  batchCreateEmptyArtifactsByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The list of artifact paths. */
      @body body: ArtifactPathList;
    },
    BatchArtifactContentInformationResult
  >;

  /** Get artifact content information by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts/contentinfo")
  @get
  getContentInformationByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;
    },
    ArtifactContentInformation
  >;

  /** Get artifact by ID by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts/metadata")
  @get
  getByIdByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;
    },
    Artifact
  >;

  /** List artifacts in path by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts/path")
  @list
  @get
  listInPathByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedArtifactList
  >;

  /** List SAS URIs by prefix by experiment ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experimentids/{experimentId}/runs/{runId}/artifacts/prefix/contentinfo")
  @list
  @get
  listSasByPrefixByExperimentId is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment ID. */
      @path experimentId: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path prefix. */
      @query path?: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedArtifactContentInformationList
  >;

  // ============================================================
  // Artifacts by experiment name
  // ============================================================

  /** List artifacts in container by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts")
  @list
  @get
  listInContainerByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedArtifactList
  >;

  /** Get artifact SAS URI by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts/artifacturi")
  @get
  getSasUriByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;
    },
    void
  >;

  /** Batch create empty artifacts by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts/batch/metadata")
  @post
  batchCreateEmptyArtifactsByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The list of artifact paths. */
      @body body: ArtifactPathList;
    },
    BatchArtifactContentInformationResult
  >;

  /** Get artifact content information by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts/contentinfo")
  @get
  getContentInformationByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;
    },
    ArtifactContentInformation
  >;

  /** Get artifact by ID by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts/metadata")
  @get
  getByIdByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;
    },
    Artifact
  >;

  /** List artifacts in path by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts/path")
  @list
  @get
  listInPathByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path. */
      @query path?: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedArtifactList
  >;

  /** List SAS URIs by prefix by experiment name. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/experiments/{experimentName}/runs/{runId}/artifacts/prefix/contentinfo")
  @list
  @get
  listSasByPrefixByExperimentName is Operation<
    {
      ...WorkspacePathParams;

      /** The experiment name. */
      @path experimentName: string;

      /** The run ID. */
      @path runId: string;

      /** The artifact path prefix. */
      @query path?: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedArtifactContentInformationList
  >;
}
