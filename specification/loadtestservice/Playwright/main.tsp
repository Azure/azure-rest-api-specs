// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Playwright.Shared";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Playwright.Shared;

@server(
  "{endpoint}",
  "Playwright Service API Endpoint",
  {
    @doc("""
      Supported Playwright Service API Endpoints (protocol and hostname, for example:
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
@service(#{ title: "Playwright Service API" })
@versioned(Playwright.Versions)
namespace Playwright;

@doc("Playwright Service API Versions.")
enum Versions {
  @doc("Version 2025-07-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Playwright.Shared.Versions.v1_0)
  `2025-07-01-preview`,
}

// Models ////////////////////

@doc("Model of an access-token linked to a workspace.")
@resource("access-tokens")
@parentResource(Workspace)
model AccessToken {
  @key("accessTokenId")
  @doc("The access-token id.")
  @visibility(Lifecycle.Read)
  id: uuid;

  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9]{2,63}$")
  @doc("The access-token name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The access-token value in JWT format.")
  @visibility(Lifecycle.Read)
  jwtToken?: string;

  @doc("The access-token createdAt utcDateTime.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The access-token expiryAt utcDateTime.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  expiryAt: utcDateTime;

  @doc("The access-token state - Active | Expired.")
  @visibility(Lifecycle.Read)
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

@doc("The os to configure for remote script runs.")
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
  @doc("Creates an access-token for the workspace with given access-token id. Authorization required is Bearer JWT Access token provided by EntraID.")
  createOrReplace is Operations.ResourceCreateOrReplace<AccessToken>;

  @doc("Gets an access-token for the workspace with given access-token id. Authorization required is Bearer JWT Access token provided by EntraID.")
  get is Operations.ResourceRead<AccessToken>;

  @doc("Deletes an access-token for the workspace with given access-token id. Authorization required is Bearer JWT Access token provided by EntraID.")
  delete is Operations.ResourceDelete<AccessToken>;

  @doc("Lists access-tokens for the given workspace id. It can use OData query params like $select, $filter, $orderby, $top and $skip. The default page size is 10. Use nextLink in response to fetch more objects in the list. Authorization required is Bearer JWT Access token provided by EntraID.")
  list is Operations.ResourceList<AccessToken>;
}

alias GetBrowsersParams = {
  @path
  @doc("The workspace id.")
  workspaceId: string;

  @query
  @doc("The os provided by client for remote script runs.")
  os?: OS = OS.Linux;
};

alias GetBrowsersResponse = {
  @statusCode
  _: 302;

  @header
  @doc("The redirect target URL to run script on remote browsers.")
  location: url;
};

interface Workspaces {
  // Workspaces Operations

  @doc("Get details of the Azure resource mapped to a workspace for the given workspace id. Authorization required is Bearer JWT Access token provided by EntraID.")
  get is Operations.ResourceRead<Workspace>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters. Consider using ResourceAction or ResourceCollectionAction instead."
  @doc("Gets remote browsers corresponding to given workspace id and redirects the client for executing Playwright scripts. Authorization required is Bearer JWT Access token provided by EntraID or Playwright Service.")
  @route("/workspaces/{workspaceId}/browsers")
  getBrowsers is RpcOperation<
    GetBrowsersParams,
    GetBrowsersResponse,
    ServiceTraits
  >;
}
