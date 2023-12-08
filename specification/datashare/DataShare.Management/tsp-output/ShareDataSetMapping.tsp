import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
// FIXME: ShareDataSetMapping has no properties property
@doc("A data set mapping data transfer object.")
@parentResource(ShareSubscription)
model ShareDataSetMapping is ProxyResource<{}> {
  @doc("The name of the dataSetMapping.")
  @path
  @key("dataSetMappingName")
  @segment("dataSetMappings")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ShareDataSetMappings {
  @doc("Get a DataSetMapping in a shareSubscription")
  get is ArmResourceRead<ShareDataSetMapping>;
  @doc("Create a DataSetMapping ")
  create is ArmResourceCreateOrReplaceSync<ShareDataSetMapping>;
  @doc("Delete a DataSetMapping in a shareSubscription")
  delete is ArmResourceDeleteSync<ShareDataSetMapping>;
  @doc("List DataSetMappings in a share subscription")
  listByShareSubscription is ArmResourceListByParent<
    ShareDataSetMapping,
    {
      ...BaseParameters<ShareDataSetMapping>;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Filters the results using OData syntax.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results using OData syntax.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
