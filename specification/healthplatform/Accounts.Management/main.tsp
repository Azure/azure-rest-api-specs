import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.HealthPlatform Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.HealthPlatform management service" })
@versioned(Versions)
namespace Microsoft.HealthPlatform;

/** API versions */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2025-02-13-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

/** HealthPlatform Account properties */
@doc("Details of the HealthPlatform Account.")
model AccountProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

/** Account resource */
model Account is TrackedResource<AccountProperties> {
  @doc("The name of the account service")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("accountName")
  @segment("accounts")
  @path
  name: string;
}

@armResourceOperations
interface Accounts {
  get is ArmResourceRead<Account>;
  list is ArmResourceListByParent<Account>;
  listBySubscription is ArmListBySubscription<Account>;
  create is ArmResourceCreateOrReplaceSync<Account>;
  update is ArmResourcePatchSync<Account, AccountProperties>;
  delete is ArmResourceDeleteSync<Account>;
}

/** The provisioning state of a resource. */
@doc("The status of the current operation.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is provisioning")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is deleting")
  Deleting: "Deleting",

  @doc("The resource is accepted")
  Accepted: "Accepted",

  string,
}
