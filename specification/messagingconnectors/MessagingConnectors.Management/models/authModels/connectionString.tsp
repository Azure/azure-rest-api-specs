import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./authModel.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("ConnectionString Model.")
model ConnectionStringAuthentication extends Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode.ConnectionString;

  @doc("ConnectionString secret.")
  @secret
  connectionString: string;
}
