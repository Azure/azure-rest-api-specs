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
  ...ManagedServiceIdentityProperty;
}

@doc("AppLink properties")
model AppLinkProperties {
  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AppLinks {
  @doc("Get an AppLink")
  get is ArmResourceRead<AppLink>;
  @doc("Create an AppLink")
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppLink>;
  @doc("Update an AppLink")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmResourcePatchAsync<
    AppLink,
    AppLinkProperties,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AppLink> &
      ArmLroLocationHeader<FinalResult = AppLink> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Delete an AppLink")
  delete is ArmResourceDeleteWithoutOkAsync<AppLink>;
  listByResourceGroup is ArmResourceListByParent<AppLink>;
  listBySubscription is ArmListBySubscription<AppLink>;
}
