import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;

namespace Playwright;

// Operations ////////////////////

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface AccessTokens {
  // AccessToken Operations
  @doc("Creates an access token for the workspace with the specified access token ID and name. The ID and name must be unique among active access tokens for the user within a Playwright workspace. Requires Bearer JWT access token provided by Entra ID.")
  createOrReplace is Operations.ResourceCreateOrReplace<AccessToken>;

  @doc("Gets an access token for the workspace with the specified access token ID. Requires Bearer JWT access token provided by Entra ID.")
  get is Operations.ResourceRead<AccessToken>;

  @doc("Deletes an access token for the workspace with the specified access token ID. Requires Bearer JWT access token provided by Entra ID.")
  delete is Operations.ResourceDelete<AccessToken>;

  @doc("Lists access tokens for the specified workspace ID. Supports OData query parameters: $select, $filter, $orderby, $top, and $skip. Default page size is 10. Use nextLink in response to fetch additional results. Requires Bearer JWT access token provided by Entra ID.")
  list is Operations.ResourceList<AccessToken>;
}

alias GetBrowsersParams = {
  @path
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @doc("The workspace ID in GUID format.")
  workspaceId: string;

  @query
  @doc("The operating system for remote script execution.")
  os: OS;

  @query
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @doc("The run ID in GUID format.")
  runId?: string;
};

alias GetBrowsersResponse = {
  @statusCode
  _: 302;

  @header
  @doc("The redirect target URL for executing Playwright scripts on remote browsers.")
  location: url;
};

interface Workspaces {
  // Workspaces Operations
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters. Consider using ResourceAction or ResourceCollectionAction instead."
  @doc("Gets remote browsers for the specified workspace ID and redirects the client to execute Playwright scripts. Requires Bearer JWT access token provided by Entra ID or Playwright Service.")
  @route("/playwrightworkspaces/{workspaceId}/browsers")
  getBrowsers is RpcOperation<
    GetBrowsersParams,
    GetBrowsersResponse,
    ServiceTraits
  >;
}

interface TestRuns {
  // TestRun Operations
  @doc("Creates or updates a test run for the workspace with the specified test run ID. Requires Bearer JWT access token provided by Entra ID or Playwright Service.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<TestRun>;

  @doc("Lists test runs for the specified workspace ID. Supports OData query parameters such as $filter and $top. Default page size is 10. Use nextLink in response to fetch additional results. Requires Bearer JWT access token provided by Entra ID or Playwright Service.")
  list is Operations.ResourceList<TestRun>;
}
