import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ElasticSan;

interface SkusOperations {
  /**
   * List all the available Skus in the region and information related to them
   */
  @summary("List all the available Skus in the region and information related to them")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ElasticSan/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Specify $filter='location eq <location>' to filter on location.
       */
      @query("$filter")
      $filter?: string;
    },
    SkuInformationList
  >;
}
