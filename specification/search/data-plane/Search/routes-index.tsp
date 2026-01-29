import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models-index.tsp";

using TypeSpec.Http;

namespace Search;

interface Documents {
  /** Queries the number of documents in the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/$count")
  @get
  count is SearchIndexOperation<
    {
      ...acceptHeaderNone;
    },
    {
      @header contentType: "application/json";
      @body body: int64;
    }
  >;

  /** Searches for documents in the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs")
  @get
  searchGet is SearchIndexOperation<
    {
      ...acceptHeaderNone;
      ...querySourceAuthorizationHeader;
      ...enableElevatedReadHeader;

      /** A full-text search query expression; Use "*" or omit this parameter to match all documents. */
      @query("search")
      searchText?: string;

      ...SearchOptions;
    },
    SearchDocumentsResult & {
      /** A process exit code. */
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @statusCode
      code: "200" | "206";
    }
  >;

  /** Searches for documents in the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/search.post.search")
  @post
  searchPost is SearchIndexOperation<
    {
      ...acceptHeaderNone;
      ...querySourceAuthorizationHeader;
      ...enableElevatedReadHeader;
      ...SearchRequest;
    },
    SearchDocumentsResult & {
      /** A process exit code. */
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @statusCode
      code: "200" | "206";
    }
  >;

  /** Retrieves a document from the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs('{key}')")
  @get
  get is SearchIndexOperation<
    {
      ...acceptHeaderNone;
      ...querySourceAuthorizationHeader;
      ...enableElevatedReadHeader;

      /** The key of the document to retrieve. */
      @path
      key: string;

      /** List of field names to retrieve for the document; Any field not retrieved will be missing from the returned document. */
      @query("$select")
      selectedFields?: string[];
    },
    LookupDocument
  >;

  /** Suggests documents in the index that match the given partial query text. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/search.suggest")
  @get
  suggestGet is SearchIndexOperation<
    {
      ...acceptHeaderNone;

      /** The search text to use to suggest documents. Must be at least 1 character, and no more than 100 characters. */
      @query("search")
      searchText: string;

      /** The name of the suggester as specified in the suggesters collection that's part of the index definition. */
      @query
      suggesterName: string;

      ...SuggestOptions;
    },
    SuggestDocumentsResult
  >;

  /** Suggests documents in the index that match the given partial query text. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/search.post.suggest")
  @post
  suggestPost is SearchIndexOperation<
    {
      ...acceptHeaderNone;
      ...SuggestRequest;
    },
    SuggestDocumentsResult
  >;

  /** Sends a batch of document write actions to the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/search.index")
  @post
  index is SearchIndexOperation<
    {
      ...acceptHeaderNone;

      /** The batch of index actions. */
      @body
      batch: IndexBatch;
    },
    IndexDocumentsResult
  >;

  /** Autocompletes incomplete query terms based on input text and matching terms in the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/search.autocomplete")
  @get
  autocompleteGet is SearchIndexOperation<
    {
      ...acceptHeaderNone;

      /** The incomplete term which should be auto-completed. */
      @query("search")
      searchText: string;

      /** The name of the suggester as specified in the suggesters collection that's part of the index definition. */
      @query
      suggesterName: string;

      /** Specifies the mode for Autocomplete. The default is 'oneTerm'. Use 'twoTerms' to get shingles and 'oneTermWithContext' to use the current context while producing auto-completed terms. */
      @query
      autocompleteMode?: AutocompleteMode;

      /** An OData expression that filters the documents used to produce completed terms for the Autocomplete result. */
      @query
      $filter?: string;

      /** A value indicating whether to use fuzzy matching for the autocomplete query. Default is false. When set to true, the query will find terms even if there's a substituted or missing character in the search text. While this provides a better experience in some scenarios, it comes at a performance cost as fuzzy autocomplete queries are slower and consume more resources. */
      @query("fuzzy")
      useFuzzyMatching?: boolean;

      /** A string tag that is appended to hit highlights. Must be set with highlightPreTag. If omitted, hit highlighting is disabled. */
      @query
      highlightPostTag?: string;

      /** A string tag that is prepended to hit highlights. Must be set with highlightPostTag. If omitted, hit highlighting is disabled. */
      @query
      highlightPreTag?: string;

      /** A number between 0 and 100 indicating the percentage of the index that must be covered by an autocomplete query in order for the query to be reported as a success. This parameter can be useful for ensuring search availability even for services with only one replica. The default is 80. */
      @query
      minimumCoverage?: float64;

      /** The list of field names to consider when querying for auto-completed terms. Target fields must be included in the specified suggester. */
      @query
      searchFields?: string[];

      /** The number of auto-completed terms to retrieve. This must be a value between 1 and 100. The default is 5. */
      @query
      $top?: int32;
    },
    AutocompleteResult
  >;

  /** Autocompletes incomplete query terms based on input text and matching terms in the index. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/indexes('{indexName}')/docs/search.post.autocomplete")
  @post
  autocompletePost is SearchIndexOperation<
    {
      ...acceptHeaderNone;
      ...AutocompleteRequest;
    },
    AutocompleteResult
  >;
}
