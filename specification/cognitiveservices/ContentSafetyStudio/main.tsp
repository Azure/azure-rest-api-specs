import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service({
  title: "Content Safety Studio API",
})
@versioned(ContentSafetyStudio.Versions)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@doc("Content Safety studio API for different metrics")
namespace ContentSafetyStudio;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2023-04-30-preview`,
}

// Models ////////////////////
@doc("Time granularity.")
enum Granularity {
  Hourly,
  Daily
}

@doc("Modality type.")
enum Modality {
  Text,
  Image
}

@doc("Content safety Operation.")
enum ContentSafetyOperation {
  AnalyzeText,
  AnalyzeImage,
}

@doc("Content safety API version.")
enum ContentSafetyVersion {
  `2023-04-30-preview`
}

@doc("Category type.")
enum CategoryEnum {
  "Hate",
  "Sexual",
  "Violence",
  "Self-harm" 
}

@doc("Severity level. The higher the value, the more risk it is.")
enum SeverityEnum {
  "0",
  "2",
  "4",
  "6"
}

@doc("Aggregation methods for latency.")
enum Aggregation {
  P99,
  P95,
  Avg
}


@doc("API total count at a timestamp.")
@resource("totalCalls")
model CountPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The count of the API total call.")
  count: int32;
}

@doc("API latency at a timestamp.")
@resource("latencies")
model LatencyPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The aggregated latency of the API in milliseconds.")
  latency: int32;
}

@doc("Popular term and it's API count.")
@resource("topTerms")
model TopTermCount {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("term")
  @doc("The term content.")
  term: string;

  @doc("The API call count of the term.")
  count: int32;
}

@doc("Blocklist hit call counts at a timestamp")
@resource("hitCalls")
model BlockListHitCallsPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The call count of the hit API.")
  count: int32;
}

@doc("The detection category.")
@resource("categories")
model Category {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("category")
  @doc("The category of the API. The value could be Hate, Sexual, Violence, Self-Harm")
  category: CategoryEnum;
}

@doc("Severity and count the API detected.")
@resource("severities")
@parentResource(Category)
model Severity {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @doc("The severity the API returned.")
  @key("severity")
  severity: SeverityEnum;

  @doc("The count of the severity.")
  count: int32;
}

@doc("API count at a timestamp")
@resource("totalCalls")
@parentResource(Severity)
model TotalCountsPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The count of the total call.")
  count: int32;
}

// @doc("Error response")
// @error
// model Error {
//   @header("x-ms-error-code")
//   @doc("Error code.")
//   code: int32;

//   @doc("Error message.")
//   message: string;
// }

// Query parameter ////////////////////
@doc("Provides the 'start' query parameter for list operations.")
model StartTimeQueryParameter {
  @query
  @doc("Start date time.")
  start: utcDateTime;
}

@doc("Provides the 'end' query parameter for list operations.")
model EndTimeQueryParameter {
  @query
  @doc("End date time.")
  end: utcDateTime;
}

@doc("Provides the 'granularity' query parameter for list operations.")
model TimeGranularityQueryParameter {
  @query
  @doc("Granularity, the value could be 'Hourly', 'Daily'.")
  granularity: Granularity;
}
@doc("Provides the 'modality' query parameter for list operations.")
model ModalityTypeQueryParameter {
  @query
  @doc("Modality type, the value could be 'Text', 'Image'.")
  modality: Modality;
}

@doc("Provides the 'contentSafetyOperation' query parameter for list operations.")
model ContentSafetyOperationQueryParameter {
  @query
  @doc("Content safety operation, the value could be 'AnalyzeText', 'AnalyzeImage'.")
  contentSafetyOperation: ContentSafetyOperation;
}

@doc("Provides the 'contentSafetyVersion' query parameter for list operations.")
model ContentSafetyVersionQueryParameter {
  @query
  @doc("API version of the call, the value could be '2023-04-30-preview'.")
  contentSafetyVersion: ContentSafetyVersion;
}

@doc("Provides the 'aggregation' query parameter for list operations.")
model AggregationQueryParameter {
  @query
  @doc("Aggregation method of the latency, the value could be 'Percentile99', 'Percentile95', 'Average'.")
  aggregation: Aggregation;
}

@doc("Provides the most common query parameters for list operations.")
model CommonListQueryParameters {
  ...TopQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
  ...StartTimeQueryParameter;
  ...EndTimeQueryParameter;
}

@doc("Provides the granularity along with common query parameters for list operations.")
model TimeGranularityListQueryParameters {
  ...TopQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
  ...StartTimeQueryParameter;
  ...EndTimeQueryParameter;
  ...TimeGranularityQueryParameter;
}

@doc("Provides the modality along with common query parameters for list operations.")
model ModalityQueryParameters {
  ...TopQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
  ...StartTimeQueryParameter;
  ...EndTimeQueryParameter;
  ...TimeGranularityQueryParameter;
  ...ModalityTypeQueryParameter;
}

@doc("Provides the content safety operation and version info along with common query parameters for list operations.")
model ApiListQueryParameters {
  ...TopQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
  ...StartTimeQueryParameter;
  ...EndTimeQueryParameter;
  ...TimeGranularityQueryParameter;
  ...ContentSafetyOperationQueryParameter;
  ...ContentSafetyVersionQueryParameter;
}

@doc("Provides the aggregation query parameter along with common query parameters for list operations.")
model AggregationListQueryParameters {
  ...TopQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
  ...StartTimeQueryParameter;
  ...EndTimeQueryParameter;
  ...TimeGranularityQueryParameter;
  ...ContentSafetyOperationQueryParameter;
  ...ContentSafetyVersionQueryParameter;
  ...AggregationQueryParameter;
}

interface Metrics {
  @doc("List total API counts at different timestamps given a time range")
  @route("/contentSafety/studio/metrics")
  listTotalCalls is ResourceList<
    CountPerTimestamp,
    ListQueryParametersTrait<ApiListQueryParameters>
  >;

  @doc("List aggregated API latencies at different timestamps given a time range")
  @route("/contentSafety/studio/metrics")
  listLatencies is ResourceList<
    LatencyPerTimestamp,
    ListQueryParametersTrait<AggregationListQueryParameters>
  >;

  @doc("List all severities and API call count number of a specific category and a specific severity given a time range")
  @route("/contentSafety/studio/metrics")
  listSeverityDistributionByCategoryAndSeverity is ResourceList<
    Severity,
    ListQueryParametersTrait<ModalityQueryParameters>
  >;

  @doc("List total API counts at different timestamps of a specific category and a specific severity given a time range")
  @route("/contentSafety/studio/metrics")
  listTotalCallsByCategoryAndSeverity is ResourceList<
    TotalCountsPerTimestamp,
    ListQueryParametersTrait<ModalityQueryParameters>
  >;
}


interface Blocklist {
  @doc("List top terms hit in blocklist at different timestamps")
  @route("/contentSafety/studio/metrics/blocklists")
  listTopTerms is ResourceList<
    TopTermCount,
    ListQueryParametersTrait<CommonListQueryParameters>
  >;

  @doc("Show all blocklist hit API count at different timestamps")
  @route("/contentSafety/studio/metrics/blocklists")
  listHitCalls is ResourceList<
    BlockListHitCallsPerTimestamp,
    ListQueryParametersTrait<TimeGranularityListQueryParameters>
  >;
}
