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
@doc("A share data transfer object.")
@parentResource(Account)
model Share is ProxyResource<ShareProperties> {
  @doc("The name of the share to retrieve.")
  @path
  @key("shareName")
  @segment("shares")
  name: string;
}

@armResourceOperations
interface Shares {
  @doc("Get a share ")
  get is ArmResourceRead<Share>;

  @doc("Create a share ")
  create is ArmResourceCreateOrReplaceSync<Share>;

  @doc("Delete a share ")
  delete is ArmResourceDeleteAsync<Share>;

  @doc("List shares in an account")
  listByAccount is ArmResourceListByParent<
    Share,
    {
      ...BaseParameters<Share>;

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
    Share,
    ShareSynchronization,
    SynchronizationDetailsList,
    {
      ...BaseParameters<Share>;

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
    Share,
    void,
    ShareSynchronizationList,
    {
      ...BaseParameters<Share>;

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
