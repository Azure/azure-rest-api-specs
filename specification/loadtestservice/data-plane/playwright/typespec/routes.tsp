import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Playwright;

// Operations ////////////////////

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId &
  RequestHeadersTrait<{
    #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase."
    @header
    @doc("Optional header to specify additional client information when the standard 'User-Agent' header cannot be explicitly set, such as when using Playwright Client. The value should follow the standard 'User-Agent' header format.")
    `x-ms-useragent`?: string;
  }>;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

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
  location: string;
};

interface Workspaces {
  // Workspaces Operations

  @added(Versions.v2026_01_01_preview)
  @doc("Get details of the Azure resource mapped to a workspace for the given workspace id. Authorization required is Bearer JWT Access token provided by EntraID.")
  get is Operations.ResourceRead<Workspace>;

  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters. Consider using ResourceAction or ResourceCollectionAction instead."
  @doc("Gets remote browsers for the specified workspace ID and redirects the client to execute Playwright scripts. Requires Bearer JWT access token provided by Entra ID or Playwright Service.")
  @route("/playwrightworkspaces/{workspaceId}/browsers")
  getBrowsers is RpcOperation<
    GetBrowsersParams,
    GetBrowsersResponse,
    ServiceTraits
  >;
}
