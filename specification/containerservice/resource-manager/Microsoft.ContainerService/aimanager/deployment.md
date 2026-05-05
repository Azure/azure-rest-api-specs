# API Design: ModelSource / AIModel / ModelDeployment / calculateCost

**Date**: 2026-04-22
**Status**: Draft

---

## 1. Resource model

### 1.1 Resource hierarchy

The `AIManager` resource and the `AIManagerNamespace` child already
exist in `Microsoft.ContainerService` (see `specification/containerservice/.../aimanager`).
`AIModel` is added as a **top-level tracked resource** under the same RP,
at the same level as `aiManagers` (resource-group-scoped, not nested
under an AIManager). `ModelSource` and `ModelDeployment` remain nested.

```
Microsoft.ContainerService/
  aiModels/{aiModelName}                          # RG-scoped (top-level, sibling of aiManagers)
  aiManagers/{aiManagerName}
    /modelSources/{modelSourceName}               # AIManager-scoped (proxy resource)
    /namespaces/{namespaceName}                   # AIManager-scoped (existing AIManagerNamespace)
      /modelDeployments/{modelDeploymentName}     # Namespace-scoped (proxy resource)
```

### 1.2 Shared type definitions

TypeSpec-style pseudocode. JSON is camelCase; enum values are PascalCase
strings per ARM guidelines. Visibility annotations mirror the existing
`aimanager.tsp` style (`@visibility(Lifecycle.Read)`).

```typespec
// The ARM resource id of an AIModel.
scalar AIModelResourceId extends Azure.Core.armResourceIdentifier<[
  { type: "Microsoft.ContainerService/aiModels" }
]>;

// The ARM resource id of an AIManager.
scalar AIManagerResourceId extends Azure.Core.armResourceIdentifier<[
  { type: "Microsoft.ContainerService/aiManagers" }
]>;

// The ARM resource id of a ModelSource.
scalar ModelSourceResourceId extends Azure.Core.armResourceIdentifier<[
  { type: "Microsoft.ContainerService/aiManagers/modelSources" }
]>;

// The ARM resource id of a model that can be deployed by a
// `ModelDeployment`. Phase 1 supports `AIModel` only; additional
// resource types (e.g. a future `BYOModel`) may be added later
// without breaking existing clients.
union ModelReferenceResourceId {
  string,
  AIModelResourceId,
}
```

---

## 2. End-to-end flows

Two primary user journeys drive the API surface. The detailed REST
contracts for each resource live in the sections that follow; the
flows below show how the pieces fit together at a glance.

### 2.1 ModelDeployment creation from a builtin model

1. Pick an `AIModel` from the platform catalog list.
2. Create a new `AIManager`, `Namespace` or reuse an existing one.
3. *(Optional)* Pick a `ModelSource` for gated models that require
   credentials.
4. Continue with the [common deployment steps](#23-common-deployment-steps).

### 2.2 ModelDeployment creation from a BYO model *(designed, not implemented in phase 1)*

1. Create an `AIManager`, `Namespace`.
2. *(Optional)* Pick or create a `ModelSource` (e.g. private Hugging
   Face with an inline token).
3. Create an `BYOModel` referencing that `ModelSource`. Platform runs a
   pre-flight check that the model is supported and accessible, and
   populates `resolvedSpec`.
4. Continue with the [common deployment steps](#23-common-deployment-steps).

### 2.3 Common deployment steps

1. Call `calculateCost` and choose a `vmSize` from the ranked plans.
2. Fill in remaining `ModelDeployment` properties (e.g.
   `performanceMode`, `autoscaling`).
3. Platform runs a sync pre-flight check on create (model is accessible, etc.).
4. Submit the `ModelDeployment` and wait for the LRO to provision.
5. Call `listAccessInfo` and run OpenAI-compatible chat completion
   requests against the returned endpoint.

---

## 3. ModelSource

### 3.1 Purpose

Registers an external model registry (Hugging Face) and the
credentials the platform uses to pull artifacts from it. Phase 1 supports
Hugging Face only; Azure Container Registry (ACR) and generic OCI
registries will be introduced in a future phase.

### 3.2 Properties

```typespec
// The properties of a model source.
model ModelSourceProperties {
  // The status of the last operation.
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Required. Model source type. Constrains the legal authentication
  // kinds. Immutable after creation. Future: "AzureContainerRegistry"
  // and "OCI" will be added in a later phase.
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sourceType: ModelSourceType;

  // An optional, free-form description of the source.
  description?: string;

  // Credential the platform uses to authenticate to the source.
  // Optional for public sources (e.g. ungated Hugging Face models).
  credential?: CredentialValue;
}

// The type of a model source.
union ModelSourceType {
  string,
  // A Hugging Face model registry.
  HuggingFace: "HuggingFace",
}

// A credential value, discriminated by `type`. Phase 1 supports
// `Inline` only; `KeyVault` is reserved for a future phase.
union CredentialValue {
  inline: InlineCredential,
  // To be added in the future.
  keyVault: KeyVaultCredential,
}

@doc("A credential provided inline.")
model InlineCredential {
  @doc("The credential source.")
  type: "Inline";

  @doc("The access token, password, or other secret value.")
  @secret
  value: string;
}

@doc("A credential stored in Azure Key Vault.")
model KeyVaultCredential {
  @doc("The credential source.")
  type: "KeyVault";
  @doc("The URI of the secret in Azure Key Vault.")
  secretUri?: string;
}
```

### 3.3 REST operations

| Operation | Method | Path | Type |
|---|---|---|---|
| CreateOrReplace | `PUT` | `/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.ContainerService/aiManagers/{aiManagerName}/modelSources/{modelSourceName}` | Sync |
| Get | `GET` | same | Sync |
| Update | `PATCH` | same | Sync |
| Delete | `DELETE` | same | Sync |
| ListByAIManager | `GET` | `.../aiManagers/{aiManagerName}/modelSources` | Sync |

`If-Match` / `If-None-Match` headers are supported for ETag-based
concurrency control.

---

## 4. AIModel

### 4.1 Purpose

`AIModel` is a top-level resource (sibling of `aiManagers`), so the same
model can be reused across multiple AIManagers in the same
subscription/resource group.

They are platform-maintained models, auto-provisioned by the RP.

The AIModel resource `name` is the upstream model id (pattern
`^[A-Za-z0-9][A-Za-z0-9._-]*(/[A-Za-z0-9][A-Za-z0-9._-]*)?$`, 1–128
chars), for example `microsoft/Phi-4-mini-instruct`. The `/` must be
URL-encoded as `%2F` on the wire. Name resolution at deployment time
uses the full ARM resource id, so Catalog and UserRegistered names
coexist without ambiguity.

### 4.2 Properties

```typespec
// The properties of an AI model.
model AIModelProperties {

  // An optional, free-form description of the model.
  description?: string;

  // Read-only: platform-resolved specification. Populated from the
  // catalog for Catalog models, or resolved from the source (e.g.
  // Hugging Face `config.json`) for UserRegistered models.
  @visibility(Lifecycle.Read)
  resolvedSpec?: ResolvedModelSpec;
}

// The platform-resolved specification of a model. All fields are read-only.
model ResolvedModelSpec {
  // The license of the model, when known.
  license?: string;
  // Whether the model is gated and requires explicit access approval.
  gated?: boolean;
  // The maximum context length supported by the model, in tokens.
  maxContextLength: int32;
}
```

### 4.3 REST operations

`AIModel` is a top-level, resource-group-scoped resource. The path does
**not** include an AIManager segment.

| Operation | Method | Path | Type |
|---|---|---|---|
| Get | `GET` | same | Sync |
| ListByResourceGroup | `GET` | `/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.ContainerService/aiModels?$filter=source eq 'Catalog'` | Sync |
| ListBySubscription | `GET` | `/subscriptions/{sub}/providers/Microsoft.ContainerService/aiModels` | Sync |

---

## 5. ModelDeployment

### 5.1 Purpose

A running deployment of a model. The RP reconciles each
`ModelDeployment` into a KAITO `Workspace` (or `InferenceSet`) plus
GAIE `InferencePool` / `InferenceModel` in the target Kubernetes
namespace (matching the parent `AIManagerNamespace` name), and attaches
the model to that namespace's Gateway route.

The ModelDeployment `name` follows RFC 1123 label rules
(`^[a-z0-9]([-a-z0-9]*[a-z0-9])?$`, max 63 chars).

### 5.2 Properties

```typespec
// The properties of a model deployment.
model ModelDeploymentProperties {
  // The status of the last reconciliation.
  @visibility(Lifecycle.Read)
  provisioningState?: ModelDeploymentProvisioningState;

  // Required. Full ARM resource id of the model to deploy. Phase 1
  // accepts an `AIModel` resource id only; the union allows other
  // model resource types (e.g. a future `BYOModel`) to be added
  // without a breaking change. The referenced resource may live in
  // any resource group / subscription the caller has read access to.
  // Immutable after creation.
  @visibility(Lifecycle.Create, Lifecycle.Read)
  modelResourceId: ModelReferenceResourceId;

  // Optional. Full ARM resource id of a `ModelSource` to use when
  // pulling artifacts for this deployment. Immutable after
  // creation.
  @visibility(Lifecycle.Create, Lifecycle.Read)
  modelSourceResourceId?: ModelSourceResourceId;

  // Runtime performance mode. Default: "Balanced". Selects a default
  // engine/quantization combination; use `overrides` to pin values.
  performanceMode?: ModelDeploymentPerformanceMode = ModelDeploymentPerformanceMode.Balanced;

  // Required. Azure VM SKU used to host the deployment, e.g.
  // "Standard_NC96ads_A100_v4". Immutable after creation.
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vmSize: string;

  // Desired replica count. Default 1. Ignored when autoscaling.enabled=true.
  replicas?: int32 = 1;

  // The autoscaling configuration for the deployment.
  autoscaling?: AutoscalingProfile;

  // User overrides layered on top of profile resolution. Replace
  // semantics on PATCH: the entire map is replaced; set to `{}` to clear.
  overrides?: ModelDeploymentOverrides;

  // Read-only runtime status, populated once reconciliation begins.
  @visibility(Lifecycle.Read)
  status?: ModelDeploymentStatus;
}

// The provisioning state of a model deployment resource.
union ModelDeploymentProvisioningState {
  string,
  // Inherits the terminal states Succeeded | Failed | Canceled.
  ResourceProvisioningState,
  // Resource is being created.
  Creating: "Creating",
  // Resource is updating.
  Updating: "Updating",
  // Resource is deleting.
  Deleting: "Deleting",
}

// The runtime status of a model deployment. All fields are read-only
// and populated once reconciliation has started.
model ModelDeploymentStatus {
  // The inference endpoint URL exposed by the deployment, once ready.
  endpoint?: url;
  // The inference engine used to serve the model, e.g. "vllm".
  engine?: string;
  // The version of the inference engine, e.g. "0.17".
  engineVersion?: string;
  // The maximum model context length, in tokens, configured for this
  // deployment.
  maxModelLen?: int32;
  // The quantization level applied to the model weights, e.g. "fp16",
  // "awq-int4".
  quantization?: string;

  // The desired replica count reported by the controller.
  // If autoscaler is disabled, equals `properties.replicas`.
  // If autoscaler is enabled, this is the current target replica count.
  desiredReplicas?: int32;

  // The peak tokens per minute measured by live stress test.
  peakTokensPerMinute?: int32;

  // Estimated total time, in seconds, for the deployment to become
  // ready end-to-end (GPU node provisioning + image/weight pull +
  // engine warm-up). Surfaced so clients can show a progress hint
  // during the LRO; refined as reconciliation progresses.
  estimatedProvisionTimeSeconds?: int32;
}

// The runtime performance mode of a model deployment.
union ModelDeploymentPerformanceMode {
  string,
  // A balanced trade-off between latency and throughput (default).
  Balanced:    "Balanced",
  // Optimize for low request latency.
  Latency:     "Latency",
  // Optimize for high aggregate throughput.
  Throughput:  "Throughput",
}

// User overrides.
model ModelDeploymentOverrides {
  // Free-form override key/value pairs. Recognized keys are documented
  // per release.
  values?: Record<string>;
}

// The autoscaling configuration of a model deployment.
model AutoscalingProfile {
  // Whether autoscaling is enabled for this deployment.
  enabled?: boolean = false;
  // The minimum number of replicas when autoscaling is enabled.
  minReplicas?: int32 = 1;
  // The maximum number of replicas when autoscaling is enabled. If not
  // specified, the service derives a default from the subscription GPU
  // quota.
  maxReplicas?: int32;
}
```

### 5.3 REST operations

| Operation | Method | Path | Type |
|---|---|---|---|
| CreateOrReplace | `PUT` | `.../aiManagers/{aiManagerName}/namespaces/{namespaceName}/modelDeployments/{modelDeploymentName}` | **LRO** |
| Get | `GET` | same | Sync |
| Update | `PATCH` | same | Sync |
| Delete | `DELETE` | same | **LRO** (no `200 OK` terminal) |
| ListByAIManagerNamespace | `GET` | `.../namespaces/{namespaceName}/modelDeployments` | Sync |

`If-Match` / `If-None-Match` headers are supported.

LRO semantics follow ARM conventions:

- `PUT` returns `201 Created` with `Azure-AsyncOperation` and
  `Operation-Location` headers. `properties.provisioningState` advances
  `Creating | Updating → Succeeded | Failed | Canceled`.
- `DELETE` returns `202 Accepted` with the same async headers and
  completes with `204 No Content` after Kubernetes and GPU teardown.
- Terminal `provisioningState=Succeeded` means the Kubernetes resources
  have been applied. Runtime readiness is reflected by
  `properties.status` (`endpoint`, `readyReplicas`, ...) and can lag by
  several minutes while GPU nodes are provisioned and weights are
  pulled. Reconciliation failures surface in
  `properties.status.provisioningError`.
- `PUT` is idempotent: re-applying the same body is a no-op. Modifying
  an immutable field (`modelResourceId`, `modelSourceResourceId`,
  `vmSize`) returns `400 ImmutableField`.

---

## 6. calculateCost (resource action)

### 6.1 Purpose

Given an `AIModel`, return the GPU SKU options available to the caller,
each annotated with feasibility and projected compute cost. The action
is exposed on the `AIModel` resource itself — it does not require an
AIManager and can be called by anyone with read access to the model.
No Kubernetes or Azure resources are provisioned. The call is safe to
issue repeatedly as a lookup against Azure Retail Prices + subscription
quota.

The verb `calculate` and the request/response shape follow the Azure
precedent for "price this configuration before you buy it" actions,
specifically `Microsoft.Capacity/calculatePrice`
(`ReservationOrder_Calculate`) and `Microsoft.Capacity/calculateExchange`
in `specification/reservations/.../stable/2022-11-01/reservations.json`.
Azure reserves `estimate` for long-horizon forecasts
(`Microsoft.CostManagement/forecast`), which is not what this action
does.

### 6.2 Endpoint

```
POST /subscriptions/{sub}/resourceGroups/{rg}/providers/
     Microsoft.ContainerService/aiModels/{aiModelName}/calculateCost
```

### 6.3 Request / response

```typespec
model CalculateCostRequest {
  // Number of replicas to price. Default 1 when omitted.
  replicas?: int32 = 1;
}

model CalculateCostResponse {
  // Echoes the effective replica count used for totals.
  replicas: int32;

  // ISO 4217, e.g. "USD".
  currency: string;

  // Ranked list of GPU SKU pricing plans. Feasible plans first,
  // ordered by `totalHourlyPrice` ascending; infeasible plans last.
  // Scans all GPU SKUs known to the platform.
  @identifiers(#["vmSize"])
  plans: CalculateCostPlan[];
}

model CalculateCostPlan {
  // Azure VM SKU, e.g. "Standard_ND96isr_H100_v5". Matches the value
  // accepted by `ModelDeploymentProperties.vmSize`.
  vmSize: string;

  // Resolved quantization on this SKU. Different hardware may use
  // different quantization levels to fit the model.
  quantization?: string;

  // Number of cluster nodes required to host one replica on this SKU.
  vmsPerReplica: int32;

  // On-demand hourly price for a single node of this SKU, in `currency`.
  vmHourlyPrice: float64;

  // Projected hourly cost for `replicas * vmsPerReplica` nodes,
  // in `currency`. Omitted when the plan is infeasible.
  totalHourlyPrice?: float64;

  // Overrides the response-level `priceAsOf` if this SKU's price came
  // from a different snapshot.
  priceAsOf?: utcDateTime;

  // Whether the caller can actually deploy this plan today (region
  // availability, GPU quota, model fit, ...).
  feasible: boolean;

  // Machine-readable reason when `feasible=false`. Omitted when
  // `feasible=true`.
  infeasibleCode?: InfeasibleCode;

  // Human-readable message accompanying `infeasibleCode`, suitable for
  // surfacing directly in UI. Omitted when `feasible=true`.
  infeasibleMessage?: string;
}

// The reason a `CalculateCostPlan` is not deployable.
union InfeasibleCode {
  string,
  // The caller's subscription does not have enough GPU quota in the
  // target region to deploy this plan. Request a quota increase to
  // enable this option.
  InsufficientQuota:     "InsufficientQuota",
  // The VM SKU is not available in the target region.
  RegionUnavailable:     "RegionUnavailable",
  // The deployment can start successfully on this SKU, but its
  // measured runtime performance (e.g. throughput, latency) falls
  // below the acceptable threshold for serving this model. The plan
  // is returned for transparency but is not recommended.
  InefficientDeployment: "InefficientDeployment",
}
```

---

## 7. listAccessInfo (resource action)

### 7.1 Purpose

Returns the namespace-scoped LLM gateway endpoint together with the
API keys that clients use to authenticate against it. Scoped to an
`AIManagerNamespace` — each namespace has its own Gateway route and
its own key material.

The verb and shape follow the Azure precedent for "read a resource's
secret + connection info" actions. References:

- `Microsoft.CognitiveServices/accounts/listKeys`
  (`Accounts_ListKeys`) in
  `specification/cognitiveservices/.../stable/2022-10-01/cognitiveservices.json`
- `Microsoft.Storage/storageAccounts/listKeys`

### 7.2 Endpoint

```
POST /subscriptions/{sub}/resourceGroups/{rg}/providers/
     Microsoft.ContainerService/aiManagers/{aiManagerName}/
     namespaces/{namespaceName}/listAccessInfo
```

Synchronous. No request body.

### 7.3 Response

```typespec
model NamespaceAccessInfo {
  // OpenAI-compatible base URL, e.g.
  //   https://team-alpha.<cluster>.<region>.aksapp.io/v1
  endpoint: url;

  // Primary API key. Send as `Authorization: Bearer <key>` (or
  // `api-key: <key>`, depending on client). Treat as secret; do not
  // log or persist in plaintext.
  @secret
  primaryKey: string;

  // Secondary API key, for zero-downtime rotation. Same usage as
  // `primaryKey`.
  @secret
  secondaryKey: string;

  // UTC time the keys were last rotated. Clients can use this to
  // detect rotation and refresh cached credentials.
  lastRotatedAt?: utcDateTime;
}
```
