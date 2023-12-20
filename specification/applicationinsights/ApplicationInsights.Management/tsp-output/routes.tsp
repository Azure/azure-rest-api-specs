import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.ApplicationInsights;

interface WorkbooksOperations {
  @doc("Get the revisions for the workbook defined by its resourceName.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/workbooks/{resourceName}/revisions")
  @get
  RevisionsList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    WorkbooksListResult
  >;

  @doc("Get a single workbook revision defined by its revisionId.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/workbooks/{resourceName}/revisions/{revisionId}")
  @get
  RevisionGet is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("The id of the workbook's revision.")
      @path
      revisionId: string;
    },
    Workbook
  >;
}

interface LiveTokenOperations {
  @doc("**Gets an access token for live metrics stream data.**")
  @route("/{resourceUri}/providers/Microsoft.Insights/generatelivetoken")
  @post
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The identifier of the resource.")
      @path
      resourceUri: string;
    },
    LiveTokenResponse
  >;
}
