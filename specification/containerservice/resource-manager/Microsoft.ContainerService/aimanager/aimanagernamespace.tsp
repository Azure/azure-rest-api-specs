import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@doc("The AI Manager namespace resource.")
@resource("namespaces")
@parentResource(AIManager)
model AIManagerNamespace is ProxyResource<AIManagerNamespaceProperties> {
  ...ResourceNameParameter<
    Resource = AIManagerNamespace,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
  >;
  ...EntityTagProperty;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@doc("AI Manager namespace properties.")
model AIManagerNamespaceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: AIManagerNamespaceProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("Labels applied to the Kubernetes namespace.")
  labels?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("Annotations applied to the Kubernetes namespace.")
  annotations?: Record<string>;
}

@doc("The provisioning state of the AI Manager namespace resource.")
union AIManagerNamespaceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a namespace being created.")
  Creating: "Creating",

  @doc("The provisioning state of a namespace being updated.")
  Updating: "Updating",

  @doc("The provisioning state of a namespace being deleted.")
  Deleting: "Deleting",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
@armResourceOperations
interface AIManagerNamespaces {
  get is ArmResourceRead<AIManagerNamespace>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AIManagerNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<AIManagerNamespace> &
      IfMatchParameters<AIManagerNamespace> &
      IfNoneMatchParameters<AIManagerNamespace>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    AIManagerNamespace,
    Azure.ResourceManager.Foundations.BaseParameters<AIManagerNamespace> &
      IfMatchParameters<AIManagerNamespace>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
  listByAIManager is ArmResourceListByParent<AIManagerNamespace>;

  @doc("Lists the credentials of an AI Manager namespace.")
  @post
  @action("listCredential")
  listCredential is ArmResourceActionSync<
    AIManagerNamespace,
    void,
    ArmResponse<CredentialResults>
  >;

  @added(Versions.v2026_05_02_preview)
  @doc("Returns the namespace-scoped LLM gateway endpoint and the API keys clients use to authenticate against it. Always use `primaryKey` for new requests; `secondaryKey`, when present, is only valid during a rotation grace period (see `updateKeyRotationPolicy`).")
  @post
  @action("listAccessInfo")
  listAccessInfo is ArmResourceActionSync<
    AIManagerNamespace,
    void,
    ArmResponse<NamespaceAccessInfo>
  >;

  @added(Versions.v2026_05_02_preview)
  @doc("""
    Schedules a one-shot rotation of the namespace-scoped LLM gateway API keys and returns the persisted policy.

    Rotation behavior: at `nextRotationTime`, the controller generates a brand-new key and installs it as the new `primaryKey`; the prior `primaryKey` is demoted to `secondaryKey` and remains valid for `gracePeriod` to allow clients to roll over without downtime. After `gracePeriod` elapses, the demoted key is revoked and `secondaryKey` is cleared.

    Once the scheduled rotation has run, `nextRotationTime` is cleared (one-shot). Call this operation again to schedule the next rotation. Omit `nextRotationTime` to disable any pending scheduled rotation.
    """)
  @post
  @action("updateKeyRotationPolicy")
  updateKeyRotationPolicy is ArmResourceActionSync<
    AIManagerNamespace,
    KeyRotationPolicy,
    ArmResponse<KeyRotationPolicy>
  >;
}

@added(Versions.v2026_05_02_preview)
@doc("Access information for an AI Manager namespace, including the OpenAI-compatible gateway endpoint and the API keys used to authenticate against it.")
model NamespaceAccessInfo {
  @doc("Inference gateway URL. OpenAI-compatible base URL, e.g. \"https://team-alpha.<cluster>.<region>.aksapp.io/v1\".")
  endpoint: url;

  @secret
  @doc("Primary API key. Clients should always authenticate with this key (send as `Authorization: Bearer <key>` or `api-key: <key>`). Treat as secret; do not log or persist in plaintext.")
  primaryKey: string;

  @secret
  @doc("Secondary API key. Present only during a key-rotation grace period: it is the previous `primaryKey`, kept valid temporarily to allow clients to migrate to the new `primaryKey` without downtime. It is revoked once `gracePeriod` from the rotation elapses. Do not use for new requests; rotate clients to `primaryKey` as soon as possible.")
  secondaryKey?: string;

  @doc("UTC time the keys were last rotated. Clients can use this to detect rotation and refresh cached credentials.")
  lastRotatedAt?: utcDateTime;
}

@added(Versions.v2026_05_02_preview)
@doc("One-shot key rotation policy for the namespace-scoped LLM gateway API keys.")
model KeyRotationPolicy {
  @doc("UTC time at which the controller will perform a one-shot rotation of the API keys. Once the rotation has completed, this value is cleared. Omit to disable any pending scheduled rotation.")
  nextRotationTime?: utcDateTime;

  @doc("Duration during which the previous primary key remains valid as `secondaryKey` after a rotation, enabling zero-downtime client migration. ISO 8601 duration (e.g. `PT24H`, `P7D`). Defaults to `PT24H`.")
  gracePeriod?: duration;
}

@@maxLength(AIManagerNamespace.name, 63);
@@minLength(AIManagerNamespace.name, 1);
@@doc(
  AIManagerNamespace.name,
  "The name of the AI Manager namespace resource."
);
