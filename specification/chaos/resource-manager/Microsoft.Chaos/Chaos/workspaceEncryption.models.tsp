import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * The requested key setting and the service-owned encryption observations.
 * A template instance keeps the object's PUT default in the generated schema.
 * @template KeySource The supported key-source type.
 */
@added(Versions.v2026_11_01)
model WorkspaceEncryption<KeySource extends string> {
  /**
   * The requested key source. Microsoft.Keyvault requires keyVaultProperties.
   * Microsoft.Storage requires keyVaultProperties to be absent.
   * Unsupported key sources are rejected.
   */
  keySource: KeySource;

  /** The customer key reference. Omit this object for Microsoft-managed protection. */
  keyVaultProperties?: WorkspaceEncryptionKeyVaultProperties;

  /** The service application used for customer consent, available before enrollment. */
  @visibility(Lifecycle.Read)
  identity?: WorkspaceEncryptionIdentity;

  /** The observed result, separate from the requested setting. */
  @visibility(Lifecycle.Read)
  status?: WorkspaceEncryptionStatus;
}

/** The key sources supported for Workspace encryption. */
@added(Versions.v2026_11_01)
union WorkspaceEncryptionKeySource {
  string,

  /** Use a customer-managed key in Azure Key Vault. */
  MicrosoftKeyvault: "Microsoft.Keyvault",

  /** Use a Microsoft-managed key. */
  MicrosoftStorage: "Microsoft.Storage",
}

/** A customer-managed key reference, not key material. */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionKeyVaultProperties {
  /**
   * The versionless HTTPS Key Vault key URI in the supported cloud and Workspace
   * tenant. A key version, query string, or fragment is not permitted.
   * Azure Storage follows key versions automatically. Keep the previous version
   * available for at least 24 hours after rotation.
   */
  keyUri: WorkspaceEncryptionKeyUri;
}

/** A versionless HTTPS Key Vault key URI; the service also validates cloud and tenant. */
@added(Versions.v2026_11_01)
@pattern("^https://[a-zA-Z0-9-]+\\.vault\\.[a-zA-Z0-9.-]+/keys/[a-zA-Z0-9-]+$")
scalar WorkspaceEncryptionKeyUri extends url;

/** The service application that the customer authorizes to use the key. */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionIdentity {
  /** The Microsoft Entra application ID of the service application for customer consent. */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  applicationId: string;
}

/** Service observations of the active encryption setting and customer-data access. */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionStatus {
  /** The result of configuration or the most recent usable health observation. */
  @visibility(Lifecycle.Read)
  state: WorkspaceEncryptionState;

  /** The last directly observed active key source. Omitted when unknown. */
  @visibility(Lifecycle.Read)
  observedKeySource?: WorkspaceEncryptionKeySource;

  /**
   * The active key URI reported by Azure Storage, including its version when
   * available. Omitted when unknown or when protection is Microsoft-managed.
   * This value is not inferred from the requested key.
   */
  @visibility(Lifecycle.Read)
  observedKeyUri?: url;

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
 * writable field. The complete merged setting must have a supported keySource
 * and matching key properties. Read-only identity and status inputs are ignored.
 */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionUpdate {
  /**
   * The requested key source. Null deletes the source; a remaining encryption
   * object without a source is invalid. Switching to Microsoft.Storage also
   * requires deletion of any existing keyVaultProperties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete keySource. The merged configuration is validated before mutation."
  keySource?: WorkspaceEncryptionKeySource;

  /** The key properties to merge. Null deletes the key properties. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete customer-key properties when switching to Microsoft-managed protection."
  keyVaultProperties?: WorkspaceEncryptionKeyVaultPropertiesUpdate;
}

/** A partial customer key reference, validated after merging with the stored setting. */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionKeyVaultPropertiesUpdate {
  /**
   * The replacement versionless key URI. Omission retains the URI; null deletes
   * it. A remaining customer-key configuration without a valid URI is rejected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete keyUri. An invalid merged configuration is rejected before mutation."
  keyUri?: WorkspaceEncryptionKeyUri;
}
