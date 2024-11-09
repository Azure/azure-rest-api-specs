import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Search;

@TypeSpec.Versioning.useDependency(Search.Versions.v2024_07_01)
namespace Customizations;

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
@@clientName(AzureMachineLearningSkill.uri, "scoringUri");
@@clientName(AzureMachineLearningSkill.key, "authenticationKey");
@@clientName(SkillNames.skillNames, "skillNameList", "csharp");
@@clientName(AMLParameters, "AzureMachineLearningParameters");
@@clientName(AMLVectorizer, "AzureMachineLearningVectorizer");
