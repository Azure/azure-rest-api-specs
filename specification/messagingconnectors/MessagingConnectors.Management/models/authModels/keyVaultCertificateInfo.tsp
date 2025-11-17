import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Auth;

@doc("certificate model.")
model KeyVaultCertificateInfo {
  @doc("Uri for keyvault which store the Certificate.")
  keyVaultUri: string;

  @doc("Access token for keyVault.")
  @secret
  keyVaultToken: string;

  @doc("Name of certificate.")
  certificateName: string;
}
