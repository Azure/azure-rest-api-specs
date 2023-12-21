import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
// FIXME: DataSet has no properties property
@doc("A DataSet data transfer object.")
@parentResource(Share)
model DataSet is ProxyResource<{}> {
  @doc("The name of the dataSet.")
  @path
  @key("dataSetName")
  @segment("dataSets")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataSets {
  @doc("Get a DataSet in a share")
  get is ArmResourceRead<DataSet>;
  @doc("Create a DataSet ")
  create is ArmResourceCreateOrReplaceSync<DataSet>;
  @doc("Delete a DataSet in a share")
  delete is ArmResourceDeleteAsync<DataSet>;
  @doc("List DataSets in a share")
  listByShare is ArmResourceListByParent<
    DataSet,
    {
      ...BaseParameters<DataSet>;

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
