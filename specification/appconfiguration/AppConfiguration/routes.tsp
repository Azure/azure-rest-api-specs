import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace AzureAppConfiguration;

alias appConfigOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError = Error
> = Foundations.Operation<
  TParams & ClientRequestIdHeader,
  TResponse,
  Traits,
  TError
>;

alias standardOps = ResourceOperations<
  SupportsClientRequestId & NoRepeatableRequests & NoConditionalRequests,
  Error
>;

alias syncTokenHeader = {
  @doc("Used to guarantee real-time consistency between requests.")
  @header("Sync-Token")
  syncToken?: string;
};

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
alias contentTypeHeader<T extends string> = {
  @doc("Content-Type header")
  @header("Content-Type")
  contentType?: T | "application/problem+json";
};

alias AppConfigResponseHeaders = {
  ...syncTokenHeader;

  @doc("A value representing the current state of the resource.")
  @header("ETag")
  etagHeader?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of keys.")
@doc("Gets a list of keys.")
op getKeys is Foundations.ResourceList<
  Key,
  {
    @doc("A filter for the name of the returned keys.")
    @query("name")
    name?: string;

    @doc("""
      Instructs the server to return elements that appear after the element referred
      to by the specified token.
      """)
    @query("After")
    after?: string;

    ...syncTokenHeader;

    @doc("""
      Requests the server to respond with the state of the resource at the specified
      time.
      """)
    @header("Accept-Datetime")
    acceptDatetime?: string;
  },
  KeyListResult & {
    ...syncTokenHeader;
    ...contentTypeHeader<"application/vnd.microsoft.appconfig.keyset+json">;
  },
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/keys")
@head
op checkKeys is appConfigOperation<
  {
    @doc("A filter for the name of the returned keys.")
    @query("name")
    name?: string;

    ...syncTokenHeader;

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
  OkResponse & {
    ...syncTokenHeader;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of key-values.")
@doc("Gets a list of key-values.")
op getKeyValues is Foundations.ResourceList<
  KeyValue,
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

    ...syncTokenHeader;

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
    @query("$Select")
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

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract"
    @doc("""
      A filter used to query by tags. Syntax reference:
      https://aka.ms/azconfig/docs/keyvaluefiltering
      """)
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  KeyValueListResult &
    AppConfigResponseHeaders &
    contentTypeHeader<"application/vnd.microsoft.appconfig.kvset+json">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/kv")
@head
op checkKeyValues is appConfigOperation<
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

    ...syncTokenHeader;

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
    @query("$Select")
    select?: KeyValueFields[];

    @doc("A filter used get key-values for a snapshot. Not valid when used with 'key' and 'label' filters.")
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

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract"
    @doc("""
      A filter used to query by tags. Syntax reference:
      https://aka.ms/azconfig/docs/keyvaluefiltering
      """)
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a single key-value.")
@doc("Gets a single key-value.")
@get
op getKeyValue is Foundations.ResourceOperation<
  Resource = KeyValue,
  Parameters = {
    @doc("The label of the key-value to retrieve.")
    @query("label")
    label?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query("$Select")
    select?: KeyValueFields[];
  } & {
    ...syncTokenHeader;

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

    ...ClientRequestIdHeader;
  },
  Response = Body<KeyValue> & {
    ...ClientRequestIdHeader;
    ...AppConfigResponseHeaders;
    ...contentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">;
  },
  Traits = {},
  ErrorResponse = Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Creates a key-value.")
@doc("Creates a key-value.")
@route("/kv/{key}")
@put
op putKeyValue is appConfigOperation<
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
    @doc("Content-Type header")
    @header("Content-Type")
    contentType:
      | "application/vnd.microsoft.appconfig.kv+json"
      | "application/vnd.microsoft.appconfig.kvset+json"
      | "application/json"
      | "text/json"
      | "application/*+json"
      | "application/json-patch+json";

    @doc("The key of the key-value to create.")
    @path
    key: string;

    @doc("The label of the key-value to create.")
    @query("label")
    label?: string;

    ...syncTokenHeader;

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
  },
  Body<KeyValue> &
    AppConfigResponseHeaders &
    contentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Deletes a key-value.")
@doc("Deletes a key-value.")
@route("/kv/{key}")
@delete
op deleteKeyValue is appConfigOperation<
  {
    @doc("The key of the key-value to delete.")
    @path
    key: string;

    @doc("The label of the key-value to delete.")
    @query("label")
    label?: string;

    ...syncTokenHeader;

    @doc("""
      Used to perform an operation only if the targeted resource's etag matches the
      value provided.
      """)
    @header("If-Match")
    ifMatch?: string;
  },
  (Body<KeyValue> &
    AppConfigResponseHeaders &
    contentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">) | {
    @statusCode
    statusCode: 204;

    ...syncTokenHeader;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/kv/{key}")
@head
op checkKeyValue is appConfigOperation<
  {
    @doc("The key of the key-value to retrieve.")
    @path
    key: string;

    @doc("The label of the key-value to retrieve.")
    @query("label")
    label?: string;

    ...syncTokenHeader;

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
    @query("$Select")
    select?: KeyValueFields[];
  },
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of key-value snapshots.")
@doc("Gets a list of key-value snapshots.")
op getSnapshots is Foundations.ResourceList<
  Snapshot,
  {
    @doc("A filter for the name of the returned snapshots.")
    @query("name")
    name?: string;

    @doc("""
      Instructs the server to return elements that appear after the element referred
      to by the specified token.
      """)
    @query("After")
    after?: string;

    @doc("Used to select what fields are present in the returned resource(s).")
    @query("$Select")
    select?: SnapshotFields[];

    @doc("Used to filter returned snapshots by their status property.")
    @query("status")
    status?: SnapshotStatus[];

    ...syncTokenHeader;
  },
  SnapshotListResult & {
    ...syncTokenHeader;
    ...contentTypeHeader<"application/vnd.microsoft.appconfig.snapshotset+json">;
  },
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/snapshots")
@head
op checkSnapshots is appConfigOperation<
  {
    ...syncTokenHeader;

    @doc("""
      Instructs the server to return elements that appear after the element referred
      to by the specified token.
      """)
    @query("After")
    after?: string;
  },
  OkResponse & {
    ...syncTokenHeader;
  }
>;

@summary("Gets a single key-value snapshot.")
@doc("Gets a single key-value snapshot.")
op getSnapshot is standardOps.ResourceRead<
  Snapshot,
  QueryParametersTrait<{
    @doc("Used to select what fields are present in the returned resource(s).")
    @query("$Select")
    select?: SnapshotFields[];
  }> &
    RequestHeadersTrait<{
      ...syncTokenHeader;

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
    }> &
    ResponseHeadersTrait<AppConfigResponseHeaders & {
      @doc("Includes links to related resources.")
      @header("Link")
      link?: string;

      ...contentTypeHeader<"application/vnd.microsoft.appconfig.snapshot+json">;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Creates a key-value snapshot.")
@doc("Creates a key-value snapshot.")
@route("/snapshots/{name}")
@pollingOperation(getOperationDetails)
@createsOrReplacesResource(Snapshot)
@put
op createSnapshot is Foundations.LongRunningOperation<
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
    @doc("Content-Type header")
    @header("Content-Type")
    contentType: "application/vnd.microsoft.appconfig.snapshot+json" | "application/json";

    @doc("The name of the key-value snapshot to create.")
    @maxLength(256)
    @path
    name: string;

    ...syncTokenHeader;

    @doc("The key-value snapshot to create.")
    @body
    entity: Snapshot;
  },
  CreatedResponse &
    Snapshot & {
      ...AppConfigResponseHeaders;

      @doc("Includes links to related resources.")
      @header("Link")
      link?: string;

      ...contentTypeHeader<"application/vnd.microsoft.appconfig.snapshot+json">;
    },
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Updates the state of a key-value snapshot.")
@doc("Updates the state of a key-value snapshot.")
@route("/snapshots/{name}")
@patch
op updateSnapshot is appConfigOperation<
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
    @doc("Content-Type header")
    @header("Content-Type")
    contentType: "application/merge-patch+json" | "application/json";

    @doc("The name of the key-value snapshot to update.")
    @path
    name: string;

    ...syncTokenHeader;

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
  },
  Snapshot & {
    ...AppConfigResponseHeaders;

    @doc("Includes links to related resources.")
    @header("Link")
    link?: string;

    ...contentTypeHeader<"application/vnd.microsoft.appconfig.snapshot+json">;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/snapshots/{name}")
@head
op checkSnapshot is appConfigOperation<
  {
    @doc("The name of the key-value snapshot to check.")
    @path
    name: string;

    ...syncTokenHeader;

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
  OkResponse & {
    ...AppConfigResponseHeaders;

    @doc("Includes links to related resources.")
    @header("Link")
    link?: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of labels.")
@doc("Gets a list of labels.")
@route("/labels")
op getLabels is appConfigOperation<
  {
    @doc("A filter for the name of the returned labels.")
    @query("name")
    name?: string;

    ...syncTokenHeader;

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
    @query("$Select")
    select?: LabelFields[];
  },
  LabelListResult & {
    ...syncTokenHeader;
    ...contentTypeHeader<"application/vnd.microsoft.appconfig.labelset+json">;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/labels")
@head
op checkLabels is appConfigOperation<
  {
    @doc("A filter for the name of the returned labels.")
    @query("name")
    name?: string;

    ...syncTokenHeader;

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
    @query("$Select")
    select?: LabelFields[];
  },
  OkResponse & {
    ...syncTokenHeader;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Locks a key-value.")
@doc("Locks a key-value.")
@route("/locks/{key}")
@put
op putLock is appConfigOperation<
  {
    @doc("The key of the key-value to lock.")
    @path
    key: string;

    @doc("The label, if any, of the key-value to lock.")
    @query("label")
    label?: string;

    ...syncTokenHeader;

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
  Body<KeyValue> &
    AppConfigResponseHeaders &
    contentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Unlocks a key-value.")
@doc("Unlocks a key-value.")
@route("/locks/{key}")
@delete
op deleteLock is appConfigOperation<
  {
    @doc("The key of the key-value to unlock.")
    @path
    key: string;

    @doc("The label, if any, of the key-value to unlock.")
    @query("label")
    label?: string;

    ...syncTokenHeader;

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
  Body<KeyValue> &
    AppConfigResponseHeaders &
    contentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of key-value revisions.")
@doc("Gets a list of key-value revisions.")
@route("/revisions")
@get
op getRevisions is appConfigOperation<
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

    ...syncTokenHeader;

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
    @query("$Select")
    select?: KeyValueFields[];

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract"
    @doc("""
      A filter used to query by tags. Syntax reference:
      https://aka.ms/azconfig/docs/restapirevisions
      """)
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  KeyValueListResult &
    AppConfigResponseHeaders &
    contentTypeHeader<"application/vnd.microsoft.appconfig.kvset+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/revisions")
@head
op checkRevisions is appConfigOperation<
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

    ...syncTokenHeader;

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
    @query("$Select")
    select?: KeyValueFields[];

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract"
    @doc("""
      A filter used to query by tags. Syntax reference:
      https://aka.ms/azconfig/docs/restapirevisions
      """)
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets the state of a long running operation.")
@doc("Gets the state of a long running operation.")
@route("/operations")
@get
op getOperationDetails is appConfigOperation<
  {
    @doc("Snapshot identifier for the long running operation.")
    @query("snapshot")
    snapshot: string;
  },
  OperationDetails
>;
