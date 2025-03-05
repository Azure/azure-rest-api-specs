import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SecretSyncController")
namespace Microsoft.SecretSyncController;

@doc("The AzureKeyVaultSecretProviderClass resource.")
model AzureKeyVaultSecretProviderClass
  is TrackedResource<AzureKeyVaultSecretProviderClassProperties> {
  ...ResourceNameParameter<
    AzureKeyVaultSecretProviderClass,
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
  >;
  ...ExtendedLocationProperty;
}

@@maxLength(AzureKeyVaultSecretProviderClass.name, 253);

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

  @doc("Objects defines the desired state of synced K8s secret objects")
  objects?: string;

  @doc("Provisioning state of the AzureKeyVaultSecretProviderClass instance.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AzureKeyVaultSecretProviderClasses {
  @doc("Gets the properties of an AzureKeyVaultSecretProviderClass instance.")
  get is ArmResourceRead<AzureKeyVaultSecretProviderClass>;

  @doc("Creates, or updates, an AzureKeyVaultSecretProviderClass instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureKeyVaultSecretProviderClass>;

  @doc("Updates an AzureKeyVaultSecretProviderClass instance.")
  update is ArmCustomPatchAsync<
    AzureKeyVaultSecretProviderClass,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AzureKeyVaultSecretProviderClass,
      AzureKeyVaultSecretProviderClassProperties
    >
  >;

  @doc("Deletes an AzureKeyVaultSecretProviderClass instance.")
  delete is ArmResourceDeleteWithoutOkAsync<AzureKeyVaultSecretProviderClass>;

  @doc("Lists the AzureKeyVaultSecretProviderClass instances within a resource group.")
  listByResourceGroup is ArmResourceListByParent<AzureKeyVaultSecretProviderClass>;

  @doc("Lists the AzureKeyVaultSecretProviderClass instances within an Azure subscription.")
  listBySubscription is ArmListBySubscription<AzureKeyVaultSecretProviderClass>;
}
