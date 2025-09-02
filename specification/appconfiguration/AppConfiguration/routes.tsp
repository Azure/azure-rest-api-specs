import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace AzureAppConfiguration;

alias AppConfigOperation<
  TParams,
  TResponse,
  Traits extends Reflection.Model = {},
  TError = Error
> = Foundations.Operation<
  TParams & ClientRequestIdHeader,
  TResponse,
  Traits,
  TError
>;

alias StandardOps = ResourceOperations<
  NoClientRequestId & NoRepeatableRequests & NoConditionalRequests,
  Error
>;

alias KeysRequestParams = {
  ...NameQueryParam<"A filter for the name of the returned keys.">;
  ...AfterHeader;
  ...SyncTokenHeader;
  ...AcceptDatetimeHeader;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
@summary("Gets a list of keys.")
@doc("Gets a list of keys.")
op getKeys is Foundations.ResourceList<
  Key,
  KeysRequestParams,
  KeyListResult &
    SyncTokenHeader &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.keyset+json">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/keys")
@head
op checkKeys is AppConfigOperation<
  KeysRequestParams,
  OkResponse & SyncTokenHeader
>;

alias KeyValuesRequestParams = {
  ...KeyQueryParam<"""
    A filter used to match keys. Syntax reference:
    https://aka.ms/azconfig/docs/keyvaluefiltering
    """>;
  ...LabelQueryParam<"""
    A filter used to match labels. Syntax reference:
    https://aka.ms/azconfig/docs/keyvaluefiltering
    """>;
  ...SyncTokenHeader;
  ...AfterHeader;
  ...AcceptDatetimeHeader;
  ...SelectQueryParam<KeyValueFields>;
  ...SnapshotOptionalQueryParam<"""
    A filter used get key-values for a snapshot. The value should be the name of
    the snapshot. Not valid when used with 'key' and 'label' filters.
    """>;
  ...IfMatchHeader;
  ...IfNoneMatchHeader;
  ...TagsQueryParam<"""
    A filter used to query by tags. Syntax reference:
    https://aka.ms/azconfig/docs/keyvaluefiltering
    """>;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
@summary("Gets a list of key-values.")
@doc("Gets a list of key-values.")
op getKeyValues is Foundations.ResourceList<
  KeyValue,
  KeyValuesRequestParams,
  KeyValueListResult &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kvset+json">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/kv")
@head
op checkKeyValues is AppConfigOperation<
  KeyValuesRequestParams,
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a single key-value.")
@doc("Gets a single key-value.")
@get
op getKeyValue is Foundations.ResourceOperation<
  KeyValue,
  {
    ...LabelQueryParam<"The label of the key-value to retrieve.">;
    ...SelectQueryParam<KeyValueFields>;
    ...SyncTokenHeader;
    ...AcceptDatetimeHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
    ...ClientRequestIdHeader;

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract."
    @added(Versions.v2024_09_01)
    @doc("A filter used to query by tags. Syntax reference:\nhttps://aka.ms/azconfig/docs/keyvaluefiltering")
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  Body<KeyValue> &
    RequestIdResponseHeader &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
@summary("Creates a key-value.")
@doc("Creates a key-value.")
@route("/kv/{key}")
@put
op putKeyValue is AppConfigOperation<
  {
    #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with current SDKs."
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

    ...KeyPathParam<"The key of the key-value to create.">;
    ...LabelQueryParam<"The label of the key-value to create.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;

    @doc("The key-value to create.")
    @body
    entity?: KeyValue;
  },
  Body<KeyValue> &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Deletes a key-value.")
@doc("Deletes a key-value.")
@route("/kv/{key}")
@delete
op deleteKeyValue is AppConfigOperation<
  {
    ...KeyPathParam<"The key of the key-value to delete.">;
    ...LabelQueryParam<"The label of the key-value to delete.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
  },
  (Body<KeyValue> &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">) | {
    @statusCode
    statusCode: 204;

    ...SyncTokenHeader;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/kv/{key}")
@head
op checkKeyValue is AppConfigOperation<
  {
    ...KeyPathParam<"The key of the key-value to retrieve.">;
    ...LabelQueryParam<"The label of the key-value to retrieve.">;
    ...SyncTokenHeader;
    ...AcceptDatetimeHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
    ...SelectQueryParam<KeyValueFields>;

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract."
    @added(Versions.v2024_09_01)
    @doc("A filter used to query by tags. Syntax reference:\nhttps://aka.ms/azconfig/docs/keyvaluefiltering")
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of key-value snapshots.")
@doc("Gets a list of key-value snapshots.")
op getSnapshots is Foundations.ResourceList<
  Snapshot,
  {
    ...NameQueryParam<"A filter for the name of the returned snapshots.">;
    ...AfterHeader;
    ...SelectQueryParam<SnapshotFields>;

    @doc("Used to filter returned snapshots by their status property.")
    @query("status")
    status?: SnapshotStatus[];

    ...SyncTokenHeader;
  },
  SnapshotListResult &
    SyncTokenHeader &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.snapshotset+json">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/snapshots")
@head
op checkSnapshots is AppConfigOperation<
  SyncTokenHeader & AfterHeader,
  OkResponse & SyncTokenHeader
>;

@summary("Gets a single key-value snapshot.")
@doc("Gets a single key-value snapshot.")
op getSnapshot is StandardOps.ResourceRead<
  Snapshot,
  QueryParametersTrait<SelectQueryParam<SnapshotFields>> &
    RequestHeadersTrait<{
      ...SyncTokenHeader;
      ...IfMatchHeader;
      ...IfNoneMatchHeader;
      ...ClientRequestIdHeader;
    }> &
    ResponseHeadersTrait<AppConfigResponseHeaders &
      LinkHeader &
      ContentTypeHeader<"application/vnd.microsoft.appconfig.snapshot+json"> &
      RequestIdResponseHeader>
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
    #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with current SDKs."
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
    @doc("Content-Type header")
    @header("Content-Type")
    contentType: "application/vnd.microsoft.appconfig.snapshot+json" | "application/json";

    ...NamePathParam<"The name of the key-value snapshot to create.">;
    ...SyncTokenHeader;

    @doc("The key-value snapshot to create.")
    @body
    entity: Snapshot;
  },
  CreatedResponse &
    Snapshot &
    AppConfigResponseHeaders &
    LinkHeader &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.snapshot+json">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Updates the state of a key-value snapshot.")
@doc("Updates the state of a key-value snapshot.")
@route("/snapshots/{name}")
@patch(#{ implicitOptionality: true })
op updateSnapshot is AppConfigOperation<
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
    #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with current SDKs."
    @doc("Content-Type header")
    @header("Content-Type")
    contentType: "application/merge-patch+json" | "application/json";

    ...NamePathParam<"The name of the key-value snapshot to update.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;

    @doc("The parameters used to update the snapshot.")
    @body
    entity: SnapshotUpdateParameters;
  },
  Snapshot &
    AppConfigResponseHeaders &
    LinkHeader &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.snapshot+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/snapshots/{name}")
@head
op checkSnapshot is AppConfigOperation<
  {
    ...NamePathParam<"The name of the key-value snapshot to check.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
  },
  OkResponse & AppConfigResponseHeaders & LinkHeader
>;

alias LabelsRequestParams = {
  ...NameQueryParam<"A filter for the name of the returned labels.">;
  ...SyncTokenHeader;
  ...AfterHeader;
  ...AcceptDatetimeHeader;
  ...SelectQueryParam<LabelFields>;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of labels.")
@doc("Gets a list of labels.")
@route("/labels")
@list
op getLabels is AppConfigOperation<
  LabelsRequestParams,
  LabelListResult &
    SyncTokenHeader &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.labelset+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/labels")
@head
op checkLabels is AppConfigOperation<
  LabelsRequestParams,
  OkResponse & SyncTokenHeader
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Locks a key-value.")
@doc("Locks a key-value.")
@route("/locks/{key}")
@put
op putLock is AppConfigOperation<
  {
    ...KeyPathParam<"The key of the key-value to lock.">;
    ...LabelQueryParam<"The label, if any, of the key-value to lock.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
  },
  Body<KeyValue> &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Unlocks a key-value.")
@doc("Unlocks a key-value.")
@route("/locks/{key}")
@delete
op deleteLock is AppConfigOperation<
  {
    ...KeyPathParam<"The key of the key-value to unlock.">;
    ...LabelQueryParam<"The label, if any, of the key-value to unlock.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
  },
  Body<KeyValue> &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kv+json">
>;

alias RevisionsRequestParams = {
  ...KeyQueryParam<"""
    A filter used to match keys. Syntax reference:
    https://aka.ms/azconfig/docs/restapirevisions
    """>;
  ...LabelQueryParam<"""
    A filter used to match labels. Syntax reference:
    https://aka.ms/azconfig/docs/restapirevisions
    """>;
  ...SyncTokenHeader;
  ...AfterHeader;
  ...AcceptDatetimeHeader;
  ...SelectQueryParam<KeyValueFields>;
  ...TagsQueryParam<"""
    A filter used to query by tags. Syntax reference:
    https://aka.ms/azconfig/docs/restapirevisions
    """>;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of key-value revisions.")
@doc("Gets a list of key-value revisions.")
@route("/revisions")
@get
@list
op getRevisions is AppConfigOperation<
  RevisionsRequestParams,
  KeyValueListResult &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kvset+json">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/revisions")
@head
op checkRevisions is AppConfigOperation<
  RevisionsRequestParams,
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets the state of a long running operation.")
@doc("Gets the state of a long running operation.")
@route("/operations")
@get
op getOperationDetails is AppConfigOperation<
  {
    @doc("Snapshot identifier for the long running operation.")
    @query("snapshot")
    snapshot: string;
  },
  OperationDetails
>;
