import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SecretSyncController")
namespace Microsoft.SecretSyncController;

@doc("The AzureKeyVaultSecretProviderClass resource.")
model AzureKeyVaultSecretProviderClass
  is TrackedResource<AzureKeyVaultSecretProviderClassProperties> {
  ...ResourceNameParameter<AzureKeyVaultSecretProviderClass>;
  ...ExtendedLocationProperty;
}

@doc("The properties of the AzureKeyVaultSecretProviderClass.")
model AzureKeyVaultSecretProviderClassProperties {
  // Azure Key Vault Provider properties
  // https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/getting-started/usage/
  @doc("The name of the Azure Key Vault to sync secrets from.")
  keyvaultName: string;

  @doc("The user assigned managed identity client ID that should be used to access the Azure Key Vault.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  clientId: string;

  @doc("The Azure Active Directory tenant ID that should be used for authenticating requests to the Azure Key Vault.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  tenantId: string;

  @doc("List of objects to synchronize from the specified Azure Key Vault.")
  @OpenAPI.extension("x-ms-identifiers", [])
  objects?: AzureKeyVaultObjectProperties[];

  @doc("Provisioning state of the AzureKeyVaultSecretProviderClass instance.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The properties of an object to synchronize from an Azure Key Vault.")
model AzureKeyVaultObjectProperties {
  // Azure Key Vault Object properties
  // https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/getting-started/usage/
  @doc("The name of the object in Azure Key Vault.")
  objectName: string;

  @doc("The type of the object in Azure Key Vault.")
  objectType: AzureKeyVaultObjectType;

  @doc("The number of versions of the object to synchronize.")
  versionsToSync?: int32;
}

// Defined as an extensable union rather than an enum for compliance with rule https://azure.github.io/typespec-azure/docs/next/libraries/azure-core/rules/no-enum
@doc("Enumeration of types of object that can be synchronized from an Azure Key Vault.")
union AzureKeyVaultObjectType {
  // https://learn.microsoft.com/en-us/azure/key-vault/general/about-keys-secrets-certificates
  // https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/configurations/getting-certs-and-keys/
  @doc("Azure Key Vault secret")
  Secret: "Secret",

  @doc("Azure Key Vault key")
  Key: "Key",

  @doc("Azure Key Vault certificate")
  Cert: "Cert",

  string,
}

@armResourceOperations
interface AzureKeyVaultSecretProviderClasses {
  @doc("Gets the properties of an AzureKeyVaultSecretProviderClass instance.")
  get is ArmResourceRead<AzureKeyVaultSecretProviderClass>;

  @doc("Creates, or updates, an AzureKeyVaultSecretProviderClass instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureKeyVaultSecretProviderClass>;

  @doc("Updates an AzureKeyVaultSecretProviderClass instance.")
  update is ArmResourcePatchAsync<
    AzureKeyVaultSecretProviderClass,
    AzureKeyVaultSecretProviderClassProperties
  >;

  @doc("Deletes an AzureKeyVaultSecretProviderClass instance.")
  delete is ArmResourceDeleteWithoutOkAsync<AzureKeyVaultSecretProviderClass>;

  @doc("Lists the AzureKeyVaultSecretProviderClass instances within a resource group.")
  listByResourceGroup is ArmResourceListByParent<AzureKeyVaultSecretProviderClass>;

  @doc("Lists the AzureKeyVaultSecretProviderClass instances within an Azure subscription.")
  listBySubscription is ArmListBySubscription<AzureKeyVaultSecretProviderClass>;
}
