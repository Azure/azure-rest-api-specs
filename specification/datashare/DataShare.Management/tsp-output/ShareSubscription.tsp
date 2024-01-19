import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
@doc("A share subscription data transfer object.")
@parentResource(Account)
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
    ShareSubscriptionSynchronization,
    BaseParameters<ShareSubscription>,
    ArmAsyncOperationHeader
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
    ShareSubscriptionSynchronization,
    BaseParameters<ShareSubscription>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerSourceDataSets_ListByShareSubscription")
  @summary("Get source dataSets of a shareSubscription.")
  @doc("Get source dataSets of a shareSubscription")
  // FIXME: ConsumerSourceDataSets_ListByShareSubscription could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataShare/accounts/{accountName}/shareSubscriptions/{shareSubscriptionName}/consumerSourceDataSets")
  @get
  listByShareSubscription is Azure.Core.Foundations.Operation<
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

@@projectedName(ShareSubscriptions.create::parameters.resource,
  "json",
  "shareSubscription"
);
@@extension(ShareSubscriptions.create::parameters.resource,
  "x-ms-client-name",
  "shareSubscription"
);
@@doc(ShareSubscriptions.create::parameters.resource,
  "create parameters for shareSubscription"
);
@@projectedName(ShareSubscriptions.cancelSynchronization::parameters.body,
  "json",
  "shareSubscriptionSynchronization"
);
@@extension(ShareSubscriptions.cancelSynchronization::parameters.body,
  "x-ms-client-name",
  "shareSubscriptionSynchronization"
);
@@doc(ShareSubscriptions.cancelSynchronization::parameters.body,
  "Share Subscription Synchronization payload."
);
@@projectedName(ShareSubscriptions.listSynchronizationDetails::parameters.body,
  "json",
  "shareSubscriptionSynchronization"
);
@@extension(ShareSubscriptions.listSynchronizationDetails::parameters.body,
  "x-ms-client-name",
  "shareSubscriptionSynchronization"
);
@@doc(ShareSubscriptions.listSynchronizationDetails::parameters.body,
  "Share Subscription Synchronization payload."
);
@@projectedName(ShareSubscriptions.synchronize::parameters.body,
  "json",
  "synchronize"
);
@@extension(ShareSubscriptions.synchronize::parameters.body,
  "x-ms-client-name",
  "synchronize"
);
@@doc(ShareSubscriptions.synchronize::parameters.body, "Synchronize payload");
