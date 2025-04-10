import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Account Filter.
 */
model AccountFilter
  is Azure.ResourceManager.ProxyResource<MediaFilterProperties> {
  ...ResourceNameParameter<
    Resource = AccountFilter,
    KeyName = "filterName",
    SegmentName = "accountFilters",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AccountFilters {
  /**
   * Get the details of an Account Filter in the Media Services account.
   */
  get is ArmResourceRead<AccountFilter>;

  /**
   * Creates or updates an Account Filter in the Media Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AccountFilter>;

  /**
   * Updates an existing Account Filter in the Media Services account.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<AccountFilter, PatchModel = AccountFilter>;

  /**
   * Deletes an Account Filter in the Media Services account.
   */
  delete is ArmResourceDeleteSync<AccountFilter>;

  /**
   * List Account Filters in the Media Services account.
   */
  list is ArmResourceListByParent<
    AccountFilter,
    Response = ArmResponse<AccountFilterCollection>
  >;
}

@@doc(AccountFilter.name, "The Account Filter name");
@@doc(AccountFilter.properties, "The Media Filter properties.");
@@doc(AccountFilters.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@doc(AccountFilters.update::parameters.properties, "The request parameters");
