import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

#suppress "@azure-tools/typespec-azure-core/casing-style" "PascalCase"
@doc("OAuth Model.")
model OAuthAuthentication extends Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode.OAuth;

  @doc("AccessToken for OAuth.")
  @secret
  accessToken: string;
}
