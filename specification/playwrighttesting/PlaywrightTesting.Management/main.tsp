// tsp compile . --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzurePlaywrightService")
@service({
  title: "Microsoft AzurePlaywrightService Management API",
  version: "2023-10-01-preview",
})
@doc("Microsoft.AzurePlaywrightService Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzurePlaywrightService;

@doc("An account resource")
model Account is TrackedResource<AccountProperties> {
  @doc("Name of account")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @key("accountName")
  @path
  @segment("accounts")
  name: string;
}

@doc("Account properties")
model AccountProperties {
  @doc("The description for the account resource.")
  description?: string;

  @doc("The Playwright testing dashboard URI for the account resource.")
  @visibility("read")
  dashboardUri: url;

  @doc("The regionalAffinity feature enablement status for the account.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("The scalableExecution feature enablement status for the account.")
  scalableExecution?: EnablementStatus = EnablementStatus.Enabled;

  @doc("The reporting feature enablement status for the account.")
  reporting?: EnablementStatus = EnablementStatus.Disabled;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The enablement status of a feature.")
enum EnablementStatus {
  @doc("The feature is Enabled.")
  Enabled,

  @doc("The feature is Disabled.")
  Disabled,
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource create request has been accepted")
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Accounts {
  @doc("Gets an Account.")
  get is ArmResourceRead<Account>;

  @doc("Creates or Replaces an Account as an Async Operation.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Account>;

  @doc("Updates an Account.")
  update is ArmResourcePatchSync<Account, AccountProperties>;

  @doc("Deletes an Account as an Async Operation.")
  delete is ArmResourceDeleteWithoutOkAsync<Account>;

  @doc("List Accounts by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<Account>;

  @doc("List Accounts by Subscription.")
  listBySubscription is ArmListBySubscription<Account>;
}
