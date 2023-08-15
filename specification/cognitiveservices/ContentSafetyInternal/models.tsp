import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;


namespace ContentSafetyInternal;

@doc("Whitelist features.")
@resource("whitelist/features")
model Feature {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("featueName")
  @doc("Feature Name.")
  featureName: string;

  @doc("The properties of the feature.")
  properties: object;
}

@doc("Response of listing whitelist features.")
model FeatureList {
  @doc("List of whitelist features.")
  value: Feature[];
}

// Models ////////////////////
@doc("Time granularity.")
enum Granularity {
  Hourly,
  Daily
}

@doc("Modality type.")
enum ContentModality {
  Text,
  Image,
  @added(ContentSafetyInternal.Versions.v2023_05_30_Preview)
  @removed(ContentSafetyInternal.Versions.v2023_10_01)
  ImageWithText
}

@doc("Content safety Operation.")
enum ContentSafetyOperation {
  AnalyzeText,
  AnalyzeImage,
  @added(ContentSafetyInternal.Versions.v2023_05_30_Preview)
  @removed(ContentSafetyInternal.Versions.v2023_10_01)
  AnalyzeImageWithText
}

@doc("Content safety API version.")
enum ContentSafetyVersion {
  `2023-04-30-preview`,
  @added(ContentSafetyInternal.Versions.v2023_05_30_Preview)
  @removed(ContentSafetyInternal.Versions.v2023_10_01)
  `2023-05-30-preview`,
  @added(ContentSafetyInternal.Versions.v2023_10_01)
  `2023-10-01`
}

@doc("Category type.")
enum CategoryEnum {
  "Hate",
  "Sexual",
  "Violence",
  "SelfHarm" 
}

@doc("Severity level. The higher the value, the more risk it is.")
enum SeverityEnum {
  Zero: 0,
  Two: 2,
  Four: 4,
  Six: 6
}

@doc("Aggregation methods for latency.")
enum Aggregation {
  P99,
  P95,
  Avg
}

@doc("API request count at a timestamp.")
@resource("requestCounts")
model CountPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The count of the API request.")
  count: int32;
}

@doc("API request latency at a timestamp.")
@resource("requestLatencies")
model LatencyPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The aggregated latency of the API in milliseconds.")
  latency: int32;
}

@doc("Popular term and it's API count.")
@resource("blocklistTopTerms")
model TopTermCount {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("term")
  @doc("The term content.")
  term: string;

  @doc("The API call count of the term.")
  count: int32;
}

@doc("Response of listing hit terms.")
@pagedResult
model TermList {
  @doc("List of terms.")
  @items
  value: TopTermCount[];
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
model Severity {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @doc("The severity the API returned.")
  @key("severity")
  severity: SeverityEnum;

  @doc("The count of the severity.")
  severityCount: int32;
}

@doc("API request count at a timestamp")
@resource("requestCounts")
@parentResource(Category)
model RequestCountsPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The count of the request.")
  count: Severity[];
}

@doc("Blocklist hit call counts at a timestamp")
@resource("blocklistHitCalls")
model BlockListHitCallsPerTimestamp {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("dateTime")
  @doc("The date time.")
  dateTime: utcDateTime;

  @doc("The call count of the hit API.")
  count: int32;
}

// Query parameter ////////////////////
@doc("Provides the 'start' query parameter for list operations. The start time is inclusive.")
model StartTimeQueryParameter {
  @query
  @doc("Start date time inclusive.")
  start: utcDateTime;
}

@doc("Provides the 'end' query parameter for list operations. The end time is exclusive.")
model EndTimeQueryParameter {
  @query
  @doc("End date time inclusive.")
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
  modality: ContentModality;
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

@doc("Provides the 'top' query parameter for list top terms.")
model TopTermQueryParameter {
  @query
  @doc("The number of result items to return. ")
  top: int32;
}