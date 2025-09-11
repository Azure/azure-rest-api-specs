import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "SecurityPlatformClient" })
@doc("SecurityPlatform Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.SecurityPlatform;

enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-10-01-preview`,
}

@doc("An AccountLink resource")
model AccountLink is TrackedResource<AccountLinkProperties> {
  @doc("Name of AccountLink Resource")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @key("name")
  @path
  @segment("accountLinks")
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("AccountLink properties")
model AccountLinkProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is in an unknown state")
  Unknown: "Unknown",

  @doc("The resource is creating")
  Creating: "Creating",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface AccountLinks {
  get is ArmResourceRead<AccountLink>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<AccountLink>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    AccountLink,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AccountLink,
      AccountLinkProperties
    >
  >;
  delete is ArmResourceDeleteSync<AccountLink>;
  listByResourceGroup is ArmResourceListByParent<AccountLink>;
  listBySubscription is ArmListBySubscription<AccountLink>;
}
