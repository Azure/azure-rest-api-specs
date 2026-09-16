import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/** The requested customer key, onboarding information, and service observations. */
@added(Versions.v2026_11_01)
model WorkspaceEncryption {
  /**
   * The requested customer-managed key. Absence means Microsoft-managed
   * protection. A present object must contain a valid keyEncryptionKeyUrl.
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
   * the Workspace. The service verifies the tenant as the first remote stage
   * of the configuration operation, before persisting requested encryption
   * state or changing Azure Storage or customer data.
   * A key version, query string, or fragment is not permitted.
   * Azure Storage follows key versions automatically. Keep the previous version
   * available for at least 24 hours after rotation.
   */
  keyEncryptionKeyUrl: WorkspaceKeyEncryptionKeyUrl;
}

/** A versionless HTTPS Key Vault key URI; the service also validates cloud and tenant. */
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
   * then consent and grant key access. GET returns the same application ID.
   * This is not a service principal object ID or an identity selector.
   * The Workspace's top-level identity does not select this application.
   */
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
 * valid key URL. Read-only onboarding and status inputs are ignored.
 */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionUpdate {
  /**
   * The customer key configuration to merge. Null deletes the object and
   * requests Microsoft-managed protection. An empty object retains an existing
   * key URL but is invalid when no key URL exists after merging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete customer-key properties when switching to Microsoft-managed protection."
  customerManagedKeyEncryption?: WorkspaceCustomerManagedKeyEncryptionUpdate;
}

/** A partial customer key reference, validated after merging with the stored setting. */
@added(Versions.v2026_11_01)
model WorkspaceCustomerManagedKeyEncryptionUpdate {
  /**
   * The replacement versionless key URI. Omission retains the URI; null deletes
   * it. A remaining customer-key configuration without a valid URI is rejected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete keyEncryptionKeyUrl. A remaining CMK object without a URL is rejected before mutation."
  keyEncryptionKeyUrl?: WorkspaceKeyEncryptionKeyUrl;
}
