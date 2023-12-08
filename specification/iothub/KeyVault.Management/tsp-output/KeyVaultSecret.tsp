import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KeyVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KeyVault;
@doc("Resource information with extended details.")
@parentResource(KeyVault)
model KeyVaultSecret is ProxyResource<SecretProperties> {
  @doc("The name of the secret.")
  @path
  @key("secretName")
  @segment("secrets")
  name: string;
}

@armResourceOperations
interface KeyVaultSecrets {
  @doc("Gets the specified secret.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  get is ArmResourceRead<KeyVaultSecret>;
  @doc("Create or update a secret in a key vault in the specified subscription.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<KeyVaultSecret>;
  @doc("Update a secret in the specified subscription.  NOTE: This API is intended for internal use in ARM deployments.  Users should use the data-plane REST service for interaction with vault secrets.")
  update is ArmResourcePatchSync<KeyVaultSecret, SecretProperties>;
  @doc("The List operation gets information about the secrets in a vault.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  list is ArmResourceListByParent<
    KeyVaultSecret,
    {
      ...BaseParameters<KeyVaultSecret>;

      @doc("Maximum number of results to return.")
      @query("$top")
      $top?: int32;
    }
  >;
}
