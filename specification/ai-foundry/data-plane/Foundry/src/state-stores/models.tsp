// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const StateStoreRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.state_stores_v1_preview],
};

// ---------------------------------------------------------------------------
// 4.1 State Store resource
// ---------------------------------------------------------------------------

/** A first-class, explicitly-created durable key-value store (spec §2, §4.1). */
@doc("A first-class, explicitly-created durable key-value store.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStore {
  @doc("Server-assigned, read-only identifier. Not used for addressing (the `name` is).")
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the store metadata was last updated.")
  @visibility(Lifecycle.Read)
  updated_at: FoundryTimestamp;
}

/** Tombstone returned after deleting a state store. */
@doc("Tombstone returned after deleting a state store.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model DeletedStateStore {
  @doc("The server-assigned identifier when the state store existed.")
  id?: string;

  @doc("The logical name of the state store.")
  name: string;

  @doc("Whether the state store was deleted.")
  deleted: true;
}

// ---------------------------------------------------------------------------
// 4.2 Item resource
// ---------------------------------------------------------------------------

/** A single `key -> value` record within a state store (spec §2, §4.2). */
@doc("A single key -> value record within a state store.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStoreItem {
  @doc("Server-assigned, read-only identifier. Not used for addressing (the `key` is).")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Logical key, unique within the store. May contain `/`.")
  @minLength(1)
  @maxLength(128)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  key: string;

  @doc("Opaque JSON object; stored and returned verbatim. <= 1 MB serialized inline.")
  value: Record<unknown>;

  @doc("Optional labels used to filter `listKeys`. Replaced wholesale on write.")
  tags?: Record<string>;

  @doc("Optimistic-concurrency token for this item; also echoed in the `ETag` response header.")
  @visibility(Lifecycle.Read)
  etag: string;

  @doc("The Unix timestamp (seconds) when the item was created.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the item was last updated.")
  @visibility(Lifecycle.Read)
  updated_at: FoundryTimestamp;
}

/**
 * Response for `createItem` / `putItem` (spec §4.2.1/§4.2.2) — server metadata
 * only, no `value` echoed back.
 */
@doc("Server metadata for a written state-store item (no value echoed back).")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStoreItemRef is OmitProperties<
  Read<StateStoreItem>,
  "value" | "tags"
>;

/** A keys-only projection entry returned by `listKeys` (spec §4.2.5) — never includes `value`. */
@doc("A keys-only projection of a state-store item (never includes the value).")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model StateStoreItemKey is OmitProperties<Read<StateStoreItem>, "value">;

/** Tombstone returned after deleting a state-store item. */
@doc("Tombstone returned after deleting a state-store item.")
@extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
model DeletedStateStoreItem {
  @doc("The server-assigned identifier when the item existed.")
  id?: string;

  @doc("The logical key of the item.")
  key: string;

  @doc("Whether the item was deleted.")
  deleted: true;
}

// ---------------------------------------------------------------------------
// Request envelopes (path + query + header + body), one alias per operation.
// Non-@path/@query/@header fields form the JSON request body.
// ---------------------------------------------------------------------------

alias ListStateStoresRequest = {
  ...CommonPageQueryParameters;
};

alias GetStateStoreRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;
};

alias UpdateStateStoreRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;

  ...Update<StateStore>;
};

alias DeleteStateStoreRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;
};

alias CreateItemRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;

  ...Create<StateStoreItem>;
};

alias ListItemKeysRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;

  @doc("Optional tag-equality filters. SDKs serialize each entry as a `tags.<name>=<value>` query parameter and combine entries with AND semantics.")
  @query
  @extension("x-ms-foundry-query-prefix", "tags.")
  tags?: Record<string>;

  ...CommonPageQueryParameters;
};

alias PutItemRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;

  @doc("The logical item key. SDKs accept the unencoded key and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  key: string;

  @doc("`\"<etag>\"` for a conditional write, or `\"*\"` to require the item already exists. Omit for unconditional last-write-wins.")
  @header("If-Match")
  if_match?: string;

  ...Update<StateStoreItem>;
};

alias GetItemRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;

  @doc("The logical item key. SDKs accept the unencoded key and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  key: string;
};

alias DeleteItemRequest = {
  @doc("The logical name of the state store. SDKs accept the unencoded name and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  name: string;

  @doc("The logical item key. SDKs accept the unencoded key and apply base64url encoding without padding to the path segment.")
  @path
  @extension("x-ms-foundry-path-encoding", "base64url")
  @minLength(1)
  @maxLength(128)
  key: string;

  @doc("`\"<etag>\"` for a conditional delete. Omit for unconditional delete.")
  @header("If-Match")
  if_match?: string;
};

/** Response header returned with successful item reads and writes. */
alias StateStoreItemEtagResponseHeader = {
  @doc("The optimistic-concurrency token for the item. This value is identical to the `etag` property in the response body.")
  @header("ETag")
  etag_header: string;
};

/** Response for creating an item. */
alias CreateStateStoreItemResponse = ResourceCreatedResponse<StateStoreItemRef> &
  StateStoreItemEtagResponseHeader;

/** Response for replacing an existing item or creating a missing item. */
alias PutStateStoreItemResponse =
  | (Response<200> & StateStoreItemRef & StateStoreItemEtagResponseHeader)
  | (ResourceCreatedResponse<StateStoreItemRef> &
      StateStoreItemEtagResponseHeader);

/** Response for retrieving an item. */
alias GetStateStoreItemResponse = Response<200> &
  StateStoreItem &
  StateStoreItemEtagResponseHeader;

/** Error envelope for conditional item operations. The ETag header is returned on a 412 response when a current item exists. */
@error
model StateStoreConditionalErrorResponse {
  error: ApiError;

  @doc("The current optimistic-concurrency token when the request fails with 412 Precondition Failed and the item exists.")
  @header("ETag")
  etag_header?: string;
}
