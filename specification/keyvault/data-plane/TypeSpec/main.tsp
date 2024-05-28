import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
    title: "KeyVaultClient"
  })
@versioned(Versions)
@server("{vaultBaseUrl}", "The key vault client performs cryptographic key operations and vault operations against the Key Vault service."
, {
vaultBaseUrl: string 
}
)
/**
* The key vault client performs cryptographic key operations and vault operations
* against the Key Vault service.
*/
namespace KeyVaultClient;

/**
* The available API versions.
*/
enum Versions {
/**
* The 7.6-preview.1 API version.
*/
v7.6_preview.1: "7.6-preview.1",
}