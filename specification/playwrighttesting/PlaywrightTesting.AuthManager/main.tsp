// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@server(
  "{endpoint}",
  "Microsoft Azure Playwright Service API Endpoint",
  {
    @doc("""
      Supported Azure Playwright Service API Endpoints (protocol and hostname, for example:
        https://{region}.api.playwright.microsoft.com).
      """)
    endpoint: string,
  }
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        description: "We can use OAuth2 Implicit flow to get the auth token for calling the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>,
    OAuth2Auth<[
      {
        type: OAuth2FlowType.authorizationCode,
        description: "We can use OAuth2 Authorization Code flow to get the auth token for calling the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        tokenUrl: "https://login.microsoftonline.com/common/v2.0/oauth2/token",
        scopes: ["https://playwright.microsoft.com/.default"],
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
  @doc("Version 2024-12-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2024-12-01`,
}

// Models ////////////////////

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

@doc("Model of an access-token linked to an account.")
@resource("access-tokens")
@parentResource(Account)
model AccessToken {
  @key("accessTokenId")
  @doc("The access-token id.")
  @maxLength(64)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
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
  createdAt: utcDateTime;

  @doc("The access-token expiryAt utcDateTime.")
  @visibility("read", "create")
  expiryAt: utcDateTime;

  @doc("The access-token state - Active | Expired.")
  @visibility("read")
  state: AccessTokenState;
}

@doc("The access-token state.")
union AccessTokenState {
  string,

  @doc("The access-token is Active.")
  Active: "Active",

  @doc("The access-token is Expired.")
  Expired: "Expired",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}

@doc("The os to configure for remote test runs.")
union OS {
  string,

  @doc("Linux OS.")
  Linux: "Linux",

  @doc("Windows OS.")
  Windows: "Windows",
}

// Operations ////////////////////

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface AccessTokens {
  // AccessToken Operations
  @doc("Creates an access-token for the account with given access-token id. Authorization required is Bearer JWT Access token provided by EntraID.")
  createOrReplace is Operations.ResourceCreateOrReplace<AccessToken>;

  @doc("Gets an access-token for the account with given access-token id. Authorization required is Bearer JWT Access token provided by EntraID.")
  get is Operations.ResourceRead<AccessToken>;

  @doc("Deletes an access-token for the account with given access-token id. Authorization required is Bearer JWT Access token provided by EntraID.")
  delete is Operations.ResourceDelete<AccessToken>;

  @doc("Lists access-tokens for the given account id. It can use OData query params like $select, $filter, $orderby, $top and $skip. The default page size is 10. Use nextLink in response to fetch more objects in the list. Authorization required is Bearer JWT Access token provided by EntraID.")
  list is Operations.ResourceList<AccessToken>;
}

alias GetBrowsersParams = {
  @path
  @doc("The account id.")
  accountId: string;

  @query
  @doc("The run id provided by client for corresponding remote test run.")
  runId?: string;

  @query
  @doc("The os provided by client for remote test runs.")
  os?: OS = OS.Linux;
};

alias GetBrowsersResponse = {
  @statusCode
  _: 302;

  @header
  @doc("The redirect target URL to run test on remote browsers.")
  location: url;
};

interface Accounts {
  // Accounts Operations

  @doc("Get details of the Azure resource mapped to an account for the given account id. Authorization required is Bearer JWT Access token provided by EntraID.")
  get is Operations.ResourceRead<Account>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters. Consider using ResourceAction or ResourceCollectionAction instead."
  @doc("Gets remote browsers corresponding to given account id and redirects the client for running Playwright tests. Authorization required is Bearer JWT Access token provided by EntraID or Microsoft Playwright Testing Service.")
  @route("/accounts/{accountId}/browsers")
  getBrowsers is RpcOperation<
    GetBrowsersParams,
    GetBrowsersResponse,
    ServiceTraits
  >;
}
