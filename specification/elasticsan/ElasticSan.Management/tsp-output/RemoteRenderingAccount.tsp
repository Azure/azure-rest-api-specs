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
@doc("RemoteRenderingAccount Response.")
model RemoteRenderingAccount is TrackedResource<MixedRealityAccountProperties> {
  @doc("Name of an Mixed Reality Account.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("accountName")
  @segment("remoteRenderingAccounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourcePlan;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface RemoteRenderingAccounts {
  @doc("Retrieve a Remote Rendering Account.")
  get is ArmResourceRead<RemoteRenderingAccount>;

  @doc("Creating or Updating a Remote Rendering Account.")
  create is ArmResourceCreateOrReplaceSync<RemoteRenderingAccount>;

  @doc("Updating a Remote Rendering Account")
  update is ArmCustomPatchSync<RemoteRenderingAccount, RemoteRenderingAccount>;

  @doc("Delete a Remote Rendering Account.")
  delete is ArmResourceDeleteSync<RemoteRenderingAccount>;

  @doc("List Resources by Resource Group")
  listByResourceGroup is ArmResourceListByParent<RemoteRenderingAccount>;

  @doc("List Remote Rendering Accounts by Subscription")
  listBySubscription is ArmListBySubscription<RemoteRenderingAccount>;

  @doc("List Both of the 2 Keys of a Remote Rendering Account")
  listKeys is ArmResourceActionSync<RemoteRenderingAccount, void, AccountKeys>;

  @doc("Regenerate specified Key of a Remote Rendering Account")
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
