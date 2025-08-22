import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models-index.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.Versioning;

namespace Search;

@route("/indexes('{indexName}')")
interface Documents {
  @doc("Queries the number of documents in the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/docs/$count")
  @get
  count is SearchIndexOperation<{}, int32>;

  @doc("Searches for documents in the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/docs")
  @get
  searchGet is SearchIndexOperation<
    {
      @doc("A full-text search query expression; Use \"*\" or omit this parameter to match all documents.")
      @query("search")
      searchText?: string;

      @doc("A value that specifies whether to fetch the total count of results. Default is false. Setting this value to true may have a performance impact. Note that the count returned is an approximation.")
      @query("$count")
      includeTotalResultCount?: boolean;

      @doc("The list of facet expressions to apply to the search query. Each facet expression contains a field name, optionally followed by a comma-separated list of name:value pairs.")
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing"
      @query(#{ name: "facet", explode: true })
      facets?: string[];

      @doc("The OData $filter expression to apply to the search query.")
      @query
      $filter?: string;

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

      @doc("The list of parameter values to be used in scoring functions (for example, referencePointParameter) using the format name-values. For example, if the scoring profile defines a function with a parameter called 'mylocation' the parameter string would be \"mylocation--122.2,44.8\" (without the quotes).")
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing"
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
      @query
      $select?: string[];

      @doc("The number of search results to skip. This value cannot be greater than 100,000. If you need to scan documents in sequence, but cannot use $skip due to this limitation, consider using $orderby on a totally-ordered key and $filter with a range query instead.")
      @query
      $skip?: int32;

      @doc("The number of search results to retrieve. This can be used in conjunction with $skip to implement client-side paging of search results. If results are truncated due to server-side paging, the response will include a continuation token that can be used to issue another Search request for the next page of results.")
      @query
      $top?: int32;

      @doc("The name of the semantic configuration that lists which fields should be used for semantic ranking, captions, highlights, and answers")
      @query
      semanticConfiguration?: string;

      @doc("Allows the user to choose whether a semantic call should fail completely, or to return partial results (default).")
      @query
      semanticErrorHandling?: SemanticErrorMode;

      @doc("Allows the user to set an upper bound on the amount of time it takes for semantic enrichment to finish processing before the request fails.")
      @minValue(700)
      @query
      semanticMaxWaitInMilliseconds?: int32;

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
      @added(Versions.v2025_08_01_preview)
      @query
      queryRewrites?: QueryRewritesType;

      @doc("Enables a debugging tool that can be used to further explore your search results.")
      @added(Versions.v2025_08_01_preview)
      @query
      debug?: QueryDebugMode;

      @doc("The language of the query.")
      @added(Versions.v2025_08_01_preview)
      @query
      queryLanguage?: QueryLanguage;

      @doc("Improve search recall by spell-correcting individual search query terms.")
      @added(Versions.v2025_08_01_preview)
      @query
      speller?: QuerySpellerType;

      @doc("The list of field names used for semantic ranking.")
      @added(Versions.v2025_08_01_preview)
      @query
      semanticFields?: string[];
    },
    SearchDocumentsResult
  >;

  @doc("Searches for documents in the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/docs/search.post.search")
  @post
  searchPost is SearchIndexOperation<
    {
      @doc("The definition of the Search request.")
      @body
      searchRequest: SearchRequest;
    },
    SearchDocumentsResult
  >;

  @doc("Retrieves a document from the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/docs('{key}')")
  @get
  get is SearchIndexOperation<
    {
      @doc("The key of the document to retrieve.")
      @path
      key: string;

      @doc("List of field names to retrieve for the document; Any field not retrieved will be missing from the returned document.")
      @query("$select")
      selectedFields?: string[];
    },
    LookupDocument
  >;

  @doc("Suggests documents in the index that match the given partial query text.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/docs/search.suggest")
  @get
  suggestGet is SearchIndexOperation<
    {
      @doc("The search text to use to suggest documents. Must be at least 1 character, and no more than 100 characters.")
      @query("search")
      searchText: string;

      @doc("The name of the suggester as specified in the suggesters collection that's part of the index definition.")
      @query
      suggesterName: string;

      @doc("An OData expression that filters the documents considered for suggestions.")
      @query
      $filter?: string;

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
      @query
      $select?: string[];

      @doc("The number of suggestions to retrieve. The value must be a number between 1 and 100. The default is 5.")
      @query
      $top?: int32;
    },
    SuggestDocumentsResult
  >;

  @doc("Suggests documents in the index that match the given partial query text.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/docs/search.post.suggest")
  @post
  suggestPost is SearchIndexOperation<
    {
      @doc("The Suggest request.")
      @body
      suggestRequest: SuggestRequest;
    },
    SuggestDocumentsResult
  >;

  @doc("Sends a batch of document write actions to the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/docs/search.index")
  @post
  index is SearchIndexOperation<
    {
      @doc("The batch of index actions.")
      @body
      batch: IndexBatch;
    },
    IndexDocumentsResult
  >;

  @doc("Autocompletes incomplete query terms based on input text and matching terms in the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/docs/search.autocomplete")
  @get
  autocompleteGet is SearchIndexOperation<
    {
      @doc("The incomplete term which should be auto-completed.")
      @query("search")
      searchText: string;

      @doc("The name of the suggester as specified in the suggesters collection that's part of the index definition.")
      @query
      suggesterName: string;

      @doc("Specifies the mode for Autocomplete. The default is 'oneTerm'. Use 'twoTerms' to get shingles and 'oneTermWithContext' to use the current context while producing auto-completed terms.")
      @query
      autocompleteMode?: AutocompleteMode;

      @doc("An OData expression that filters the documents used to produce completed terms for the Autocomplete result.")
      @query
      $filter?: string;

      @doc("A value indicating whether to use fuzzy matching for the autocomplete query. Default is false. When set to true, the query will find terms even if there's a substituted or missing character in the search text. While this provides a better experience in some scenarios, it comes at a performance cost as fuzzy autocomplete queries are slower and consume more resources.")
      @query("fuzzy")
      useFuzzyMatching?: boolean;

      @doc("A string tag that is appended to hit highlights. Must be set with highlightPreTag. If omitted, hit highlighting is disabled.")
      @query
      highlightPostTag?: string;

      @doc("A string tag that is prepended to hit highlights. Must be set with highlightPostTag. If omitted, hit highlighting is disabled.")
      @query
      highlightPreTag?: string;

      @doc("A number between 0 and 100 indicating the percentage of the index that must be covered by an autocomplete query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 80.")
      @query
      minimumCoverage?: float64;

      @doc("The list of field names to consider when querying for auto-completed terms. Target fields must be included in the specified suggester.")
      @query
      searchFields?: string[];

      @doc("The number of auto-completed terms to retrieve. This must be a value between 1 and 100. The default is 5.")
      @query
      $top?: int32;
    },
    AutocompleteResult
  >;

  @doc("Autocompletes incomplete query terms based on input text and matching terms in the index.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/docs/search.post.autocomplete")
  @post
  autocompletePost is SearchIndexOperation<
    {
      @doc("The definition of the Autocomplete request.")
      @body
      autocompleteRequest: AutocompleteRequest;
    },
    AutocompleteResult
  >;
}

