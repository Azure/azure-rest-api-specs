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
/**
 * A share subscription data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Account)
@Azure.ResourceManager.Private.armResourceInternal(ShareSubscriptionProperties)
@includeInapplicableMetadataInPayload(false)
model ShareSubscription extends ProxyDto {
  /**
   * The name of the shareSubscription.
   */
  @path
  @key("shareSubscriptionName")
  @segment("shareSubscriptions")
  name: string;

  /**
   * Properties on the share subscription
   */
  @extension("x-ms-client-flatten", true)
  properties: ShareSubscriptionProperties;
}

@armResourceOperations
interface ShareSubscriptions {
  /**
   * Get a shareSubscription in an account
   */
  get is ArmResourceRead<ShareSubscription>;

  /**
   * Create a shareSubscription in an account
   */
  create is ArmResourceCreateOrReplaceSync<ShareSubscription>;

  /**
   * Delete a shareSubscription in an account
   */
  delete is ArmResourceDeleteAsync<ShareSubscription>;

  /**
   * List share subscriptions in an account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ShareSubscriptions_ListByAccount")
  listByAccount is ArmResourceListByParent<
    ShareSubscription,
    {
      ...BaseParameters<ShareSubscription>;

      /**
       * Continuation Token
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Filters the results using OData syntax.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results using OData syntax.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Request to cancel a synchronization.
   */
  cancelSynchronization is ArmResourceActionAsync<
    ShareSubscription,
    ShareSubscriptionSynchronization,
    ShareSubscriptionSynchronization,
    BaseParameters<ShareSubscription>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get synchronization settings set on a share
   */
  listSourceShareSynchronizationSettings is ArmResourceActionSync<
    ShareSubscription,
    void,
    SourceShareSynchronizationSettingList,
    {
      ...BaseParameters<ShareSubscription>;

      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * List synchronization details
   */
  listSynchronizationDetails is ArmResourceActionSync<
    ShareSubscription,
    ShareSubscriptionSynchronization,
    SynchronizationDetailsList,
    {
      ...BaseParameters<ShareSubscription>;

      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Filters the results using OData syntax.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results using OData syntax.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * List synchronizations of a share subscription
   */
  listSynchronizations is ArmResourceActionSync<
    ShareSubscription,
    void,
    ShareSubscriptionSynchronizationList,
    {
      ...BaseParameters<ShareSubscription>;

      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Filters the results using OData syntax.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results using OData syntax.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * Initiate a copy
   */
  synchronize is ArmResourceActionAsync<
    ShareSubscription,
    Synchronize,
    ShareSubscriptionSynchronization,
    BaseParameters<ShareSubscription>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get source dataSets of a shareSubscription
   */
  // FIXME: ConsumerSourceDataSets_ListByShareSubscription could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerSourceDataSets_ListByShareSubscription")
  @summary("Get source dataSets of a shareSubscription.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataShare/accounts/{accountName}/shareSubscriptions/{shareSubscriptionName}/consumerSourceDataSets")
  @get
  listByShareSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription identifier
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the share account.
       */
      @path
      accountName: string;

      /**
       * The name of the shareSubscription.
       */
      @path
      shareSubscriptionName: string;

      /**
       * Continuation token
       */
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
