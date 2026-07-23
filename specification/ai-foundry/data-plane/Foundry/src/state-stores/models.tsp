// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * ============================================================================
 * DRAFT — Foundry State Storage contract, adapted to the azure-rest-api-specs
 * Foundry data-plane convention (mirrors `../memory-stores/models.tsp`).
 *
 * This is a STARTING POINT staged for the Azure/azure-rest-api-specs PR. It has
 * NOT been compiled. Before opening the PR you MUST, inside a full specs clone:
 *   1. Register the opt-in key in `../common/servicepatterns.tsp`:
 *        state_stores_v1_preview: "StateStores=V1Preview",
 *      (added to the `FoundryFeaturesOptInKeys` union).
 *   2. `npx tsp compile .` from the Foundry `src` root and fix any diagnostics.
 *   3. Re-generate both SDKs (tsp-client) and reconcile the hand-written
 *      wrappers — generated model SHAPES change vs. the old self-contained
 *      contract (utcDateTime timestamps, Azure.Core paged results, preview
 *      header/opt-in envelope).
 *
 * Open items to verify on compile:
 *   - ETag response header + If-Match optimistic-concurrency (412) semantics
 *     are modelled here as request `@header`s + an alternate error; confirm the
 *     `FoundryDataPlaneRequiredPreviewOperation` template surfaces the response
 *     `ETag` header the way the real service returns it.
 *   - Verb choices (PATCH for update, PUT for putItem) against the template.
 *   - Whether deleted responses should keep the original `object` wire values
 *     ("state_store" / "state_store.item") — preserved here for fidelity with
 *     the real service — or adopt distinct ".deleted" discriminators like
 *     memory-stores does.
 * ============================================================================
 */
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const StateStoreRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.state_stores_v1_preview],
};

// ---------------------------------------------------------------------------
// Object-type discriminators (real wire values, preserved from the prose spec).
// ---------------------------------------------------------------------------

/** The `object` discriminator for a state-store resource. */
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
union StateStoreObjectType {
  stateStore: "state_store",
}

/** The `object` discriminator for a state-store item resource. */
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
union StateStoreItemObjectType {
  stateStoreItem: "state_store.item",
}

// ---------------------------------------------------------------------------
// 4.1 State Store resource
// ---------------------------------------------------------------------------

/** A first-class, explicitly-created durable key-value store (spec §2, §4.1). */
@doc("A first-class, explicitly-created durable key-value store.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStore {
  @doc("The object type, which is always 'state_store'.")
  object: StateStoreObjectType.stateStore;

  @doc("Server-assigned, read-only identifier. Not used for addressing (the `name` is).")
  id: string;

  @doc("Caller-chosen logical name. Unique within [project_id, agent_guid]. May contain `/` as a hierarchy separator. Immutable.")
  @minLength(1)
  @maxLength(128)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  @doc("Whether item operations are partitioned per resolved user. Omitted at create -> `false`. Immutable.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  user_isolation: boolean = false;

  @doc("Store-wide default TTL (seconds) inherited by every item, write-sliding per item. `-1` = never expire. Immutable.")
  @minValue(-1)
  @maxValue(2147483647)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  item_ttl_seconds: int32 = 2592000;

  @doc("Optional free-form description. Mutable via `updateStateStore`.")
  @maxLength(1024)
  description?: string;

  @doc("Optional string-to-string labels. Mutable (replaced wholesale) via `updateStateStore`.")
  tags?: Record<string>;

  @doc("The Unix timestamp (seconds) when the store was created.")
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the store metadata was last updated.")
  updated_at: FoundryTimestamp;
}

/** Response for `deleteStateStore` (spec §4.1.5). Idempotent. */
@doc("Response for deleting a state store.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model DeletedStateStore {
  @doc("The object type, which is always 'state_store'.")
  object: StateStoreObjectType.stateStore;

  @doc("Present when the store existed; absent when the delete was a no-op (already gone).")
  id?: string;

  @doc("The name of the state store.")
  name: string;

  @doc("Whether the state store was deleted. Always `true`.")
  deleted: boolean;
}

// ---------------------------------------------------------------------------
// 4.2 Item resource
// ---------------------------------------------------------------------------

/** A single `key -> value` record within a state store (spec §2, §4.2). */
@doc("A single key -> value record within a state store.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStoreItem {
  @doc("The object type, which is always 'state_store.item'.")
  object: StateStoreItemObjectType.stateStoreItem;

  @doc("Server-assigned, read-only identifier. Not used for addressing (the `key` is).")
  id: string;

  @doc("Logical key, unique within the store. May contain `/`.")
  @minLength(1)
  @maxLength(128)
  key: string;

  @doc("Opaque JSON object; stored and returned verbatim. <= 1 MB serialized inline.")
  value: Record<unknown>;

  @doc("Optional labels used to filter `listKeys`. Replaced wholesale on write.")
  tags?: Record<string>;

  @doc("Optimistic-concurrency token for this item; also echoed in the `ETag` response header.")
  etag: string;

  @doc("The Unix timestamp (seconds) when the item was created.")
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the item was last updated.")
  updated_at: FoundryTimestamp;
}

/**
 * Response for `createItem` / `putItem` (spec §4.2.1/§4.2.2) — server metadata
 * only, no `value` echoed back.
 */
@doc("Server metadata for a written state-store item (no value echoed back).")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStoreItemRef {
  @doc("The object type, which is always 'state_store.item'.")
  object: StateStoreItemObjectType.stateStoreItem;

  @doc("Server-assigned, read-only identifier.")
  id: string;

  @doc("Logical key of the item.")
  key: string;

  @doc("Optimistic-concurrency token; also echoed in the `ETag` response header.")
  etag: string;

  @doc("The Unix timestamp (seconds) when the item was created.")
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the item was last updated.")
  updated_at: FoundryTimestamp;
}

/** Response for `deleteItem` (spec §4.2.4). Idempotent. */
@doc("Response for deleting a state-store item.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model DeletedStateStoreItem {
  @doc("The object type, which is always 'state_store.item'.")
  object: StateStoreItemObjectType.stateStoreItem;

  @doc("Present when the item existed; absent when the delete was a no-op (already gone).")
  id?: string;

  @doc("Logical key of the item.")
  key: string;

  @doc("Whether the item was deleted. Always `true`.")
  deleted: boolean;
}

/** A keys-only projection entry returned by `listKeys` (spec §4.2.5) — never includes `value`. */
@doc("A keys-only projection of a state-store item (never includes the value).")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStoreItemKey {
  @doc("The object type, which is always 'state_store.item'.")
  object: StateStoreItemObjectType.stateStoreItem;

  @doc("Server-assigned, read-only identifier.")
  id: string;

  @doc("Logical key of the item.")
  key: string;

  @doc("Optional labels associated with the item.")
  tags?: Record<string>;

  @doc("Optimistic-concurrency token for this item.")
  etag: string;

  @doc("The Unix timestamp (seconds) when the item was created.")
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the item was last updated.")
  updated_at: FoundryTimestamp;
}

// ---------------------------------------------------------------------------
// Request envelopes (path + query + header + body), one alias per operation.
// Non-@path/@query/@header fields form the JSON request body.
// ---------------------------------------------------------------------------

alias CreateStateStoreRequest = {
  @doc("Required. Unique within [project_id, agent_guid].")
  @minLength(1)
  @maxLength(128)
  name: string;

  @doc("Optional. Omitted -> `false` (agent-level, shared). Fixed at create.")
  user_isolation?: boolean = false;

  @doc("Optional. Default 30 days (2592000). `-1` = never expire. Fixed at create.")
  @minValue(-1)
  @maxValue(2147483647)
  item_ttl_seconds?: int32 = 2592000;

  @doc("Optional free-form description.")
  @maxLength(1024)
  description?: string;

  @doc("Optional string-to-string labels.")
  tags?: Record<string>;
};

alias ListStateStoresRequest = {
  ...CommonPageQueryParameters;
};

alias GetStateStoreRequest = {
  @doc("The name of the state store to retrieve.")
  @path
  state_store: string;
};

alias UpdateStateStoreRequest = {
  @doc("The name of the state store to update.")
  @path
  state_store: string;

  @doc("Optional free-form description. A present value replaces the stored one.")
  @maxLength(1024)
  description?: string;

  @doc("Optional string-to-string labels. Replaced wholesale (not merged) when present.")
  tags?: Record<string>;
};

alias DeleteStateStoreRequest = {
  @doc("The name of the state store to delete.")
  @path
  state_store: string;
};

alias CreateItemRequest = {
  @doc("The name of the state store.")
  @path
  state_store: string;

  @doc("Trusted-only delegation header supplying the resolved end-user id for a user-isolated store.")
  @header("x-ms-user-id")
  user_id?: string;

  @doc("Logical key, unique within the store. May contain `/`.")
  @minLength(1)
  @maxLength(128)
  key: string;

  @doc("Opaque JSON object; stored and returned verbatim.")
  value: Record<unknown>;

  @doc("Optional labels used to filter `listKeys`.")
  tags?: Record<string>;
};

alias ListItemKeysRequest = {
  @doc("The name of the state store.")
  @path
  state_store: string;

  @doc("Optional, repeatable tag-equality filter, e.g. `tags.version=1`. AND-combined; omit to list every key.")
  @query
  tags?: Record<string>;

  @doc("Trusted-only delegation header supplying the resolved end-user id for a user-isolated store.")
  @header("x-ms-user-id")
  user_id?: string;

  ...CommonPageQueryParameters;
};

alias PutItemRequest = {
  @doc("The name of the state store.")
  @path
  state_store: string;

  @doc("The item key.")
  @path
  key: string;

  @doc("`\"<etag>\"` for a conditional write, or `\"*\"` to require the item already exists. Omit for unconditional last-write-wins.")
  @header("If-Match")
  if_match?: string;

  @doc("Trusted-only delegation header supplying the resolved end-user id for a user-isolated store.")
  @header("x-ms-user-id")
  user_id?: string;

  @doc("Opaque JSON object; stored and returned verbatim.")
  value: Record<unknown>;

  @doc("Optional labels used to filter `listKeys`.")
  tags?: Record<string>;
};

alias GetItemRequest = {
  @doc("The name of the state store.")
  @path
  state_store: string;

  @doc("The item key.")
  @path
  key: string;

  @doc("Trusted-only delegation header supplying the resolved end-user id for a user-isolated store.")
  @header("x-ms-user-id")
  user_id?: string;
};

alias DeleteItemRequest = {
  @doc("The name of the state store.")
  @path
  state_store: string;

  @doc("The item key.")
  @path
  key: string;

  @doc("`\"<etag>\"` for a conditional delete. Omit for unconditional delete.")
  @header("If-Match")
  if_match?: string;

  @doc("Trusted-only delegation header supplying the resolved end-user id for a user-isolated store.")
  @header("x-ms-user-id")
  user_id?: string;
};
