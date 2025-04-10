import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
/**
 * A share subscription data transfer object.
 */
@parentResource(Account)
model ShareSubscription
  is Azure.ResourceManager.ProxyResource<ShareSubscriptionProperties, false> {
  ...ResourceNameParameter<
    Resource = ShareSubscription,
    KeyName = "shareSubscriptionName",
    SegmentName = "shareSubscriptions",
    NamePattern = ""
  >;
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
  delete is ArmResourceDeleteWithoutOkAsync<
    ShareSubscription,
    Response = ArmResponse<OperationResponse> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List share subscriptions in an account
   */
  listByAccount is ArmResourceListByParent<
    ShareSubscription,
    Parameters = {
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
    },
    Response = ArmResponse<ShareSubscriptionList>
  >;

  /**
   * Request to cancel a synchronization.
   */
  cancelSynchronization is ArmResourceActionAsync<
    ShareSubscription,
    ShareSubscriptionSynchronization,
    ArmResponse<ShareSubscriptionSynchronization>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get synchronization settings set on a share
   */
  listSourceShareSynchronizationSettings is ArmResourceActionSync<
    ShareSubscription,
    void,
    ArmResponse<SourceShareSynchronizationSettingList>,
    Parameters = {
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
    ArmResponse<SynchronizationDetailsList>,
    Parameters = {
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
    ArmResponse<ShareSubscriptionSynchronizationList>,
    Parameters = {
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
    ArmResponse<ShareSubscriptionSynchronization>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get source dataSets of a shareSubscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("consumerSourceDataSets")
  @operationId("ConsumerSourceDataSets_ListByShareSubscription")
  listByShareSubscription is ArmResourceActionSync<
    ShareSubscription,
    void,
    ArmResponse<ConsumerSourceDataSetList>,
    Parameters = {
      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(ShareSubscription.name, "The name of the shareSubscription.");
@@doc(ShareSubscription.properties, "Properties on the share subscription");
@@doc(ShareSubscriptions.create::parameters.resource,
  "create parameters for shareSubscription"
);
@@doc(ShareSubscriptions.cancelSynchronization::parameters.body,
  "Share Subscription Synchronization payload."
);
@@doc(ShareSubscriptions.listSynchronizationDetails::parameters.body,
  "Share Subscription Synchronization payload."
);
@@doc(ShareSubscriptions.synchronize::parameters.body, "Synchronize payload");
