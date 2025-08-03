import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("ConnectionString Model.")
model ConnectionStringAuthentication extends Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode.ConnectionString;

  @doc("ConnectionString secret.")
  @secret
  connectionString: string;
}
