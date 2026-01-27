import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Search;

@TypeSpec.Versioning.useDependency(
  Search.Versions.v2026_04_01,
  Search.Versions.v2025_11_01_preview
)
namespace Customizations;

@client({
  name: "SearchClient",
  service: Search,
})
@clientInitialization(Search.SearchIndexClientOptions)
@clientNamespace("Azure.Search.Documents")
@clientNamespace("com.azure.search.documents", "java")
namespace SearchClient {
  interface Documents {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    count is Search.Documents.count;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    searchGet is Search.Documents.searchGet;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    searchPost is Search.Documents.searchPost;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.Documents.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    suggestGet is Search.Documents.suggestGet;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    suggestPost is Search.Documents.suggestPost;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    index is Search.Documents.index;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    autocompleteGet is Search.Documents.autocompleteGet;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    autocompletePost is Search.Documents.autocompletePost;
  }
}

@client({
  name: "SearchIndexClient",
  service: Search,
})
@clientNamespace("Azure.Search.Documents.Indexes")
@clientNamespace("com.azure.search.documents.indexes", "java")
namespace SearchIndexClient {
  interface SynonymMaps {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.SynonymMaps.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.SynonymMaps.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.SynonymMaps.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.SynonymMaps.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.SynonymMaps.create;
  }
  interface Indexes {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.Indexes.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.Indexes.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.Indexes.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.Indexes.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.Indexes.create;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getStatistics is Search.Indexes.getStatistics;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    analyze is Search.Indexes.analyze;
  }
  interface Aliases {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.Aliases.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.Aliases.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.Aliases.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.Aliases.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.Aliases.create;
  }

  interface KnowledgeBases {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.KnowledgeBases.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.KnowledgeBases.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.KnowledgeBases.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.KnowledgeBases.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.KnowledgeBases.create;
  }

  interface Sources {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.KnowledgeSources.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.KnowledgeSources.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.KnowledgeSources.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.KnowledgeSources.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.KnowledgeSources.create;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getStatus is Search.KnowledgeSources.getStatus;
  }

  interface Root {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getServiceStatistics is Search.getServiceStatistics;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getIndexStatsSummary is Search.getIndexStatsSummary;
  }
}

@client({
  name: "SearchIndexerClient",
  service: Search,
})
@clientNamespace("Azure.Search.Documents.Indexes")
@clientNamespace("com.azure.search.documents.indexes", "java")
namespace SearchIndexerClient {
  interface DataSources {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.DataSources.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.DataSources.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.DataSources.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.DataSources.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.DataSources.create;
  }
  interface Indexers {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    reset is Search.Indexers.reset;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    resync is Search.Indexers.resync;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    resetDocs is Search.Indexers.resetDocs;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    run is Search.Indexers.run;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.Indexers.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.Indexers.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.Indexers.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.Indexers.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.Indexers.create;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getStatus is Search.Indexers.getStatus;
  }
  interface Skillsets {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    createOrUpdate is Search.Skillsets.createOrUpdate;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    delete is Search.Skillsets.delete;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    get is Search.Skillsets.get;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    list is Search.Skillsets.list;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    create is Search.Skillsets.create;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    resetSkills is Search.Skillsets.resetSkills;
  }
}

@client({
  name: "KnowledgeBaseRetrievalClient",
  service: Search,
})
@clientNamespace("Azure.Search.Documents.KnowledgeBases")
@clientNamespace("com.azure.search.documents.knowledgebases", "java")
namespace KnowledgeBaseRetrievalClient {
  interface KnowledgeRetrieval {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    retrieve is Search.KnowledgeRetrieval.retrieve;
  }
}

@@access(VectorSearchAlgorithmKind, Access.public);
@@usage(VectorSearchAlgorithmKind, Usage.input);
@@access(VectorSearchVectorizerKind, Access.public);
@@usage(VectorSearchVectorizerKind, Usage.input);
@@access(SearchIndexPermissionFilterOption, Access.public);
@@usage(SearchIndexPermissionFilterOption, Usage.input);
@@access(IndexerResyncBody, Access.public);
@@usage(IndexerResyncBody, Usage.input);
@@access(KnowledgeBaseAzureOpenAIModel, Access.public);
@@usage(KnowledgeBaseAzureOpenAIModel, Usage.input);
@@access(AnalyzedTokenInfo, Access.public);
@@usage(AnalyzedTokenInfo, Usage.input);
@@access(IndexerExecutionStatus, Access.public);
@@usage(IndexerExecutionStatus, Usage.input);
@@access(IndexerExecutionStatus, Access.public);
@@usage(IndexerExecutionStatus, Usage.input);
@@access(SearchIndexer, Access.public);
@@usage(SearchIndexer, Usage.input);
@@access(SearchIndexerSkillset, Access.public);
@@usage(SearchIndexerSkillset, Usage.input);
@@access(SynonymMap, Access.public);
@@usage(SynonymMap, Usage.input);
@@access(AutocompleteItem, Access.public);
@@usage(AutocompleteItem, Usage.input);
@@access(SuggestResult, Access.public);
@@usage(SuggestResult, Usage.input);
@@access(IndexingResult, Access.public);
@@usage(IndexingResult, Usage.input);
@@access(FacetResult, Access.public);
@@usage(FacetResult, Usage.input);
@@access(QueryAnswerResult, Access.public);
@@usage(QueryAnswerResult, Usage.input);
@@access(DebugInfo, Access.public);
@@usage(DebugInfo, Usage.input);
@@access(SearchResult, Access.public);
@@usage(SearchResult, Usage.input);
@@access(AnalyzeResult, Access.public);
@@usage(AnalyzeResult, Usage.input);
@@access(AnalyzeRequest, Access.public);
@@usage(AnalyzeRequest, Usage.input);
@@access(DocumentKeysOrIds, Access.public);
@@usage(DocumentKeysOrIds, Usage.input);
@@access(SkillNames, Access.public);
@@usage(SkillNames, Usage.input);
@@access(SearchDocumentsResult, Access.public);
@@usage(SearchDocumentsResult, Usage.input);
@@access(GetIndexStatisticsResult, Access.public);
@@usage(GetIndexStatisticsResult, Usage.input);
@@access(SemanticErrorReason, Access.public);
@@usage(SemanticErrorReason, Usage.input);
@@access(IndexBatch, Access.public);
@@usage(IndexBatch, Usage.input);
@@access(KnowledgeSourceStatus, Access.public);
@@usage(KnowledgeSourceStatus, Usage.input);
@@access(WebKnowledgeSource, Access.public);
@@usage(WebKnowledgeSource, Usage.input);
@@access(RemoteSharePointKnowledgeSource, Access.public);
@@usage(RemoteSharePointKnowledgeSource, Usage.input);

@@access(SearchClient.Documents.searchGet, Access.internal);
@@access(SearchClient.Documents.searchPost, Access.internal);
@@clientName(SearchClient.Documents.searchPost, "search", "java");
@@access(SearchClient.Documents.searchPost, Access.public, "java");
@@access(SearchClient.Documents.autocompleteGet, Access.internal);
@@access(SearchClient.Documents.autocompletePost, Access.internal);
@@access(SearchClient.Documents.autocompletePost, Access.public, "java");
@@clientName(SearchClient.Documents.autocompletePost, "autocomplete", "java");
@@access(SearchClient.Documents.suggestGet, Access.internal);
@@access(SearchClient.Documents.suggestPost, Access.internal);
@@access(SearchClient.Documents.suggestPost, Access.public, "java");
@@clientName(SearchClient.Documents.suggestPost, "suggest", "java");
@@access(SearchClient.Documents.index, Access.internal);
@@access(SearchIndexerClient.DataSources.list, Access.internal);
@@access(SearchIndexerClient.DataSources.createOrUpdate, Access.internal);
@@access(SearchIndexerClient.DataSources.delete, Access.internal, "python");
@@access(SearchIndexerClient.Indexers.list, Access.internal);
@@access(SearchIndexerClient.Indexers.createOrUpdate, Access.internal);
@@access(SearchIndexerClient.Indexers.resetDocs, Access.internal, "python");
@@access(SearchIndexerClient.Indexers.delete, Access.internal, "python");
@@access(SearchIndexerClient.Indexers.resync, Access.internal, "python");
@@access(SearchIndexerClient.Skillsets.list, Access.internal);
@@access(SearchIndexerClient.Skillsets.createOrUpdate, Access.internal);
@@access(SearchIndexerClient.Skillsets.delete, Access.internal, "python");
@@access(SearchIndexerClient.Skillsets.resetSkills, Access.internal, "python");
@@access(SearchIndexClient.SynonymMaps.list, Access.internal);
@@access(SearchIndexClient.SynonymMaps.createOrUpdate, Access.internal);
@@access(SearchIndexClient.SynonymMaps.delete, Access.internal, "python");
@@access(SearchIndexClient.Indexes.createOrUpdate, Access.internal);
@@access(SearchIndexClient.Indexes.delete, Access.internal, "python");
@@access(SearchIndexClient.Indexes.analyze, Access.internal, "python");
@@access(SearchIndexClient.Indexes.getStatistics, Access.internal, "python");
@@access(SearchIndexClient.Aliases.createOrUpdate, Access.internal);
@@access(SearchIndexClient.Aliases.delete, Access.internal, "python");
@@access(SearchIndexClient.KnowledgeBases.createOrUpdate, Access.internal);
@@access(SearchIndexClient.KnowledgeBases.delete, Access.internal, "python");
@@access(SearchIndexClient.Sources.createOrUpdate, Access.internal);
@@access(SearchIndexClient.Sources.delete, Access.internal, "python");

@@clientNamespace(Search.ErrorResponse, "Azure.Search.Documents");
@@clientNamespace(Search.ErrorResponse, "com.azure.search.documents", "java");
@@clientNamespace(Search.ErrorDetail, "Azure.Search.Documents");
@@clientNamespace(Search.ErrorDetail, "com.azure.search.documents", "java");
@@clientNamespace(Search.ErrorAdditionalInfo, "Azure.Search.Documents");
@@clientNamespace(Search.ErrorAdditionalInfo,
  "com.azure.search.documents",
  "java"
);

// Search documents types
@@clientNamespace(Search.SemanticErrorMode, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticErrorMode,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryAnswerType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryAnswerType, "com.azure.search.documents", "java");
@@clientNamespace(Search.QueryCaptionType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryCaptionType,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryRewritesType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryRewritesType,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryDebugMode, "Azure.Search.Documents");
@@clientNamespace(Search.QueryDebugMode, "com.azure.search.documents", "java");
@@clientNamespace(Search.QueryLanguage, "Azure.Search.Documents");
@@clientNamespace(Search.QueryLanguage, "com.azure.search.documents", "java");
@@clientNamespace(Search.QuerySpellerType, "Azure.Search.Documents");
@@clientNamespace(Search.QuerySpellerType,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorQueryKind, "Azure.Search.Documents");
@@clientNamespace(Search.VectorQueryKind, "com.azure.search.documents", "java");
@@clientNamespace(Search.VectorThresholdKind, "Azure.Search.Documents");
@@clientNamespace(Search.VectorThresholdKind,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorFilterMode, "Azure.Search.Documents");
@@clientNamespace(Search.VectorFilterMode,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.HybridCountAndFacetMode, "Azure.Search.Documents");
@@clientNamespace(Search.HybridCountAndFacetMode,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SemanticFieldState, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticFieldState,
  "com.azure.search.documents",
  "java"
);
@@clientName(Search.SemanticField.fieldName, "name", "javascript");
@@clientNamespace(Search.SemanticErrorReason, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticErrorReason,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SemanticSearchResultsType, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticSearchResultsType,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SemanticQueryRewritesResultType,
  "Azure.Search.Documents"
);
@@clientNamespace(Search.SemanticQueryRewritesResultType,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryType, "com.azure.search.documents", "java");
@@clientNamespace(Search.SearchMode, "Azure.Search.Documents");
@@clientNamespace(Search.SearchMode, "com.azure.search.documents", "java");
@@clientNamespace(Search.ScoringStatistics, "Azure.Search.Documents");
@@clientNamespace(Search.ScoringStatistics,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.IndexActionType, "Azure.Search.Documents");
@@clientNamespace(Search.IndexActionType, "com.azure.search.documents", "java");
@@clientNamespace(Search.AutocompleteMode, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteMode,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SearchDocumentsResult, "Azure.Search.Documents");
@@clientNamespace(Search.SearchDocumentsResult,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.FacetResult, "Azure.Search.Documents");
@@clientNamespace(Search.FacetResult, "com.azure.search.documents", "java");
@@clientNamespace(Search.QueryAnswerResult, "Azure.Search.Documents");
@@clientNamespace(Search.QueryAnswerResult,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.DebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.DebugInfo, "com.azure.search.documents", "java");
@@clientNamespace(Search.QueryRewritesDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.QueryRewritesDebugInfo,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryRewritesValuesDebugInfo,
  "Azure.Search.Documents"
);
@@clientNamespace(Search.QueryRewritesValuesDebugInfo,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SearchRequest, "Azure.Search.Documents");
@@clientNamespace(Search.SearchRequest, "com.azure.search.documents", "java");
@@clientNamespace(Search.VectorQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorQuery, "com.azure.search.documents", "java");
@@clientNamespace(Search.VectorThreshold, "Azure.Search.Documents");
@@clientNamespace(Search.VectorThreshold, "com.azure.search.documents", "java");
@@clientNamespace(Search.HybridSearch, "Azure.Search.Documents");
@@clientNamespace(Search.HybridSearch, "com.azure.search.documents", "java");
@@clientNamespace(Search.SearchResult, "Azure.Search.Documents");
@@clientNamespace(Search.SearchResult, "com.azure.search.documents", "java");
@@clientNamespace(Search.QueryCaptionResult, "Azure.Search.Documents");
@@clientNamespace(Search.QueryCaptionResult,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.DocumentDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.DocumentDebugInfo,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SemanticDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticDebugInfo,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryResultDocumentSemanticField,
  "Azure.Search.Documents"
);
@@clientNamespace(Search.QueryResultDocumentSemanticField,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryResultDocumentRerankerInput,
  "Azure.Search.Documents"
);
@@clientNamespace(Search.QueryResultDocumentRerankerInput,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorsDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.VectorsDebugInfo,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryResultDocumentSubscores,
  "Azure.Search.Documents"
);
@@clientNamespace(Search.QueryResultDocumentSubscores,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.TextResult, "Azure.Search.Documents");
@@clientNamespace(Search.TextResult, "com.azure.search.documents", "java");
@@clientNamespace(Search.SingleVectorFieldResult, "Azure.Search.Documents");
@@clientNamespace(Search.SingleVectorFieldResult,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SuggestDocumentsResult, "Azure.Search.Documents");
@@clientNamespace(Search.SuggestDocumentsResult,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SuggestResult, "Azure.Search.Documents");
@@clientNamespace(Search.SuggestResult, "com.azure.search.documents", "java");
@@clientNamespace(Search.SuggestRequest, "Azure.Search.Documents");
@@clientNamespace(Search.SuggestRequest, "com.azure.search.documents", "java");
@@clientNamespace(Search.IndexBatch, "Azure.Search.Documents");
@@clientNamespace(Search.IndexBatch, "com.azure.search.documents", "java");
@@clientNamespace(Search.IndexAction, "Azure.Search.Documents");
@@clientNamespace(Search.IndexAction, "com.azure.search.documents", "java");
@@clientNamespace(Search.LookupDocument, "Azure.Search.Documents");
@@clientNamespace(Search.LookupDocument, "com.azure.search.documents", "java");
@@clientNamespace(Search.IndexDocumentsResult, "Azure.Search.Documents");
@@clientNamespace(Search.IndexDocumentsResult,
  "com.azure.search.documents",
  "java"
);
@@access(Search.IndexDocumentsResult, Access.public, "java");
@@clientNamespace(Search.IndexingResult, "Azure.Search.Documents");
@@clientNamespace(Search.IndexingResult, "com.azure.search.documents", "java");
@@clientNamespace(Search.AutocompleteResult, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteResult,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.AutocompleteItem, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteItem,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.AutocompleteRequest, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteRequest,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorizedQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizedQuery, "com.azure.search.documents", "java");
@@clientNamespace(Search.VectorizableTextQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizableTextQuery,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorizableImageUrlQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizableImageUrlQuery,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorizableImageBinaryQuery,
  "Azure.Search.Documents"
);
@@clientNamespace(Search.VectorizableImageBinaryQuery,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.VectorSimilarityThreshold, "Azure.Search.Documents");
@@clientNamespace(Search.VectorSimilarityThreshold,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.SearchScoreThreshold, "Azure.Search.Documents");
@@clientNamespace(Search.SearchScoreThreshold,
  "com.azure.search.documents",
  "java"
);
@@clientNamespace(Search.QueryResultDocumentInnerHit, "Azure.Search.Documents");
@@clientNamespace(Search.QueryResultDocumentInnerHit,
  "com.azure.search.documents",
  "java"
);

// Search index types
@@clientNamespace(Search.SearchIndexerDataSourceType,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerDataSourceType,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.BlobIndexerParsingMode,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.BlobIndexerParsingMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MarkdownParsingSubmode,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MarkdownParsingSubmode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MarkdownHeaderDepth, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MarkdownHeaderDepth,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.BlobIndexerDataToExtract,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.BlobIndexerDataToExtract,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.BlobIndexerImageAction,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.BlobIndexerImageAction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.BlobIndexerPDFTextRotationAlgorithm,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.BlobIndexerPDFTextRotationAlgorithm,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerExecutionEnvironment,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexerExecutionEnvironment,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerExecutionStatusDetail,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexerExecutionStatusDetail,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexingMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexProjectionMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexProjectionMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchFieldDataType, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchFieldDataType,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LexicalAnalyzerName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalAnalyzerName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LexicalNormalizerName,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.LexicalNormalizerName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorEncodingFormat,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorEncodingFormat,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchAlgorithmKind,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchAlgorithmKind,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchVectorizerKind,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchVectorizerKind,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchCompressionKind,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchCompressionKind,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchCompressionRescoreStorageMethod,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchCompressionRescoreStorageMethod,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LexicalTokenizerName,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.LexicalTokenizerName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TokenFilterName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TokenFilterName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CharFilterName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CharFilterName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.RegexFlags, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.RegexFlags,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchAlgorithmMetric,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchAlgorithmMetric,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchCompressionTarget,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchCompressionTarget,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureOpenAIModelName,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureOpenAIModelName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AIFoundryModelCatalogName,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AIFoundryModelCatalogName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KeyPhraseExtractionSkillLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KeyPhraseExtractionSkillLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.OcrSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OcrSkillLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.OcrLineEnding, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OcrLineEnding,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ImageAnalysisSkillLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ImageAnalysisSkillLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VisualFeature, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VisualFeature,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ImageDetail, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ImageDetail,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EntityCategory, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityCategory,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PIIDetectionSkillMaskingMode,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.PIIDetectionSkillMaskingMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SplitSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkillLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TextSplitMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TextSplitMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SplitSkillUnit, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkillUnit,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SplitSkillEncoderModelName,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SplitSkillEncoderModelName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CustomEntityLookupSkillLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CustomEntityLookupSkillLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TextTranslationSkillLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.TextTranslationSkillLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillOutputMode,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillOutputMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillMarkdownHeaderDepth,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillMarkdownHeaderDepth,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerStatus, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerStatus,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerRuntime, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerRuntime,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerExecutionStatus,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexerExecutionStatus,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ScoringFunctionInterpolation,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ScoringFunctionInterpolation,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ScoringFunctionAggregation,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ScoringFunctionAggregation,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TokenCharacterKind, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TokenCharacterKind,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MicrosoftTokenizerLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MicrosoftTokenizerLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MicrosoftStemmingTokenizerLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MicrosoftStemmingTokenizerLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CjkBigramTokenFilterScripts,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CjkBigramTokenFilterScripts,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EdgeNGramTokenFilterSide,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.EdgeNGramTokenFilterSide,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PhoneticEncoder, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PhoneticEncoder,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SnowballTokenFilterLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SnowballTokenFilterLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.StemmerTokenFilterLanguage,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.StemmerTokenFilterLanguage,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.StopwordsList, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StopwordsList,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerDataSource,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerDataSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DataSourceCredentials,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DataSourceCredentials,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerDataContainer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerDataContainer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DataChangeDetectionPolicy,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DataChangeDetectionPolicy,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DataDeletionDetectionPolicy,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DataDeletionDetectionPolicy,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchResourceEncryptionKey,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchResourceEncryptionKey,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureActiveDirectoryApplicationCredentials,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureActiveDirectoryApplicationCredentials,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListDataSourcesResult,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ListDataSourcesResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@access(Search.ListDataSourcesResult, Access.public, "java");
@@clientNamespace(Search.DocumentKeysOrIds, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DocumentKeysOrIds,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexingSchedule, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingSchedule,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexingParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexingParametersConfiguration,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexingParametersConfiguration,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.FieldMapping, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.FieldMapping,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.FieldMappingFunction,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.FieldMappingFunction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerCache, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerCache,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListIndexersResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListIndexersResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@access(Search.ListIndexersResult, Access.public, "java");
@@clientNamespace(Search.SearchIndexerStatus, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerStatus,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerExecutionResult,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexerExecutionResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerCurrentState, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerCurrentState,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerError, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerError,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerWarning,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerWarning,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerLimits, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerLimits,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerSkillset,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerSkillset,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.InputFieldMappingEntry,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.InputFieldMappingEntry,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.OutputFieldMappingEntry,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.OutputFieldMappingEntry,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CognitiveServicesAccount,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CognitiveServicesAccount,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStore,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStore,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreProjection,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreProjection,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreTableProjectionSelector,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreTableProjectionSelector,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreProjectionSelector,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreProjectionSelector,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreObjectProjectionSelector,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreObjectProjectionSelector,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreBlobProjectionSelector,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreBlobProjectionSelector,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreFileProjectionSelector,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreFileProjectionSelector,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerIndexProjection,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerIndexProjection,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerIndexProjectionSelector,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerIndexProjectionSelector,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerIndexProjectionsParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerIndexProjectionsParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListSkillsetsResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListSkillsetsResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@access(Search.ListSkillsetsResult, Access.public, "java");
@@clientNamespace(Search.SkillNames, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SkillNames,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SynonymMap, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SynonymMap,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListSynonymMapsResult,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ListSynonymMapsResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@access(Search.ListSynonymMapsResult, Access.public, "java");
@@clientNamespace(Search.SearchIndex, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndex,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchField, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchField,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ScoringProfile, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScoringProfile,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TextWeights, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TextWeights,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScoringFunction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CorsOptions, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CorsOptions,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeBase, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KnowledgeBase,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceReference,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KnowledgeSourceReference,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceContentExtractionMode,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KnowledgeSourceContentExtractionMode,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceIngestionPermissionOption,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KnowledgeSourceIngestionPermissionOption,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceSynchronizationStatus,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KnowledgeSourceSynchronizationStatus,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListKnowledgeBasesResult,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ListKnowledgeBasesResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseModel, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KnowledgeBaseModel,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseModelKind,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KnowledgeBaseModelKind,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseAzureOpenAIModel,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KnowledgeBaseAzureOpenAIModel,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureOpenAiParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureOpenAiParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeSource, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceKind, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KnowledgeSourceKind,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexKnowledgeSource,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexKnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexKnowledgeSourceParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexKnowledgeSourceParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureBlobKnowledgeSource,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureBlobKnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureBlobKnowledgeSourceParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureBlobKnowledgeSourceParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexedOneLakeKnowledgeSource,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexedOneLakeKnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexedOneLakeKnowledgeSourceParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexedOneLakeKnowledgeSourceParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexedSharePointContainerName,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexedSharePointContainerName,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexedSharePointKnowledgeSource,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexedSharePointKnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexedSharePointKnowledgeSourceParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexedSharePointKnowledgeSourceParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.RemoteSharePointKnowledgeSource,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.RemoteSharePointKnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.RemoteSharePointKnowledgeSourceParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.RemoteSharePointKnowledgeSourceParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebKnowledgeSource, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebKnowledgeSource,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebKnowledgeSourceDomain,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.WebKnowledgeSourceDomain,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebKnowledgeSourceDomains,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.WebKnowledgeSourceDomains,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebKnowledgeSourceParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.WebKnowledgeSourceParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexFieldReference,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexFieldReference,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ServiceIndexersRuntime,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ServiceIndexersRuntime,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListKnowledgeSourcesResult,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ListKnowledgeSourcesResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CreatedResources, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CreatedResources,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchSuggester, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchSuggester,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LexicalAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalAnalyzer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LexicalTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CharFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CharFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LexicalNormalizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalNormalizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SimilarityAlgorithm, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SimilarityAlgorithm,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SemanticSearch, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SemanticSearch,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SemanticConfiguration,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SemanticConfiguration,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SemanticPrioritizedFields,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SemanticPrioritizedFields,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SemanticField, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SemanticField,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearch, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearch,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchProfile, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchProfile,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchAlgorithmConfiguration,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchAlgorithmConfiguration,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchVectorizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchVectorizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VectorSearchCompression,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VectorSearchCompression,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.RescoringOptions, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.RescoringOptions,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListIndexesResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListIndexesResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.GetIndexStatisticsResult,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.GetIndexStatisticsResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AnalyzeRequest, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AnalyzeRequest,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AnalyzeResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AnalyzeResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AnalyzedTokenInfo, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AnalyzedTokenInfo,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchAlias, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchAlias,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListAliasesResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListAliasesResult,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchServiceStatistics,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchServiceStatistics,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchServiceCounters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchServiceCounters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ResourceCounter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ResourceCounter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchServiceLimits, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchServiceLimits,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CustomAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomAnalyzer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PatternAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternAnalyzer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LuceneStandardAnalyzer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.LuceneStandardAnalyzer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.StopAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StopAnalyzer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CustomNormalizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomNormalizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ClassicTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ClassicTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EdgeNGramTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EdgeNGramTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KeywordTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeywordTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KeywordTokenizerV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeywordTokenizerV2,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MicrosoftLanguageTokenizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MicrosoftLanguageTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MicrosoftLanguageStemmingTokenizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MicrosoftLanguageStemmingTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.NGramTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.NGramTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PathHierarchyTokenizerV2,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.PathHierarchyTokenizerV2,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PatternTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LuceneStandardTokenizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.LuceneStandardTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LuceneStandardTokenizerV2,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.LuceneStandardTokenizerV2,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.UaxUrlEmailTokenizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.UaxUrlEmailTokenizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AsciiFoldingTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AsciiFoldingTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CjkBigramTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CjkBigramTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CommonGramTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CommonGramTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DictionaryDecompounderTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DictionaryDecompounderTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EdgeNGramTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.EdgeNGramTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EdgeNGramTokenFilterV2,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.EdgeNGramTokenFilterV2,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ElisionTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ElisionTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KeepTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeepTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KeywordMarkerTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KeywordMarkerTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LengthTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LengthTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LimitTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LimitTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.NGramTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.NGramTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.NGramTokenFilterV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.NGramTokenFilterV2,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PatternCaptureTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.PatternCaptureTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PatternReplaceTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.PatternReplaceTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PhoneticTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PhoneticTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ShingleTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ShingleTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SnowballTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SnowballTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.StemmerTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StemmerTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.StemmerOverrideTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.StemmerOverrideTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.StopwordsTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.StopwordsTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SynonymTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SynonymTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TruncateTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TruncateTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.UniqueTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.UniqueTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WordDelimiterTokenFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.WordDelimiterTokenFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MappingCharFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MappingCharFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PatternReplaceCharFilter,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.PatternReplaceCharFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ClassicSimilarityAlgorithm,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ClassicSimilarityAlgorithm,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.BM25SimilarityAlgorithm,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.BM25SimilarityAlgorithm,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.HnswAlgorithmConfiguration,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.HnswAlgorithmConfiguration,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.HnswParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.HnswParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ExhaustiveKnnAlgorithmConfiguration,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ExhaustiveKnnAlgorithmConfiguration,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ExhaustiveKnnParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ExhaustiveKnnParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ScalarQuantizationCompression,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ScalarQuantizationCompression,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ScalarQuantizationParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ScalarQuantizationParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.BinaryQuantizationCompression,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.BinaryQuantizationCompression,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureOpenAIVectorizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureOpenAIVectorizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureOpenAIVectorizerParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureOpenAIVectorizerParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerDataIdentity,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerDataIdentity,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebApiVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebApiVectorizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebApiVectorizerParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.WebApiVectorizerParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AIServicesVisionVectorizer,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AIServicesVisionVectorizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AIServicesVisionParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AIServicesVisionParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AMLVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AMLVectorizer,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AMLParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AMLParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerDataNoneIdentity,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerDataNoneIdentity,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerDataUserAssignedIdentity,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerDataUserAssignedIdentity,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.HighWaterMarkChangeDetectionPolicy,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.HighWaterMarkChangeDetectionPolicy,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SqlIntegratedChangeTrackingPolicy,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SqlIntegratedChangeTrackingPolicy,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SoftDeleteColumnDeletionDetectionPolicy,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SoftDeleteColumnDeletionDetectionPolicy,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.NativeBlobSoftDeleteDeletionDetectionPolicy,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.NativeBlobSoftDeleteDeletionDetectionPolicy,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DistanceScoringFunction,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DistanceScoringFunction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DistanceScoringParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DistanceScoringParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.FreshnessScoringFunction,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.FreshnessScoringFunction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.FreshnessScoringParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.FreshnessScoringParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MagnitudeScoringFunction,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MagnitudeScoringFunction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MagnitudeScoringParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.MagnitudeScoringParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TagScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TagScoringFunction,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TagScoringParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.TagScoringParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexerKnowledgeStoreParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DefaultCognitiveServicesAccount,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DefaultCognitiveServicesAccount,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CognitiveServicesAccountKey,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CognitiveServicesAccountKey,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AIServicesAccountKey,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AIServicesAccountKey,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AIServicesAccountIdentity,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AIServicesAccountIdentity,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CustomEntity, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomEntity,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CustomEntityAlias, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomEntityAlias,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ConditionalSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ConditionalSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.KeyPhraseExtractionSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.KeyPhraseExtractionSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.OcrSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OcrSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ImageAnalysisSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ImageAnalysisSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.LanguageDetectionSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.LanguageDetectionSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ShaperSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ShaperSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.MergeSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MergeSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SentimentSkillV3, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SentimentSkillV3,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EntityLinkingSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityLinkingSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.EntityRecognitionSkillV3,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.EntityRecognitionSkillV3,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PIIDetectionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PIIDetectionSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SplitSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureOpenAITokenizerParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureOpenAITokenizerParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.CustomEntityLookupSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.CustomEntityLookupSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.TextTranslationSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.TextTranslationSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentExtractionSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentExtractionSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebApiSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebApiSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureMachineLearningSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureMachineLearningSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.AzureOpenAIEmbeddingSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.AzureOpenAIEmbeddingSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.VisionVectorizeSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.VisionVectorizeSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ContentUnderstandingSkillChunkingUnit,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ContentUnderstandingSkillChunkingUnit,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ContentUnderstandingSkillExtractionOptions,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ContentUnderstandingSkillExtractionOptions,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ContentUnderstandingSkill,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ContentUnderstandingSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ContentUnderstandingSkillChunkingProperties,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ContentUnderstandingSkillChunkingProperties,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexStatisticsSummary,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexStatisticsSummary,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ListIndexStatsSummary,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ListIndexStatsSummary,
  "com.azure.search.documents.indexes",
  "java"
);

@@clientNamespace(Search.ChatCompletionExtraParametersBehavior,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ChatCompletionExtraParametersBehavior,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ChatCompletionResponseFormatType,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ChatCompletionResponseFormatType,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillChunkingUnit,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillChunkingUnit,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillExtractionOptions,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillExtractionOptions,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillOutputFormat,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillOutputFormat,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerPermissionOption,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.IndexerPermissionOption,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.PermissionFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PermissionFilter,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.RankingOrder, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.RankingOrder,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ChatCompletionCommonModelParameters,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ChatCompletionCommonModelParameters,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ChatCompletionResponseFormat,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ChatCompletionResponseFormat,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ChatCompletionSchema,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ChatCompletionSchema,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ChatCompletionSchemaProperties,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.ChatCompletionSchemaProperties,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.ChatCompletionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ChatCompletionSkill,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillChunkingProperties,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillChunkingProperties,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.WebApiHttpHeaders, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebApiHttpHeaders,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchOptions, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchOptions,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.SearchIndexPermissionFilterOption,
  "Azure.Search.Documents.Indexes"
);
@@clientNamespace(Search.SearchIndexPermissionFilterOption,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerResyncBody, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerResyncBody,
  "com.azure.search.documents.indexes",
  "java"
);
@@clientNamespace(Search.IndexerResyncOption, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerResyncOption,
  "com.azure.search.documents.indexes",
  "java"
);

@@clientName(SearchClient.Documents.count, "getDocumentCount");
@@clientName(SearchClient.Documents.get, "getDocument");
@@clientName(SearchIndexClient.Indexes.list, "listIndexes");
@@clientName(SearchIndexClient.Indexes.get, "getIndex");
@@clientName(SearchIndexClient.Indexes.getStatistics, "getIndexStatistics");
@@clientName(SearchIndexClient.Indexes.delete, "deleteIndex");
@@clientName(SearchIndexClient.Indexes.create, "createIndex");
@@clientName(SearchIndexClient.Indexes.createOrUpdate, "createOrUpdateIndex");
@@clientName(SearchIndexClient.Indexes.analyze, "analyzeText");
@@clientName(SearchIndexClient.SynonymMaps.list, "getSynonymMaps");
@@clientName(SearchIndexClient.SynonymMaps.get, "getSynonymMap");
@@clientName(SearchIndexClient.SynonymMaps.delete, "deleteSynonymMap");
@@clientName(SearchIndexClient.SynonymMaps.create, "createSynonymMap");
@@clientName(SearchIndexClient.SynonymMaps.createOrUpdate,
  "createOrUpdateSynonymMap"
);
@@clientName(SearchIndexClient.Root.getIndexStatsSummary,
  "listIndexStatsSummary"
);
@@clientName(SearchIndexClient.Aliases.list, "listAliases");
@@clientName(SearchIndexClient.Aliases.get, "getAlias");
@@clientName(SearchIndexClient.Aliases.delete, "deleteAlias");
@@clientName(SearchIndexClient.Aliases.create, "createAlias");
@@clientName(SearchIndexClient.Aliases.createOrUpdate, "createOrUpdateAlias");
@@clientName(SearchIndexClient.KnowledgeBases.delete, "deleteKnowledgeBase");
@@clientName(SearchIndexClient.KnowledgeBases.create, "createKnowledgeBase");
@@clientName(SearchIndexClient.KnowledgeBases.createOrUpdate,
  "createOrUpdateKnowledgeBase"
);
@@clientName(SearchIndexClient.KnowledgeBases.get, "getKnowledgeBase");
@@clientName(SearchIndexClient.KnowledgeBases.list, "listKnowledgeBases");
@@clientName(SearchIndexClient.Sources.delete, "deleteKnowledgeSource");
@@clientName(SearchIndexClient.Sources.create, "createKnowledgeSource");
@@clientName(SearchIndexClient.Sources.createOrUpdate,
  "createOrUpdateKnowledgeSource"
);
@@clientName(SearchIndexClient.Sources.get, "getKnowledgeSource");
@@clientName(SearchIndexClient.Sources.list, "listKnowledgeSources");
@@clientName(SearchIndexClient.Sources.getStatus, "getKnowledgeSourceStatus");
@@clientName(SearchIndexerClient.Indexers.create, "createIndexer");
@@clientName(SearchIndexerClient.Indexers.createOrUpdate,
  "createOrUpdateIndexer"
);
@@clientName(SearchIndexerClient.Indexers.delete, "deleteIndexer");
@@clientName(SearchIndexerClient.Indexers.get, "getIndexer");
@@clientName(SearchIndexerClient.Indexers.list, "getIndexers");
@@clientName(SearchIndexerClient.Indexers.run, "runIndexer");
@@clientName(SearchIndexerClient.Indexers.reset, "resetIndexer");
@@clientName(SearchIndexerClient.Indexers.resetDocs, "resetDocuments");
@@clientName(SearchIndexerClient.Indexers.resync, "resync");
@@clientName(SearchIndexerClient.Indexers.getStatus, "getIndexerStatus");
@@clientName(SearchIndexerClient.DataSources.create,
  "createDataSourceConnection"
);
@@clientName(SearchIndexerClient.DataSources.createOrUpdate,
  "createOrUpdateDataSourceConnection"
);
@@clientName(SearchIndexerClient.DataSources.get, "getDataSourceConnection");
@@clientName(SearchIndexerClient.DataSources.list, "getDataSourceConnections");
@@clientName(SearchIndexerClient.DataSources.delete,
  "deleteDataSourceConnection"
);
@@clientName(SearchIndexerClient.Skillsets.create, "createSkillset");
@@clientName(SearchIndexerClient.Skillsets.createOrUpdate,
  "createOrUpdateSkillset"
);
@@clientName(SearchIndexerClient.Skillsets.get, "getSkillset");
@@clientName(SearchIndexerClient.Skillsets.list, "getSkillsets");
@@clientName(SearchIndexerClient.Skillsets.delete, "deleteSkillset");

@@clientName(VectorQuery.k, "kNearestNeighbors");
@@clientName(VectorQuery.k, "kNearestNeighborsCount", "csharp");
@@clientName(SearchDocumentsResult.value, "results");
@@clientName(SearchRequest.count, "includeTotalCount");
@@clientName(SearchRequest.highlight, "highlightFields");
@@clientName(SearchRequest.search, "searchText");
@@clientName(SearchRequest.orderby, "orderBy");
@@clientName(SuggestDocumentsResult.value, "results");
@@clientName(SuggestRequest.fuzzy, "useFuzzyMatching");
@@clientName(SuggestRequest.orderby, "orderBy");
@@clientName(SuggestRequest.search, "searchText");
@@clientName(Search.IndexBatch, "IndexDocumentsBatch");
@@clientName(IndexBatch.value, "actions");
@@clientName(IndexDocumentsResult.value, "results");
@@clientName(IndexingResult.status, "succeeded");
@@clientName(AutocompleteResult.value, "results");
@@clientName(AutocompleteRequest.search, "searchText");
@@clientName(AutocompleteRequest.fuzzy, "useFuzzyMatching");
@@clientName(ListDataSourcesResult.value, "dataSources");
@@clientName(SearchResourceEncryptionKey.keyVaultKeyName, "keyName");
@@clientName(SearchResourceEncryptionKey.keyVaultKeyVersion, "keyVersion");
@@clientName(SearchResourceEncryptionKey.keyVaultUri, "vaultUri");
@@clientName(SearchIndexer.disabled, "isDisabled");
@@clientName(ListIndexersResult.value, "indexers");
@@clientName(IndexerExecutionResult.itemsProcessed, "itemCount");
@@clientName(IndexerExecutionResult.itemsFailed, "failedItemCount");
@@clientName(SearchIndexerSkillset.cognitiveServices,
  "cognitiveServicesAccount"
);
@@clientName(SearchIndexerSkillset.indexProjections, "indexProjection");
@@clientName(ListSkillsetsResult.value, "skillsets");
@@clientName(ListSynonymMapsResult.value, "synonymMaps");
@@clientName(AnalyzeRequest, "AnalyzeTextOptions");
@@clientName(AnalyzeRequest.analyzer, "analyzerName");
@@clientName(AnalyzeRequest.tokenizer, "tokenizerName");
@@clientName(AnalyzeRequest.normalizer, "normalizerName");
@@clientName(SearchIndexerDataSource, "SearchIndexerDataSourceConnection");
@@clientName(SearchRequest.speller, "querySpeller");
@@clientName(SearchRequest.semanticConfiguration, "semanticConfigurationName");
@@clientName(SearchIndex.semantic, "semanticSearch");
@@clientName(SearchField.analyzer, "analyzerName");
@@clientName(SearchField.searchAnalyzer, "searchAnalyzerName");
@@clientName(SearchField.indexAnalyzer, "indexAnalyzerName");
@@clientName(SearchField.normalizer, "normalizerName");
@@clientName(SearchField.synonymMaps, "synonymMapNames");
@@clientName(SearchField.dimensions, "vectorSearchDimensions");
@@clientName(SearchField.vectorSearchProfile, "vectorSearchProfileName");
@@clientName(SearchField.vectorEncoding, "vectorEncodingFormat");
@@clientName(ScoringProfile.text, "textWeights");
@@clientName(SemanticSearch.defaultConfiguration, "defaultConfigurationName");
@@clientName(SemanticPrioritizedFields.prioritizedContentFields,
  "contentFields"
);
@@clientName(SemanticPrioritizedFields.prioritizedKeywordsFields,
  "keywordsFields"
);
@@clientName(VectorSearchProfile.algorithm, "algorithmConfigurationName");
@@clientName(VectorSearchProfile.vectorizer, "vectorizerName");
@@clientName(VectorSearchProfile.compression, "compressionName");
@@clientName(VectorSearchVectorizer.name, "vectorizerName");
@@clientName(VectorSearchCompression.name, "compressionName");
@@clientName(ListIndexesResult.value, "indexes");
@@clientName(SearchServiceCounters.aliasesCount, "aliasCounter");
@@clientName(SearchServiceCounters.documentCount, "documentCounter");
@@clientName(SearchServiceCounters.indexesCount, "indexCounter");
@@clientName(SearchServiceCounters.indexersCount, "indexerCounter");
@@clientName(SearchServiceCounters.dataSourcesCount, "dataSourceCounter");
@@clientName(SearchServiceCounters.storageSize, "storageSizeCounter");
@@clientName(SearchServiceCounters.synonymMaps, "synonymMapCounter");
@@clientName(SearchServiceCounters.skillsetCount, "skillsetCounter");
@@clientName(SearchServiceCounters.vectorIndexSize, "vectorIndexSizeCounter");
@@clientName(SearchServiceLimits.maxStoragePerIndex,
  "maxStoragePerIndexInBytes"
);
@@clientName(PatternAnalyzer.lowercase, "lowerCaseTerms");
@@clientName(PathHierarchyTokenizerV2.reverse, "reverseTokenOrder");
@@clientName(PathHierarchyTokenizerV2.skip, "numberOfTokensToSkip");
@@clientName(CommonGramTokenFilter.queryMode, "useQueryMode");
@@clientName(KeepTokenFilter.keepWordsCase, "lowerCaseKeepWords");
@@clientName(LengthTokenFilter.min, "minLength");
@@clientName(LengthTokenFilter.max, "maxLength");
@@clientName(PhoneticTokenFilter.replace, "replaceOriginalTokens");
@@clientName(StopwordsTokenFilter.removeTrailing, "removeTrailingStopWords");
@@clientName(HnswAlgorithmConfiguration.hnswParameters, "parameters");
@@clientName(ExhaustiveKnnAlgorithmConfiguration.exhaustiveKnnParameters,
  "parameters"
);
@@clientName(ScalarQuantizationCompression.scalarQuantizationParameters,
  "parameters"
);
@@clientName(AzureOpenAIVectorizer.azureOpenAIParameters, "parameters");
@@clientName(AzureOpenAIVectorizerParameters.resourceUri, "resourceUrl");
@@clientName(AzureOpenAIVectorizerParameters.deploymentId, "deploymentName");
@@clientName(WebApiVectorizer.customWebApiParameters, "webApiParameters");
@@clientName(WebApiVectorizerParameters.uri, "url", "python");
@@clientName(WebApiVectorizerParameters.uri, "url", "java");
@@clientName(SearchIndexerDataUserAssignedIdentity.userAssignedIdentity,
  "resourceId"
);
@@clientName(DistanceScoringFunction.distance, "parameters");
@@clientName(FreshnessScoringFunction.freshness, "parameters");
@@clientName(MagnitudeScoringFunction.magnitude, "parameters");
@@clientName(MagnitudeScoringParameters.constantBoostBeyondRange,
  "shouldBoostBeyondRangeByConstant"
);
@@clientName(TagScoringFunction.tag, "parameters");
@@clientName(OcrSkill.detectOrientation, "shouldDetectOrientation");
@@clientName(PIIDetectionSkill.minimumPrecision, "minPrecision", "csharp");
@@clientName(PIIDetectionSkill.maskingCharacter, "mask");
@@clientName(ListAliasesResult.value, "aliases");
@@clientName(AMLParameters.uri, "scoringUri");
@@clientName(AMLParameters.key, "authenticationKey");
@@clientName(AMLVectorizer.amlParameters, "AMLParameters");
@@clientName(AzureMachineLearningSkill.uri, "scoringUri");
@@clientName(AzureMachineLearningSkill.key, "authenticationKey");
@@clientName(SkillNames.skillNames, "skillNameList", "csharp");
@@clientName(AMLParameters, "AzureMachineLearningParameters");
@@clientName(AMLVectorizer, "AzureMachineLearningVectorizer");
@@clientName(DataChangeDetectionPolicy.`@odata.type`, "odataType");
@@clientName(DataChangeDetectionPolicy.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(DataDeletionDetectionPolicy.`@odata.type`, "odataType");
@@clientName(DataDeletionDetectionPolicy.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(SearchIndexerSkill.`@odata.type`, "odataType");
@@clientName(SearchIndexerSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(CognitiveServicesAccount.`@odata.type`, "odataType");
@@clientName(CognitiveServicesAccount.`@odata.type`, "odatatype", "javascript");
@@clientName(LexicalAnalyzer.`@odata.type`, "odataType");
@@clientName(LexicalAnalyzer.`@odata.type`, "odatatype", "javascript");
@@clientName(LexicalTokenizer.`@odata.type`, "odataType");
@@clientName(LexicalTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(TokenFilter.`@odata.type`, "odataType");
@@clientName(TokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(CharFilter.`@odata.type`, "odataType");
@@clientName(CharFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(LexicalNormalizer.`@odata.type`, "odataType");
@@clientName(LexicalNormalizer.`@odata.type`, "odatatype", "javascript");
@@clientName(SimilarityAlgorithm.`@odata.type`, "odataType");
@@clientName(SimilarityAlgorithm.`@odata.type`, "odatatype", "javascript");
@@clientName(CustomAnalyzer.`@odata.type`, "odataType");
@@clientName(CustomAnalyzer.`@odata.type`, "odatatype", "javascript");
@@clientName(PatternAnalyzer.`@odata.type`, "odataType");
@@clientName(PatternAnalyzer.`@odata.type`, "odatatype", "javascript");
@@clientName(LuceneStandardAnalyzer.`@odata.type`, "odataType");
@@clientName(LuceneStandardAnalyzer.`@odata.type`, "odatatype", "javascript");
@@clientName(StopAnalyzer.`@odata.type`, "odataType");
@@clientName(StopAnalyzer.`@odata.type`, "odatatype", "javascript");
@@clientName(CustomNormalizer.`@odata.type`, "odataType");
@@clientName(CustomNormalizer.`@odata.type`, "odatatype", "javascript");
@@clientName(ClassicTokenizer.`@odata.type`, "odataType");
@@clientName(ClassicTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(EdgeNGramTokenizer.`@odata.type`, "odataType");
@@clientName(EdgeNGramTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(KeywordTokenizer.`@odata.type`, "odataType");
@@clientName(KeywordTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(KeywordTokenizerV2.`@odata.type`, "odataType");
@@clientName(KeywordTokenizerV2.`@odata.type`, "odatatype", "javascript");
@@clientName(MicrosoftLanguageTokenizer.`@odata.type`, "odataType");
@@clientName(MicrosoftLanguageTokenizer.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(MicrosoftLanguageStemmingTokenizer.`@odata.type`, "odataType");
@@clientName(MicrosoftLanguageStemmingTokenizer.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(NGramTokenizer.`@odata.type`, "odataType");
@@clientName(NGramTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(PatternTokenizer.`@odata.type`, "odataType");
@@clientName(PatternTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(LuceneStandardTokenizer.`@odata.type`, "odataType");
@@clientName(LuceneStandardTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(LuceneStandardTokenizerV2.`@odata.type`, "odataType");
@@clientName(LuceneStandardTokenizerV2.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(UaxUrlEmailTokenizer.`@odata.type`, "odataType");
@@clientName(UaxUrlEmailTokenizer.`@odata.type`, "odatatype", "javascript");
@@clientName(AsciiFoldingTokenFilter.`@odata.type`, "odataType");
@@clientName(AsciiFoldingTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(CjkBigramTokenFilter.`@odata.type`, "odataType");
@@clientName(CjkBigramTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(CommonGramTokenFilter.`@odata.type`, "odataType");
@@clientName(CommonGramTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(DictionaryDecompounderTokenFilter.`@odata.type`, "odataType");
@@clientName(DictionaryDecompounderTokenFilter.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(EdgeNGramTokenFilter.`@odata.type`, "odataType");
@@clientName(EdgeNGramTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(EdgeNGramTokenFilterV2.`@odata.type`, "odataType");
@@clientName(EdgeNGramTokenFilterV2.`@odata.type`, "odatatype", "javascript");
@@clientName(ElisionTokenFilter.`@odata.type`, "odataType");
@@clientName(ElisionTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(KeepTokenFilter.`@odata.type`, "odataType");
@@clientName(KeepTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(KeywordMarkerTokenFilter.`@odata.type`, "odataType");
@@clientName(KeywordMarkerTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(LengthTokenFilter.`@odata.type`, "odataType");
@@clientName(LengthTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(LimitTokenFilter.`@odata.type`, "odataType");
@@clientName(LimitTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(NGramTokenFilter.`@odata.type`, "odataType");
@@clientName(NGramTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(NGramTokenFilterV2.`@odata.type`, "odataType");
@@clientName(NGramTokenFilterV2.`@odata.type`, "odatatype", "javascript");
@@clientName(PatternCaptureTokenFilter.`@odata.type`, "odataType");
@@clientName(PatternCaptureTokenFilter.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(PatternReplaceTokenFilter.`@odata.type`, "odataType");
@@clientName(PatternReplaceTokenFilter.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(PhoneticTokenFilter.`@odata.type`, "odataType");
@@clientName(PhoneticTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(ShingleTokenFilter.`@odata.type`, "odataType");
@@clientName(ShingleTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(SnowballTokenFilter.`@odata.type`, "odataType");
@@clientName(SnowballTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(StemmerTokenFilter.`@odata.type`, "odataType");
@@clientName(StemmerTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(StemmerOverrideTokenFilter.`@odata.type`, "odataType");
@@clientName(StemmerOverrideTokenFilter.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(StopwordsTokenFilter.`@odata.type`, "odataType");
@@clientName(StopwordsTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(SynonymTokenFilter.`@odata.type`, "odataType");
@@clientName(SynonymTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(TruncateTokenFilter.`@odata.type`, "odataType");
@@clientName(TruncateTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(UniqueTokenFilter.`@odata.type`, "odataType");
@@clientName(UniqueTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(WordDelimiterTokenFilter.`@odata.type`, "odataType");
@@clientName(WordDelimiterTokenFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(MappingCharFilter.`@odata.type`, "odataType");
@@clientName(MappingCharFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(PatternReplaceCharFilter.`@odata.type`, "odataType");
@@clientName(PatternReplaceCharFilter.`@odata.type`, "odatatype", "javascript");
@@clientName(ClassicSimilarityAlgorithm.`@odata.type`, "odataType");
@@clientName(ClassicSimilarityAlgorithm.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(BM25SimilarityAlgorithm.`@odata.type`, "odataType");
@@clientName(BM25SimilarityAlgorithm.`@odata.type`, "odatatype", "javascript");
@@clientName(SearchIndexerDataIdentity.`@odata.type`, "odataType");
@@clientName(SearchIndexerDataIdentity.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(SearchIndexerDataNoneIdentity.`@odata.type`, "odataType");
@@clientName(SearchIndexerDataNoneIdentity.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(SearchIndexerDataUserAssignedIdentity.`@odata.type`, "odataType");
@@clientName(SearchIndexerDataUserAssignedIdentity.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(HighWaterMarkChangeDetectionPolicy.`@odata.type`, "odataType");
@@clientName(HighWaterMarkChangeDetectionPolicy.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(SqlIntegratedChangeTrackingPolicy.`@odata.type`, "odataType");
@@clientName(SqlIntegratedChangeTrackingPolicy.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(SoftDeleteColumnDeletionDetectionPolicy.`@odata.type`,
  "odataType"
);
@@clientName(SoftDeleteColumnDeletionDetectionPolicy.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(NativeBlobSoftDeleteDeletionDetectionPolicy.`@odata.type`,
  "odataType"
);
@@clientName(NativeBlobSoftDeleteDeletionDetectionPolicy.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(DefaultCognitiveServicesAccount.`@odata.type`, "odataType");
@@clientName(DefaultCognitiveServicesAccount.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(CognitiveServicesAccountKey.`@odata.type`, "odataType");
@@clientName(CognitiveServicesAccountKey.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(AIServicesAccountKey.`@odata.type`, "odataType");
@@clientName(AIServicesAccountKey.`@odata.type`, "odatatype", "javascript");
@@clientName(AIServicesAccountIdentity.`@odata.type`, "odataType");
@@clientName(AIServicesAccountIdentity.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(ConditionalSkill.`@odata.type`, "odataType");
@@clientName(ConditionalSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(KeyPhraseExtractionSkill.`@odata.type`, "odataType");
@@clientName(KeyPhraseExtractionSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(OcrSkill.`@odata.type`, "odataType");
@@clientName(OcrSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(ImageAnalysisSkill.`@odata.type`, "odataType");
@@clientName(ImageAnalysisSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(LanguageDetectionSkill.`@odata.type`, "odataType");
@@clientName(LanguageDetectionSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(ShaperSkill.`@odata.type`, "odataType");
@@clientName(ShaperSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(MergeSkill.`@odata.type`, "odataType");
@@clientName(MergeSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(SentimentSkillV3.`@odata.type`, "odataType");
@@clientName(SentimentSkillV3.`@odata.type`, "odatatype", "javascript");
@@clientName(EntityLinkingSkill.`@odata.type`, "odataType");
@@clientName(EntityLinkingSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(EntityRecognitionSkillV3.`@odata.type`, "odataType");
@@clientName(EntityRecognitionSkillV3.`@odata.type`, "odatatype", "javascript");
@@clientName(PIIDetectionSkill.`@odata.type`, "odataType");
@@clientName(PIIDetectionSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(SplitSkill.`@odata.type`, "odataType");
@@clientName(SplitSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(CustomEntityLookupSkill.`@odata.type`, "odataType");
@@clientName(CustomEntityLookupSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(TextTranslationSkill.`@odata.type`, "odataType");
@@clientName(TextTranslationSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(DocumentExtractionSkill.`@odata.type`, "odataType");
@@clientName(DocumentExtractionSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(DocumentIntelligenceLayoutSkill.`@odata.type`, "odataType");
@@clientName(DocumentIntelligenceLayoutSkill.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(WebApiSkill.`@odata.type`, "odataType");
@@clientName(WebApiSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(AzureMachineLearningSkill.`@odata.type`, "odataType");
@@clientName(AzureMachineLearningSkill.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(AzureOpenAIEmbeddingSkill.`@odata.type`, "odataType");
@@clientName(AzureOpenAIEmbeddingSkill.`@odata.type`,
  "odatatype",
  "javascript"
);
@@clientName(VisionVectorizeSkill.`@odata.type`, "odataType");
@@clientName(VisionVectorizeSkill.`@odata.type`, "odatatype", "javascript");
@@clientName(PathHierarchyTokenizerV2.`@odata.type`, "odataType");
@@clientName(PathHierarchyTokenizerV2.`@odata.type`, "odatatype", "javascript");
@@clientName(ListIndexStatsSummary.value, "IndexesStatistics");
@@clientName(Search.BM25SimilarityAlgorithm, "BM25Similarity", "csharp");
@@clientName(Search.BM25SimilarityAlgorithm, "BM25Similarity", "javascript");
@@clientName(Search.ClassicSimilarityAlgorithm, "ClassicSimilarity", "csharp");
@@clientName(Search.ClassicSimilarityAlgorithm,
  "ClassicSimilarity",
  "javascript"
);
@@clientName(Search.ChatCompletionCommonModelParameters,
  "CommonModelParameters",
  "javascript"
);
@@clientName(Search.SearchServiceCounters, "ServiceCounters", "javascript");
@@clientName(Search.SearchServiceLimits, "ServiceLimits", "javascript");

// Knowledge Base types
@@clientNamespace(Search.AIServices, "Azure.Search.Documents.KnowledgeBases");
@@clientNamespace(Search.AIServices,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.SynchronizationState,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.SynchronizationState,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.CompletedSynchronizationState,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.CompletedSynchronizationState,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseRetrievalRequest,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseRetrievalRequest,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseRetrievalResponse,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseRetrievalResponse,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalReasoningEffort,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalReasoningEffort,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalMinimalReasoningEffort,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalMinimalReasoningEffort,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalLowReasoningEffort,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalLowReasoningEffort,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalMediumReasoningEffort,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalMediumReasoningEffort,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalReasoningEffortKind,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalReasoningEffortKind,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalOutputMode,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalOutputMode,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.SearchIndexKnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.SearchIndexKnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.AzureBlobKnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.AzureBlobKnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.IndexedSharePointKnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.IndexedSharePointKnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.IndexedOneLakeKnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.IndexedOneLakeKnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.WebKnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.WebKnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.RemoteSharePointKnowledgeSourceParams,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.RemoteSharePointKnowledgeSourceParams,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceVectorizer,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeSourceVectorizer,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceAzureOpenAIVectorizer,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeSourceAzureOpenAIVectorizer,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceIngestionParameters,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeSourceIngestionParameters,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceStatistics,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeSourceStatistics,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeSourceStatus,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeSourceStatus,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalIntent,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalIntent,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalIntentType,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalIntentType,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeRetrievalSemanticIntent,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeRetrievalSemanticIntent,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseMessage,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseMessage,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseMessageContent,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseMessageContent,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseMessageContentType,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseMessageContentType,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseMessageTextContent,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseMessageTextContent,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseMessageImageContent,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseMessageImageContent,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseImageContent,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseImageContent,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseActivityRecordType,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseActivityRecordType,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseRetrievalActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseRetrievalActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseSearchIndexActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseSearchIndexActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseSearchIndexActivityArguments,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseSearchIndexActivityArguments,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseAzureBlobActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseAzureBlobActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseAzureBlobActivityArguments,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseAzureBlobActivityArguments,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseIndexedSharePointActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseIndexedSharePointActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseIndexedSharePointActivityArguments,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseIndexedSharePointActivityArguments,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseIndexedOneLakeActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseIndexedOneLakeActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseIndexedOneLakeActivityArguments,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseIndexedOneLakeActivityArguments,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseWebActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseWebActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseWebActivityArguments,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseWebActivityArguments,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseRemoteSharePointActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseRemoteSharePointActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseRemoteSharePointActivityArguments,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseRemoteSharePointActivityArguments,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseModelQueryPlanningActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseModelQueryPlanningActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseModelAnswerSynthesisActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseModelAnswerSynthesisActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseAgenticReasoningActivityRecord,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseAgenticReasoningActivityRecord,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseReferenceType,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseReferenceType,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseSearchIndexReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseSearchIndexReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseAzureBlobReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseAzureBlobReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseIndexedSharePointReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseIndexedSharePointReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseIndexedOneLakeReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseIndexedOneLakeReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseWebReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseWebReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseRemoteSharePointReference,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseRemoteSharePointReference,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.SharePointSensitivityLabelInfo,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.SharePointSensitivityLabelInfo,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseErrorDetail,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseErrorDetail,
  "com.azure.search.documents.knowledgebases",
  "java"
);
@@clientNamespace(Search.KnowledgeBaseErrorAdditionalInfo,
  "Azure.Search.Documents.KnowledgeBases"
);
@@clientNamespace(Search.KnowledgeBaseErrorAdditionalInfo,
  "com.azure.search.documents.knowledgebases",
  "java"
);
