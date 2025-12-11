import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;

namespace Playwright;

// Models ////////////////////

@doc("Model of an access token linked to a workspace.")
@resource("access-tokens")
@parentResource(Workspace)
model AccessToken {
  @key("accessTokenId")
  @doc("The access token ID in GUID format.")
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  // Standard Azure Resource Name parameter regex pattern - https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/#Azure.ResourceManager.ResourceNameParameter
  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The access token name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The access token value in JWT format.")
  @visibility(Lifecycle.Read)
  jwtToken?: string;

  @doc("The access token creation timestamp in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The access token expiration timestamp in UTC.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  expiryAt: utcDateTime;

  @doc("The access token state.")
  @visibility(Lifecycle.Read)
  state: AccessTokenState;
}

@doc("The access token state.")
union AccessTokenState {
  string,

  @doc("The access token is active and can be used for authentication.")
  Active: "Active",

  @doc("The access token has expired and cannot be used for authentication.")
  Expired: "Expired",
}

// Operations ////////////////////

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
