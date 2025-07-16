import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * Deleted storage account
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DeletedAccount
  is Azure.ResourceManager.ProxyResource<DeletedAccountProperties> {
  ...ResourceNameParameter<
    Resource = DeletedAccount,
    KeyName = "deletedAccountName",
    SegmentName = "deletedAccounts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedAccounts {
  /**
   * Get properties of specified deleted account resource.
   */
  get is ArmResourceRead<
    DeletedAccount,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Lists deleted accounts under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @get
  @action("deletedAccounts")
  @tag("DeletedAccounts")
  list is ArmProviderActionSync<
    Response = DeletedAccountListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

@@maxLength(DeletedAccount.name, 24);
@@minLength(DeletedAccount.name, 3);
@@doc(DeletedAccount.name, "Name of the deleted storage account.");
@@doc(DeletedAccount.properties, "Properties of the deleted account.");
