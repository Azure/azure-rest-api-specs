import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLink resource")
model AppLink is TrackedResource<AppLinkProperties> {
  ...ResourceNameParameter<AppLink>;
}

@doc("AppLink properties")
model AppLinkProperties {
  @doc("Provisioning state of the AppLink resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AppLinks {
  get is ArmResourceRead<AppLink>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppLink>;
  update is ArmResourcePatchAsync<AppLink, AppLinkProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLink>;
  listByResourceGroup is ArmResourceListByParent<AppLink>;
  listBySubscription is ArmListBySubscription<AppLink>;
}
