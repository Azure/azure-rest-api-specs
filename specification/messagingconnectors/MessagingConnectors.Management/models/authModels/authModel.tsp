import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

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

  @doc("AccessKey model.")
  AccessKey: "AccessKey",

  @doc("SasToken model.")
  SasToken: "SasToken",

  @doc("Anonymous model.")
  Anonymous: "Anonymous",

  @doc("Certificate model.")
  Certificate: "Certificate",

  @doc("FabricConnection model.")
  FabricConnection: "FabricConnection",

  string,
}
