import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Search;

@TypeSpec.Versioning.useDependency(Search.Versions.v2025_03_01_preview)
namespace Customizations;

@client({
  name: "SearchIndexClient",
  service: Search,
})
@clientNamespace("Azure.Search.Documents")
namespace SearchIndexClient {
  @operationGroup()
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
  name: "SearchServiceClient",
  service: Search,
})
@clientNamespace("Azure.Search.Documents.Indexes")
namespace SearchServiceClient {
  @operationGroup()
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
  @operationGroup()
  interface Indexers {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    reset is Search.Indexers.reset;
  
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
  @operationGroup()
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
  @operationGroup()
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
  @operationGroup()
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
  @operationGroup()
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
  interface Root {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getServiceStatistics is Search.getServiceStatistics;
  
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
    getIndexStatsSummary is Search.getIndexStatsSummary;
  }
}

@@clientNamespace(Search.ErrorResponse, "Azure.Search.Documents");
@@clientNamespace(Search.ErrorDetail, "Azure.Search.Documents");
@@clientNamespace(Search.ErrorAdditionalInfo, "Azure.Search.Documents");

@@clientNamespace(Search.SemanticErrorMode, "Azure.Search.Documents");
@@clientNamespace(Search.QueryAnswerType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryCaptionType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryRewritesType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryDebugMode, "Azure.Search.Documents");
@@clientNamespace(Search.QueryLanguage, "Azure.Search.Documents");
@@clientNamespace(Search.QuerySpellerType, "Azure.Search.Documents");
@@clientNamespace(Search.VectorQueryKind, "Azure.Search.Documents");
@@clientNamespace(Search.VectorThresholdKind, "Azure.Search.Documents");
@@clientNamespace(Search.VectorFilterMode, "Azure.Search.Documents");
@@clientNamespace(Search.HybridCountAndFacetMode, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticFieldState, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticErrorReason, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticSearchResultsType, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticQueryRewritesResultType, "Azure.Search.Documents");
@@clientNamespace(Search.QueryType, "Azure.Search.Documents");
@@clientNamespace(Search.SearchMode, "Azure.Search.Documents");
@@clientNamespace(Search.ScoringStatistics, "Azure.Search.Documents");
@@clientNamespace(Search.IndexActionType, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteMode, "Azure.Search.Documents");
@@clientNamespace(Search.SearchDocumentsResult, "Azure.Search.Documents");
@@clientNamespace(Search.FacetResult, "Azure.Search.Documents");
@@clientNamespace(Search.QueryAnswerResult, "Azure.Search.Documents");
@@clientNamespace(Search.DebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.QueryRewritesDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.QueryRewritesValuesDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.SearchRequest, "Azure.Search.Documents");
@@clientNamespace(Search.VectorQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorThreshold, "Azure.Search.Documents");
@@clientNamespace(Search.HybridSearch, "Azure.Search.Documents");
@@clientNamespace(Search.SearchResult, "Azure.Search.Documents");
@@clientNamespace(Search.QueryCaptionResult, "Azure.Search.Documents");
@@clientNamespace(Search.DocumentDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.SemanticDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.QueryResultDocumentSemanticField, "Azure.Search.Documents");
@@clientNamespace(Search.QueryResultDocumentRerankerInput, "Azure.Search.Documents");
@@clientNamespace(Search.VectorsDebugInfo, "Azure.Search.Documents");
@@clientNamespace(Search.QueryResultDocumentSubscores, "Azure.Search.Documents");
@@clientNamespace(Search.TextResult, "Azure.Search.Documents");
@@clientNamespace(Search.SingleVectorFieldResult, "Azure.Search.Documents");
@@clientNamespace(Search.SuggestDocumentsResult, "Azure.Search.Documents");
@@clientNamespace(Search.SuggestResult, "Azure.Search.Documents");
@@clientNamespace(Search.SuggestRequest, "Azure.Search.Documents");
@@clientNamespace(Search.IndexBatch, "Azure.Search.Documents");
@@clientNamespace(Search.IndexAction, "Azure.Search.Documents");
@@clientNamespace(Search.LookupDocument, "Azure.Search.Documents");
@@clientNamespace(Search.IndexDocumentsResult, "Azure.Search.Documents");
@@clientNamespace(Search.IndexingResult, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteResult, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteItem, "Azure.Search.Documents");
@@clientNamespace(Search.AutocompleteRequest, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizedQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizableTextQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizableImageUrlQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorizableImageBinaryQuery, "Azure.Search.Documents");
@@clientNamespace(Search.VectorSimilarityThreshold, "Azure.Search.Documents");
@@clientNamespace(Search.SearchScoreThreshold, "Azure.Search.Documents");

@@clientNamespace(Search.SearchIndexerDataSourceType, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.BlobIndexerParsingMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MarkdownParsingSubmode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MarkdownHeaderDepth, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.BlobIndexerDataToExtract, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.BlobIndexerImageAction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.BlobIndexerPDFTextRotationAlgorithm, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerExecutionEnvironment, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerExecutionStatusDetail, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexProjectionMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchFieldDataType, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalAnalyzerName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalNormalizerName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorEncodingFormat, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchAlgorithmKind, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchVectorizerKind, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchCompressionKind, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchCompressionRescoreStorageMethod, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalTokenizerName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TokenFilterName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CharFilterName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.RegexFlags, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchAlgorithmMetric, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchCompressionTarget, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureOpenAIModelName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AIFoundryModelCatalogName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeyPhraseExtractionSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OcrSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OcrLineEnding, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ImageAnalysisSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VisualFeature, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ImageDetail, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityCategory, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityRecognitionSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SentimentSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PIIDetectionSkillMaskingMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TextSplitMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkillUnit, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkillEncoderModelName, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomEntityLookupSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TextTranslationSkillLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillOutputMode, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DocumentIntelligenceLayoutSkillMarkdownHeaderDepth, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerStatus, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerExecutionStatus, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScoringFunctionInterpolation, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScoringFunctionAggregation, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TokenCharacterKind, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MicrosoftTokenizerLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MicrosoftStemmingTokenizerLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CjkBigramTokenFilterScripts, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EdgeNGramTokenFilterSide, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PhoneticEncoder, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SnowballTokenFilterLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StemmerTokenFilterLanguage, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StopwordsList, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerDataSource, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DataSourceCredentials, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerDataContainer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DataChangeDetectionPolicy, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DataDeletionDetectionPolicy, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchResourceEncryptionKey, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureActiveDirectoryApplicationCredentials, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListDataSourcesResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DocumentKeysOrIds, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingSchedule, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexingParametersConfiguration, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.FieldMapping, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.FieldMappingFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerCache, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListIndexersResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerStatus, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerExecutionResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexerCurrentState, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerError, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerWarning, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerLimits, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerSkillset, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.InputFieldMappingEntry, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OutputFieldMappingEntry, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CognitiveServicesAccount, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStore, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreProjection, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreTableProjectionSelector, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreProjectionSelector, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreObjectProjectionSelector, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreBlobProjectionSelector, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreFileProjectionSelector, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerIndexProjection, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerIndexProjectionSelector, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerIndexProjectionsParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListSkillsetsResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SkillNames, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SynonymMap, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListSynonymMapsResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndex, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchField, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScoringProfile, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TextWeights, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CorsOptions, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchSuggester, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CharFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LexicalNormalizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SimilarityAlgorithm, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SemanticSearch, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SemanticConfiguration, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SemanticPrioritizedFields, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SemanticField, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearch, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchProfile, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchAlgorithmConfiguration, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VectorSearchCompression, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.RescoringOptions, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListIndexesResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.GetIndexStatisticsResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AnalyzeRequest, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AnalyzeResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AnalyzedTokenInfo, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchAlias, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListAliasesResult, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchServiceStatistics, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchServiceCounters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ResourceCounter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchServiceLimits, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LuceneStandardAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StopAnalyzer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomNormalizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ClassicTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EdgeNGramTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeywordTokenizerV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MicrosoftLanguageTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MicrosoftLanguageStemmingTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.NGramTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PathHierarchyTokenizerV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LuceneStandardTokenizerV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.UaxUrlEmailTokenizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AsciiFoldingTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CjkBigramTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CommonGramTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DictionaryDecompounderTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EdgeNGramTokenFilterV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ElisionTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeepTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeywordMarkerTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LengthTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LimitTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.NGramTokenFilterV2, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternCaptureTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternReplaceTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PhoneticTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ShingleTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SnowballTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StemmerTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StemmerOverrideTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.StopwordsTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SynonymTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TruncateTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.UniqueTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WordDelimiterTokenFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MappingCharFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PatternReplaceCharFilter, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ClassicSimilarityAlgorithm, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.BM25SimilarityAlgorithm, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.HnswAlgorithmConfiguration, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.HnswParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ExhaustiveKnnAlgorithmConfiguration, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ExhaustiveKnnParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScalarQuantizationCompression, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ScalarQuantizationParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.BinaryQuantizationCompression, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureOpenAIVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureOpenAIVectorizerParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerDataIdentity, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebApiVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebApiVectorizerParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AIServicesVisionVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AIServicesVisionParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AMLVectorizer, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AMLParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerDataNoneIdentity, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerDataUserAssignedIdentity, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.HighWaterMarkChangeDetectionPolicy, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SqlIntegratedChangeTrackingPolicy, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SoftDeleteColumnDeletionDetectionPolicy, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.NativeBlobSoftDeleteDeletionDetectionPolicy, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DistanceScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DistanceScoringParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.FreshnessScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.FreshnessScoringParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MagnitudeScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MagnitudeScoringParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TagScoringFunction, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TagScoringParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SearchIndexerKnowledgeStoreParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DefaultCognitiveServicesAccount, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CognitiveServicesAccountKey, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AIServicesAccountKey, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AIServicesAccountIdentity, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomEntity, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomEntityAlias, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ConditionalSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.KeyPhraseExtractionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.OcrSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ImageAnalysisSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.LanguageDetectionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ShaperSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.MergeSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityRecognitionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SentimentSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SentimentSkillV3, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityLinkingSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.EntityRecognitionSkillV3, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.PIIDetectionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.SplitSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureOpenAITokenizerParameters, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.CustomEntityLookupSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.TextTranslationSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DocumentExtractionSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.DocumentIntelligenceLayoutSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.WebApiSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureMachineLearningSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.AzureOpenAIEmbeddingSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.VisionVectorizeSkill, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.IndexStatisticsSummary, "Azure.Search.Documents.Indexes");
@@clientNamespace(Search.ListIndexStatsSummary, "Azure.Search.Documents.Indexes");


@@access(VectorSearchAlgorithmKind, Access.public);
@@usage(VectorSearchAlgorithmKind, Usage.input);
@@access(VectorSearchVectorizerKind, Access.public);
@@usage(VectorSearchVectorizerKind, Usage.input);
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
@@clientName(SearchIndex.semantic, "semanticSearch");
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
@@clientName(WebApiVectorizerParameters.uri, "url");
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
@@clientName(DataDeletionDetectionPolicy.`@odata.type`, "odataType");
@@clientName(SearchIndexerSkill.`@odata.type`, "odataType");
@@clientName(CognitiveServicesAccount.`@odata.type`, "odataType");
@@clientName(LexicalAnalyzer.`@odata.type`, "odataType");
@@clientName(LexicalTokenizer.`@odata.type`, "odataType");
@@clientName(TokenFilter.`@odata.type`, "odataType");
@@clientName(CharFilter.`@odata.type`, "odataType");
@@clientName(LexicalNormalizer.`@odata.type`, "odataType");
@@clientName(SimilarityAlgorithm.`@odata.type`, "odataType");
@@clientName(CustomAnalyzer.`@odata.type`, "odataType");
@@clientName(PatternAnalyzer.`@odata.type`, "odataType");
@@clientName(LuceneStandardAnalyzer.`@odata.type`, "odataType");
@@clientName(StopAnalyzer.`@odata.type`, "odataType");
@@clientName(CustomNormalizer.`@odata.type`, "odataType");
@@clientName(ClassicTokenizer.`@odata.type`, "odataType");
@@clientName(EdgeNGramTokenizer.`@odata.type`, "odataType");
// @@clientName(KeywordTokenizer.`@odata.type`, "odataType");
@@clientName(KeywordTokenizerV2.`@odata.type`, "odataType");
@@clientName(MicrosoftLanguageTokenizer.`@odata.type`, "odataType");
@@clientName(MicrosoftLanguageStemmingTokenizer.`@odata.type`, "odataType");
@@clientName(NGramTokenizer.`@odata.type`, "odataType");
@@clientName(PatternTokenizer.`@odata.type`, "odataType");
// @@clientName(LuceneStandardTokenizer.`@odata.type`, "odataType");
@@clientName(LuceneStandardTokenizerV2.`@odata.type`, "odataType");
@@clientName(UaxUrlEmailTokenizer.`@odata.type`, "odataType");
@@clientName(AsciiFoldingTokenFilter.`@odata.type`, "odataType");
@@clientName(CjkBigramTokenFilter.`@odata.type`, "odataType");
@@clientName(CommonGramTokenFilter.`@odata.type`, "odataType");
@@clientName(DictionaryDecompounderTokenFilter.`@odata.type`, "odataType");
// @@clientName(EdgeNGramTokenFilter.`@odata.type`, "odataType");
@@clientName(EdgeNGramTokenFilterV2.`@odata.type`, "odataType");
@@clientName(ElisionTokenFilter.`@odata.type`, "odataType");
@@clientName(KeepTokenFilter.`@odata.type`, "odataType");
@@clientName(KeywordMarkerTokenFilter.`@odata.type`, "odataType");
@@clientName(LengthTokenFilter.`@odata.type`, "odataType");
@@clientName(LimitTokenFilter.`@odata.type`, "odataType");
// @@clientName(NGramTokenFilter.`@odata.type`, "odataType");
@@clientName(NGramTokenFilterV2.`@odata.type`, "odataType");
@@clientName(PatternCaptureTokenFilter.`@odata.type`, "odataType");
@@clientName(PatternReplaceTokenFilter.`@odata.type`, "odataType");
@@clientName(PhoneticTokenFilter.`@odata.type`, "odataType");
@@clientName(ShingleTokenFilter.`@odata.type`, "odataType");
@@clientName(SnowballTokenFilter.`@odata.type`, "odataType");
@@clientName(StemmerTokenFilter.`@odata.type`, "odataType");
@@clientName(StemmerOverrideTokenFilter.`@odata.type`, "odataType");
@@clientName(StopwordsTokenFilter.`@odata.type`, "odataType");
@@clientName(SynonymTokenFilter.`@odata.type`, "odataType");
@@clientName(TruncateTokenFilter.`@odata.type`, "odataType");
@@clientName(UniqueTokenFilter.`@odata.type`, "odataType");
@@clientName(WordDelimiterTokenFilter.`@odata.type`, "odataType");
@@clientName(MappingCharFilter.`@odata.type`, "odataType");
@@clientName(PatternReplaceCharFilter.`@odata.type`, "odataType");
@@clientName(ClassicSimilarityAlgorithm.`@odata.type`, "odataType");
@@clientName(BM25SimilarityAlgorithm.`@odata.type`, "odataType");
@@clientName(SearchIndexerDataIdentity.`@odata.type`, "odataType");
@@clientName(SearchIndexerDataNoneIdentity.`@odata.type`, "odataType");
@@clientName(SearchIndexerDataUserAssignedIdentity.`@odata.type`, "odataType");
@@clientName(HighWaterMarkChangeDetectionPolicy.`@odata.type`, "odataType");
@@clientName(SqlIntegratedChangeTrackingPolicy.`@odata.type`, "odataType");
@@clientName(SoftDeleteColumnDeletionDetectionPolicy.`@odata.type`,
  "odataType"
);
@@clientName(NativeBlobSoftDeleteDeletionDetectionPolicy.`@odata.type`,
  "odataType"
);
@@clientName(DefaultCognitiveServicesAccount.`@odata.type`, "odataType");
@@clientName(CognitiveServicesAccountKey.`@odata.type`, "odataType");
@@clientName(AIServicesAccountKey.`@odata.type`, "odataType");
@@clientName(AIServicesAccountIdentity.`@odata.type`, "odataType");
@@clientName(ConditionalSkill.`@odata.type`, "odataType");
@@clientName(KeyPhraseExtractionSkill.`@odata.type`, "odataType");
@@clientName(OcrSkill.`@odata.type`, "odataType");
@@clientName(ImageAnalysisSkill.`@odata.type`, "odataType");
@@clientName(LanguageDetectionSkill.`@odata.type`, "odataType");
@@clientName(ShaperSkill.`@odata.type`, "odataType");
@@clientName(MergeSkill.`@odata.type`, "odataType");
@@clientName(EntityRecognitionSkill.`@odata.type`, "odataType");
@@clientName(SentimentSkill.`@odata.type`, "odataType");
@@clientName(SentimentSkillV3.`@odata.type`, "odataType");
@@clientName(EntityLinkingSkill.`@odata.type`, "odataType");
@@clientName(EntityRecognitionSkillV3.`@odata.type`, "odataType");
@@clientName(EntityRecognitionSkill.`@odata.type`, "odataType");
@@clientName(PIIDetectionSkill.`@odata.type`, "odataType");
@@clientName(SplitSkill.`@odata.type`, "odataType");
@@clientName(CustomEntityLookupSkill.`@odata.type`, "odataType");
@@clientName(TextTranslationSkill.`@odata.type`, "odataType");
@@clientName(DocumentExtractionSkill.`@odata.type`, "odataType");
@@clientName(DocumentIntelligenceLayoutSkill.`@odata.type`, "odataType");
@@clientName(WebApiSkill.`@odata.type`, "odataType");
@@clientName(AzureMachineLearningSkill.`@odata.type`, "odataType");
@@clientName(AzureOpenAIEmbeddingSkill.`@odata.type`, "odataType");
@@clientName(VisionVectorizeSkill.`@odata.type`, "odataType");
@@clientName(PathHierarchyTokenizerV2.`@odata.type`, "odataType");
@@clientName(ListIndexStatsSummary.value, "IndexesStatistics");
