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
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @doc("The workspace id in GUID format.")
  workspaceId: string;

  @query
  @doc("The os provided by client for remote script runs.")
  os: OS;

  @query
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @doc("The runId provided by client in GUID format.")
  runId?: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters. Consider using ResourceAction or ResourceCollectionAction instead."
  @doc("Gets remote browsers corresponding to given workspace id and redirects the client for executing Playwright scripts. Authorization required is Bearer JWT Access token provided by EntraID or Playwright Service.")
  @route("/playwrightworkspaces/{workspaceId}/browsers")
  getBrowsers is RpcOperation<
    GetBrowsersParams,
    GetBrowsersResponse,
    ServiceTraits
  >;
}

interface TestRuns {
  // TestRun Operations
  @doc("Creates/Updates a test-run for the workspace with given test-run id. Authorization required is Bearer JWT Access token provided by EntraID or Playwright Service.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<TestRun>;

  @doc("Lists test-runs for the given workspace id. It can use OData query params like $filter, $top etc. The default page size is 10. Use nextLink in response to fetch more objects in the list. Authorization required is Bearer JWT Access token provided by EntraID or Playwright Service.")
  list is Operations.ResourceList<TestRun>;
}
