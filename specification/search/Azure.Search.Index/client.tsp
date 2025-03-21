import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Search;

@TypeSpec.Versioning.useDependency(Search.Versions.v2024_07_01)
namespace Customizations;

@@clientName(VectorQuery.k, "kNearestNeighbors");
@@clientName(SearchDocumentsResult.value, "results");
@@clientName(SearchRequest.count, "includeTotalResultCount");
@@clientName(SearchRequest.highlight, "highlightFields");
@@clientName(SearchRequest.search, "searchText");
@@clientName(SearchRequest.orderby, "orderBy");
@@clientName(SuggestDocumentsResult.value, "results");
@@clientName(SuggestRequest.fuzzy, "useFuzzyMatching");
@@clientName(SuggestRequest.orderby, "orderBy");
@@clientName(SuggestRequest.search, "searchText");
@@clientName(IndexBatch.value, "actions");
@@clientName(IndexDocumentsResult.value, "results");
@@clientName(IndexingResult.status, "succeeded");
@@clientName(AutocompleteResult.value, "results");
@@clientName(AutocompleteRequest.search, "searchText");
@@clientName(AutocompleteRequest.fuzzy, "useFuzzyMatching");