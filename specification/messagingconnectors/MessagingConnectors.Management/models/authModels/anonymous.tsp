import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("Anonymous Model.")
model AnonymousAuthentication extends Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode.Anonymous;
}
