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
@doc("A share subscription data transfer object.")
@parentResource(DataShareAccount)
model ShareSubscription is ProxyResource<ShareSubscriptionProperties> {
  @doc("The name of the shareSubscription.")
  @path
  @key("shareSubscriptionName")
  @segment("shareSubscriptions")
  name: string;
}

@armResourceOperations
interface ShareSubscriptions {
  @doc("Get a shareSubscription in an account")
  get is ArmResourceRead<ShareSubscription>;
  @doc("Create a shareSubscription in an account")
  create is ArmResourceCreateOrReplaceSync<ShareSubscription>;
  @doc("Delete a shareSubscription in an account")
  delete is ArmResourceDeleteAsync<ShareSubscription>;
  @doc("List share subscriptions in an account")
  listByAccount is ArmResourceListByParent<
    ShareSubscription,
    {
      ...BaseParameters<ShareSubscription>;

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
  @doc("Request to cancel a synchronization.")
  cancelSynchronization is ArmResourceActionAsync<
    ShareSubscription,
    ShareSubscriptionSynchronization,
    ShareSubscriptionSynchronization
  >;
  @doc("Get synchronization settings set on a share")
  listSourceShareSynchronizationSettings is ArmResourceActionSync<
    ShareSubscription,
    void,
    SourceShareSynchronizationSettingList,
    {
      ...BaseParameters<ShareSubscription>;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("List synchronization details")
  listSynchronizationDetails is ArmResourceActionSync<
    ShareSubscription,
    ShareSubscriptionSynchronization,
    SynchronizationDetailsList,
    {
      ...BaseParameters<ShareSubscription>;

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
  @doc("List synchronizations of a share subscription")
  listSynchronizations is ArmResourceActionSync<
    ShareSubscription,
    void,
    ShareSubscriptionSynchronizationList,
    {
      ...BaseParameters<ShareSubscription>;

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
  @doc("Initiate a copy")
  synchronize is ArmResourceActionAsync<
    ShareSubscription,
    Synchronize,
    ShareSubscriptionSynchronization
  >;
  @summary("Get source dataSets of a shareSubscription.")
  @doc("Get source dataSets of a shareSubscription")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataShare/accounts/{accountName}/shareSubscriptions/{shareSubscriptionName}/consumerSourceDataSets")
  @get
  ListByShareSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @path
      resourceGroupName: string;

      @doc("The name of the share account.")
      @path
      accountName: string;

      @doc("The name of the shareSubscription.")
      @path
      shareSubscriptionName: string;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;
    },
    ConsumerSourceDataSetList
  >;
}
