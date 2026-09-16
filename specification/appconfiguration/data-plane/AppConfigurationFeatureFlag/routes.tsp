import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace AppConfigurationFeatureFlag;

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

alias FeatureFlagsRequestParams = {
  ...NameQueryParam<"""
    A filter used to match feature flag names.
    """>;
  ...LabelQueryParam<"""
    A filter used to match labels. Syntax reference:
    https://aka.ms/azconfig/docs/keyvaluefiltering
    """>;
  ...SyncTokenHeader;
  ...AfterQueryParam;
  ...AcceptDatetimeHeader;
  ...SelectQueryParam<FeatureFlagFields>;
  ...IfMatchHeader;
  ...IfNoneMatchHeader;
  ...TagsQueryParam<"""
    A filter used to query by tags. Syntax reference:
    https://aka.ms/azconfig/docs/keyvaluefiltering
    """>;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
@summary("Gets a list of feature flags.")
@doc("Gets a list of feature flags.")
@added(Versions.v2026_05_01_preview)
op getFeatureFlags is Foundations.ResourceList<
  FeatureFlag,
  FeatureFlagsRequestParams,
  FeatureFlagListResult &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/json;profile=\\\"https://azconfig.io/mime-profiles/ffset\\\";charset=utf-8">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/ff")
@head
@added(Versions.v2026_05_01_preview)
op checkFeatureFlags is AppConfigOperation<
  FeatureFlagsRequestParams,
  OkResponse & AppConfigResponseHeaders
>;

alias FeatureFlagReadParams = {
  ...LabelQueryParam<"The label of the feature flag to retrieve.">;
  ...SelectQueryParam<FeatureFlagFields>;
  ...SyncTokenHeader;
  ...AcceptDatetimeHeader;
  ...IfMatchHeader;
  ...IfNoneMatchHeader;
  ...ClientRequestIdHeader;

  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract."
  @doc("A filter used to query by tags. Syntax reference:\nhttps://aka.ms/azconfig/docs/keyvaluefiltering")
  @query(#{ name: "tags", explode: true })
  tags?: string[];
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing pattern for the service"
@summary("Gets a single feature flag.")
@doc("Gets a single feature flag.")
@added(Versions.v2026_05_01_preview)
op getFeatureFlag is Foundations.ResourceOperation<
  FeatureFlag,
  FeatureFlagReadParams,
  Body<FeatureFlag> &
    RequestIdResponseHeader &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/json;profile=\\\"https://azconfig.io/mime-profiles/ff\\\";charset=utf-8">,
  {},
  Error
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/ff/{name}")
@head
@added(Versions.v2026_05_01_preview)
op checkFeatureFlag is AppConfigOperation<
  {
    @doc("The name of the feature flag to retrieve.")
    @maxLength(256)
    @path
    name: string;

    ...LabelQueryParam<"The label of the feature flag to retrieve.">;
    ...SyncTokenHeader;
    ...AcceptDatetimeHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
    ...SelectQueryParam<FeatureFlagFields>;

    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract."
    @doc("A filter used to query by tags. Syntax reference:\nhttps://aka.ms/azconfig/docs/keyvaluefiltering")
    @query(#{ name: "tags", explode: true })
    tags?: string[];
  },
  OkResponse & AppConfigResponseHeaders
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
@summary("Creates a feature flag.")
@doc("Creates a feature flag.")
@route("/ff/{name}")
@put
@added(Versions.v2026_05_01_preview)
op putFeatureFlag is AppConfigOperation<
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
    @doc("Content-Type header")
    @header("Content-Type")
    contentType: "application/json;profile=\\\"https://azconfig.io/mime-profiles/ff\\\";charset=utf-8";

    ...NamePathParam<"The name of the feature flag to create.">;
    ...LabelQueryParam<"The label of the feature flag to create.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;

    @doc("The feature flag to create.")
    @body
    entity?: FeatureFlag;
  },
  Body<FeatureFlag> &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/json;profile=\\\"https://azconfig.io/mime-profiles/ff\\\";charset=utf-8">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Deletes a feature flag.")
@doc("Deletes a feature flag.")
@route("/ff/{name}")
@delete
@added(Versions.v2026_05_01_preview)
op deleteFeatureFlag is AppConfigOperation<
  {
    ...NamePathParam<"The name of the feature flag to delete.">;
    ...LabelQueryParam<"The label of the feature flag to delete.">;
    ...SyncTokenHeader;
    ...IfMatchHeader;
  },
  | (Body<FeatureFlag> &
      AppConfigResponseHeaders &
      ContentTypeHeader<"application/json;profile=\\\"https://azconfig.io/mime-profiles/ff\\\";charset=utf-8">)
  | {
      @statusCode
      statusCode: 204;

      ...SyncTokenHeader;
    }
>;

alias FeatureFlagRevisionsRequestParams = NameQueryParam<"""
  A filter used to match names.
  """> &
  LabelQueryParam<"""
    A filter used to match labels. Syntax reference:
    https://aka.ms/azconfig/docs/restapirevisions
    """> &
  AfterQueryParam &
  SelectQueryParam<FeatureFlagFields> &
  TagsQueryParam<"""
    A filter used to query by tags. Syntax reference:
    https://aka.ms/azconfig/docs/restapirevisions
    """>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name pattern"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Not a standard operation"
@summary("Gets a list of feature flag revisions.")
@doc("Gets a list of feature flag revisions.")
@route("/ff-revisions")
@get
@list
@added(Versions.v2026_05_01_preview)
op getFeatureFlagRevisions is AppConfigOperation<
  {
    ...FeatureFlagRevisionsRequestParams;
    ...SyncTokenHeader;
    ...IfMatchHeader;
    ...IfNoneMatchHeader;
  },
  FeatureFlagListResult &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/json;profile=\\\"https://azconfig.io/mime-profiles/ffset\\\";charset=utf-8">
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No data-plane HEAD operation template"
@summary("Requests the headers and status of the given resource.")
@doc("Requests the headers and status of the given resource.")
@route("/ff-revisions")
@head
@added(Versions.v2026_05_01_preview)
op checkFeatureFlagRevisions is AppConfigOperation<
  FeatureFlagRevisionsRequestParams,
  OkResponse & AppConfigResponseHeaders
>;
