// Models ////////////////////

import "@azure-tools/typespec-azure-core";
import "../Playwright.Shared";

using Azure.Core;
using Playwright.Shared;

namespace Playwright;

@doc("Model of an access-token linked to a workspace.")
@resource("access-tokens")
@parentResource(Workspace)
model AccessToken {
  @key("accessTokenId")
  @doc("The access-token id.")
  @maxLength(64)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
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