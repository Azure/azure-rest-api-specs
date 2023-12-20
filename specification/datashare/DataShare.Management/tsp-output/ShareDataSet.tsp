import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataShare.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
// FIXME: ShareDataSet has no properties property
@doc("A DataSet data transfer object.")
@parentResource(DataShare)
model ShareDataSet is ProxyResource<{}> {
  @doc("The name of the dataSet.")
  @path
  @key("dataSetName")
  @segment("dataSets")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ShareDataSets {
  @doc("Get a DataSet in a share")
  get is ArmResourceRead<ShareDataSet>;
  @doc("Create a DataSet ")
  create is ArmResourceCreateOrReplaceSync<ShareDataSet>;
  @doc("Delete a DataSet in a share")
  delete is ArmResourceDeleteAsync<ShareDataSet>;
  @doc("List DataSets in a share")
  listByShare is ArmResourceListByParent<
    ShareDataSet,
    {
      ...BaseParameters<ShareDataSet>;

      @doc("continuation token")
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
