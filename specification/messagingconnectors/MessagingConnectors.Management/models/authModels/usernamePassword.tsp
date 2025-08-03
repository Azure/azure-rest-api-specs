import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("UsernamePassword Model.")
model UsernamePasswordAuthentication extends Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode.UsernamePassword;

  @doc("Username for auth.")
  username: string;

  @doc("Password for auth.")
  @secret
  password: string;
}
