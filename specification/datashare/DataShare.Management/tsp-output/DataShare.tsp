import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataShareAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
@doc("A share data transfer object.")
@parentResource(DataShareAccount)
model DataShare is ProxyResource<ShareProperties> {
  @doc("The name of the share to retrieve.")
  @path
  @key("shareName")
  @segment("shares")
  name: string;
}

@armResourceOperations
interface DataShares {
  @doc("Get a share ")
  get is ArmResourceRead<DataShare>;
  @doc("Create a share ")
  create is ArmResourceCreateOrReplaceSync<DataShare>;
  @doc("Delete a share ")
  delete is ArmResourceDeleteAsync<DataShare>;
  @doc("List shares in an account")
  listByAccount is ArmResourceListByParent<
    DataShare,
    {
      ...BaseParameters<DataShare>;

      @doc("Continuation Token")
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
  @doc("List synchronization details")
  listSynchronizationDetails is ArmResourceActionSync<
    DataShare,
    ShareSynchronization,
    SynchronizationDetailsList,
    {
      ...BaseParameters<DataShare>;

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
  @doc("List synchronizations of a share")
  listSynchronizations is ArmResourceActionSync<
    DataShare,
    void,
    ShareSynchronizationList,
    {
      ...BaseParameters<DataShare>;

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
