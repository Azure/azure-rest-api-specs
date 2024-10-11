import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models-service.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SearchClient;

interface DataSourcesOperations {
    /**
     * Creates a new datasource or updates a datasource if it already exists.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/datasources('{dataSourceName}')")
    @put
    createOrUpdate is Azure.Core.Foundations.Operation<
        {
            ...dataSourceNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
            ...preferHeader;
            /**
             * The definition of the datasource to create or update.
             */
            @body
            dataSource: SearchIndexerDataSource;
        },
        SearchIndexerDataSource
    >;

    /**
     * Deletes a datasource.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/datasources('{dataSourceName}')")
    @delete
    delete is Azure.Core.Foundations.Operation<
        {
            ...dataSourceNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
        },
        void
    >;

    /**
     * Retrieves a datasource definition.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/datasources('{dataSourceName}')")
    @get
    get is Azure.Core.Foundations.Operation<
        {
            ...dataSourceNamePath;
            ...clientRequestIdHeader;
        },
        SearchIndexerDataSource
    >;

    /**
     * Lists all datasources available for a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/datasources")
    @get
    list is Azure.Core.Foundations.Operation<
        {
            ...selectQuery;
            ...clientRequestIdHeader;
        },
        ListDataSourcesResult
    >;

    /**
     * Creates a new datasource.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/datasources")
    @post
    create is Azure.Core.Foundations.Operation<
        {
            ...clientRequestIdHeader;
            /**
             * The definition of the datasource to create.
             */
            @body
            dataSource: SearchIndexerDataSource;
        },
        SearchIndexerDataSource
    >;
}

interface IndexersOperations {
    /**
     * Resets the change tracking state associated with an indexer.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers('{indexerName}')/search.reset")
    @post
    reset is Azure.Core.Foundations.Operation<
        {
            ...indexerNamePath;
            ...clientRequestIdHeader;
        },
        void
    >;

    /**
     * Runs an indexer on-demand.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers('{indexerName}')/search.run")
    @post
    run is Azure.Core.Foundations.Operation<
        {
            ...indexerNamePath;
            ...clientRequestIdHeader;
        },
        void
    >;

    /**
     * Creates a new indexer or updates an indexer if it already exists.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers('{indexerName}')")
    @put
    createOrUpdate is Azure.Core.Foundations.Operation<
        {
            ...indexerNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
            ...preferHeader;
            /**
             * The definition of the indexer to create or update.
             */
            @body
            indexer: SearchIndexer;
        },
        SearchIndexer
    >;

    /**
     * Deletes an indexer.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers('{indexerName}')")
    @delete
    delete is Azure.Core.Foundations.Operation<
        {
            ...indexerNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
        },
        void
    >;

    /**
     * Retrieves an indexer definition.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers('{indexerName}')")
    @get
    get is Azure.Core.Foundations.Operation<
        {
            ...indexerNamePath;
            ...clientRequestIdHeader;
        },
        SearchIndexer
    >;

    /**
     * Lists all indexers available for a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers")
    @get
    list is Azure.Core.Foundations.Operation<
        {
            ...selectQuery;
            ...clientRequestIdHeader;
        },
        ListIndexersResult
    >;

    /**
     * Creates a new indexer.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers")
    @post
    create is Azure.Core.Foundations.Operation<
        {
            ...clientRequestIdHeader;
            /**
             * The definition of the indexer to create.
             */
            @body
            indexer: SearchIndexer;
        },
        SearchIndexer
    >;

    /**
     * Returns the current status and execution history of an indexer.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexers('{indexerName}')/search.status")
    @get
    getStatus is Azure.Core.Foundations.Operation<
        {
            ...indexerNamePath;
            ...clientRequestIdHeader;
        },
        SearchIndexerStatus
    >;
}

interface SkillsetsOperations {
    /**
     * Creates a new skillset in a search service or updates the skillset if it
     * already exists.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/skillsets('{skillsetName}')")
    @put
    createOrUpdate is Azure.Core.Foundations.Operation<
        {
            ...skillsetNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
            ...preferHeader;
            /**
             * The skillset containing one or more skills to create or update in a search
             * service.
             */
            @body
            skillset: SearchIndexerSkillset;
        },
        SearchIndexerSkillset
    >;

    /**
     * Deletes a skillset in a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/skillsets('{skillsetName}')")
    @delete
    delete is Azure.Core.Foundations.Operation<
        {
            ...skillsetNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
        },
        void
    >;

    /**
     * Retrieves a skillset in a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/skillsets('{skillsetName}')")
    @get
    get is Azure.Core.Foundations.Operation<
        {
            ...skillsetNamePath;
            ...clientRequestIdHeader;
        },
        SearchIndexerSkillset
    >;

    /**
     * List all skillsets in a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/skillsets")
    @get
    list is Azure.Core.Foundations.Operation<
        {
            ...selectQuery;
            ...clientRequestIdHeader;
        },
        ListSkillsetsResult
    >;

    /**
     * Creates a new skillset in a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/skillsets")
    @post
    create is Azure.Core.Foundations.Operation<
        {
            ...clientRequestIdHeader;
            /**
             * The skillset containing one or more skills to create in a search service.
             */
            @body
            skillset: SearchIndexerSkillset;
        },
        SearchIndexerSkillset
    >;
}

interface SynonymMapsOperations {
    /**
     * Creates a new synonym map or updates a synonym map if it already exists.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/synonymmaps('{synonymMapName}')")
    @put
    createOrUpdate is Azure.Core.Foundations.Operation<
        {
            ...synonymMapNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
            ...preferHeader;
            /**
             * The definition of the synonym map to create or update.
             */
            @body
            synonymMap: SynonymMap;
        },
        SynonymMap
    >;

    /**
     * Deletes a synonym map.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/synonymmaps('{synonymMapName}')")
    @delete
    delete is Azure.Core.Foundations.Operation<
        {
            ...synonymMapNamePath;
            ...clientRequestIdHeader;
            ...matchingHeader;
        },
        void
    >;

    /**
     * Retrieves a synonym map definition.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/synonymmaps('{synonymMapName}')")
    @get
    get is Azure.Core.Foundations.Operation<
        {
            ...synonymMapNamePath;
            ...clientRequestIdHeader;
        },
        SynonymMap
    >;

    /**
     * Lists all synonym maps available for a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/synonymmaps")
    @get
    list is Azure.Core.Foundations.Operation<
        {
            ...selectQuery;
            ...clientRequestIdHeader;
        },
        ListSynonymMapsResult
    >;

    /**
     * Creates a new synonym map.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/synonymmaps")
    @post
    create is Azure.Core.Foundations.Operation<
        {
            ...clientRequestIdHeader;
            /**
             * The definition of the synonym map to create.
             */
            @body
            synonymMap: SynonymMap;
        },
        SynonymMap
    >;
}

interface IndexesOperations {
    /**
     * Creates a new search index.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes")
    @post
    create is Azure.Core.Foundations.Operation<
        {
            ...clientRequestIdHeader;
            /**
             * The definition of the index to create.
             */
            @body
            index: SearchIndex;
        },
        SearchIndex
    >;

    /**
     * Lists all indexes available for a search service.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes")
    @get
    list is Azure.Core.Foundations.Operation<
        {
            ...selectQuery;
            ...clientRequestIdHeader;
        },
        ListIndexesResult
    >;

    /**
     * Creates a new search index or updates an index if it already exists.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes('{indexName}')")
    @put
    createOrUpdate is Azure.Core.Foundations.Operation<
        {
            ...indexNamePath;
            /**
             * Allows new analyzers, tokenizers, token filters, or char filters to be added to
             * an index by taking the index offline for at least a few seconds. This
             * temporarily causes indexing and query requests to fail. Performance and write
             * availability of the index can be impaired for several minutes after the index
             * is updated, or longer for very large indexes.
             */
            @query("allowIndexDowntime")
            allowIndexDowntime?: boolean;
            ...clientRequestIdHeader;
            ...matchingHeader;
            ...preferHeader;
            /**
             * The definition of the index to create or update.
             */
            @body
            index: SearchIndex;
        },
        SearchIndex
    >;

    /**
     * Deletes a search index and all the documents it contains. This operation is
     * permanent, with no recovery option. Make sure you have a master copy of your
     * index definition, data ingestion code, and a backup of the primary data source
     * in case you need to re-build the index.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes('{indexName}')")
    @delete
    delete is Azure.Core.Foundations.Operation<
        {
            ...indexNamePath;
            ...matchingHeader;
        },
        void
    >;

    /**
     * Retrieves an index definition.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes('{indexName}')")
    @get
    get is Azure.Core.Foundations.Operation<
        {
            ...indexNamePath;
            ...clientRequestIdHeader;
        },
        SearchIndex
    >;

    /**
     * Returns statistics for the given index, including a document count and storage
     * usage.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes('{indexName}')/search.stats")
    @get
    getStatistics is Azure.Core.Foundations.Operation<
        {
            ...indexNamePath;
            ...clientRequestIdHeader;
        },
        GetIndexStatisticsResult
    >;

    /**
     * Shows how an analyzer breaks text into tokens.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
    @route("/indexes('{indexName}')/search.analyze")
    @post
    analyze is Azure.Core.Foundations.Operation<
        {
            ...indexNamePath;
            ...clientRequestIdHeader;

            /**
             * The text and analyzer or analysis components to test.
             */
            @body
            request: AnalyzeRequest;
        },
        AnalyzeResult
    >;
}

/**
 * Gets service level statistics for a search service.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@route("/servicestats")
@get
op getServiceStatistics is Azure.Core.Foundations.Operation<
    {
        ...clientRequestIdHeader;
    },
    SearchServiceStatistics
>;
