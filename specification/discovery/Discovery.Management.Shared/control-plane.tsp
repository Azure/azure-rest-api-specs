import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";
import "./shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;

@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  string,
}

/** For tracking mobo resources */
model WithMoboBrokerResources {
  @doc("Managed-On-Behalf-Of broker resources")
  // TODO: Azure.ResourceManager.CommonTypes.MoboBrokerResource was in common types v5 but not v6. Find out why.
  @visibility(Lifecycle.Read)
  moboBrokerResources?: Azure.ResourceManager.CommonTypes.MoboBrokerResource[];
}

@doc("Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner.")
model MoboConfigurationWithMrg {
  @doc("The resource group for resources managed on behalf of customer.")
  @visibility(Lifecycle.Read)
  managedResourceGroup?: string;

  /** Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner. */
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: WithMoboBrokerResources;
}

@doc("For resource version")
model WithVersion {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The version of a resource definition")
  version: string;
}

@doc("For tracking he status of the last operation.")
model WithProvisioningState {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("For resource definition content")
model WithDefinitionContent {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Need flexibly content to match various use-cases"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The JSON content for defining a resource")
  definitionContent: Record<unknown>;
}

@doc("For Workspace managed identity")
model DiscoveryResourceProperties {
  ...WithProvisioningState;
  ...WithVersion;
}

@doc("For user assigned identity resource property.")
model Identity {
  @doc("The resource ID of the user assigned identity.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  id: Microsoft.Discovery.Shared.UserAssignedIdentityId;

  ...Azure.ResourceManager.CommonTypes.UserAssignedIdentity;
}

@removed(Versions.v2026_02_01_preview)
@doc("The kind of the credential used for RBAC against the store.")
union CredentialType {
  @doc("Managed identity credential kind.")
  ManagedIdentity: "ManagedIdentity",

  @doc("Secret stored in KeyVault secret kind.")
  KeyVaultSecret: "KeyVaultSecret",

  string,
}

@discriminator("kind")
@removed(Versions.v2026_02_01_preview)
@doc("An abstract representation of credential kind.")
model Credential {
  /** Name of credential */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The credential kind.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: CredentialType;

  ...Microsoft.Discovery.Shared.WithDescription;
}

@doc("The managed identity credential properties.")
@removed(Versions.v2026_02_01_preview)
model ManagedIdentityCredential extends Credential {
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: CredentialType.ManagedIdentity;

  @doc("The managed identity client Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  identityId?: Microsoft.Discovery.Shared.UserAssignedIdentityId;
}

/** For associated Azure NetApp Files volume ID */
@added(Versions.v2026_02_01_preview)
model WithNetAppVolumeId {
  @doc("The associated Azure NetApp Files volume ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  netAppVolumeId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;
}

@doc("Secret credential properties")
@removed(Versions.v2026_02_01_preview)
model KeyVaultSecretCredential extends Credential {
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: CredentialType.KeyVaultSecret;

  @doc("The secret name.")
  @secret
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  secretName: string;
}

/** For associated azure storage account ID */
model WithStorageAccountId {
  @doc("The associated azure storage account ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

@doc("Standard Discovery resource interface")
interface DiscoveryResource<
  T extends Azure.ResourceManager.Foundations.TrackedResource,
  P extends {},
  L extends {} = T
> {
  get is ArmResourceRead<T>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<T>;
  update is ArmResourcePatchAsync<T, P>;
  delete is ArmResourceDeleteWithoutOkAsync<T>;
  listByResourceGroup is ArmResourceListByParent<T>;
  listBySubscription is ArmListBySubscription<T>;
}

@doc("State of customer managed key usage.")
@added(Versions.v2026_02_01_preview)
union CustomerManagedKeys {
  string,

  @doc("Customer managed keys are enabled.")
  Enabled: "Enabled",

  @doc("Customer managed keys are disabled.")
  Disabled: "Disabled",
}

@doc("For Key Vault Key references")
@added(Versions.v2026_02_01_preview)
model KeyVaultProperties {
  @doc("The Key Vault URI")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultUri: url;

  @doc("The Key Name in Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyName: string;

  @doc("The Key Version in Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyVersion?: string;
}

@doc("For Key Vault Key references with identity reference")
@added(Versions.v2026_02_01_preview)
model KeyVaultWithIdentityReferenceProperties is KeyVaultProperties {
  @doc("The identity to use for accessing the Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity: Microsoft.Discovery.Identity;
}

@doc("State of public network access.")
@added(Versions.v2026_02_01_preview)
union PublicNetworkAccess {
  string,

  @doc("Public network access is enabled.")
  Enabled: "Enabled",

  @doc("Public network access is disabled.")
  Disabled: "Disabled",
}
