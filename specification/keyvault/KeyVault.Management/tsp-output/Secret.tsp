import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KeyVault;
@doc("Resource information with extended details.")
@parentResource(Vault)
model Secret is ProxyResource<SecretProperties> {
  @doc("The name of the secret.")
  @key("secretName")
  @segment("secrets")
  name: string;
}

@armResourceOperations
interface Secrets {
  @doc("Gets the specified secret.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  get is ArmResourceRead<Secret>;

  @doc("Create or update a secret in a key vault in the specified subscription.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Secret>;

  @doc("Update a secret in the specified subscription.  NOTE: This API is intended for internal use in ARM deployments.  Users should use the data-plane REST service for interaction with vault secrets.")
  update is ArmCustomPatchSync<Secret, SecretPatchParameters>;

  @doc("The List operation gets information about the secrets in a vault.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.")
  list is ArmResourceListByParent<
    Secret,
    {
      ...BaseParameters<Secret>;

      @doc("Maximum number of results to return.")
      @query("$top")
      $top?: int32;
    }
  >;
}
