import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.WorkspaceDataplane;

interface Workspaces {
  /** Create project workspace under workspaceHub's default resource group. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Existing API path structure."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API operation name"
  @route("/rp/workspaces/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/join/{projectWorkspaceName}")
  @put
  hubJoin is Azure.Core.Foundations.Operation<
    {
      /** The ID of the target subscription. */
      @path subscriptionId: string;

      /** The name of the resource group. */
      @path resourceGroupName: string;

      /** Azure Machine Learning Workspace Name. */
      @path workspaceName: string;

      /** Name of the project workspace. */
      @path projectWorkspaceName: string;

      /** The workspace to create. */
      @body body: Workspace;
    },
    Workspace | AcceptedResponse
  >;
}

/** Accepted response with location header for polling. */
model AcceptedResponse {
  /** HTTP status code. */
  @statusCode statusCode: 202;

  /** URI to poll for asynchronous operation result. */
  @header("Location") location?: string;

  /** Duration the client should wait between requests, in seconds. */
  @header("Retry-After") retryAfter?: int32;
}
