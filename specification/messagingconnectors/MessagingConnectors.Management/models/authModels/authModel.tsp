import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Base properties for auth.")
@discriminator("authenticationMode")
model Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode;
}

@doc("Auth Model types")
union AuthenticationMode {
  @doc("OAuth model.")
  OAuth: "OAuth",

  @doc("ConnectionString model.")
  ConnectionString: "ConnectionString",

  @doc("UsernamePassword model.")
  UsernamePassword: "UsernamePassword",

  @added(Versions.v2025_05_01_preview)
  @doc("AccessKey model.")
  AccessKey: "AccessKey",

  @added(Versions.v2025_05_01_preview)
  @doc("SasToken model.")
  SasToken: "SasToken",

  string,
}
