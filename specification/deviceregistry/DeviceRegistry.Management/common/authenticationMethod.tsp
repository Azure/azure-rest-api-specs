import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("The method to authenticate the user of the client at the server.")
@renamedFrom(Versions.v2024_09_01_preview, "UserAuthenticationMode")
union AuthenticationMethod {
  @doc("The user authentication method is anonymous.")
  Anonymous: "Anonymous",

  @doc("The user authentication method is an x509 certificate.")
  Certificate: "Certificate",

  @doc("The user authentication method is a username and password.")
  UsernamePassword: "UsernamePassword",

  string,
}
