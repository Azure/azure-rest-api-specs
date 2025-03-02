// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.Core;

@versioned(Microsoft.PlaywrightTesting.Shared.Versions)
namespace Microsoft.PlaywrightTesting.Shared;

@doc("The PlaywrightTesting Accounts Model Version.")
enum Versions {
  @doc("Version 1.0")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v1_0,
}

@doc("An account is a parent resource for most of the other service resources. It's directly mapped to an Azure resource.")
@resource("accounts")
model Account {
  @key("accountId")
  @doc("The account id.")
  @maxLength(64)
  @pattern("[A-Za-z0-9]+(_[A-Za-z0-9]+)*(-[A-Za-z0-9]+)+")
  @visibility("read")
  id: string;

  @doc("The fully-qualified Azure resource id for the account.")
  @visibility("read")
  resourceId: string;

  @doc("The account name.")
  @visibility("read")
  name: string;

  @doc("The state of account - Active | Inactive")
  @visibility("read")
  state: AccountState;

  @doc("The Azure subscription id for the account.")
  @visibility("read")
  subscriptionId: uuid;

  @doc("The Azure subscription state - Registered | Unregistered | Warned | Suspended | Deleted")
  @visibility("read")
  subscriptionState: SubscriptionState;

  @doc("The Azure tenant id of the account.")
  @visibility("read")
  tenantId: uuid;

  @doc("The account resource location in Azure, for eg. eastus, southeastasia.")
  @visibility("read")
  location: string;

  @doc("This property sets the connection region for Playwright client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  @visibility("read")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, Playwright client workers can connect to cloud-hosted browsers. This can increase the number of parallel workers for a test run, significantly minimizing test completion durations.")
  @visibility("read")
  scalableExecution?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to upload and display test results, including artifacts like traces and screenshots, in the Playwright portal. This enables faster and more efficient troubleshooting.")
  @visibility("read")
  reporting?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  @visibility("read")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("The account state.")
union AccountState {
  string,

  @doc("The account is Active.")
  "Active",

  @doc("The account is Inactive.")
  "Inactive",
}

@doc("The Azure subscription state.")
union SubscriptionState {
  string,

  @doc("The subscription state is Registered.")
  "Registered",

  @doc("The subscription state is Warned.")
  "Warned",

  @doc("The subscription state is Suspended.")
  "Suspended",

  @doc("The subscription state is Deleted.")
  "Deleted",

  @doc("The subscription state is Unregistered.")
  "Unregistered",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}
