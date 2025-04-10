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
 * A share data transfer object.
 */
@parentResource(Account)
model Share is Azure.ResourceManager.ProxyResource<ShareProperties> {
  ...ResourceNameParameter<
    Resource = Share,
    KeyName = "shareName",
    SegmentName = "shares",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Shares {
  /**
   * Get a share
   */
  get is ArmResourceRead<Share>;

  /**
   * Create a share
   */
  create is ArmResourceCreateOrReplaceSync<Share>;

  /**
   * Delete a share
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Share,
    Response = ArmResponse<OperationResponse> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List shares in an account
   */
  listByAccount is ArmResourceListByParent<
    Share,
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
    Response = ArmResponse<ShareList>
  >;

  /**
   * List synchronization details
   */
  listSynchronizationDetails is ArmResourceActionSync<
    Share,
    ShareSynchronization,
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
   * List synchronizations of a share
   */
  listSynchronizations is ArmResourceActionSync<
    Share,
    void,
    ArmResponse<ShareSynchronizationList>,
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
}

@@doc(Share.name, "The name of the share to retrieve.");
@@doc(Share.properties, "Properties on the share");
@@doc(Shares.create::parameters.resource, "The share payload");
@@doc(Shares.listSynchronizationDetails::parameters.body,
  "Share Synchronization payload."
);
