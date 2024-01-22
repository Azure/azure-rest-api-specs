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
 * A share data transfer object.
 */
@parentResource(Account)
model Share is ProxyResource<ShareProperties> {
  /**
   * The name of the share to retrieve.
   */
  @path
  @key("shareName")
  @segment("shares")
  name: string;
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
  delete is ArmResourceDeleteAsync<Share>;

  /**
   * List shares in an account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Shares_ListByAccount")
  listByAccount is ArmResourceListByParent<
    Share,
    {
      ...BaseParameters<Share>;

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
   * List synchronization details
   */
  listSynchronizationDetails is ArmResourceActionSync<
    Share,
    ShareSynchronization,
    SynchronizationDetailsList,
    {
      ...BaseParameters<Share>;

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
    ShareSynchronizationList,
    {
      ...BaseParameters<Share>;

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

@@projectedName(Shares.create::parameters.resource, "json", "share");
@@extension(Shares.create::parameters.resource, "x-ms-client-name", "share");
@@doc(Shares.create::parameters.resource, "The share payload");
@@projectedName(Shares.listSynchronizationDetails::parameters.body,
  "json",
  "shareSynchronization"
);
@@extension(Shares.listSynchronizationDetails::parameters.body,
  "x-ms-client-name",
  "shareSynchronization"
);
@@doc(Shares.listSynchronizationDetails::parameters.body,
  "Share Synchronization payload."
);
