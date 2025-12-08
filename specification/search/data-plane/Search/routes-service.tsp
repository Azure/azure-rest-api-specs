import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models-service.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Search;

interface DataSources {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new datasource or updates a datasource if it already exists.")
  @route("/datasources('{dataSourceName}')")
  @put
  createOrUpdate is SearchDataSourceOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("Ignores cache reset requirements.")
      @query("ignoreResetRequirements")
      skipIndexerResetRequirementForCache?: boolean;

      @doc("The definition of the datasource to create or update.")
      @body
      dataSource: SearchIndexerDataSource;
    },
    SearchIndexerDataSource & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes a datasource.")
  @route("/datasources('{dataSourceName}')")
  @delete
  delete is SearchDataSourceOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves a datasource definition.")
  @route("/datasources('{dataSourceName}')")
  @get
  get is SearchDataSourceOperation<{}, SearchIndexerDataSource>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all datasources available for a search service.")
  @route("/datasources")
  @get
  list is SearchOperation<selectQuery, ListDataSourcesResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new datasource.")
  @route("/datasources")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the datasource to create.")
      @body
      dataSource: SearchIndexerDataSource;
    },
    SearchIndexerDataSource & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;
}

interface Indexers {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Resets the change tracking state associated with an indexer.")
  @route("/indexers('{indexerName}')/search.reset")
  @post
  reset is SearchIndexerOperation<
    {},
    {
      @doc("A process exit code.")
      @statusCode
      code: "204";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Resync selective options from the datasource to be re-ingested by the indexer.\"")
  @route("/indexers('{indexerName}')/search.resync")
  @post
  resync is SearchIndexerOperation<
    {
      @doc("The definition of the indexer resync options.")
      @body
      indexerResync: IndexerResyncBody;
    },
    {
      @doc("A process exit code.")
      @statusCode
      code: "204";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Resets specific documents in the datasource to be selectively re-ingested by the indexer.")
  @route("/indexers('{indexerName}')/search.resetdocs")
  @post
  resetDocs is SearchIndexerOperation<
    {
      @doc("If false, keys or ids will be appended to existing ones. If true, only the keys or ids in this payload will be queued to be re-ingested.")
      @query
      overwrite?: boolean = false;

      @doc("The keys or ids of the documents to be re-ingested. If keys are provided, the document key field must be specified in the indexer configuration. If ids are provided, the document key field is ignored.")
      @body
      keysOrIds?: DocumentKeysOrIds;
    },
    {
      @doc("A process exit code.")
      @statusCode
      code: "204";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Runs an indexer on-demand.")
  @route("/indexers('{indexerName}')/search.run")
  @post
  run is SearchIndexerOperation<
    {},
    {
      @doc("A process exit code.")
      @statusCode
      code: "202";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new indexer or updates an indexer if it already exists.")
  @route("/indexers('{indexerName}')")
  @put
  createOrUpdate is SearchIndexerOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("Ignores cache reset requirements.")
      @query("ignoreResetRequirements")
      skipIndexerResetRequirementForCache?: boolean;

      @doc("Disables cache reprocessing change detection.")
      @query("disableCacheReprocessingChangeDetection")
      disableCacheReprocessingChangeDetection?: boolean;

      @doc("The definition of the indexer to create or update.")
      @body
      indexer: SearchIndexer;
    },
    SearchIndexer & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes an indexer.")
  @route("/indexers('{indexerName}')")
  @delete
  delete is SearchIndexerOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Retrieves an indexer definition.")
  @route("/indexers('{indexerName}')")
  @get
  get is SearchIndexerOperation<{}, SearchIndexer>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all indexers available for a search service.")
  @route("/indexers")
  @get
  list is SearchOperation<selectQuery, ListIndexersResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new indexer.")
  @route("/indexers")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the indexer to create.")
      @body
      indexer: SearchIndexer;
    },
    SearchIndexer & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Returns the current status and execution history of an indexer.")
  @route("/indexers('{indexerName}')/search.status")
  @get
  getStatus is SearchIndexerOperation<{}, SearchIndexerStatus>;
}

interface Skillsets {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new skillset in a search service or updates the skillset if it already exists.")
  @route("/skillsets('{skillsetName}')")
  @put
  createOrUpdate is SearchSkillsetOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("Ignores cache reset requirements.")
      @query("ignoreResetRequirements")
      skipIndexerResetRequirementForCache?: boolean;

      @doc("Disables cache reprocessing change detection.")
      @query("disableCacheReprocessingChangeDetection")
      disableCacheReprocessingChangeDetection?: boolean;

      @doc("The skillset containing one or more skills to create or update in a search service.")
      @body
      skillset: SearchIndexerSkillset;
    },
    SearchIndexerSkillset & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Deletes a skillset in a search service.")
  @route("/skillsets('{skillsetName}')")
  @delete
  delete is SearchSkillsetOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves a skillset in a search service.")
  @route("/skillsets('{skillsetName}')")
  @get
  get is SearchSkillsetOperation<{}, SearchIndexerSkillset>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("List all skillsets in a search service.")
  @route("/skillsets")
  @get
  list is SearchOperation<selectQuery, ListSkillsetsResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new skillset in a search service.")
  @route("/skillsets")
  @post
  create is SearchOperation<
    {
      @doc("The skillset containing one or more skills to create in a search service.")
      @body
      skillset: SearchIndexerSkillset;
    },
    SearchIndexerSkillset & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Reset an existing skillset in a search service.")
  @route("/skillsets('{skillsetName}')/search.resetskills")
  @post
  resetSkills is SearchSkillsetOperation<
    {
      @doc("The names of the skills to reset. If not specified, all skills in the skillset will be reset.")
      @body
      skillNames: SkillNames;
    },
    void
  >;
}

interface SynonymMaps {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new synonym map or updates a synonym map if it already exists.")
  @route("/synonymmaps('{synonymMapName}')")
  @put
  createOrUpdate is SearchSynonymMapOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("The definition of the synonym map to create or update.")
      @body
      synonymMap: SynonymMap;
    },
    SynonymMap & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes a synonym map.")
  @route("/synonymmaps('{synonymMapName}')")
  @delete
  delete is SearchSynonymMapOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Retrieves a synonym map definition.")
  @route("/synonymmaps('{synonymMapName}')")
  @get
  get is SearchSynonymMapOperation<{}, SynonymMap>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all synonym maps available for a search service.")
  @route("/synonymmaps")
  @get
  list is SearchOperation<selectQuery, ListSynonymMapsResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new synonym map.")
  @route("/synonymmaps")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the synonym map to create.")
      @body
      synonymMap: SynonymMap;
    },
    SynonymMap & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;
}

interface Indexes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new search index.")
  @route("/indexes")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the index to create.")
      @body
      index: SearchIndex;
    },
    SearchIndex & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all indexes available for a search service.")
  @route("/indexes")
  @list
  @get
  list is SearchOperation<selectQuery, ListIndexesResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new search index or updates an index if it already exists.")
  @route("/indexes('{indexName}')")
  @put
  createOrUpdate is SearchIndexOperation<
    {
      ...matchingHeader;

      @doc("Allows new analyzers, tokenizers, token filters, or char filters to be added to an index by taking the index offline for at least a few seconds. This temporarily causes indexing and query requests to fail. Performance and write availability of the index can be impaired for several minutes after the index is updated, or longer for very large indexes.")
      @query
      allowIndexDowntime?: boolean;

      ...preferHeader;

      @doc("The definition of the index to create or update.")
      @body
      index: SearchIndex;
    },
    SearchIndex & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes a search index and all the documents it contains. This operation is permanent, with no recovery option. Make sure you have a master copy of your index definition, data ingestion code, and a backup of the primary data source in case you need to re-build the index.")
  @route("/indexes('{indexName}')")
  @delete
  delete is SearchIndexOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves an index definition.")
  @route("/indexes('{indexName}')")
  @get
  get is SearchIndexOperation<{}, SearchIndex>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Returns statistics for the given index, including a document count and storage usage.")
  @route("/indexes('{indexName}')/search.stats")
  @get
  getStatistics is SearchIndexOperation<{}, GetIndexStatisticsResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Shows how an analyzer breaks text into tokens.")
  @route("/indexes('{indexName}')/search.analyze")
  @post
  analyze is SearchIndexOperation<
    {
      @doc("The text and analyzer or analysis components to test.")
      @body
      request: AnalyzeRequest;
    },
    AnalyzeResult
  >;
}

interface Aliases {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new search alias.")
  @route("/aliases")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the alias to create.")
      @body
      `alias`: SearchAlias;
    },
    SearchAlias & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all aliases available for a search service.")
  @route("/aliases")
  @list
  @get
  list is SearchOperation<{}, ListAliasesResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new search alias or updates an alias if it already exists.")
  @route("/aliases('{aliasName}')")
  @put
  createOrUpdate is SearchAliasOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("The definition of the alias to create or update.")
      @body
      `alias`: SearchAlias;
    },
    SearchAlias & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes a search alias and its associated mapping to an index. This operation is permanent, with no recovery option. The mapped index is untouched by this operation.")
  @route("/aliases('{aliasName}')")
  @delete
  delete is SearchAliasOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves an alias definition.")
  @route("/aliases('{aliasName}')")
  @get
  get is SearchAliasOperation<{}, SearchAlias>;
}

interface KnowledgeBases {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new knowledge base.")
  @route("/knowledgebases")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the knowledge base to create.")
      @body
      knowledgeBase: KnowledgeBase;
    },
    KnowledgeBase & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all knowledge bases available for a search service.")
  @route("/knowledgebases")
  @list
  @get
  list is SearchOperation<{}, ListKnowledgeBasesResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new knowledge base or updates a knowledge base if it already exists.")
  @route("/knowledgebases('{knowledgeBaseName}')")
  @put
  createOrUpdate is SearchKnowledgeBaseOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("The definition of the knowledge base to create or update.")
      @body
      knowledgeBase: KnowledgeBase;
    },
    KnowledgeBase & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes a knowledge base.")
  @route("/knowledgebases('{knowledgeBaseName}')")
  @delete
  delete is SearchKnowledgeBaseOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves a knowledge base definition.")
  @route("/knowledgebases('{knowledgeBaseName}')")
  @get
  get is SearchKnowledgeBaseOperation<{}, KnowledgeBase>;
}

interface KnowledgeSources {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Creates a new knowledge source.")
  @route("/knowledgesources")
  @post
  create is SearchOperation<
    {
      @doc("The definition of the knowledge source to create.")
      @body
      knowledgeSource: KnowledgeSource;
    },
    KnowledgeSource & {
      @doc("A process exit code.")
      @statusCode
      code: "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Lists all knowledge sources available for a search service.")
  @route("/knowledgesources")
  @list
  @get
  list is SearchOperation<{}, ListKnowledgeSourcesResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
  @doc("Creates a new knowledge source or updates an knowledge source if it already exists.")
  @route("/knowledgesources('{sourceName}')")
  @put
  createOrUpdate is SearchSourceOperation<
    {
      ...matchingHeader;
      ...preferHeader;

      @doc("The definition of the knowledge source to create or update.")
      @body
      knowledgeSource: KnowledgeSource;
    },
    KnowledgeSource & {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "200" | "201";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Deletes an existing knowledge source.")
  @route("/knowledgesources('{sourceName}')")
  @delete
  delete is SearchSourceOperation<
    {
      ...matchingHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "return status code"
      @doc("A process exit code.")
      @statusCode
      code: "204" | "404";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves a knowledge source definition.")
  @route("/knowledgesources('{sourceName}')")
  @get
  get is SearchSourceOperation<{}, KnowledgeSource>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("Retrieves the status of a knowledge source.")
  @route("/knowledgesources('{sourceName}')/status")
  @get
  getStatus is SearchSourceOperation<{}, KnowledgeSourceStatus>;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@doc("Gets service level statistics for a search service.")
@route("/servicestats")
@get
op getServiceStatistics is SearchOperation<{}, SearchServiceStatistics>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Pre-existing API contract"
@doc("Retrieves a summary of statistics for all indexes in the search service.")
@route("/indexstats")
@list
@get
op getIndexStatsSummary is SearchOperation<{}, ListIndexStatsSummary>;
