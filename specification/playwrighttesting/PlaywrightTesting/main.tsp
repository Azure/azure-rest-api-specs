// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Autorest;

@server(
  "https://api.playwright-int.io",
  "Azure Playwright Service API Endpoint"
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://preview.playwright-int.io/.default"],
      }
    ]>
  ]
)
@service({
  title: "Microsoft PlaywrightTesting AuthManager Service API",
})
@versioned(Microsoft.PlaywrightTesting.AuthManager.Versions)
namespace Microsoft.PlaywrightTesting.AuthManager;

@doc("The PlaywrightTesting Auth Manager service version.")
enum Versions {
  @doc("Version 2023-10-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-10-01-preview`,
}

// Models ////////////////////

@doc("An account is a parent resource for most of the other service resources. It's directly mapped to an ARM resource and helps to create a link between control-plane and data-plane resources.")
@resource("accounts")
model Account {
  @key("accountId")
  @doc("The account id.")
  @visibility("read")
  id: string;

  @doc("The ARM fully-qualified resource id for the account.")
  @visibility("read")
  resourceId: string;

  @doc("The account name.")
  @visibility("read")
  name: string;

  @doc("The state of account - Active | Inactive")
  @visibility("read")
  state: AccountState;

  @doc("The ARM-based subscription id for the account.")
  @visibility("read")
  subscriptionId: uuid;

  @doc("The ARM-based subscription state - Registered | Unregistered | Warned | Suspended | Deleted")
  @visibility("read")
  subscriptionState: SubscriptionState;

  @doc("The Azure tenant id of the account.")
  @visibility("read")
  tenantId: uuid;

  @doc("The account resource ARM location, for eg. eastus, southeastasia.")
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
  reporting?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("The account state.")
union AccountState {
  string,

  @doc("The account is Active.")
  "Active",

  @doc("The account is Inactive.")
  "Inactive",
}

@doc("The ARM-based subscription state.")
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

@doc("Model of an access-token linked to an account.")
@resource("access-tokens")
@parentResource(Account)
model AccessToken {
  @key("accessTokenId")
  @doc("The access-token id.")
  @visibility("read")
  id: uuid;

  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9]{2,63}$")
  @doc("The access-token name.")
  @visibility("read", "create")
  name: string;

  @doc("The access-token value in JWT format.")
  @visibility("read")
  jwtToken?: string;

  @doc("The access-token createdAt utcDateTime.")
  @visibility("read")
  createdAt?: utcDateTime;

  @doc("The access-token expiryAt utcDateTime.")
  @visibility("read", "create")
  expiryAt: utcDateTime;

  @doc("The access-token state - Active | Expired.")
  @visibility("read")
  state?: AccessTokenState;
}

@doc("The access-token state.")
union AccessTokenState {
  string,

  @doc("The access-token is Active.")
  "Active",

  @doc("The access-token is Expired.")
  "Expired",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}

// Operations ////////////////////

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface AccessTokens {
  // AccessToken Operations

  @doc("Creates an access-token with given access-token id in guid format.")
  createAccessToken is Operations.ResourceCreateOrReplace<AccessToken>;

  @doc("Get an access-token for given access-token id in guid format.")
  getAccessToken is Operations.ResourceRead<AccessToken>;

  @doc("Revoke an access-token with given access-token id in guid format.")
  deleteAccessToken is Operations.ResourceDelete<AccessToken>;

  @doc("List access-tokens for a given accountId.")
  listAccessTokens is Operations.ResourceList<AccessToken>;
}

interface Accounts {
  // Accounts Operations
  @doc("Get details of the ARM resource mapped to an account for the given accountId.")
  getAccount is Operations.ResourceRead<Account>;
}
