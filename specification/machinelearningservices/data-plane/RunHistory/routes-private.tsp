import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RunHistory;

/** Common path prefix for private history workspace operations. */
/** Private delete configuration operations. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
interface DeleteConfiguration_Operations {
  /** Patch delete configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/private/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/deleteConfiguration")
  @patch(#{ implicitOptionality: true })
  patchConfiguration is Operation<
    {
      ...WorkspacePathParams;

      /** The delete configuration. */
      @body body: DeleteConfiguration;
    },
    DeleteConfiguration
  >;

  /** Get delete configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/private/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/deleteConfiguration")
  @get
  getConfiguration is Operation<
    {
      ...WorkspacePathParams;
    },
    DeleteConfiguration
  >;
}

/** Span operations. */
interface Spans {
  /** Post run status spans. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/history/v1.0/private/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/spans")
  @post
  post is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The run status spans. */
      @body body: RunStatusSpans;
    },
    void
  >;

  /** List run status spans. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/history/v1.0/private/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/spans")
  @list
  @get
  list is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedSpanDefinitionList
  >;

  /** Get active run status spans. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API name from swagger."
  @route("/history/v1.0/private/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/runs/{runId}/spans/active")
  @list
  @get
  getActive is Operation<
    {
      ...WorkspacePathParams;

      /** The run ID. */
      @path runId: string;

      /** The continuation token. */
      @continuationToken @query continuationToken?: string;
    },
    PaginatedSpanDefinitionList
  >;
}
