import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.AI.AgentServer.Core.Storage;

/** Unix epoch seconds used by state-store timestamps. */
scalar FoundryTimestamp extends int64;

/** Standard Foundry error envelope. */
model ApiErrorResponse {
  /** The service error. */
  error: ApiError;
}

/** A service error. */
model ApiError {
  /** Machine-readable error code. */
  code: string;

  /** Human-readable error message. */
  message: string;

  /** For 400 responses, the name of the offending request field. */
  param?: string;
}

/** A first-class, explicitly-created durable key-value store. */
model StateStore {
  /** Server-assigned, read-only identifier. */
  id: string;

  /** The wire object type. */
  object: "state_store";

  /** Caller-chosen logical name. */
  name: string;

  /** Whether item operations are partitioned per resolved user. */
  @encodedName("application/json", "user_isolation")
  userIsolation: boolean;

  /** Store-wide default TTL in seconds. */
  @encodedName("application/json", "item_ttl_seconds")
  itemTtlSeconds: int32;

  /** Optional free-form description. */
  description?: string;

  /** Optional string-to-string labels. */
  tags?: Record<string>;

  /** Creation time in Unix epoch seconds. */
  @encodedName("application/json", "created_at")
  createdAt: FoundryTimestamp;

  /** Last metadata-update time in Unix epoch seconds. */
  @encodedName("application/json", "updated_at")
  updatedAt: FoundryTimestamp;
}

/** Request body for creating a state store. */
model CreateStateStoreRequest {
  /** The caller-chosen logical name. */
  name: string;

  /** Whether item operations are partitioned per resolved user. */
  @encodedName("application/json", "user_isolation")
  userIsolation?: boolean = false;

  /** Store-wide default TTL in seconds. */
  @encodedName("application/json", "item_ttl_seconds")
  itemTtlSeconds?: int32 = 2592000;

  /** Optional free-form description. */
  description?: string;

  /** Optional string-to-string labels. */
  tags?: Record<string>;
}

/** Request body for updating mutable state-store metadata. */
model UpdateStateStoreRequest {
  /** Optional replacement description. */
  description?: string;

  /** Optional replacement labels. */
  tags?: Record<string>;
}

/** Tombstone returned after deleting a state store. */
model DeletedStateStore {
  /** The server-assigned identifier when the state store existed. */
  id?: string;

  /** The wire object type. */
  object: "state_store";

  /** The logical state-store name. */
  name: string;

  /** Whether the state store was deleted. */
  deleted: boolean;
}

/** A single key-value record within a state store. */
model StateStoreItem {
  /** The server-assigned identifier. */
  id: string;

  /** The wire object type. */
  object: "state_store.item";

  /** The logical item key. */
  key: string;

  /** The opaque JSON object stored for the item. */
  value: Record<unknown>;

  /** Optional labels for filtering item keys. */
  tags?: Record<string>;

  /** The optimistic-concurrency token. */
  etag: Azure.Core.eTag;

  /** Creation time in Unix epoch seconds. */
  @encodedName("application/json", "created_at")
  createdAt: FoundryTimestamp;

  /** Last update time in Unix epoch seconds. */
  @encodedName("application/json", "updated_at")
  updatedAt: FoundryTimestamp;
}

/** Request body for creating a state-store item. */
model CreateItemRequest {
  /** The logical item key. */
  key: string;

  /** The opaque JSON object to store. */
  value: Record<unknown>;

  /** Optional labels for filtering item keys. */
  tags?: Record<string>;
}

/** Request body for creating or replacing a state-store item. */
model PutItemRequest {
  /** The opaque JSON object to store. */
  value: Record<unknown>;

  /** Optional replacement labels. */
  tags?: Record<string>;
}

/** Server metadata for a written state-store item. */
model StateStoreItemRef {
  /** The server-assigned identifier. */
  id: string;

  /** The wire object type. */
  object: "state_store.item";

  /** The logical item key. */
  key: string;

  /** The optimistic-concurrency token. */
  etag: Azure.Core.eTag;

  /** Creation time in Unix epoch seconds. */
  @encodedName("application/json", "created_at")
  createdAt: FoundryTimestamp;

  /** Last update time in Unix epoch seconds. */
  @encodedName("application/json", "updated_at")
  updatedAt: FoundryTimestamp;
}

/** Tombstone returned after deleting a state-store item. */
model DeletedStateStoreItem {
  /** The server-assigned identifier when the item existed. */
  id?: string;

  /** The wire object type. */
  object: "state_store.item";

  /** The logical item key. */
  key: string;

  /** Whether the item was deleted. */
  deleted: boolean;
}

/** A keys-only projection of a state-store item. */
model StateStoreItemKey {
  /** The server-assigned identifier. */
  id: string;

  /** The wire object type. */
  object: "state_store.item";

  /** The logical item key. */
  key: string;

  /** Optional labels for filtering item keys. */
  tags?: Record<string>;

  /** The optimistic-concurrency token. */
  etag: Azure.Core.eTag;

  /** Creation time in Unix epoch seconds. */
  @encodedName("application/json", "created_at")
  createdAt: FoundryTimestamp;

  /** Last update time in Unix epoch seconds. */
  @encodedName("application/json", "updated_at")
  updatedAt: FoundryTimestamp;
}

/** Sort order for state-store list requests. */
enum ListRequestOrder {
  /** Ascending order. */
  Asc: "asc",

  /** Descending order. */
  Desc: "desc",
}

/** A page of state stores. */
model ListResponseStateStore {
  /** The wire object type. */
  object: "list";

  /** The state stores in this page. */
  data: StateStore[];

  /** The first item identifier, or null for an empty page. */
  @encodedName("application/json", "first_id")
  firstId: string | null;

  /** The last item identifier, or null for an empty page. */
  @encodedName("application/json", "last_id")
  lastId: string | null;

  /** Whether another page is available. */
  @encodedName("application/json", "has_more")
  hasMore: boolean;
}

/** A page of state-store item keys. */
model ListResponseStateStoreItemKey {
  /** The wire object type. */
  object: "list";

  /** The state-store item keys in this page. */
  data: StateStoreItemKey[];

  /** The first item identifier, or null for an empty page. */
  @encodedName("application/json", "first_id")
  firstId: string | null;

  /** The last item identifier, or null for an empty page. */
  @encodedName("application/json", "last_id")
  lastId: string | null;

  /** Whether another page is available. */
  @encodedName("application/json", "has_more")
  hasMore: boolean;
}

@@usage(ApiErrorResponse, Usage.output);
@@access(ApiErrorResponse, Access.internal);
@@usage(ApiError, Usage.output);
@@access(ApiError, Access.internal);

@@usage(StateStore, Usage.output);
@@access(StateStore, Access.public);
@@usage(CreateStateStoreRequest, Usage.input);
@@access(CreateStateStoreRequest, Access.internal);
@@usage(UpdateStateStoreRequest, Usage.input);
@@access(UpdateStateStoreRequest, Access.internal);
@@usage(DeletedStateStore, Usage.output);
@@access(DeletedStateStore, Access.public);

@@usage(StateStoreItem, Usage.output);
@@access(StateStoreItem, Access.public);
@@usage(CreateItemRequest, Usage.input);
@@access(CreateItemRequest, Access.internal);
@@usage(PutItemRequest, Usage.input);
@@access(PutItemRequest, Access.internal);
@@usage(StateStoreItemRef, Usage.output);
@@access(StateStoreItemRef, Access.public);
@@usage(DeletedStateStoreItem, Usage.output);
@@access(DeletedStateStoreItem, Access.public);
@@usage(StateStoreItemKey, Usage.output);
@@access(StateStoreItemKey, Access.public);

@@usage(ListRequestOrder, Usage.input);
@@access(ListRequestOrder, Access.public);
@@usage(ListResponseStateStore, Usage.output);
@@access(ListResponseStateStore, Access.internal);
@@usage(ListResponseStateStoreItemKey, Usage.output);
@@access(ListResponseStateStoreItemKey, Access.internal);
