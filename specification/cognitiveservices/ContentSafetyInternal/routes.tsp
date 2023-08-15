import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace ContentSafetyInternal;

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;


interface BlockOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}


interface WhitelistFeature {
  @route("whitelist/features")
  @summary("List Whitelist Features.")
  @doc("Get whitelist features.")
  op listBlocklistTopTerms is RpcOperation<
    {},
    FeatureList  ,
    ServiceTraits,
    Azure.Core.Foundations.ErrorResponse
  >;
}

interface Metrics {
  @route("/metrics")
  @summary("List API Request Counts At Different Timestamps Given A Time Range.")
  @doc("List API request counts at different timestamps given a time range. Default maxpagesize is 1000.")
  listRequestCounts is BlockOps.ResourceList<
    CountPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter
    }>
  >;

  @route("/metrics")
  @summary("List API Request Latencies At Different Timestamps Given A Time Range.")
  @doc("List API request latencies at different timestamps given a time range. Default maxpagesize is 1000.")
  listRequestLatencies is BlockOps.ResourceList<
    LatencyPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...AggregationQueryParameter
    }>
  >;

  @summary("List API Request Count At Different Timestamps Of A Specific Category Given A Time Range.")
  @doc("List API request count at different timestamps of a specific category given a time range.")
  @route("/metrics")
  listRequestCountsByCategoryAndSeverity is BlockOps.ResourceList<
    RequestCountsPerTimestamp,
    ListQueryParametersTrait<{
      ...TopQueryParameter,
          ...SkipQueryParameter,
          ...MaxPageSizeQueryParameter,
          ...StartTimeQueryParameter,
          ...EndTimeQueryParameter,
          ...TimeGranularityQueryParameter,
          ...ContentSafetyVersionQueryParameter,
          ...ModalityTypeQueryParameter
    }>
  >;

  @route("/metrics/blocklistTopTerms")
  @summary("List Top Terms Hit In Blocklist At Different Timestamps.")
  @doc("List top terms hit in blocklist at different timestamps.")
  op listBlocklistTopTerms is RpcOperation<
    {

      ...TopTermQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...ContentSafetyVersionQueryParameter,
    },
    TermList  ,
    ServiceTraits,
    Azure.Core.Foundations.ErrorResponse
  >;

  @route("/metrics")
  @summary("Show Blocklist Hit Request Count At Different Timestamps.")
  @doc("Show blocklist hit request count at different timestamps.")
  op listBlocklistHitCalls is BlockOps.ResourceList<
  BlockListHitCallsPerTimestamp,
  ListQueryParametersTrait<{
    ...SkipQueryParameter,
    ...TopQueryParameter,
    ...MaxPageSizeQueryParameter,
    ...StartTimeQueryParameter,
    ...EndTimeQueryParameter,
    ...TimeGranularityQueryParameter,
    ...ContentSafetyVersionQueryParameter
    }>
  >;
}
