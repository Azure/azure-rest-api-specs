import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MixedReality;
/**
 * RemoteRenderingAccount Response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  MixedRealityAccountProperties
)
@includeInapplicableMetadataInPayload(false)
model RemoteRenderingAccount extends TrackedResourceBase {
  /**
   * Name of an Mixed Reality Account.
   */
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("accountName")
  @segment("remoteRenderingAccounts")
  name: string;

  /**
   * The kind of account, if supported
   */
  kind?: Sku;

  /**
   * Property bag.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MixedRealityAccountProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface RemoteRenderingAccounts {
  /**
   * Retrieve a Remote Rendering Account.
   */
  get is ArmResourceRead<RemoteRenderingAccount>;

  /**
   * Creating or Updating a Remote Rendering Account.
   */
  create is ArmResourceCreateOrReplaceSync<RemoteRenderingAccount>;

  /**
   * Updating a Remote Rendering Account
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<RemoteRenderingAccount, RemoteRenderingAccount>;

  /**
   * Delete a Remote Rendering Account.
   */
  delete is ArmResourceDeleteSync<RemoteRenderingAccount>;

  /**
   * List Resources by Resource Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RemoteRenderingAccounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<RemoteRenderingAccount>;

  /**
   * List Remote Rendering Accounts by Subscription
   */
  listBySubscription is ArmListBySubscription<RemoteRenderingAccount>;

  /**
   * List Both of the 2 Keys of a Remote Rendering Account
   */
  listKeys is ArmResourceActionSync<RemoteRenderingAccount, void, AccountKeys>;

  /**
   * Regenerate specified Key of a Remote Rendering Account
   */
  regenerateKeys is ArmResourceActionSync<
    RemoteRenderingAccount,
    AccountKeyRegenerateRequest,
    AccountKeys
  >;
}

@@projectedName(RemoteRenderingAccounts.create::parameters.resource,
  "json",
  "remoteRenderingAccount"
);
@@extension(RemoteRenderingAccounts.create::parameters.resource,
  "x-ms-client-name",
  "remoteRenderingAccount"
);
@@doc(RemoteRenderingAccounts.create::parameters.resource,
  "Remote Rendering Account parameter."
);
@@projectedName(RemoteRenderingAccounts.update::parameters.properties,
  "json",
  "remoteRenderingAccount"
);
@@extension(RemoteRenderingAccounts.update::parameters.properties,
  "x-ms-client-name",
  "remoteRenderingAccount"
);
@@doc(RemoteRenderingAccounts.update::parameters.properties,
  "Remote Rendering Account parameter."
);
@@projectedName(RemoteRenderingAccounts.regenerateKeys::parameters.body,
  "json",
  "regenerate"
);
@@extension(RemoteRenderingAccounts.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "regenerate"
);
@@doc(RemoteRenderingAccounts.regenerateKeys::parameters.body,
  "Required information for key regeneration."
);
