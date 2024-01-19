import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.LabServices;

interface SkusOperations {
  @summary("Gets the Azure Lab Services resource SKUs.")
  @doc("Returns a list of Azure Lab Services resource SKUs.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    },
    PagedLabServicesSkus
  >;
}

interface UsagesOperations {
  @summary("Gets the list of usages.")
  @doc("Returns list of usage per SKU family for the specified subscription in the specified region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/locations/{location}/usages")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The location name.")
      @maxLength(100)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      location: string;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    },
    ListUsagesResult
  >;
}
