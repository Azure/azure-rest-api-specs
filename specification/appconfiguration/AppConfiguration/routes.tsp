import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureAppConfiguration;

@summary("Gets a list of keys.")
@doc("Gets a list of keys.")
@route("/keys")
@get
op getKeys is Azure.Core.Foundations.Operation<
  {
    @doc("A filter for the name of the returned keys.")
    @query("name")
    name?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.keyset+json, application/problem+json";
  },
  KeyListResult
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/keys")
@head
op checkKeys is Azure.Core.Foundations.Operation<
  {
    @doc("A filter for the name of the returned keys.")
    @query("name")
    name?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;
  },
  void
>;

@summary("Gets a list of key-values.")
@doc("Gets a list of key-values.")
@route("/kv")
@get
op getKeyValues is Azure.Core.Foundations.Operation<
  {
    @doc("""
A filter used to match keys. Syntax reference:
https://aka.ms/azconfig/docs/keyvaluefiltering
""")
    @query("key")
    key?: string;

    @doc("""
A filter used to match labels. Syntax reference:
https://aka.ms/azconfig/docs/keyvaluefiltering
""")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: KeyValueFields[];

    @doc("""
A filter used get key-values for a snapshot. The value should be the name of
the snapshot. Not valid when used with 'key' and 'label' filters.
""")
    @query("snapshot")
    snapshot?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    #suppress "@azure-tools/typespec-azure-core/prefer-csv-collection-format" "Pre-existing API contract"
    @doc("""
A filter used to query by tags. Syntax reference:
https://aka.ms/azconfig/docs/keyvaluefiltering
""")
    @query({
      name: "tags",
      format: "multi",
    })
    tags?: string[];

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kvset+json, application/problem+json";
  },
  KeyValueListResult
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/kv")
@head
op checkKeyValues is Azure.Core.Foundations.Operation<
  {
    @doc("""
A filter used to match keys. Syntax reference:
https://aka.ms/azconfig/docs/keyvaluefiltering
""")
    @query("key")
    key?: string;

    @doc("""
A filter used to match labels. Syntax reference:
https://aka.ms/azconfig/docs/keyvaluefiltering
""")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: KeyValueFields[];

    @doc("""
A filter used get key-values for a snapshot. Not valid when used with 'key' and
'label' filters.
""")
    @query("snapshot")
    snapshot?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    #suppress "@azure-tools/typespec-azure-core/prefer-csv-collection-format" "Pre-existing API contract"
    @doc("""
A filter used to query by tags. Syntax reference:
https://aka.ms/azconfig/docs/keyvaluefiltering
""")
    @query({
      name: "tags",
      format: "multi",
    })
    tags?: string[];
  },
  void
>;

@summary("Gets a single key-value.")
@doc("Gets a single key-value.")
@route("/kv/{key}")
@get
op getKeyValue is Azure.Core.Foundations.Operation<
  {
    @doc("The key of the key-value to retrieve.")
    @path
    key: string;

    @doc("The label of the key-value to retrieve.")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: KeyValueFields[];

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kv+json, application/problem+json";
  },
  KeyValue
>;

@summary("Creates a key-value.")
@doc("Creates a key-value.")
@route("/kv/{key}")
@put
op putKeyValue is Azure.Core.Foundations.Operation<
  {
    @doc("The key of the key-value to create.")
    @path
    key: string;

    @doc("The label of the key-value to create.")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("The key-value to create.")
    @body
    entity?: KeyValue;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kv+json, application/problem+json";
  },
  KeyValue
>;

@summary("Deletes a key-value.")
@doc("Deletes a key-value.")
@route("/kv/{key}")
@delete
op deleteKeyValue is Azure.Core.Foundations.Operation<
  {
    @doc("The key of the key-value to delete.")
    @path
    key: string;

    @doc("The label of the key-value to delete.")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kv+json, application/problem+json";
  },
  KeyValue | void
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/kv/{key}")
@head
op checkKeyValue is Azure.Core.Foundations.Operation<
  {
    @doc("The key of the key-value to retrieve.")
    @path
    key: string;

    @doc("The label of the key-value to retrieve.")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: KeyValueFields[];
  },
  void
>;

@summary("Gets a list of key-value snapshots.")
@doc("Gets a list of key-value snapshots.")
@route("/snapshots")
@get
op getSnapshots is Azure.Core.Foundations.Operation<
  {
    @doc("A filter for the name of the returned snapshots.")
    @query("name")
    name?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: SnapshotFields[];

    @doc("Used to filter returned snapshots by their status property.")
    @query({
      name: "status",
      format: "csv",
    })
    status?: SnapshotStatus[];

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.snapshotset+json, application/problem+json";
  },
  SnapshotListResult
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/snapshots")
@head
op checkSnapshots is Azure.Core.Foundations.Operation<
  {
    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;
  },
  void
>;

@summary("Gets a single key-value snapshot.")
@doc("Gets a single key-value snapshot.")
@route("/snapshots/{name}")
@get
op getSnapshot is Azure.Core.Foundations.Operation<
  {
    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("The name of the key-value snapshot to retrieve.")
    @path
    name: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: SnapshotFields[];

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.snapshot+json, application/problem+json";
  },
  Snapshot
>;

@summary("Creates a key-value snapshot.")
@doc("Creates a key-value snapshot.")
@route("/snapshots/{name}")
@put
op createSnapshot is Azure.Core.Foundations.Operation<
  {
    @doc("The name of the key-value snapshot to create.")
    @maxLength(256)
    @path
    name: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("The key-value snapshot to create.")
    @body
    entity: Snapshot;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.snapshot+json, application/problem+json";
  },
  Snapshot
>;

@summary("Updates the state of a key-value snapshot.")
@doc("Updates the state of a key-value snapshot.")
@route("/snapshots/{name}")
@patch
op updateSnapshot is Azure.Core.Foundations.Operation<
  {
    @doc("The name of the key-value snapshot to update.")
    @path
    name: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("The parameters used to update the snapshot.")
    @body
    entity: SnapshotUpdateParameters;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.snapshot+json, application/problem+json";
  },
  Snapshot
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/snapshots/{name}")
@head
op checkSnapshot is Azure.Core.Foundations.Operation<
  {
    @doc("The name of the key-value snapshot to check.")
    @path
    name: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;
  },
  void
>;

@summary("Gets a list of labels.")
@doc("Gets a list of labels.")
@route("/labels")
@get
op getLabels is Azure.Core.Foundations.Operation<
  {
    @doc("A filter for the name of the returned labels.")
    @query("name")
    name?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: LabelFields[];

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.labelset+json, application/problem+json";
  },
  LabelListResult
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/labels")
@head
op checkLabels is Azure.Core.Foundations.Operation<
  {
    @doc("A filter for the name of the returned labels.")
    @query("name")
    name?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: LabelFields[];
  },
  void
>;

@summary("Locks a key-value.")
@doc("Locks a key-value.")
@route("/locks/{key}")
@put
op putLock is Azure.Core.Foundations.Operation<
  {
    @doc("The key of the key-value to lock.")
    @path
    key: string;

    @doc("The label, if any, of the key-value to lock.")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kv+json, application/problem+json";
  },
  KeyValue
>;

@summary("Unlocks a key-value.")
@doc("Unlocks a key-value.")
@route("/locks/{key}")
@delete
op deleteLock is Azure.Core.Foundations.Operation<
  {
    @doc("The key of the key-value to unlock.")
    @path
    key: string;

    @doc("The label, if any, of the key-value to unlock.")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag matches the
value provided.
""")
    @header("If-Match")
    ifMatch?: string;

    @doc("""
Used to perform an operation only if the targeted resource's etag does not
match the value provided.
""")
    @header("If-None-Match")
    ifNoneMatch?: string;

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kv+json, application/problem+json";
  },
  KeyValue
>;

@summary("Gets a list of key-value revisions.")
@doc("Gets a list of key-value revisions.")
@route("/revisions")
@get
op getRevisions is Azure.Core.Foundations.Operation<
  {
    @doc("""
A filter used to match keys. Syntax reference:
https://aka.ms/azconfig/docs/restapirevisions
""")
    @query("key")
    key?: string;

    @doc("""
A filter used to match labels. Syntax reference:
https://aka.ms/azconfig/docs/restapirevisions
""")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: KeyValueFields[];

    #suppress "@azure-tools/typespec-azure-core/prefer-csv-collection-format" "Pre-existing API contract"
    @doc("""
A filter used to query by tags. Syntax reference:
https://aka.ms/azconfig/docs/restapirevisions
""")
    @query({
      name: "tags",
      format: "multi",
    })
    tags?: string[];

    @doc("Accept header")
    @header
    accept: "application/vnd.microsoft.appconfig.kvset+json, application/problem+json";
  },
  KeyValueListResult
>;

@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/revisions")
@head
op checkRevisions is Azure.Core.Foundations.Operation<
  {
    @doc("""
A filter used to match keys. Syntax reference:
https://aka.ms/azconfig/docs/restapirevisions
""")
    @query("key")
    key?: string;

    @doc("""
A filter used to match labels. Syntax reference:
https://aka.ms/azconfig/docs/restapirevisions
""")
    @query("label")
    label?: string;

    @doc("Used to guarantee real-time consistency between requests.")
    @header("Sync-Token")
    syncToken?: string;

    @doc("""
Instructs the server to return elements that appear after the element referred
to by the specified token.
""")
    @query("After")
    after?: string;

    @doc("""
Requests the server to respond with the state of the resource at the specified
time.
""")
    @header("Accept-Datetime")
    acceptDatetime?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query({
      name: "$Select",
      format: "csv",
    })
    select?: KeyValueFields[];

    #suppress "@azure-tools/typespec-azure-core/prefer-csv-collection-format" "Pre-existing API contract"
    @doc("""
A filter used to query by tags. Syntax reference:
https://aka.ms/azconfig/docs/restapirevisions
""")
    @query({
      name: "tags",
      format: "multi",
    })
    tags?: string[];
  },
  void
>;

@summary("Gets the state of a long running operation.")
@doc("Gets the state of a long running operation.")
@route("/operations")
@get
op getOperationDetails is Azure.Core.Foundations.Operation<
  {
    @doc("Snapshot identifier for the long running operation.")
    @query("snapshot")
    snapshot: string;
  },
  OperationDetails
>;
