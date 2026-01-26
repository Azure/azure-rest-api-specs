import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("FabricConnection Authentication types")
model FabricConnectionAuthentication extends Authentication {
  @doc("Type of the Auth Model.")
  authenticationMode: AuthenticationMode.FabricConnection;

  @doc("Endpoint for server refresh the token.")
  endpoint: string;

  @doc("Artifact id for connection.")
  artifactId: string;

  @doc("Connection id.")
  connectionId: string;

  @doc("Tenant id for connection.")
  tenantId: string;

  @doc("User token for the DMTS.")
  @secret
  userToken: string;
}
