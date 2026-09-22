import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/** The validated requested key and vault reference, onboarding information, and service observations. */
@added(Versions.v2026_11_01)
model WorkspaceEncryption {
  /**
   * The requested customer-managed key. Absence means Microsoft-managed
   * protection. A present object requires a coherent keyEncryptionKeyUrl and
   * keyVaultResourceId pair. After synchronous caller and vault validation,
   * the accepted pair can be returned while configuration is Pending.
   * It does not prove that active data already uses the requested key.
   */
  customerManagedKeyEncryption?: WorkspaceCustomerManagedKeyEncryption;

  /** The service application used for customer consent, returned for existing Workspaces before enrollment. */
  @visibility(Lifecycle.Read)
  customerManagedKeyOnboarding?: WorkspaceCustomerManagedKeyOnboarding;

  /** The observed result, separate from the requested setting. */
  @visibility(Lifecycle.Read)
  status?: WorkspaceEncryptionStatus;
}

/** The last directly observed protection of active Workspace customer data. */
@added(Versions.v2026_11_01)
union WorkspaceEncryptionProtection {
  string,

  /** Active customer data uses customer-managed key protection. */
  CustomerManaged: "CustomerManaged",

  /** Active customer data uses Microsoft-managed key protection. */
  MicrosoftManaged: "MicrosoftManaged",
}

/** A customer-managed key reference, not key material. */
@added(Versions.v2026_11_01)
model WorkspaceCustomerManagedKeyEncryption {
  /**
   * The versionless HTTPS Key Vault key URI in the supported cloud and Workspace
   * tenant. The key vault must belong to the same Microsoft Entra tenant as
   * the Workspace. Its HTTPS origin must match the vault referenced by
   * keyVaultResourceId. The service validates the effective pair and caller
   * vault-read permission synchronously through Azure Resource Manager before
   * creating public operation metadata, accepting the configuration operation,
   * persisting requested encryption, or changing Storage or customer data.
   * Supports RSA keys in Azure Key Vault and RSA-HSM keys in Premium Key Vault,
   * with key sizes of 2048, 3072, or 4096 bits. Premium RSA-HSM keys use the same
   * vault URL. The separate Azure Managed HSM service is not supported;
   * Managed HSM endpoints are rejected before operation acceptance.
   * A key version, query string, or fragment is not permitted.
   * Azure Storage follows key versions automatically. Keep the previous version
   * available for at least 24 hours after rotation.
   */
  keyEncryptionKeyUrl: WorkspaceKeyEncryptionKeyUrl;

  /**
   * The fully qualified Azure resource ID of the key vault that contains the key.
   * Use /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName},
   * not a key child resource, Managed HSM, or URL. Full PUT with CMK and PATCH
   * that changes either CMK member require Microsoft.KeyVault/vaults/read on
   * the effective vault. The service compares its canonical ID, tenant, and
   * vault URI with the requested pair before accepting the operation.
   */
  keyVaultResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}

/**
 * A versionless HTTPS Azure Key Vault key URI, including Premium-vault RSA-HSM
 * keys. Azure Managed HSM endpoints are not supported. The service also
 * validates the cloud host allowlist and tenant; a vault URL does not identify
 * the key type.
 */
@added(Versions.v2026_11_01)
@pattern("^https://[a-zA-Z0-9-]+\\.vault\\.[a-zA-Z0-9.-]+/keys/[a-zA-Z0-9-]+$")
scalar WorkspaceKeyEncryptionKeyUrl extends url;

/** The service application that the customer authorizes to use the key. */
@added(Versions.v2026_11_01)
model WorkspaceCustomerManagedKeyOnboarding {
  /**
   * The Microsoft Entra application ID used for customer consent, returned for
   * existing Workspaces, including before customer-key enrollment. Before
   * creating a Workspace with a customer key, obtain the application name and
   * ID for the target cloud from the service onboarding documentation or Portal,
   * then consent and grant key access. The configuring caller separately needs
   * Microsoft.KeyVault/vaults/read on the referenced vault.
   * GET returns the same application ID.
   * This is not a service principal object ID or an identity selector.
   * The Workspace's top-level identity does not select this application.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  applicationId: string;
}

/** Service observations of protection and access for customer data under the Workspace encryption scope. */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionStatus {
  /** The result of configuration or the most recent usable health observation. */
  @visibility(Lifecycle.Read)
  state: WorkspaceEncryptionState;

  /** The last directly observed active protection. Omitted when unknown. */
  @visibility(Lifecycle.Read)
  observedProtection?: WorkspaceEncryptionProtection;

  /**
   * The active key URI reported by Azure Storage, including its version when
   * available. Omitted when unknown or when protection is Microsoft-managed.
   * This value is not inferred from the requested key.
   */
  @visibility(Lifecycle.Read)
  observedKeyEncryptionKeyUrl?: url;

  /** The UTC time of the observation, including a failed check. */
  @visibility(Lifecycle.Read)
  lastCheckedAt?: utcDateTime;

  /**
   * The configuration or health error. Failed state includes a code and message.
   * CustomerKeyAccessFailed means Azure Storage cannot use the customer key.
   * EncryptionConfigurationFailed means a service-side configuration step failed.
   * A more specific cause is included only when the platform response identifies it.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/** The observed encryption state; this does not replace Workspace provisioningState. */
@added(Versions.v2026_11_01)
union WorkspaceEncryptionState {
  string,

  /** No per-Workspace encryption configuration exists. Microsoft-managed protection applies. */
  NotConfigured: "NotConfigured",

  /** An encryption configuration operation is in progress. */
  Pending: "Pending",

  /** A fresh check confirms the requested setting and customer-data access, for either key source. */
  Applied: "Applied",

  /** An encryption configuration step or health check failed. See the error for corrective action. */
  Failed: "Failed",

  /** No usable fresh observation is available. */
  Unknown: "Unknown",
}

/**
 * A partial encryption setting. Omitted fields are unchanged and null deletes a
 * writable field. A remaining customerManagedKeyEncryption object must have a
 * coherent key URL and vault resource ID. Read-only onboarding and status
 * inputs are ignored. Changing either member requires synchronous caller and
 * vault validation of the merged pair, including any retained member.
 */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionUpdate {
  /**
   * The customer key configuration to merge. Null deletes the object and
   * requests Microsoft-managed protection. An empty object retains an existing
   * complete pair without a lookup when neither member changes, but is invalid
   * when the merged pair is incomplete. Whole-object removal does not require
   * a vault metadata lookup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete customer-key properties when switching to Microsoft-managed protection."
  customerManagedKeyEncryption?: WorkspaceCustomerManagedKeyEncryptionUpdate;
}

/** A partial customer key reference, validated after merging with the stored setting. */
@added(Versions.v2026_11_01)
model WorkspaceCustomerManagedKeyEncryptionUpdate {
  /**
   * The replacement versionless key URI. Omission retains the URI; null deletes
   * it. A same-vault replacement retains the stored vault ID. The effective
   * pair is authorized and validated before acceptance; an incomplete or
   * mismatched pair is rejected. Key path and name casing is preserved.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete keyEncryptionKeyUrl. A remaining CMK object without a URL is rejected before mutation."
  keyEncryptionKeyUrl?: WorkspaceKeyEncryptionKeyUrl;

  /**
   * The vault resource ID to merge with the key URL. Omission retains the ID,
   * but does not bypass caller authorization when the URL changes. Null deletes
   * the ID; a remaining CMK object without both members is invalid. Changing
   * vault requires a coherent new URL and ID pair.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete keyVaultResourceId. A remaining CMK object without its vault ID is rejected before acceptance."
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}
