import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Insights;

interface WorkbooksOperations {
  /**
   * Get the revisions for the workbook defined by its resourceName.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/workbooks/{resourceName}/revisions")
  @get
  revisionsList is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the resource.
       */
      @path
      resourceName: string;
    },
    ResourceListResult<Workbook>
  >;

  /**
   * Get a single workbook revision defined by its revisionId.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/workbooks/{resourceName}/revisions/{revisionId}")
  @get
  revisionGet is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the resource.
       */
      @path
      resourceName: string;

      /**
       * The id of the workbook's revision.
       */
      @path
      revisionId: string;
    },
    Workbook
  >;
}

interface LiveTokenOperations {
  /**
   * **Gets an access token for live metrics stream data.**
   */
  @route("/{resourceUri}/providers/Microsoft.Insights/generatelivetoken")
  @post
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The identifier of the resource.
       */
      @path
      resourceUri: string;
    },
    LiveTokenResponse
  >;
}
