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
  title: "Content Safety Whitelist features API",
})
@versioned(ContentSafety.Versions)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
  "{endpoint}/contentsafety",
  "Show metrics of content safety service",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://<resource-name>.cognitiveservices.azure.com).
""")
    endpoint: string,
  }
)
@doc("Content Safety API for whitelisted features.")
namespace ContentSafety;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2023-07-30-preview`,
}

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;


// Models ////////////////////
// @doc("Time granularity.")
// enum Granularity {
//   Hourly,
//   Daily
// }

// @doc("Reject kind")
// enum RejectKind {
//   General,
//   AI
// }

// @doc("Modality type.")
// enum Modality {
//   Text,
//   Image
// }

// @doc("Content safety Operation.")
// enum ContentSafetyOperation {
//   AnalyzeText,
//   AnalyzeImage,
// }

// @doc("Content safety API version.")
// enum ContentSafetyVersion {
//   `2023-04-30-preview`
// }

// @doc("Category type.")
// enum CategoryEnum {
//   "Hate",
//   "Sexual",
//   "Violence",
//   "SelfHarm" 
// }

// @doc("Severity level. The higher the value, the more risk it is.")
// enum SeverityEnum {
//   Zero: 0,
//   Two: 2,
//   Four: 4,
//   Six: 6
// }

// @doc("Aggregation methods for latency.")
// enum Aggregation {
//   P99,
//   P95,
//   Avg
// }


@doc("Whitelisted features.")
@resource("features")
model Feature {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @key("featueName")
  @doc("Feature Name.")
  featureName: string;

  @doc("The properties of the feature.")
  properties: object;
}

@doc("Response of listing whitelist features.")
// @pagedResult
model FeatureList {
  @doc("List of whitelist features.")
  // @items
  value: Feature[];

  // @doc("Link to fetch more terms.")
  // @nextLink
  // nextLink?: string;
}

// @doc("API request count at a timestamp.")
// @resource("requestCounts")
// model CountPerTimestamp {
//   #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
//   @key("dateTime")
//   @doc("The date time.")
//   dateTime: utcDateTime;

//   @doc("The count of the API request.")
//   count: int32;
// }
// @doc("API reject count at a timestamp.")
// @resource("rejectCounts")
// model RejectCountPerTimestamp {
//   #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
//   @key("dateTime")
//   @doc("The date time.")
//   dateTime: utcDateTime;

//   @doc("The count of the API request.")
//   count: int32;
// }


// @doc("Response of calls.")
// @pagedResult
// model CallList {
//   @doc("List of request count.")
//   @items
//   value: CountPerTimestamp[];

//   @doc("Link to fetch more.")
//   @nextLink
//   nextLink?: string;
// }


// @doc("Response of latencies.")
// @pagedResult
// model LatencyList {
//   @doc("List of latency.")
//   @items
//   value: LatencyPerTimestamp[];

//   @doc("Link to fetch more.")
//   @nextLink
//   nextLink?: string;
// }






// @doc("Response of severities.")
// @pagedResult
// model SeverityList {
//   @doc("List of terms.")
//   @items
//   value: Severity[];

//   @doc("Link to fetch more terms.")
//   @nextLink
//   nextLink?: string;
// }



// @doc("Response of listing hit calls.")
// @pagedResult
// model HitCallsList {
//   @doc("List of hit calls.")
//   @items
//   value: BlockListHitCallsPerTimestamp[];

//   @doc("Link to fetch more calls.")
//   @nextLink
//   nextLink?: string;
// }




// Query parameter ////////////////////


// @doc("Provides the most common query parameters for list operations.")
// model CommonListQueryParameters {
//   ...TopQueryParameter;
//   ...SkipQueryParameter;
//   ...MaxPageSizeQueryParameter;
//   ...StartTimeQueryParameter;
//   ...EndTimeQueryParameter;
// }

interface Metrics {

  // @route("/metrics/requestCounts")
  // @summary("List API request counts at different timestamps given a time range.")
  // @doc("List API request counts at different timestamps given a time range. Default maxpagesize is 1000.")
  // op listRequestCounts is RpcOperation<
  //   {
  //     ...SkipQueryParameter,
  //     ...TopQueryParameter,
  //     ...MaxPageSizeQueryParameter,
  //     ...StartTimeQueryParameter,
  //     ...EndTimeQueryParameter,
  //     ...TimeGranularityQueryParameter,
  //     ...ContentSafetyOperationQueryParameter,
  //     ...ContentSafetyVersionQueryParameter
  //   },
  //   CallList  ,
  //   ServiceTraits,
  //   Error
  // >;

  @route("/metrics")
  @summary("List API request counts at different timestamps given a time range.")
  @doc("List API request counts at different timestamps given a time range. Default maxpagesize is 1000.")
  listRequestCounts is ResourceList<
    CountPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...ProjectNameQueryParameter
    }>
  >;
  @route("/metrics")
  @summary("List API reject counts at different timestamps given a time range.")
  @doc("List API reject counts at different timestamps given a time range. Default maxpagesize is 1000.")
  listRejectCounts is ResourceList<
    RejectCountPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...RequiredProjectNameQueryParameter,
      ...RejectKindQueryParameter
    }>
  >;
  @route("/metrics")
  @summary("List API request latencies at different timestamps given a time range.")
  @doc("List API request latencies at different timestamps given a time range. Default maxpagesize is 1000.")
  listRequestLatencies is ResourceList<
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
    ...AggregationQueryParameter,
    ...ProjectNameQueryParameter
  }>
>;

  // @route("/metrics/requestLatencies")
  // @summary("List API request latencies at different timestamps given a time range.")
  // @doc("List API request latencies at different timestamps given a time range. Default maxpagesize is 1000.")
  // op listRequestLatencies is RpcOperation<
  //   {
  //     ...TopQueryParameter,
  //     ...SkipQueryParameter,
  //     ...MaxPageSizeQueryParameter,
  //     ...StartTimeQueryParameter,
  //     ...EndTimeQueryParameter,
  //     ...TimeGranularityQueryParameter,
  //     ...ContentSafetyOperationQueryParameter,
  //     ...ContentSafetyVersionQueryParameter,
  //     ...AggregationQueryParameter
  //   },
  //   LatencyList  ,
  //   ServiceTraits,
  //   Error
  // >;

  // @route("/metrics/categories/{category}/severities")
  // @summary("List severitie distribution， severity and API call count number of a specific category and a specific severity given a time range.")
  // @doc("List all severities and API call count number of a specific category and a specific severity given a time range. Default top is 50.")
  // op listSeverities is RpcOperation<
  //   {
  //     @doc("Category.")
  //     @path
  //     category: CategoryEnum,
  //     ...TopQueryParameter,
  //     ...SkipQueryParameter,
  //     ...MaxPageSizeQueryParameter,
  //     ...StartTimeQueryParameter,
  //     ...EndTimeQueryParameter,
  //     ...ContentSafetyVersionQueryParameter,
  //     ...ModalityTypeQueryParameter
  //   },
  //   SeverityList,
  //   ServiceTraits,
  //   Error
  // >;

  // @summary("List all severities and API call count number of a specific category and a specific severity given a time range")
  // @doc("List all severities and API call count number of a specific category and a specific severity given a time range")
  // @route("/contentSafety/metrics")
  // listSeverityDistributionByCategoryAndSeverity is ResourceList<
  //   Severity,
  //   ListQueryParametersTrait<{
  //     ...SkipQueryParameter,
  //     ...TopQueryParameter,
  //     ...MaxPageSizeQueryParameter,
  //     ...StartTimeQueryParameter,
  //     ...EndTimeQueryParameter,
  //     ...TimeGranularityQueryParameter,
  //     ...ContentSafetyVersionQueryParameter,
  //     ...ModalityTypeQueryParameter
  //   }>
  // >;

  
  // @route("/metrics/categories/{category}/severities/{severity}/requestCounts")
  // @summary("ListAPI request count number of a specific category and a specific severity given a time range.")
  // @doc("List API request count number of a specific category and a specific severity given a time range. Default maxpagesize is 1000.")
  // op listRequestCountsByCategoryAndSeverity is RpcOperation<
  //   {
  //     @doc("Category.")
  //     @path
  //     category: CategoryEnum,
  //     @doc("Severity, the value could be 0, 2, 4, 6.")
  //     @path
  //     severity: SeverityEnum,
  //     ...TopQueryParameter,
  //     ...SkipQueryParameter,
  //     ...MaxPageSizeQueryParameter,
  //     ...StartTimeQueryParameter,
  //     ...EndTimeQueryParameter,
  //     ...TimeGranularityQueryParameter,
  //     ...ContentSafetyVersionQueryParameter,
  //     ...ModalityTypeQueryParameter
  //   },
  //   CallList  ,
  //   ServiceTraits,
  //   Error
  // >;
  
  @summary("List API request count at different timestamps of a specific category and a specific severity given a time range")
  @doc("List API request count at different timestamps of a specific category and a specific severity given a time range")
  @route("/metrics")
  listRequestCountsByCategoryAndSeverity is ResourceList<
    RequestCountsPerTimestamp,
    ListQueryParametersTrait<{
      ...TopQueryParameter,
          ...SkipQueryParameter,
          ...MaxPageSizeQueryParameter,
          ...StartTimeQueryParameter,
          ...EndTimeQueryParameter,
          ...TimeGranularityQueryParameter,
          ...ContentSafetyVersionQueryParameter,
          ...ModalityTypeQueryParameter,
          ...ProjectNameQueryParameter
    }>
  >;

  @route("/metrics/blocklistTopTerms")
  @summary("List top terms hit in blocklist at different timestamps.")
  @doc("List top terms hit in blocklist at different timestamps.")
  op listBlocklistTopTerms is RpcOperation<
    {
      // ...SkipQueryParameter,
      ...TopTermQueryParameter,
      // ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ProjectNameQueryParameter
    },
    TermList  ,
    ServiceTraits,
    Azure.Core.Foundations.ErrorResponse
  >;

  // @route("/metrics")
  // @summary("List top terms hit in blocklist at different timestamps.")
  // @doc("List top terms hit in blocklist at different timestamps.")
  // op listBlocklistTopterms is ResourceList<
  // TopTermCount,
  // ListQueryParametersTrait<{
  //   ...SkipQueryParameter,
  //   ...TopQueryParameter,
  //   ...MaxPageSizeQueryParameter,
  //   ...StartTimeQueryParameter,
  //   ...EndTimeQueryParameter,
  //   ...ContentSafetyVersionQueryParameter,
  //   }>
  // >;

  @route("/metrics")
  @summary("Show blocklist hit request count at different timestamps.")
  @doc("Show blocklist hit request count at different timestamps.")
  op listBlocklistHitCalls is ResourceList<
  BlockListHitCallsPerTimestamp,
  ListQueryParametersTrait<{
    ...SkipQueryParameter,
    ...TopQueryParameter,
    ...MaxPageSizeQueryParameter,
    ...StartTimeQueryParameter,
    ...EndTimeQueryParameter,
    ...TimeGranularityQueryParameter,
    ...ContentSafetyVersionQueryParameter,
    ...ProjectNameQueryParameter
    }>
  >;

  // @route("/metrics/blocklistHitCalls")
  // @summary("Show blocklist hit request count at different timestamps.")
  // @doc("Show blocklist hit request count at different timestamps.")
  // op listBlocklistHitCalls is RpcOperation<
  //   {
  //     ...SkipQueryParameter,
  //     ...TopQueryParameter,
  //     ...MaxPageSizeQueryParameter,
  //     ...StartTimeQueryParameter,
  //     ...EndTimeQueryParameter,
  //     ...TimeGranularityQueryParameter,
  //     ...ContentSafetyVersionQueryParameter,
  //   },
  //   HitCallsList  ,
  //   ServiceTraits,
  //   Error
  // >;
}




// alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

// interface Projects {

//   @summary("Create or update a project.")
//   @doc("Update a project is project does exist, create a new project if not. Note that modality cannot be updated.")
//   createOrUpdateProject is ResourceCreateOrUpdate<Project>;

//   @summary("Get project detailed information by project name.")
//   @doc("Returns project details.")
//   getProject is ResourceRead<Project>;

//   @summary("Delete a project by project name.")
//   @doc("Delete a project by name.")
//   deleteProject is ResourceDelete<Project>;

//   @summary("List projects.")
//   @doc("Get project details.")
//   listProjects is ResourceList<Project,  
//     ListQueryParametersTrait<{
//       ...TopQueryParameter,
//       ...SkipQueryParameter,
//       ...MaxPageSizeQueryParameter,
//     }>
//   >;

//   @summary("Analyze content by project when the project is deployed for a policy. ")
//   @doc("Analyze content by project when the project is deployed for a policy. ")
//   @route("/projects/{projectName}:analyze")
//   @post
//   analyzeContentByProject is RpcOperation<
//     {
//       @doc("The policy to be deployed.")
//       @body
//       body: AnalyzeContentRequest,

//       @doc("The name of the project to be deployed.")
//       @path
//       projectName: string
//     },
//     null,
//     Foundations.Error
//   >;
    
//   @summary("Deploy policy for a project. ")
//   @doc("A sync API to deploy policy for a project.")
//   @route("/projects/{projectName}:deploy")
//   @post
//   deployPolicy is RpcOperation<
//     {
//       @doc("The policy to be deployed")
//       @body
//       body: DeployOption,

//       @doc("The name of the project to be deployed")
//       @path
//       projectName: string
//     },
//     null,
//     Foundations.Error
//   >;

//   @summary("List deployment history of a project.")
//   @doc("List deployment history of a project.")
//   listProjectDeployHistory is ResourceList<
//     DeployOption,
//     ListQueryParametersTrait<{
//           ...TopQueryParameter,
//           ...SkipQueryParameter,
//           ...MaxPageSizeQueryParameter,
//     }>
//   >;
// }


// interface Projects {


//   // @summary("List whitelist features.")
//   // @doc("Get whitelist features.")
//   // listFeatures is ResourceList<Feature,  
//   //   ListQueryParametersTrait<{
//   //   }>
//   // >;


//   @route("whitelist/features")
//   @summary("List whitelist features.")
//   @doc("Get whitelist features.")
//   op listBlocklistTopTerms is RpcOperation<
//     {
    
//     },
//     FeatureList  ,
//     ServiceTraits,
//     Azure.Core.Foundations.ErrorResponse
//   >;

// }


