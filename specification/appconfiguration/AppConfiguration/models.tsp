import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AzureAppConfiguration;

@doc("Key-value fields.")
union KeyValueFields {
  @doc("Key field.")
  key: "key",

  @doc("Label field.")
  label: "label",

  @doc("Content type field.")
  content_type: "content_type",

  @doc("Value field.")
  value: "value",

  @doc("Last modified field.")
  last_modified: "last_modified",

  @doc("Tags field.")
  tags: "tags",

  @doc("Locked field.")
  locked: "locked",

  @doc("Etag field.")
  etag: "etag",

  string,
}

@doc("Snapshot fields.")
union SnapshotFields {
  @doc("Name field.")
  name: "name",

  @doc("Status field.")
  status: "status",

  @doc("Filters field.")
  filters: "filters",

  @doc("Composition type field.")
  composition_type: "composition_type",

  @doc("Created field.")
  created: "created",

  @doc("Expires field.")
  expires: "expires",

  @doc("Retention period field.")
  retention_period: "retention_period",

  @doc("Size field.")
  size: "size",

  @doc("Items count field.")
  items_count: "items_count",

  @doc("Tags field.")
  tags: "tags",

  @doc("Etag field.")
  etag: "etag",

  string,
}

@doc("Snapshot status.")
union SnapshotStatus {
  @doc("Provisioning")
  provisioning: "provisioning",

  @doc("Ready")
  ready: "ready",

  @doc("Archived")
  archived: "archived",

  @doc("Failed")
  failed: "failed",

  string,
}

@doc("Composition types.")
union CompositionType {
  @doc("The 'key' composition type.")
  key: "key",

  @doc("The 'key_label' composition type.")
  key_label: "key_label",

  string,
}

@doc("Label fields.")
union LabelFields {
  @doc("Name field.")
  name: "name",

  string,
}

@doc("The result of a list request.")
model KeyListResult {
  @doc("The collection value.")
  @pageItems
  items?: Key[];

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  `@nextLink`?: string;
}

@doc("Keys serve as identifiers for key-values and are used to store and retrieve corresponding values.")
@resource("keys")
model Key {
  @doc("The name of the key.")
  @key
  @visibility(Lifecycle.Read)
  name: string;
}

@doc("Azure App Configuration error object.")
@error
model Error {
  @doc("The type of the error.")
  type?: string;

  @doc("A brief summary of the error.")
  title?: string;

  @doc("The name of the parameter that resulted in the error.")
  name?: string;

  @doc("A detailed description of the error.")
  detail?: string;

  @doc("The HTTP status code that the error maps to.")
  status?: int32;
}

@doc("The result of a list request.")
model KeyValueListResult {
  @doc("The collection value.")
  @pageItems
  items?: KeyValue[];

  @doc("An identifier representing the returned state of the resource.")
  etag?: string;

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  `@nextLink`?: string;
}

@doc("A key-value pair representing application settings.")
@resource("kv")
model KeyValue {
  @key
  @visibility(Lifecycle.Read)
  @doc("The key of the key-value.")
  key: string;

  @doc("The label the key-value belongs to.")
  label?: string;

  @doc("The content type of the value stored within the key-value.")
  @encodedName("application/json", "content_type")
  contentType?: string;

  @doc("The value of the key-value.")
  value?: string;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Pre-existing API contract."
  @doc("A date representing the last time the key-value was modified.")
  @encodedName("application/json", "last_modified")
  lastModified?: offsetDateTime;

  @doc("The tags of the key-value")
  tags?: Record<string>;

  @doc("Indicates whether the key-value is locked.")
  locked?: boolean;

  @doc("A value representing the current state of the resource.")
  etag?: string;
}

@doc("The result of a snapshot list request.")
model SnapshotListResult {
  @doc("The collection value.")
  @pageItems
  items?: Snapshot[];

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  `@nextLink`?: string;
}

@doc("A snapshot is a named, immutable subset of an App Configuration store's key-values.")
@resource("snapshots")
model Snapshot {
  @key
  @doc("The name of the snapshot.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The current status of the snapshot.")
  @visibility(Lifecycle.Read)
  status?: SnapshotStatus;

  @doc("A list of filters used to filter the key-values included in the snapshot.")
  @minItems(1)
  @maxItems(3)
  filters: KeyValueFilter[];

  @doc("""
    The composition type describes how the key-values within the snapshot are
    composed. The 'key' composition type ensures there are no two key-values
    containing the same key. The 'key_label' composition type ensures there are no
    two key-values containing the same key and label.
    """)
  @encodedName("application/json", "composition_type")
  compositionType?: CompositionType;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Pre-existing API contract."
  @doc("The time that the snapshot was created.")
  @visibility(Lifecycle.Read)
  created?: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Pre-existing API contract."
  @doc("The time that the snapshot will expire.")
  @visibility(Lifecycle.Read)
  expires?: offsetDateTime;

  @doc("""
    The amount of time, in seconds, that a snapshot will remain in the archived
    state before expiring. This property is only writable during the creation of a
    snapshot. If not specified, the default lifetime of key-value revisions will be
    used.
    """)
  @maxValue(7776000)
  @minValue(3600)
  @encodedName("application/json", "retention_period")
  retentionPeriod?: int64;

  @doc("The size in bytes of the snapshot.")
  @visibility(Lifecycle.Read)
  size?: int64;

  @doc("The amount of key-values in the snapshot.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "items_count")
  itemsCount?: int64;

  @doc("The tags of the snapshot.")
  tags?: Record<string>;

  @doc("A value representing the current state of the snapshot.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@doc("""
  Enables filtering of key-values. Syntax reference:
  https://aka.ms/azconfig/docs/restapisnapshots
  """)
model KeyValueFilter {
  @doc("Filters key-values by their key field.")
  key: string;

  @doc("Filters key-values by their label field.")
  label?: string;

  @doc("Filters key-values by their tags field.")
  tags?: string[];
}

@doc("Parameters used to update a snapshot.")
model SnapshotUpdateParameters {
  @doc("The desired status of the snapshot.")
  status?: SnapshotStatus;
}

@doc("The result of a list request.")
model LabelListResult {
  @doc("The collection value.")
  @pageItems
  items?: Label[];

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  `@nextLink`?: string;
}

@doc("Labels are used to group key-values.")
model Label {
  @doc("The name of the label.")
  name?: string;
}

@doc("Details of a long running operation.")
model OperationDetails {
  @doc("The unique id of the operation.")
  id: string;

  @doc("The current status of the operation")
  status: Foundations.OperationState;

  @doc("""
    An error, available when the status is `Failed`, describing why the operation
    failed.
    """)
  error?: Foundations.Error;
}

alias SyncTokenHeader = {
  @doc("Used to guarantee real-time consistency between requests.")
  @header("Sync-Token")
  syncToken?: string;
};

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
alias ContentTypeHeader<T extends string> = {
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Avoiding creating a bunch of types for each content type."
  @doc("Content-Type header")
  @header("Content-Type")
  contentType?: T | "application/problem+json";
};

alias AppConfigResponseHeaders = {
  ...SyncTokenHeader;

  @doc("A value representing the current state of the resource.")
  @header("ETag")
  etagHeader?: string;
};

alias AfterHeader = {
  @doc("""
    Instructs the server to return elements that appear after the element referred
    to by the specified token.
    """)
  @query("After")
  after?: string;
};

alias AcceptDatetimeHeader = {
  @doc("""
    Requests the server to respond with the state of the resource at the specified
    time.
    """)
  @header("Accept-Datetime")
  acceptDatetime?: string;
};

alias SelectQueryParam<Type extends TypeSpec.Reflection.Model | string> = {
  @doc("Used to select what fields are present in the returned resource(s).")
  @query("$Select")
  select?: Type[];
};

alias NameQueryParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @query("name")
  name?: string;
};

alias KeyQueryParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @query("key")
  key?: string;
};

alias IfMatchHeader = {
  @doc("""
    Used to perform an operation only if the targeted resource's etag matches the
    value provided.
    """)
  @header("If-Match")
  ifMatch?: string;
};

alias IfNoneMatchHeader = {
  @doc("""
    Used to perform an operation only if the targeted resource's etag does not
    match the value provided.
    """)
  @header("If-None-Match")
  ifNoneMatch?: string;
};

alias KeyPathParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @path
  key: string;
};

alias LabelQueryParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @query("label")
  label?: string;
};

alias SnapshotOptionalQueryParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @query("snapshot")
  snapshot?: string;
};

alias TagsQueryParam<TDoc extends valueof string> = {
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract."
  @doc(TDoc)
  @query(#{ name: "tags", explode: true })
  tags?: string[];
};

alias LinkHeader = {
  @doc("Includes links to related resources.")
  @header("Link")
  link?: string;
};

alias NamePathParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @maxLength(256)
  @path
  name: string;
};
