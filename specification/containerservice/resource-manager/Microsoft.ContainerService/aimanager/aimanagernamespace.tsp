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
  @doc("Returns the namespace-scoped LLM gateway endpoint and the current API keys.")
  @post
  @action("listAccessKeys")
  listAccessKeys is ArmResourceActionSync<
    AIManagerNamespace,
    void,
    ArmResponse<NamespaceAccessInfo>
  >;

  @added(Versions.v2026_05_02_preview)
  @doc("Rotates the namespace-scoped LLM gateway API keys. A new key is generated and installed as `primaryKey`, and the previous `primaryKey` overwrites `secondaryKey` so clients can roll over without downtime. Returns the updated access info.")
  @post
  @action("rotateKeys")
  rotateKeys is ArmResourceActionSync<
    AIManagerNamespace,
    void,
    ArmResponse<NamespaceAccessInfo>
  >;
}

@added(Versions.v2026_05_02_preview)
@doc("Access information for an AI Manager namespace, including the OpenAI-compatible gateway endpoint and the API keys used to authenticate against it.")
model NamespaceAccessInfo {
  @visibility(Lifecycle.Read)
  @doc("OpenAI-compatible inference gateway base URL (for example, `https://team-alpha.<cluster>.<region>.aksapp.io/v1`).")
  endpoint: url;

  @visibility(Lifecycle.Read)
  @secret
  @doc("Primary API key. Send as `Authorization: Bearer <key>` or `api-key: <key>`. Treat as secret; do not log or persist in plaintext.")
  primaryKey: string;

  @visibility(Lifecycle.Read)
  @secret
  @doc("Secondary API key, accepted by the gateway in the same headers as `primaryKey`. Generated independently when the namespace is created, then overwritten by the previous `primaryKey` on each `rotateKeys` call so clients can roll over without downtime. Treat as secret; do not log or persist in plaintext.")
  secondaryKey: string;

  @visibility(Lifecycle.Read)
  @doc("UTC time the keys were last rotated by `rotateKeys`. Absent until the first rotation. Clients can use this to detect rotation and refresh cached credentials.")
  lastRotatedAt?: utcDateTime;
}

@@maxLength(AIManagerNamespace.name, 63);
@@minLength(AIManagerNamespace.name, 1);
@@doc(
  AIManagerNamespace.name,
  "The name of the AI Manager namespace resource."
);
