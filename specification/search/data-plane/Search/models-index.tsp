import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Search;

@doc("Allows the user to choose whether a semantic call should fail completely, or to return partial results.")
union SemanticErrorMode {
  string,

  @doc("If the semantic processing fails, partial results still return. The definition of partial results depends on what semantic step failed and what was the reason for failure.")
  Partial: "partial",

  @doc("If there is an exception during the semantic processing step, the query will fail and return the appropriate HTTP code depending on the error.")
  Fail: "fail",
}

@doc("This parameter is only valid if the query type is `semantic`. If set, the query returns answers extracted from key passages in the highest ranked documents. The number of answers returned can be configured by appending the pipe character `|` followed by the `count-<number of answers>` option after the answers parameter value, such as `extractive|count-3`. Default count is 1. The confidence threshold can be configured by appending the pipe character `|` followed by the `threshold-<confidence threshold>` option after the answers parameter value, such as `extractive|threshold-0.9`. Default threshold is 0.7. The maximum character length of answers can be configured by appending the pipe character '|' followed by the 'count-<number of maximum character length>', such as 'extractive|maxcharlength-600'.")
union QueryAnswerType {
  string,

  @doc("Do not return answers for the query.")
  None: "none",

  @doc("Extracts answer candidates from the contents of the documents returned in response to a query expressed as a question in natural language.")
  Extractive: "extractive",
}

@doc("This parameter is only valid if the query type is `semantic`. If set, the query returns captions extracted from key passages in the highest ranked documents. When Captions is set to `extractive`, highlighting is enabled by default, and can be configured by appending the pipe character `|` followed by the `highlight-<true/false>` option, such as `extractive|highlight-true`. Defaults to `None`. The maximum character length of captions can be configured by appending the pipe character '|' followed by the 'count-<number of maximum character length>', such as 'extractive|maxcharlength-600'.")
union QueryCaptionType {
  string,

  @doc("Do not return captions for the query.")
  None: "none",

  @doc("Extracts captions from the matching documents that contain passages relevant to the search query.")
  Extractive: "extractive",
}

@doc("This parameter is only valid if the query type is `semantic`. When QueryRewrites is set to `generative`, the query terms are sent to a generate model which will produce 10 (default) rewrites to help increase the recall of the request. The requested count can be configured by appending the pipe character `|` followed by the `count-<number of rewrites>` option, such as `generative|count-3`. Defaults to `None`.")
union QueryRewritesType {
  string,

  @doc("Do not generate additional query rewrites for this query.")
  None: "none",

  @doc("Generate alternative query terms to increase the recall of a search request.")
  Generative: "generative",
}

@doc("Enables a debugging tool that can be used to further explore your search results. You can enable multiple debug modes simultaneously by separating them with a | character, for example: semantic|queryRewrites.")
union QueryDebugMode {
  string,

  @doc("No query debugging information will be returned.")
  Disabled: "disabled",

  @doc("Allows the user to further explore their reranked results.")
  Semantic: "semantic",

  @doc("Allows the user to further explore their hybrid and vector query results.")
  Vector: "vector",

  @doc("Allows the user to explore the list of query rewrites generated for their search request.")
  QueryRewrites: "queryRewrites",

  @doc("Allows the user to retrieve scoring information regarding vectors matched within a collection of complex types.")
  InnerHits: "innerHits",

  @doc("Turn on all debug options.")
  All: "all",
}

@doc("The language of the query.")
union QueryLanguage {
  string,

  @doc("Query language not specified.")
  None: "none",

  @doc("Query language value for English (United States).")
  EnUs: "en-us",

  @doc("Query language value for English (Great Britain).")
  EnGb: "en-gb",

  @doc("Query language value for English (India).")
  EnIn: "en-in",

  @doc("Query language value for English (Canada).")
  EnCa: "en-ca",

  @doc("Query language value for English (Australia).")
  EnAu: "en-au",

  @doc("Query language value for French (France).")
  FrFr: "fr-fr",

  @doc("Query language value for French (Canada).")
  FrCa: "fr-ca",

  @doc("Query language value for German (Germany).")
  DeDe: "de-de",

  @doc("Query language value for Spanish (Spain).")
  EsEs: "es-es",

  @doc("Query language value for Spanish (Mexico).")
  EsMx: "es-mx",

  @doc("Query language value for Chinese (China).")
  ZhCn: "zh-cn",

  @doc("Query language value for Chinese (Taiwan).")
  ZhTw: "zh-tw",

  @doc("Query language value for Portuguese (Brazil).")
  PtBr: "pt-br",

  @doc("Query language value for Portuguese (Portugal).")
  PtPt: "pt-pt",

  @doc("Query language value for Italian (Italy).")
  ItIt: "it-it",

  @doc("Query language value for Japanese (Japan).")
  JaJp: "ja-jp",

  @doc("Query language value for Korean (Korea).")
  KoKr: "ko-kr",

  @doc("Query language value for Russian (Russia).")
  RuRu: "ru-ru",

  @doc("Query language value for Czech (Czech Republic).")
  CsCz: "cs-cz",

  @doc("Query language value for Dutch (Belgium).")
  NlBe: "nl-be",

  @doc("Query language value for Dutch (Netherlands).")
  NlNl: "nl-nl",

  @doc("Query language value for Hungarian (Hungary).")
  HuHu: "hu-hu",

  @doc("Query language value for Polish (Poland).")
  PlPl: "pl-pl",

  @doc("Query language value for Swedish (Sweden).")
  SvSe: "sv-se",

  @doc("Query language value for Turkish (Turkey).")
  TrTr: "tr-tr",

  @doc("Query language value for Hindi (India).")
  HiIn: "hi-in",

  @doc("Query language value for Arabic (Saudi Arabia).")
  ArSa: "ar-sa",

  @doc("Query language value for Arabic (Egypt).")
  ArEg: "ar-eg",

  @doc("Query language value for Arabic (Morocco).")
  ArMa: "ar-ma",

  @doc("Query language value for Arabic (Kuwait).")
  ArKw: "ar-kw",

  @doc("Query language value for Arabic (Jordan).")
  ArJo: "ar-jo",

  @doc("Query language value for Danish (Denmark).")
  DaDk: "da-dk",

  @doc("Query language value for Norwegian (Norway).")
  NoNo: "no-no",

  @doc("Query language value for Bulgarian (Bulgaria).")
  BgBg: "bg-bg",

  @doc("Query language value for Croatian (Croatia).")
  HrHr: "hr-hr",

  @doc("Query language value for Croatian (Bosnia and Herzegovina).")
  HrBa: "hr-ba",

  @doc("Query language value for Malay (Malaysia).")
  MsMy: "ms-my",

  @doc("Query language value for Malay (Brunei Darussalam).")
  MsBn: "ms-bn",

  @doc("Query language value for Slovenian (Slovenia).")
  SlSl: "sl-sl",

  @doc("Query language value for Tamil (India).")
  TaIn: "ta-in",

  @doc("Query language value for Vietnamese (Viet Nam).")
  ViVn: "vi-vn",

  @doc("Query language value for Greek (Greece).")
  ElGr: "el-gr",

  @doc("Query language value for Romanian (Romania).")
  RoRo: "ro-ro",

  @doc("Query language value for Icelandic (Iceland).")
  IsIs: "is-is",

  @doc("Query language value for Indonesian (Indonesia).")
  IdId: "id-id",

  @doc("Query language value for Thai (Thailand).")
  ThTh: "th-th",

  @doc("Query language value for Lithuanian (Lithuania).")
  LtLt: "lt-lt",

  @doc("Query language value for Ukrainian (Ukraine).")
  UkUa: "uk-ua",

  @doc("Query language value for Latvian (Latvia).")
  LvLv: "lv-lv",

  @doc("Query language value for Estonian (Estonia).")
  EtEe: "et-ee",

  @doc("Query language value for Catalan.")
  CaEs: "ca-es",

  @doc("Query language value for Finnish (Finland).")
  FiFi: "fi-fi",

  @doc("Query language value for Serbian (Bosnia and Herzegovina).")
  SrBa: "sr-ba",

  @doc("Query language value for Serbian (Montenegro).")
  SrMe: "sr-me",

  @doc("Query language value for Serbian (Serbia).")
  SrRs: "sr-rs",

  @doc("Query language value for Slovak (Slovakia).")
  SkSk: "sk-sk",

  @doc("Query language value for Norwegian (Norway).")
  NbNo: "nb-no",

  @doc("Query language value for Armenian (Armenia).")
  HyAm: "hy-am",

  @doc("Query language value for Bengali (India).")
  BnIn: "bn-in",

  @doc("Query language value for Basque.")
  EuEs: "eu-es",

  @doc("Query language value for Galician.")
  GlEs: "gl-es",

  @doc("Query language value for Gujarati (India).")
  GuIn: "gu-in",

  @doc("Query language value for Hebrew (Israel).")
  HeIl: "he-il",

  @doc("Query language value for Irish (Ireland).")
  GaIe: "ga-ie",

  @doc("Query language value for Kannada (India).")
  KnIn: "kn-in",

  @doc("Query language value for Malayalam (India).")
  MlIn: "ml-in",

  @doc("Query language value for Marathi (India).")
  MrIn: "mr-in",

  @doc("Query language value for Persian (U.A.E.).")
  FaAe: "fa-ae",

  @doc("Query language value for Punjabi (India).")
  PaIn: "pa-in",

  @doc("Query language value for Telugu (India).")
  TeIn: "te-in",

  @doc("Query language value for Urdu (Pakistan).")
  UrPk: "ur-pk",
}

@doc("Improve search recall by spell-correcting individual search query terms.")
union QuerySpellerType {
  string,

  @doc("Speller not enabled.")
  None: "none",

  @doc("Speller corrects individual query terms using a static lexicon for the language specified by the queryLanguage parameter.")
  Lexicon: "lexicon",
}

@doc("The kind of vector query being performed.")
union VectorQueryKind {
  string,

  @doc("Vector query where a raw vector value is provided.")
  Vector: "vector",

  @doc("Vector query where a text value that needs to be vectorized is provided.")
  Text: "text",

  @doc("Vector query where an url that represents an image value that needs to be vectorized is provided.")
  ImageUrl: "imageUrl",

  @doc("Vector query where a base 64 encoded binary of an image that needs to be vectorized is provided.")
  ImageBinary: "imageBinary",
}

@doc("The kind of threshold used to filter vector queries.")
union VectorThresholdKind {
  string,

  @doc("The results of the vector query will be filtered based on the vector similarity metric. Note this is the canonical definition of similarity metric, not the 'distance' version. The threshold direction (larger or smaller) will be chosen automatically according to the metric used by the field.")
  VectorSimilarity: "vectorSimilarity",

  @doc("The results of the vector query will filter based on the '\@search.score' value. Note this is the \@search.score returned as part of the search response. The threshold direction will be chosen for higher \@search.score.")
  SearchScore: "searchScore",
}

@doc("Determines whether or not filters are applied before or after the vector search is performed.")
union VectorFilterMode {
  string,

  @doc("The filter will be applied after the candidate set of vector results is returned. Depending on the filter selectivity, this can result in fewer results than requested by the parameter 'k'.")
  PostFilter: "postFilter",

  @doc("The filter will be applied before the search query.")
  PreFilter: "preFilter",

  @doc("The filter will be applied after the global top-k candidate set of vector results is returned. This will result in fewer results than requested by the parameter 'k'.")
  StrictPostFilter: "strictPostFilter",
}

@doc("Determines whether the count and facets should includes all documents that matched the search query, or only the documents that are retrieved within the 'maxTextRecallSize' window. The default value is 'countAllResults'.")
union HybridCountAndFacetMode {
  string,

  @doc("Only include documents that were matched within the 'maxTextRecallSize' retrieval window when computing 'count' and 'facets'.")
  CountRetrievableResults: "countRetrievableResults",

  @doc("Include all documents that were matched by the search query when computing 'count' and 'facets', regardless of whether or not those documents are within the 'maxTextRecallSize' retrieval window.")
  CountAllResults: "countAllResults",
}

@doc("The way the field was used for the semantic enrichment process.")
union SemanticFieldState {
  string,

  @doc("The field was fully used for semantic enrichment.")
  Used: "used",

  @doc("The field was not used for semantic enrichment.")
  Unused: "unused",

  @doc("The field was partially used for semantic enrichment.")
  Partial: "partial",
}

@doc("Reason that a partial response was returned for a semantic ranking request.")
union SemanticErrorReason {
  string,

  @doc("If `semanticMaxWaitInMilliseconds` was set and the semantic processing duration exceeded that value. Only the base results were returned.")
  MaxWaitExceeded: "maxWaitExceeded",

  @doc("The request was throttled. Only the base results were returned.")
  CapacityOverloaded: "capacityOverloaded",

  @doc("At least one step of the semantic process failed.")
  Transient: "transient",
}

@doc("Type of partial response that was returned for a semantic ranking request.")
union SemanticSearchResultsType {
  string,

  @doc("Results without any semantic enrichment or reranking.")
  BaseResults: "baseResults",

  @doc("Results have been reranked with the reranker model and will include semantic captions. They will not include any answers, answers highlights or caption highlights.")
  RerankedResults: "rerankedResults",
}

@doc("Type of query rewrite that was used for this request.")
union SemanticQueryRewritesResultType {
  string,

  @doc("Query rewrites were not successfully generated for this request. Only the original query was used to retrieve the results.")
  OriginalQueryOnly: "originalQueryOnly",
}

@doc("Specifies the syntax of the search query. The default is 'simple'. Use 'full' if your query uses the Lucene query syntax and 'semantic' if query syntax is not needed.")
union QueryType {
  string,

  @doc("Uses the simple query syntax for searches. Search text is interpreted using a simple query language that allows for symbols such as +, * and \"\". Queries are evaluated across all searchable fields by default, unless the searchFields parameter is specified.")
  Simple: "simple",

  @doc("Uses the full Lucene query syntax for searches. Search text is interpreted using the Lucene query language which allows field-specific and weighted searches, as well as other advanced features.")
  Full: "full",

  @doc("Best suited for queries expressed in natural language as opposed to keywords. Improves precision of search results by re-ranking the top search results using a ranking model trained on the Web corpus.")
  Semantic: "semantic",
}

@doc("Specifies whether any or all of the search terms must be matched in order to count the document as a match.")
union SearchMode {
  string,

  @doc("Any of the search terms must be matched in order to count the document as a match.")
  Any: "any",

  @doc("All of the search terms must be matched in order to count the document as a match.")
  All: "all",
}

@doc("A value that specifies whether we want to calculate scoring statistics (such as document frequency) globally for more consistent scoring, or locally, for lower latency. The default is 'local'. Use 'global' to aggregate scoring statistics globally before scoring. Using global scoring statistics can increase latency of search queries.")
union ScoringStatistics {
  string,

  @doc("The scoring statistics will be calculated locally for lower latency.")
  Local: "local",

  @doc("The scoring statistics will be calculated globally for more consistent scoring.")
  Global: "global",
}

@doc("The operation to perform on a document in an indexing batch.")
union IndexActionType {
  string,

  @doc("Inserts the document into the index if it is new and updates it if it exists. All fields are replaced in the update case.")
  Upload: "upload",

  @doc("Merges the specified field values with an existing document. If the document does not exist, the merge will fail. Any field you specify in a merge will replace the existing field in the document. This also applies to collections of primitive and complex types.")
  Merge: "merge",

  @doc("Behaves like merge if a document with the given key already exists in the index. If the document does not exist, it behaves like upload with a new document.")
  MergeOrUpload: "mergeOrUpload",

  @doc("Removes the specified document from the index. Any field you specify in a delete operation other than the key field will be ignored. If you want to remove an individual field from a document, use merge instead and set the field explicitly to null.")
  Delete: "delete",
}

@doc("Specifies the mode for Autocomplete. The default is 'oneTerm'. Use 'twoTerms' to get shingles and 'oneTermWithContext' to use the current context in producing autocomplete terms.")
union AutocompleteMode {
  string,

  @doc("Only one term is suggested. If the query has two terms, only the last term is completed. For example, if the input is 'washington medic', the suggested terms could include 'medicaid', 'medicare', and 'medicine'.")
  OneTerm: "oneTerm",

  @doc("Matching two-term phrases in the index will be suggested. For example, if the input is 'medic', the suggested terms could include 'medicare coverage' and 'medical assistant'.")
  TwoTerms: "twoTerms",

  @doc("Completes the last term in a query with two or more terms, where the last two terms are a phrase that exists in the index. For example, if the input is 'washington medic', the suggested terms could include 'washington medicaid' and 'washington medical'.")
  OneTermWithContext: "oneTermWithContext",
}

@doc("Parameters grouped for search operations.")
model SearchOptions {
  @doc("A value that specifies whether to fetch the total count of results. Default is false. Setting this value to true may have a performance impact. Note that the count returned is an approximation.")
  @query("$count")
  includeTotalResultCount?: boolean;

  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing"
  @doc("The list of facet expressions to apply to the search query. Each facet expression contains a field name, optionally followed by a comma-separated list of name:value pairs.")
  @query(#{ name: "facet", explode: true })
  facets?: string[];

  @doc("The OData $filter expression to apply to the search query.")
  @query("$filter")
  filter?: string;

  @doc("The list of field names to use for hit highlights. Only searchable fields can be used for hit highlighting.")
  @query("highlight")
  highlightFields?: string[];

  @doc("A string tag that is appended to hit highlights. Must be set with highlightPreTag. Default is &lt;/em&gt;.")
  @query
  highlightPostTag?: string;

  @doc("A string tag that is prepended to hit highlights. Must be set with highlightPostTag. Default is &lt;em&gt;.")
  @query
  highlightPreTag?: string;

  @doc("A number between 0 and 100 indicating the percentage of the index that must be covered by a search query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 100.")
  @query
  minimumCoverage?: float64;

  @doc("The list of OData $orderby expressions by which to sort the results. Each expression can be either a field name or a call to either the geo.distance() or the search.score() functions. Each expression can be followed by asc to indicate ascending, and desc to indicate descending. The default is ascending order. Ties will be broken by the match scores of documents. If no OrderBy is specified, the default sort order is descending by document match score. There can be at most 32 $orderby clauses.")
  @query("$orderby")
  orderBy?: string[];

  @doc("A value that specifies the syntax of the search query. The default is 'simple'. Use 'full' if your query uses the Lucene query syntax.")
  @query
  queryType?: QueryType;

  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing"
  @doc("The list of parameter values to be used in scoring functions (for example, referencePointParameter) using the format name-values. For example, if the scoring profile defines a function with a parameter called 'mylocation' the parameter string would be \"mylocation--122.2,44.8\" (without the quotes).")
  @query(#{ name: "scoringParameter", explode: true })
  scoringParameters?: string[];

  @doc("The name of a scoring profile to evaluate match scores for matching documents in order to sort the results.")
  @query
  scoringProfile?: string;

  @doc("The list of field names to which to scope the full-text search. When using fielded search (fieldName:searchExpression) in a full Lucene query, the field names of each fielded search expression take precedence over any field names listed in this parameter.")
  @query
  searchFields?: string[];

  @doc("A value that specifies whether any or all of the search terms must be matched in order to count the document as a match.")
  @query
  searchMode?: SearchMode;

  @doc("A value that specifies whether we want to calculate scoring statistics (such as document frequency) globally for more consistent scoring, or locally, for lower latency.")
  @query
  scoringStatistics?: ScoringStatistics;

  @doc("A value to be used to create a sticky session, which can help to get more consistent results. As long as the same sessionId is used, a best-effort attempt will be made to target the same replica set. Be wary that reusing the same sessionID values repeatedly can interfere with the load balancing of the requests across replicas and adversely affect the performance of the search service. The value used as sessionId cannot start with a '_' character.")
  @query
  sessionId?: string;

  @doc("The list of fields to retrieve. If unspecified, all fields marked as retrievable in the schema are included.")
  @query("$select")
  select?: string[];

  @doc("The number of search results to skip. This value cannot be greater than 100,000. If you need to scan documents in sequence, but cannot use $skip due to this limitation, consider using $orderby on a totally-ordered key and $filter with a range query instead.")
  @query("$skip")
  skip?: int32;

  @doc("The number of search results to retrieve. This can be used in conjunction with $skip to implement client-side paging of search results. If results are truncated due to server-side paging, the response will include a continuation token that can be used to issue another Search request for the next page of results.")
  @query("$top")
  top?: int32;

  @doc("The name of the semantic configuration that lists which fields should be used for semantic ranking, captions, highlights, and answers")
  @query
  semanticConfiguration?: string;

  @doc("Allows the user to choose whether a semantic call should fail completely, or to return partial results (default).")
  @query
  semanticErrorHandling?: SemanticErrorMode;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Allows the user to set an upper bound on the amount of time it takes for semantic enrichment to finish processing before the request fails.")
  @minValue(700)
  @query
  semanticMaxWaitInMilliseconds?: int32 | null;

  @doc("This parameter is only valid if the query type is `semantic`. If set, the query returns answers extracted from key passages in the highest ranked documents. The number of answers returned can be configured by appending the pipe character `|` followed by the `count-<number of answers>` option after the answers parameter value, such as `extractive|count-3`. Default count is 1. The confidence threshold can be configured by appending the pipe character `|` followed by the `threshold-<confidence threshold>` option after the answers parameter value, such as `extractive|threshold-0.9`. Default threshold is 0.7. The maximum character length of answers can be configured by appending the pipe character '|' followed by the 'count-<number of maximum character length>', such as 'extractive|maxcharlength-600'.")
  @query
  answers?: QueryAnswerType;

  @doc("This parameter is only valid if the query type is `semantic`. If set, the query returns captions extracted from key passages in the highest ranked documents. When Captions is set to `extractive`, highlighting is enabled by default, and can be configured by appending the pipe character `|` followed by the `highlight-<true/false>` option, such as `extractive|highlight-true`. Defaults to `None`. The maximum character length of captions can be configured by appending the pipe character '|' followed by the 'count-<number of maximum character length>', such as 'extractive|maxcharlength-600'.")
  @query
  captions?: QueryCaptionType;

  @doc("Allows setting a separate search query that will be solely used for semantic reranking, semantic captions and semantic answers. Is useful for scenarios where there is a need to use different queries between the base retrieval and ranking phase, and the L2 semantic phase.")
  @query
  semanticQuery?: string;

  @doc("When QueryRewrites is set to `generative`, the query terms are sent to a generate model which will produce 10 (default) rewrites to help increase the recall of the request. The requested count can be configured by appending the pipe character `|` followed by the `count-<number of rewrites>` option, such as `generative|count-3`. Defaults to `None`. This parameter is only valid if the query type is `semantic`.")
  @query
  queryRewrites?: QueryRewritesType;

  @doc("Enables a debugging tool that can be used to further explore your search results.")
  @query
  debug?: QueryDebugMode;

  @doc("The language of the query.")
  @query
  queryLanguage?: QueryLanguage;

  @doc("Improve search recall by spell-correcting individual search query terms.")
  @query
  speller?: QuerySpellerType;

  @doc("The list of field names used for semantic ranking.")
  @query
  semanticFields?: string[];
}

@doc("Parameters grouped for suggest operations.")
model SuggestOptions {
  @doc("An OData expression that filters the documents considered for suggestions.")
  @query("$filter")
  filter?: string;

  @doc("A value indicating whether to use fuzzy matching for the suggestions query. Default is false. When set to true, the query will find terms even if there's a substituted or missing character in the search text. While this provides a better experience in some scenarios, it comes at a performance cost as fuzzy suggestions queries are slower and consume more resources.")
  @query("fuzzy")
  useFuzzyMatching?: boolean;

  @doc("A string tag that is appended to hit highlights. Must be set with highlightPreTag. If omitted, hit highlighting of suggestions is disabled.")
  @query
  highlightPostTag?: string;

  @doc("A string tag that is prepended to hit highlights. Must be set with highlightPostTag. If omitted, hit highlighting of suggestions is disabled.")
  @query
  highlightPreTag?: string;

  @doc("A number between 0 and 100 indicating the percentage of the index that must be covered by a suggestions query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 80.")
  @query
  minimumCoverage?: float64;

  @doc("The list of OData $orderby expressions by which to sort the results. Each expression can be either a field name or a call to either the geo.distance() or the search.score() functions. Each expression can be followed by asc to indicate ascending, or desc to indicate descending. The default is ascending order. Ties will be broken by the match scores of documents. If no $orderby is specified, the default sort order is descending by document match score. There can be at most 32 $orderby clauses.")
  @query("$orderby")
  orderBy?: string[];

  @doc("The list of field names to search for the specified search text. Target fields must be included in the specified suggester.")
  @query
  searchFields?: string[];

  @doc("The list of fields to retrieve. If unspecified, only the key field will be included in the results.")
  @query("$select")
  select?: string[];

  @doc("The number of suggestions to retrieve. The value must be a number between 1 and 100. The default is 5.")
  @query("$top")
  top?: int32;
}

@doc("Response containing search results from an index.")
model SearchDocumentsResult {
  @doc("The total count of results found by the search operation, or null if the count was not requested. If present, the count may be greater than the number of results in this response. This can happen if you use the $top or $skip parameters, or if the query can't return all the requested documents in a single response.")
  @encodedName("application/json", "@odata.count")
  @visibility(Lifecycle.Read)
  count?: int64;

  @doc("A value indicating the percentage of the index that was included in the query, or null if minimumCoverage was not specified in the request.")
  @encodedName("application/json", "@search.coverage")
  @visibility(Lifecycle.Read)
  coverage?: float64;

  @doc("The facet query results for the search operation, organized as a collection of buckets for each faceted field; null if the query did not include any facet expressions.")
  @encodedName("application/json", "@search.facets")
  @visibility(Lifecycle.Read)
  facets?: Record<FacetResult[]>;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The answers query results for the search operation; null if the answers query parameter was not specified or set to 'none'.")
  @encodedName("application/json", "@search.answers")
  @visibility(Lifecycle.Read)
  answers?: QueryAnswerResult[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Debug information that applies to the search results as a whole.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.debug")
  debugInfo?: DebugInfo | null;

  @doc("Continuation JSON payload returned when the query can't return all the requested results in a single response. You can use this JSON along with @odata.nextLink to formulate another POST Search request to get the next part of the search response.")
  @encodedName("application/json", "@search.nextPageParameters")
  @visibility(Lifecycle.Read)
  nextPageParameters?: SearchRequest;

  @doc("The sequence of results returned by the query.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: SearchResult[];

  @doc("Continuation URL returned when the query can't return all the requested results in a single response. You can use this URL to formulate another GET or POST Search request to get the next part of the search response. Make sure to use the same verb (GET or POST) as the request that produced this response.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@odata.nextLink")
  @nextLink
  nextLink?: string;

  @doc("Reason that a partial response was returned for a semantic ranking request.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.semanticPartialResponseReason")
  semanticPartialResponseReason?: SemanticErrorReason;

  @doc("Type of partial response that was returned for a semantic ranking request.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.semanticPartialResponseType")
  semanticPartialResponseType?: SemanticSearchResultsType;

  @doc("Type of query rewrite that was used to retrieve documents.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.semanticQueryRewritesResultType")
  semanticQueryRewritesResultType?: SemanticQueryRewritesResultType;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("A single bucket of a facet query result. Reports the number of documents with a field value falling within a particular range or having a particular value or interval.")
model FacetResult is Record<unknown> {
  @doc("The approximate count of documents falling within the bucket described by this facet.")
  @visibility(Lifecycle.Read)
  count?: int64;

  @doc("The resulting total avg for the facet when a avg metric is requested.")
  @visibility(Lifecycle.Read)
  avg?: float64;

  @doc("The resulting total min for the facet when a min metric is requested.")
  @visibility(Lifecycle.Read)
  min?: float64;

  @doc("The resulting total max for the facet when a max metric is requested.")
  @visibility(Lifecycle.Read)
  max?: float64;

  @doc("The resulting total sum for the facet when a sum metric is requested.")
  @visibility(Lifecycle.Read)
  sum?: float64;

  @doc("The resulting total cardinality for the facet when a cardinality metric is requested.")
  @visibility(Lifecycle.Read)
  cardinality?: int64;

  @doc("The nested facet query results for the search operation, organized as a collection of buckets for each faceted field; null if the query did not contain any nested facets.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.facets")
  facets?: Record<FacetResult[]>;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("An answer is a text passage extracted from the contents of the most relevant documents that matched the query. Answers are extracted from the top search results. Answer candidates are scored and the top answers are selected.")
model QueryAnswerResult is Record<unknown> {
  @doc("The score value represents how relevant the answer is to the query relative to other answers returned for the query.")
  @visibility(Lifecycle.Read)
  score?: float64;

  @doc("The key of the document the answer was extracted from.")
  @visibility(Lifecycle.Read)
  key?: string;

  @doc("The text passage extracted from the document contents as the answer.")
  @visibility(Lifecycle.Read)
  text?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Same text passage as in the Text property with highlighted text phrases most relevant to the query.")
  @visibility(Lifecycle.Read)
  highlights?: string | null;
}

@doc("Contains debugging information that can be used to further explore your search results.")
model DebugInfo {
  @doc("Contains debugging information specific to query rewrites.")
  @visibility(Lifecycle.Read)
  queryRewrites?: QueryRewritesDebugInfo;
}

@doc("Contains debugging information specific to query rewrites.")
model QueryRewritesDebugInfo {
  @doc("List of query rewrites generated for the text query.")
  @visibility(Lifecycle.Read)
  text?: QueryRewritesValuesDebugInfo;

  @doc("List of query rewrites generated for the vectorizable text queries.")
  @visibility(Lifecycle.Read)
  vectors?: QueryRewritesValuesDebugInfo[];
}

@doc("Contains debugging information specific to query rewrites.")
model QueryRewritesValuesDebugInfo {
  @doc("The input text to the generative query rewriting model. There may be cases where the user query and the input to the generative model are not identical.")
  @visibility(Lifecycle.Read)
  inputQuery?: string;

  @doc("List of query rewrites.")
  @visibility(Lifecycle.Read)
  rewrites?: string[];
}

@doc("Parameters for filtering, sorting, faceting, paging, and other search query behaviors.")
model SearchRequest {
  @doc("A value that specifies whether to fetch the total count of results. Default is false. Setting this value to true may have a performance impact. Note that the count returned is an approximation.")
  count?: boolean;

  @doc("The list of facet expressions to apply to the search query. Each facet expression contains a field name, optionally followed by a comma-separated list of name:value pairs.")
  facets?: string[];

  @doc("The OData $filter expression to apply to the search query.")
  filter?: string;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of field names to use for hit highlights. Only searchable fields can be used for hit highlighting.")
  @encode(ArrayEncoding.commaDelimited)
  highlight?: string;

  @doc("A string tag that is appended to hit highlights. Must be set with highlightPreTag. Default is &lt;/em&gt;.")
  highlightPostTag?: string;

  @doc("A string tag that is prepended to hit highlights. Must be set with highlightPostTag. Default is &lt;em&gt;.")
  highlightPreTag?: string;

  @doc("A number between 0 and 100 indicating the percentage of the index that must be covered by a search query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 100.")
  minimumCoverage?: float64;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of OData $orderby expressions by which to sort the results. Each expression can be either a field name or a call to either the geo.distance() or the search.score() functions. Each expression can be followed by asc to indicate ascending, or desc to indicate descending. The default is ascending order. Ties will be broken by the match scores of documents. If no $orderby is specified, the default sort order is descending by document match score. There can be at most 32 $orderby clauses.")
  @encode(ArrayEncoding.commaDelimited)
  orderby?: string;

  @doc("A value that specifies the syntax of the search query. The default is 'simple'. Use 'full' if your query uses the Lucene query syntax.")
  queryType?: QueryType;

  @doc("A value that specifies whether we want to calculate scoring statistics (such as document frequency) globally for more consistent scoring, or locally, for lower latency. The default is 'local'. Use 'global' to aggregate scoring statistics globally before scoring. Using global scoring statistics can increase latency of search queries.")
  scoringStatistics?: ScoringStatistics;

  @doc("A value to be used to create a sticky session, which can help getting more consistent results. As long as the same sessionId is used, a best-effort attempt will be made to target the same replica set. Be wary that reusing the same sessionID values repeatedly can interfere with the load balancing of the requests across replicas and adversely affect the performance of the search service. The value used as sessionId cannot start with a '_' character.")
  sessionId?: string;

  @doc("The list of parameter values to be used in scoring functions (for example, referencePointParameter) using the format name-values. For example, if the scoring profile defines a function with a parameter called 'mylocation' the parameter string would be \"mylocation--122.2,44.8\" (without the quotes).")
  scoringParameters?: string[];

  @doc("The name of a scoring profile to evaluate match scores for matching documents in order to sort the results.")
  scoringProfile?: string;

  @doc("Enables a debugging tool that can be used to further explore your reranked results.")
  debug?: QueryDebugMode;

  @doc("A full-text search query expression; Use \"*\" or omit this parameter to match all documents.")
  search?: string;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of field names to which to scope the full-text search. When using fielded search (fieldName:searchExpression) in a full Lucene query, the field names of each fielded search expression take precedence over any field names listed in this parameter.")
  @encode(ArrayEncoding.commaDelimited)
  searchFields?: string;

  @doc("A value that specifies whether any or all of the search terms must be matched in order to count the document as a match.")
  searchMode?: SearchMode;

  @doc("A value that specifies the language of the search query.")
  queryLanguage?: QueryLanguage;

  @doc("A value that specifies the type of the speller to use to spell-correct individual search query terms.")
  speller?: QuerySpellerType;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of fields to retrieve. If unspecified, all fields marked as retrievable in the schema are included.")
  @encode(ArrayEncoding.commaDelimited)
  select?: string;

  @doc("The number of search results to skip. This value cannot be greater than 100,000. If you need to scan documents in sequence, but cannot use skip due to this limitation, consider using orderby on a totally-ordered key and filter with a range query instead.")
  skip?: int32;

  @doc("The number of search results to retrieve. This can be used in conjunction with $skip to implement client-side paging of search results. If results are truncated due to server-side paging, the response will include a continuation token that can be used to issue another Search request for the next page of results.")
  top?: int32;

  @doc("The name of a semantic configuration that will be used when processing documents for queries of type semantic.")
  semanticConfiguration?: string;

  @doc("Allows the user to choose whether a semantic call should fail completely (default / current behavior), or to return partial results.")
  semanticErrorHandling?: SemanticErrorMode;

  @doc("Allows the user to set an upper bound on the amount of time it takes for semantic enrichment to finish processing before the request fails.")
  @minValue(700)
  semanticMaxWaitInMilliseconds?: int32;

  @doc("Allows setting a separate search query that will be solely used for semantic reranking, semantic captions and semantic answers. Is useful for scenarios where there is a need to use different queries between the base retrieval and ranking phase, and the L2 semantic phase.")
  semanticQuery?: string;

  @doc("A value that specifies whether answers should be returned as part of the search response.")
  answers?: QueryAnswerType;

  @doc("A value that specifies whether captions should be returned as part of the search response.")
  captions?: QueryCaptionType;

  @doc("A value that specifies whether query rewrites should be generated to augment the search query.")
  queryRewrites?: QueryRewritesType;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of field names used for semantic ranking.")
  @encode(ArrayEncoding.commaDelimited)
  semanticFields?: string;

  @doc("The query parameters for vector and hybrid search queries.")
  vectorQueries?: VectorQuery[];

  @doc("Determines whether or not filters are applied before or after the vector search is performed. Default is 'preFilter' for new indexes.")
  vectorFilterMode?: VectorFilterMode;

  @doc("The query parameters to configure hybrid search behaviors.")
  hybridSearch?: HybridSearch;
}

@doc("The query parameters for vector and hybrid search queries.")
@discriminator("kind")
model VectorQuery {
  @doc("Number of nearest neighbors to return as top hits.")
  k?: int32;

  @doc("Vector Fields of type Collection(Edm.Single) to be included in the vector searched.")
  fields?: string;

  @doc("When true, triggers an exhaustive k-nearest neighbor search across all vectors within the vector index. Useful for scenarios where exact matches are critical, such as determining ground truth values.")
  exhaustive?: boolean;

  @doc("Oversampling factor. Minimum value is 1. It overrides the 'defaultOversampling' parameter configured in the index definition. It can be set only when 'rerankWithOriginalVectors' is true. This parameter is only permitted when a compression method is used on the underlying vector field.")
  oversampling?: float64;

  @doc("Relative weight of the vector query when compared to other vector query and/or the text query within the same search request. This value is used when combining the results of multiple ranking lists produced by the different vector queries and/or the results retrieved through the text query. The higher the weight, the higher the documents that matched that query will be in the final ranking. Default is 1.0 and the value needs to be a positive number larger than zero.")
  weight?: float32;

  @doc("The threshold used for vector queries. Note this can only be set if all 'fields' use the same similarity metric.")
  threshold?: VectorThreshold;

  @doc("The OData filter expression to apply to this specific vector query. If no filter expression is defined at the vector level, the expression defined in the top level filter parameter is used instead.")
  filterOverride?: string;

  @doc("Controls how many vectors can be matched from each document in a vector search query. Setting it to 1 ensures at most one vector per document is matched, guaranteeing results come from distinct documents. Setting it to 0 (unlimited) allows multiple relevant vectors from the same document to be matched. Default is 0.")
  perDocumentVectorLimit?: int32;

  @doc("Type of query.")
  kind: VectorQueryKind;
}

@doc("The threshold used for vector queries.")
@discriminator("kind")
model VectorThreshold {
  @doc("Type of threshold.")
  kind: VectorThresholdKind;
}

@doc("TThe query parameters to configure hybrid search behaviors.")
model HybridSearch {
  @doc("Determines the maximum number of documents to be retrieved by the text query portion of a hybrid search request. Those documents will be combined with the documents matching the vector queries to produce a single final list of results. Choosing a larger maxTextRecallSize value will allow retrieving and paging through more documents (using the top and skip parameters), at the cost of higher resource utilization and higher latency. The value needs to be between 1 and 10,000. Default is 1000.")
  maxTextRecallSize?: int32;

  @doc("Determines whether the count and facets should includes all documents that matched the search query, or only the documents that are retrieved within the 'maxTextRecallSize' window.")
  countAndFacetMode?: HybridCountAndFacetMode;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("Contains a document found by a search query, plus associated metadata.")
model SearchResult {
  ...Record<unknown>;

  @doc("The relevance score of the document compared to other documents returned by the query.")
  @encodedName("application/json", "@search.score")
  @visibility(Lifecycle.Read)
  score: float64;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The relevance score computed by the semantic ranker for the top search results. Search results are sorted by the RerankerScore first and then by the Score. RerankerScore is only returned for queries of type 'semantic'.")
  @encodedName("application/json", "@search.rerankerScore")
  @visibility(Lifecycle.Read)
  rerankerScore?: float64 | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The relevance score computed by boosting the Reranker Score. Search results are sorted by the RerankerScore/RerankerBoostedScore based on useScoringProfileBoostedRanking in the Semantic Config. RerankerBoostedScore is only returned for queries of type 'semantic'.")
  @encodedName("application/json", "@search.rerankerBoostedScore")
  @visibility(Lifecycle.Read)
  rerankerBoostedScore?: float64 | null;

  @doc("Text fragments from the document that indicate the matching search terms, organized by each applicable field; null if hit highlighting was not enabled for the query.")
  @encodedName("application/json", "@search.highlights")
  @visibility(Lifecycle.Read)
  highlights?: Record<string[]>;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Captions are the most representative passages from the document relatively to the search query. They are often used as document summary. Captions are only returned for queries of type 'semantic'.")
  @encodedName("application/json", "@search.captions")
  @visibility(Lifecycle.Read)
  captions?: QueryCaptionResult[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Contains debugging information that can be used to further explore your search results.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.documentDebugInfo")
  documentDebugInfo?: DocumentDebugInfo | null;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("Captions are the most representative passages from the document relatively to the search query. They are often used as document summary. Captions are only returned for queries of type `semantic`.")
model QueryCaptionResult {
  ...Record<unknown>;

  @doc("A representative text passage extracted from the document most relevant to the search query.")
  @visibility(Lifecycle.Read)
  text?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Same text passage as in the Text property with highlighted phrases most relevant to the query.")
  @visibility(Lifecycle.Read)
  highlights?: string | null;
}

@doc("Contains debugging information that can be used to further explore your search results.")
model DocumentDebugInfo {
  @doc("Contains debugging information specific to semantic ranking requests.")
  @visibility(Lifecycle.Read)
  semantic?: SemanticDebugInfo;

  @doc("Contains debugging information specific to vector and hybrid search.")
  @visibility(Lifecycle.Read)
  vectors?: VectorsDebugInfo;

  @doc("Contains debugging information specific to vectors matched within a collection of complex types.")
  @visibility(Lifecycle.Read)
  innerHits?: Record<QueryResultDocumentInnerHit[]>;
}

@doc("Contains debugging information specific to semantic ranking requests.")
model SemanticDebugInfo {
  @doc("The title field that was sent to the semantic enrichment process, as well as how it was used")
  @visibility(Lifecycle.Read)
  titleField?: QueryResultDocumentSemanticField;

  @doc("The content fields that were sent to the semantic enrichment process, as well as how they were used")
  @visibility(Lifecycle.Read)
  contentFields?: QueryResultDocumentSemanticField[];

  @doc("The keyword fields that were sent to the semantic enrichment process, as well as how they were used")
  @visibility(Lifecycle.Read)
  keywordFields?: QueryResultDocumentSemanticField[];

  @doc("The raw concatenated strings that were sent to the semantic enrichment process.")
  @visibility(Lifecycle.Read)
  rerankerInput?: QueryResultDocumentRerankerInput;
}

@doc("Detailed scoring information for an individual element of a complex collection.")
model QueryResultDocumentInnerHit {
  @doc("Position of this specific matching element within it's original collection. Position starts at 0.")
  @visibility(Lifecycle.Read)
  ordinal?: int64;

  @doc("Detailed scoring information for an individual element of a complex collection that matched a vector query.")
  @visibility(Lifecycle.Read)
  vectors?: Record<SingleVectorFieldResult>[];
}

@doc("Description of fields that were sent to the semantic enrichment process, as well as how they were used")
model QueryResultDocumentSemanticField {
  @doc("The name of the field that was sent to the semantic enrichment process")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The way the field was used for the semantic enrichment process (fully used, partially used, or unused)")
  @visibility(Lifecycle.Read)
  state?: SemanticFieldState;
}

@doc("The raw concatenated strings that were sent to the semantic enrichment process.")
model QueryResultDocumentRerankerInput {
  @doc("The raw string for the title field that was used for semantic enrichment.")
  @visibility(Lifecycle.Read)
  title?: string;

  @doc("The raw concatenated strings for the content fields that were used for semantic enrichment.")
  @visibility(Lifecycle.Read)
  content?: string;

  @doc("The raw concatenated strings for the keyword fields that were used for semantic enrichment.")
  @visibility(Lifecycle.Read)
  keywords?: string;
}

@doc("\"Contains debugging information specific to vector and hybrid search.\")")
model VectorsDebugInfo {
  @doc("The breakdown of subscores of the document prior to the chosen result set fusion/combination method such as RRF.")
  @visibility(Lifecycle.Read)
  subscores?: QueryResultDocumentSubscores;
}

@doc("The breakdown of subscores between the text and vector query components of the search query for this document. Each vector query is shown as a separate object in the same order they were received.")
model QueryResultDocumentSubscores {
  @doc("The BM25 or Classic score for the text portion of the query.")
  @visibility(Lifecycle.Read)
  text?: TextResult;

  @doc("The vector similarity and \@search.score values for each vector query.")
  @visibility(Lifecycle.Read)
  vectors?: Record<SingleVectorFieldResult>[];

  @doc("The BM25 or Classic score for the text portion of the query.")
  @visibility(Lifecycle.Read)
  documentBoost?: float64;
}

@doc("The BM25 or Classic score for the text portion of the query.")
model TextResult {
  @doc("The BM25 or Classic score for the text portion of the query.")
  @visibility(Lifecycle.Read)
  searchScore?: float64;
}

@doc("A single vector field result. Both \@search.score and vector similarity values are returned. Vector similarity is related to \@search.score by an equation.")
model SingleVectorFieldResult {
  @doc("The \@search.score value that is calculated from the vector similarity score. This is the score that's visible in a pure single-field single-vector query.")
  @visibility(Lifecycle.Read)
  searchScore?: float64;

  @doc("The vector similarity score for this document. Note this is the canonical definition of similarity metric, not the 'distance' version. For example, cosine similarity instead of cosine distance.")
  @visibility(Lifecycle.Read)
  vectorSimilarity?: float64;
}

@doc("Response containing suggestion query results from an index.")
model SuggestDocumentsResult {
  @doc("The sequence of results returned by the query.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: SuggestResult[];

  @doc("A value indicating the percentage of the index that was included in the query, or null if minimumCoverage was not set in the request.")
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@search.coverage")
  coverage?: float64;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("A result containing a document found by a suggestion query, plus associated metadata.")
model SuggestResult {
  ...Record<unknown>;

  @doc("The text of the suggestion result.")
  @encodedName("application/json", "@search.text")
  @visibility(Lifecycle.Read)
  text: string;
}

@doc("Parameters for filtering, sorting, fuzzy matching, and other suggestions query behaviors.")
model SuggestRequest {
  @doc("An OData expression that filters the documents considered for suggestions.")
  filter?: string;

  @doc("A value indicating whether to use fuzzy matching for the suggestion query. Default is false. When set to true, the query will find suggestions even if there's a substituted or missing character in the search text. While this provides a better experience in some scenarios, it comes at a performance cost as fuzzy suggestion searches are slower and consume more resources.")
  fuzzy?: boolean;

  @doc("A string tag that is appended to hit highlights. Must be set with highlightPreTag. If omitted, hit highlighting of suggestions is disabled.")
  highlightPostTag?: string;

  @doc("A string tag that is prepended to hit highlights. Must be set with highlightPostTag. If omitted, hit highlighting of suggestions is disabled.")
  highlightPreTag?: string;

  @doc("A number between 0 and 100 indicating the percentage of the index that must be covered by a suggestion query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 80.")
  minimumCoverage?: float64;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of OData $orderby expressions by which to sort the results. Each expression can be either a field name or a call to either the geo.distance() or the search.score() functions. Each expression can be followed by asc to indicate ascending, or desc to indicate descending. The default is ascending order. Ties will be broken by the match scores of documents. If no $orderby is specified, the default sort order is descending by document match score. There can be at most 32 $orderby clauses.")
  @encode(ArrayEncoding.commaDelimited)
  orderby?: string;

  @doc("The search text to use to suggest documents. Must be at least 1 character, and no more than 100 characters.")
  search: string;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of field names to search for the specified search text. Target fields must be included in the specified suggester.")
  @encode(ArrayEncoding.commaDelimited)
  searchFields?: string;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of fields to retrieve. If unspecified, only the key field will be included in the results.")
  @encode(ArrayEncoding.commaDelimited)
  select?: string;

  @doc("The name of the suggester as specified in the suggesters collection that's part of the index definition.")
  suggesterName: string;

  @doc("The number of suggestions to retrieve. This must be a value between 1 and 100. The default is 5.")
  top?: int32;
}

@doc("Contains a batch of document write actions to send to the index.")
model IndexBatch {
  @doc("The actions in the batch.")
  value: IndexAction[];
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("Represents an index action that operates on a document.")
model IndexAction {
  ...Record<unknown>;

  @doc("The operation to perform on a document in an indexing batch.")
  @encodedName("application/json", "@search.action")
  actionType?: IndexActionType;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("A document retrieved via a document lookup operation.")
model LookupDocument {
  ...Record<unknown>;
}

@doc("Response containing the status of operations for all documents in the indexing request.")
model IndexDocumentsResult {
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
  @doc("Response containing the status of operations for all actions in the batch.")
  @statusCode
  _: 200 | 207;

  @doc("The list of status information for each document in the indexing request.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: IndexingResult[];
}

@doc("Status of an indexing operation for a single document.")
model IndexingResult {
  @visibility(Lifecycle.Read)
  @doc("The key of a document that was in the indexing request.")
  key: string;

  @visibility(Lifecycle.Read)
  @doc("The error message explaining why the indexing operation failed for the document identified by the key; null if indexing succeeded.")
  errorMessage?: string;

  @visibility(Lifecycle.Read)
  @doc("A value indicating whether the indexing operation succeeded for the document identified by the key.")
  status: boolean;

  @visibility(Lifecycle.Read)
  @doc("The status code of the indexing operation. Possible values include: 200 for a successful update or delete, 201 for successful document creation, 400 for a malformed input document, 404 for document not found, 409 for a version conflict, 422 when the index is temporarily unavailable, or 503 for when the service is too busy.")
  statusCode: int32;
}

@doc("The result of Autocomplete query.")
model AutocompleteResult {
  @doc("A value indicating the percentage of the index that was considered by the autocomplete request, or null if minimumCoverage was not specified in the request.")
  @encodedName("application/json", "@search.coverage")
  @visibility(Lifecycle.Read)
  coverage?: float64;

  @doc("The list of returned Autocompleted items.")
  @pageItems
  @visibility(Lifecycle.Read)
  value: AutocompleteItem[];
}

@doc("The result of Autocomplete requests.")
model AutocompleteItem {
  @doc("The completed term.")
  @visibility(Lifecycle.Read)
  text: string;

  @doc("The query along with the completed term.")
  @visibility(Lifecycle.Read)
  queryPlusText: string;
}

@doc("Parameters for fuzzy matching, and other autocomplete query behaviors.")
model AutocompleteRequest {
  @doc("The search text on which to base autocomplete results.")
  search: string;

  @doc("Specifies the mode for Autocomplete. The default is 'oneTerm'. Use 'twoTerms' to get shingles and 'oneTermWithContext' to use the current context while producing auto-completed terms.")
  autocompleteMode?: AutocompleteMode;

  @doc("An OData expression that filters the documents used to produce completed terms for the Autocomplete result.")
  filter?: string;

  @doc("A value indicating whether to use fuzzy matching for the autocomplete query. Default is false. When set to true, the query will autocomplete terms even if there's a substituted or missing character in the search text. While this provides a better experience in some scenarios, it comes at a performance cost as fuzzy autocomplete queries are slower and consume more resources.")
  fuzzy?: boolean;

  @doc("A string tag that is appended to hit highlights. Must be set with highlightPreTag. If omitted, hit highlighting is disabled.")
  highlightPostTag?: string;

  @doc("A string tag that is prepended to hit highlights. Must be set with highlightPostTag. If omitted, hit highlighting is disabled.")
  highlightPreTag?: string;

  @doc("A number between 0 and 100 indicating the percentage of the index that must be covered by an autocomplete query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 80.")
  minimumCoverage?: float64;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("The comma-separated list of field names to consider when querying for auto-completed terms. Target fields must be included in the specified suggester.")
  @encode(ArrayEncoding.commaDelimited)
  searchFields?: string;

  @doc("The name of the suggester as specified in the suggesters collection that's part of the index definition.")
  suggesterName: string;

  @doc("The number of auto-completed terms to retrieve. This must be a value between 1 and 100. The default is 5.")
  top?: int32;
}

@doc("The query parameters to use for vector search when a raw vector value is provided.")
model VectorizedQuery extends VectorQuery {
  @doc("The vector representation of a search query.")
  vector: float32[];

  @doc("The kind of vector query being performed.")
  kind: "vector";
}

@doc("The query parameters to use for vector search when a text value that needs to be vectorized is provided.")
model VectorizableTextQuery extends VectorQuery {
  @doc("The text to be vectorized to perform a vector search query.")
  text: string;

  @doc("Can be configured to let a generative model rewrite the query before sending it to be vectorized.")
  queryRewrites?: QueryRewritesType;

  @doc("The kind of vector query being performed.")
  kind: "text";
}

@doc("The query parameters to use for vector search when an url that represents an image value that needs to be vectorized is provided.")
model VectorizableImageUrlQuery extends VectorQuery {
  @doc("The URL of an image to be vectorized to perform a vector search query.")
  url?: string;

  @doc("The kind of vector query being performed.")
  kind: "imageUrl";
}

@doc("The query parameters to use for vector search when a base 64 encoded binary of an image that needs to be vectorized is provided.")
model VectorizableImageBinaryQuery extends VectorQuery {
  @doc("The base 64 encoded binary of an image to be vectorized to perform a vector search query.")
  base64Image?: string;

  @doc("The kind of vector query being performed.")
  kind: "imageBinary";
}

@doc("The results of the vector query will be filtered based on the vector similarity metric. Note this is the canonical definition of similarity metric, not the 'distance' version. The threshold direction (larger or smaller) will be chosen automatically according to the metric used by the field.")
model VectorSimilarityThreshold extends VectorThreshold {
  @doc("The threshold will filter based on the similarity metric value. Note this is the canonical definition of similarity metric, not the 'distance' version. The threshold direction (larger or smaller) will be chosen automatically according to the metric used by the field.")
  value: float64;

  @doc("The kind of threshold used to filter vector queries")
  kind: "vectorSimilarity";
}

@doc("The results of the vector query will filter based on the '\@search.score' value. Note this is the \@search.score returned as part of the search response. The threshold direction will be chosen for higher \@search.score.")
model SearchScoreThreshold extends VectorThreshold {
  @doc("The threshold will filter based on the '\@search.score' value. Note this is the \@search.score returned as part of the search response. The threshold direction will be chosen for higher \@search.score.")
  value: float64;

  @doc("The kind of threshold used to filter vector queries")
  kind: "searchScore";
}
