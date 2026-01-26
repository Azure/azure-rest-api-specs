import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace Genome;

/**
 * Queries suppliers from the supply chain service with various filters using
 * cursor-based pagination. Filters are applied only to Entity node properties.
 * Related data (addresses, identifiers, flags) are returned but not filterable.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation with specific pagination and filtering requirements"
@summary("Query entities")
@route("/v1/supplychain/entities")
@get
op getSuppliers is Azure.Core.Foundations.Operation<
  {
    /**
     * Supplier name (fuzzy search)
     */
    @query("name")
    name?: string;

    /**
     * The jurisdiction filter
     */
    @query("jurisdiction")
    jurisdiction?: string;

    /**
     * The entity type filter
     */
    @query("entityType")
    entityType?: string;

    /**
     * The risk score filter (exact match)
     */
    @query("riskScore")
    riskScore?: int32;

    /**
     * The minimum risk score filter for range queries
     */
    @query("minRiskScore")
    minRiskScore?: int32;

    /**
     * The maximum risk score filter for range queries
     */
    @query("maxRiskScore")
    maxRiskScore?: int32;

    /**
     * The source system filter (e.g., SAP, TV)
     */
    @query("source")
    source?: string;

    /**
     * The leader source filter (e.g., TV)
     */
    @query("leaderSource")
    leaderSource?: string;

    /**
     * The leader entity key filter
     */
    @query("leaderEntityKey")
    leaderEntityKey?: string;

    /**
     * The version filter
     */
    @query("version")
    version?: string;

    /**
     * The cursor for pagination support
     */
    @query("cursor")
    cursor?: string;

    /**
     * Maximum number of results to return (default: 50)
     */
    @minValue(1)
    @query("limit")
    limit?: int32 = 50;

    /**
     * Primary sort field (e.g., riskScore, name, jurisdiction, entityKey)
     */
    @query("sortBy")
    sortBy?: string;

    /**
     * Primary sort direction (ASC or DESC)
     */
    @query("sortDirection")
    sortDirection?: Paths1995XaxV1SupplychainEntitiesGetParameters13Schema;

    /**
     * Secondary sort field for stable ordering
     */
    @query("secondarySortBy")
    secondarySortBy?: string;

    /**
     * Secondary sort direction (ASC or DESC)
     */
    @query("secondarySortDirection")
    secondarySortDirection?: PathsMi8Vf6V1SupplychainEntitiesGetParameters15Schema;
  },
  SupplierListResponse
>;

/**
 * Retrieves a specific entity from the graph database using its unique
 * identifier. You can use TV-0 to TV-99
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operation for graph database entity retrieval"
@summary("Get entity by ID")
@route("/v1/supplychain/entities/{entityKey}")
@get
op getEntityById is Azure.Core.Foundations.Operation<
  {
    /**
     * The unique identifier of the entity to retrieve
     */
    @maxLength(100)
    @minLength(1)
    @path
    entityKey: string;
  },
  SupplierResponse
>;

/**
 * Gets N-tier suppliers from a root entity using breadth-first search traversal
 * with advanced filtering capabilities. Only single-direction queries are
 * supported - specify either upstreamDepth OR downstreamDepth, but not both.
 * Defaults to downstreamDepth = 1 for convenient single-tier downstream queries.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "NTier is a business domain term"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom graph traversal operation"
@summary("Get N-tier suppliers with filters (single-direction)")
@route("/v1/supplychain/entities/{entityKey}/search")
@get
op getNTierSuppliersWithFilters is Azure.Core.Foundations.Operation<
  {
    /**
     * The unique identifier of the root entity to start traversal from
     */
    @path
    entityKey: string;

    /**
     * The depth for upstream traversal (suppliers of suppliers, default: 0). Cannot
     * be used with downstreamDepth.
     */
    @query("upstreamDepth")
    upstreamDepth?: int32;

    /**
     * The depth for downstream traversal (customers of customers, default: 1). Cannot
     * be used with upstreamDepth.
     */
    @query("downstreamDepth")
    downstreamDepth?: int32 = 1;

    /**
     * The cursor for pagination support
     */
    @query("cursor")
    cursor?: string;

    /**
     * The maximum number of results to return (default: 100)
     */
    @minValue(1)
    @query("limit")
    limit?: int32 = 100;

    /**
     * The risk score filter (exact match)
     */
    @query("riskScore")
    riskScore?: int32;

    /**
     * The minimum risk score filter
     */
    @query("minRiskScore")
    minRiskScore?: int32;

    /**
     * The maximum risk score filter
     */
    @query("maxRiskScore")
    maxRiskScore?: int32;

    /**
     * The jurisdiction filter
     */
    @query("jurisdiction")
    jurisdiction?: string;

    /**
     * The supplier name filter for fuzzy search
     */
    @query("name")
    name?: string;

    /**
     * The entity type filter
     */
    @query("entityType")
    entityType?: string;

    /**
     * The source system filter (exact match, e.g., SAP, TV)
     */
    @query("source")
    source?: string;

    /**
     * The leader source filter (e.g., TV)
     */
    @query("leaderSource")
    leaderSource?: string;

    /**
     * The leader entity key filter
     */
    @query("leaderEntityKey")
    leaderEntityKey?: string;

    /**
     * Primary sort field (default: "depth"). Valid options: depth, riskScore, name,
     * jurisdiction, entityKey
     */
    @query("sortBy")
    sortBy?: string;

    /**
     * Primary sort direction (default: "ASC"). Valid options: ASC, DESC
     */
    @query("sortDirection")
    sortDirection?: Paths1A00F2QV1SupplychainEntitiesEntitykeySearchGetParameters15Schema = Paths1A00F2QV1SupplychainEntitiesEntitykeySearchGetParameters15Schema.ASC;

    /**
     * Secondary sort field for stable ordering (default: "name")
     */
    @query("secondarySortBy")
    secondarySortBy?: string;

    /**
     * Secondary sort direction (default: "ASC")
     */
    @query("secondarySortDirection")
    secondarySortDirection?: Paths1Dk1QrqV1SupplychainEntitiesEntitykeySearchGetParameters17Schema = Paths1Dk1QrqV1SupplychainEntitiesEntitykeySearchGetParameters17Schema.ASC;

    /**
     * Optional list of flag IDs to filter by. Entities must have at least one
     * matching flag.
     */
    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Array parameter requires explode for compatibility"
    @query(#{ name: "flagIds", explode: true })
    flagIds?: string[];
  },
  SearchNtierSuppliersResponse
>;

/**
 * Gets the subgraph of entities connected to a root entity with configurable
 * upstream OR downstream depth. Returns complete graph structure without
 * artificial limits to maintain graph integrity. Only single-direction queries
 * are supported - specify either upstreamDepth OR downstreamDepth, but not both.
 * Uses a high internal limit (10,000) to ensure complete subgraph retrieval.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "NTier is a business domain term"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom graph subgraph retrieval operation"
@summary("Get entity subgraph (single-direction)")
@route("/v1/supplychain/entities/{entityKey}/traversal")
@get
op getNTierSuppliers is Azure.Core.Foundations.Operation<
  {
    /**
     * The unique identifier of the root entity
     */
    @path
    entityKey: string;

    /**
     * The depth for upstream traversal (default: 0). Cannot be used with
     * downstreamDepth.
     */
    @query("upstreamDepth")
    upstreamDepth?: int32;

    /**
     * The depth for downstream traversal (default: 0). Cannot be used with
     * upstreamDepth.
     */
    @query("downstreamDepth")
    downstreamDepth?: int32;
  },
  NtierSuppliersResponse
>;

/**
 * Gets all flags from the supply chain graph database with pagination support.
 * Users can request any page size via the limit parameter, which will be capped
 * at 100 to prevent excessive queries.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom flags enumeration with pagination"
@summary("Get all flags")
@route("/v1/supplychain/flags")
@get
op getAllFlags is Azure.Core.Foundations.Operation<
  {
    /**
     * The cursor for pagination support
     */
    @query("cursor")
    cursor?: string;

    /**
     * The number of results to return per page (default: 100, max: 100)
     */
    @maxValue(100)
    @minValue(1)
    @query("limit")
    limit?: int32 = 100;
  },
  PathsFbhgtlV1SupplychainFlagsGetResponses200ContentApplicationJsonSchema
>;

/**
 * Searches supply chain entities using Azure AI Search with adaptive search
 * strategies. Searches across entity names and all address fields (streetAddress,
 * city, stateProvince, country, postalCode). Implements fuzzy matching for
 * queries 4-5 characters (1 char mismatch tolerance) and prefix search for all
 * queries. Returns raw data from Azure AI Search index in native OData format. If
 * no search text is provided, returns the first 50 documents by default.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom Azure AI Search integration"
@summary("Search entities using Azure AI Search")
@route("/v1/supplychain/search")
@get
op getSearchResults is Azure.Core.Foundations.Operation<
  {
    /**
     * The search query text. If empty, returns default set of documents. Searches
     * across name and address fields.
     */
    @query("q")
    q?: string;

    /**
     * Maximum number of results to return per page (default: 50)
     */
    @minValue(1)
    @query("top")
    top?: int32 = 50;

    /**
     * Number of results to skip for pagination (default: 0). Note: skip + top cannot
     * exceed 100,000 (Azure AI Search limit)
     */
    @query("skip")
    skip?: int32;
  },
  SearchResultsResponse
>;
