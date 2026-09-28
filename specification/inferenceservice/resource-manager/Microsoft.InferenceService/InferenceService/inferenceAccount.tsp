import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Versioning;

namespace Microsoft.InferenceService;

/** An inference service account resource for managing inference workloads. */
model InferenceAccount is TrackedResource<InferenceAccountProperties> {
  ...ResourceNameParameter<
    InferenceAccount,
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$"
  >;
}

// Design note: this properties bag had no writable fields in 2026-01-15-preview.
// Key-based authentication configuration becomes writable in 2026-08-01-preview.
/** Read-only properties of an inference service account. */
model InferenceAccountProperties {
  /** The REST endpoint for the inference account */
  @visibility(Lifecycle.Read)
  endpoint?: url;

  /** Provisioning state of the inference account */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Whether key-based authentication is enabled for the inference account. */
  @added(Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  enableKeyBasedAuthentication?: boolean;

  /** Metadata about the inference account's API keys, such as last-usage timestamps. */
  @added(Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  keysMetadata?: KeysMetadata;
}

/** The properties that can be updated on an inference service account. */
@added(Versions.v2026_08_01_preview)
model InferenceAccountUpdate is Azure.ResourceManager.Foundations.ResourceUpdateModel<
  InferenceAccount,
  InferenceAccountProperties
>;

/** The resource provisioning state. */
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is updating. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  string,
}

/** The type of API key to regenerate. */
@added(Versions.v2026_08_01_preview)
union KeyType {
  /** The primary API key. */
  Primary: "Primary",

  /** The secondary API key. */
  Secondary: "Secondary",

  string,
}

/** Metadata about the API keys of an inference account. */
@added(Versions.v2026_08_01_preview)
model KeysMetadata {
  /** The UTC timestamp of the last time the primary key was used. */
  @visibility(Lifecycle.Read)
  primaryKeyLastUsage?: utcDateTime;

  /** The UTC timestamp of the last time the secondary key was used. */
  @visibility(Lifecycle.Read)
  secondaryKeyLastUsage?: utcDateTime;
}

/** The API keys of an inference account. */
@added(Versions.v2026_08_01_preview)
model AccountKeysResult {
  /** The primary API key for the inference account. */
  @secret
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /** The secondary API key for the inference account. */
  @secret
  @visibility(Lifecycle.Read)
  secondaryKey?: string;
}

/** The request body for regenerating an inference account API key. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.v2026_08_01_preview)
model RegenerateApiKeyRequest {
  /** The type of API key to regenerate. */
  keyType: KeyType;

  /** When true, bypasses the key's last-usage validation when regenerating. Defaults to false when omitted. */
  bypassLastUsageCheck?: boolean;
}

@armResourceOperations
interface InferenceAccounts {
  get is ArmResourceRead<InferenceAccount>;
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InferenceAccount,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @TypeSpec.Http.sharedRoute
  @removed(Versions.v2026_08_01_preview)
  @renamedFrom(Versions.v2026_08_01_preview, "update")
  updateTags is ArmTagsPatchSync<InferenceAccount>;

  @TypeSpec.Http.sharedRoute
  @added(Versions.v2026_08_01_preview)
  update is ArmCustomPatchSync<InferenceAccount, InferenceAccountUpdate>;

  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    InferenceAccount,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
  listByResourceGroup is ArmResourceListByParent<InferenceAccount>;
  listBySubscription is ArmListBySubscription<InferenceAccount>;

  /** List the API keys for an inference account. */
  @added(Versions.v2026_08_01_preview)
  listKeys is ArmResourceActionSync<InferenceAccount, void, AccountKeysResult>;

  /** Regenerate an API key for an inference account. */
  @added(Versions.v2026_08_01_preview)
  regenerateKeys is ArmResourceActionSync<
    InferenceAccount,
    RegenerateApiKeyRequest,
    InferenceAccount
  >;
}
