import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "./models.common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "MPCPro Ingestion and Management API" })
@useAuth(BearerAuth)
@versioned(Versions)
namespace MicrosoftPlanetaryComputerPro;

@route("/api/collections/{collectionId}/ingestions")
@tag("Ingestion Management")
namespace Ingestions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get ingestions of a catalog")
  op getAll(...CollectionParameters, ...OdataQuery): IngestionDefinition[];

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get the definition of an ingestion")
  op get(...IngestionParameters): IngestionDefinition | NotFound;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new ingestion")
  op create(
    ...CollectionParameters,

    /**
     * TODO: add description for definition
     */
    @doc("Definition of the ingestion")
    @body
    definition: IngestionDefinitionCreation,
  ): {
    /**
     * TODO: add description for Location
     */
    @doc("Url of the created ingestion")
    @header
    location: url;

    @statusCode statusCode: "201";

    /**
     * TODO: add description for }
     */
    @body _: IngestionDefinition;
  } | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update an existing ingestion")
  @patch
  op update(
    ...IngestionParameters,

    @doc("Ingestion properties to update")
    @body
    request: PatchRequest,
  ): {
    @statusCode statusCode: "200";
    @body _: IngestionDefinition;
  } | NotFound | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete an ingestion from a catalog. All runs of the ingestion will be deleted. Ingestion must not have any runs in progress or queued.")
  @delete
  op delete(...IngestionParameters): {
    /**
     * TODO: add description for Location
     */
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    /**
     * TODO: add description for operationLocation
     */
    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    /**
     * TODO: add description for statusCode
     */
    @statusCode statusCode: "202";

    @body _: Operation;
  } | NotFound | BadRequest;

  /**
   * TODO: add description for IngestionDefinitionCreation
   */
  @doc("Spatio geo-catalog ingestion creation model")
  model IngestionDefinitionCreation {
    /**
     * TODO: add description for importType
     */
    @doc("Ingestion type")
    importType: IngestionType;

    /**
     * TODO: add description for displayName
     */
    @doc("Ingestion name")
    displayName?: string;

    /**
     * TODO: add description for sourceCatalogUrl
     */
    @doc("Source catalog URL. *Required for StaticCatalog ingestion type")
    sourceCatalogUrl?: url;

    /**
     * TODO: add description for stacGeoparquetUrl
     */
    @doc("Parquet catalog URL. *Required for StacGeoparquet ingestion type")
    geoparquetUrl?: url;

    /**
     * TODO: add description for skipExistingItems
     */
    @doc("Skip processing existing items in the catalog")
    skipExistingItems?: boolean;

    /**
     * TODO: add description for keepOriginalAssets
     */
    @doc("Keep original source assets")
    keepOriginalAssets?: boolean;
  }

  /**
   * TODO: add description for IngestionDefinition
   */
  @doc("Spatio geo-catalog ingestion definition")
  model IngestionDefinition is IngestionDefinitionCreation {
    /**
     * TODO: add description for id
     */
    @doc("Ingestion id")
    ingestionId: Guid;

    /**
     * TODO: add description for creationTime
     */
    @doc("Ingestion creation time")
    creationTime: utcDateTime;

    /**
     * TODO: add description for IngestionStatus
     */
    @doc("Ingestion status")
    status: IngestionStatus;
  }

  /**
   * TODO: add description for PatchRequest
   */
  model PatchRequest {
    /**
     * TODO: add description for displayName
     */
    @doc("Ingestion name")
    displayName?: string;

    /**
     * TODO: add description for sourceCatalogUrl
     */
    @doc("Source catalog URL")
    sourceCatalogUrl?: url;

    /**
     * TODO: add description for stacGeoparquetUrl
     */
    @doc("Parquet catalog URL. *Required for StacGeoparquet ingestion type")
    stacGeoparquetUrl?: url;

    /**
     * TODO: add description for skipExistingItems
     */
    @doc("Skip processing existing items in the catalog")
    skipExistingItems?: boolean;

    /**
     * TODO: add description for keepOriginalAssets
     */
    @doc("Keep original source assets")
    keepOriginalAssets?: boolean;
  }

  /**
   * TODO: add description for IngestionType
   */
  union IngestionType {
    string,

    @doc("Static STAC Catalog")
    StaticCatalog: "StaticCatalog",

    @doc("Ingestion STAC Geoparquet catalog")
    StacGeoparquet: "StacGeoparquet",
  }

  /**
   * TODO: add description for IngestionStatus
   */
  union IngestionStatus {
    string,

    @doc("Ingestion accepted and ready to be run")
    Ready: "Ready",

    @doc("Ingestion is being deleting in the background")
    Deleting: "Deleting",
  }

  /**
   * TODO: add description for IngestionParameters
   */
  model IngestionParameters is CollectionParameters {
    /**
     * TODO: add description for ingestionId
     */
    @doc("Ingestion id")
    @path
    @maxLength(500)
    @pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
    ingestionId: string;
  }

  @route("{ingestionId}/runs")
  namespace Runs {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
    @doc("Get the runs of an ingestion")
    op getAll(...IngestionParameters): IngestionRun[] | NotFound;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
    @doc("Get a run of an ingestion")
    op get(...IngestionRunParameters): IngestionRun | NotFound;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
    @doc("Create a new run of an ingestion")
    @post
    op create(...IngestionParameters): {
      /**
       * TODO: add description for Location
       */
      @doc("Url of the created ingestion run")
      @header
      location: url;

      @statusCode statusCode: "201";

      /**
       * TODO: add description for }
       */
      @body _: IngestionRun;
    } | NotFound;

    /**
     * TODO: add description for IngestionRun
     */
    @doc("Spatio geo-catalog ingestion run")
    model IngestionRun {
      /**
       * TODO: add description for id
       */
      @doc("Run id")
      runId: Guid;

      /**
       * TODO: add description for operation
       */
      @doc("Run creation time")
      creationTime: utcDateTime;

      /**
       * TODO: add description for operation
       */
      @doc("Source catalog URL")
      sourceCatalogUrl: url;

      /**
       * TODO: add description for operation
       */
      @doc("Skip existing items")
      skipExistingItems: boolean;

      /**
       * TODO: add description for operation
       */
      @doc("Keep original assets")
      keepOriginalAssets: boolean;

      /**
       * TODO: add description for operation
       */
      @doc("Operation")
      operation: Operation;
    }

    /**
     * TODO: add description for IngestionRunParameters
     */
    model IngestionRunParameters is IngestionParameters {
      /**
       * TODO: add description for runId
       */
      @doc("Run id")
      @path
      @maxLength(500)
      @pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
      runId: string;
    }
  }
}

@route("/api/collections/{collectionId}/items")
@tag("SpatioTemporal Asset Catalog (STAC) API")
namespace Items {
  /**
   * Fetch features of the feature collection with id `collectionId`.
   *
   * Every feature in a dataset belongs to a collection. A dataset may
   * consist of multiple feature collections. A feature collection is often a
   * collection of features of a similar type, based on a common schema.")
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  op getFeatures(
    ...CollectionParameters,

    /**
     * The optional limit parameter recommends the number of items that should be present in the response document.
     *
     * If the limit parameter value is greater than advertised limit maximum, the server must return the
     * maximum possible number of items, rather than responding with an error.
     *
     * Only items are counted that are on the first level of the collection in the response document.
     * Nested objects contained within the explicitly requested items must not be counted.
     *
     *  Minimum = 1. Maximum = 10000. Default = 10.
     */
    @query
    limit?: int64,

    /**
     * Only features that have a geometry that intersects the bounding box are selected.
     * The bounding box is provided as four or six numbers, depending on whether the
     * coordinate reference system includes a vertical axis (height or depth):
     *
     * - Lower left corner, coordinate axis 1
     * - Lower left corner, coordinate axis 2
     * - Minimum value, coordinate axis 3 (optional)
     * - Upper right corner, coordinate axis 1
     * - Upper right corner, coordinate axis 2
     * - Maximum value, coordinate axis 3 (optional)
     *
     * The coordinate reference system of the values is WGS 84 longitude/latitude
     * (http://www.opengis.net/def/crs/OGC/1.3/CRS84).
     *
     * For WGS 84 longitude/latitude the values are in most cases the sequence of
     * minimum longitude, minimum latitude, maximum longitude and maximum latitude.
     * However, in cases where the box spans the antimeridian the first value
     * (west-most box edge) is larger than the third value (east-most box edge).
     *
     * If the vertical axis is included, the third and the sixth number are
     * the bottom and the top of the 3-dimensional bounding box.
     *
     * If a feature has multiple spatial geometry properties, it is the decision of the
     * server whether only a single spatial geometry property is used to determine
     * the extent or all relevant geometries.
     */
    #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
    @query(#{ explode: true })
    bbox?: float64[],

    /**
     * Either a date-time or an interval, open or closed. Date and time expressions
     * adhere to RFC 3339. Open intervals are expressed using double-dots.
     *
     * Examples:
     *
     * - A date-time: "2018-02-12T23:20:50Z"
     * - A closed interval: "2018-02-12T00:00:00Z/2018-03-18T12:31:12Z"
     * - Open intervals: "2018-02-12T00:00:00Z/.." or "../2018-03-18T12:31:12Z"
     *
     * Only features that have a temporal property that intersects the value of
     * `datetime` are selected.
     *
     * If a feature has multiple temporal properties, it is the decision of the
     * server whether only a single temporal property is used to determine
     * the extent or all relevant temporal properties.
     */
    @query
    datetime?: string,
  ): StacItemCollection | NotFound | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Fetch a single STAC Item")
  op get(
    ...CollectionParameters,

    /**
     * TODO: add description for itemId
     */
    @doc("STAC Item id")
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,
  ): StacItem | NotFound | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new STAC item or a set of items in a collection")
  @pollingOperation(Operations.get)
  op create(
    ...CollectionParameters,

    /**
     * TODO: add description for item
     */
    #suppress "@azure-tools/typespec-autorest/union-unsupported" ""
    @doc("STAC Item or ItemCollection")
    @body
    item: StacPostOrPutItem | StacPostOrPutItemCollection,
  ): {
    /**
     * TODO: add description for Location
     */
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: "202";

    /**
     * TODO: add description for }
     */
    @body _: Operation;
  } | NotFound | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update a STAC item in a collection")
  @put
  @pollingOperation(Operations.get)
  op update(
    ...CollectionParameters,

    /**
     * TODO: add description for itemId
     */
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,

    /**
     * TODO: add description for item
     */
    @doc("STAC Item")
    @body
    item: StacPostOrPutItem,
  ): {
    /**
     * TODO: add description for Location
     */
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: "202";

    /**
     * TODO: add description for }
     */
    @body _: Operation;
  } | NotFound | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update a STAC item in a collection")
  @patch
  @pollingOperation(Operations.get)
  op patch(
    ...CollectionParameters,

    /**
     * TODO: add description for itemId
     */
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,

    /**
     * TODO: add description for item
     */
    @doc("STAC Item")
    @body
    item: StacPostOrPutItem,
  ): {
    /**
     * TODO: add description for Location
     */
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: "202";

    /**
     * TODO: add description for }
     */
    @body _: Operation;
  } | NotFound | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete a STAC item from a collection")
  @delete
  @pollingOperation(Operations.get)
  op delete(
    ...CollectionParameters,

    /**
     * TODO: add description for itemId
     */
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,
  ): {
    /**
     * TODO: add description for Location
     */
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: "202";

    /**
     * TODO: add description for }
     */
    @body _: Operation;
  } | NotFound | BadRequest;

  /**
   * TODO: add description for STACItem
   */
  model StacItem {
    /**
     * TODO: add description for type
     */
    type: string;

    /**
     * TODO: add description for stacVersion
     */
    stacVersion: string;

    /**
     * TODO: add description for stacExtensions
     */
    stacExtensions: string[];

    /**
     * TODO: add description for id
     */
    id: string;

    /**
     * TODO: add description for geometry
     */
    geometry: string;

    /**
     * TODO: add description for bbox
     */
    bbox: int32[];

    /**
     * TODO: add description for properties
     */
    properties: Properties;

    /**
     * TODO: add description for assets
     */
    assets: string;

    /**
     * TODO: add description for links
     */
    links: Link[];

    /**
     * TODO: add description for collection
     */
    collection: string;
  }

  /**
   * TODO: add description for STACPostOrPutItem
   */
  model StacPostOrPutItem {
    /**
     * TODO: add description for type
     */
    type: string;

    /**
     * TODO: add description for stacVersion
     */
    stacVersion: string;

    /**
     * TODO: add description for stacExtensions
     */
    stacExtensions: string[];

    /**
     * TODO: add description for id
     */
    id: string;

    /**
     * TODO: add description for geometry
     */
    geometry: string;

    /**
     * TODO: add description for bbox
     */
    bbox: int32[];

    /**
     * TODO: add description for properties
     */
    properties: Properties;

    /**
     * TODO: add description for assets
     */
    assets: string;

    /**
     * TODO: add description for links
     */
    links: Link[];

    /**
     * TODO: add description for collection
     */
    collection: string;
  }

  /**
   * TODO: add description for STACItemCollection
   */
  model StacItemCollection {
    /**
     * TODO: add description for type
     */
    type: string;

    /**
     * TODO: add description for features
     */
    features: StacItem[];

    /**
     * TODO: add description for links
     */
    links: Link[];

    /**
     * TODO: add description for stacVersion
     */
    stacVersion?: string;

    /**
     * TODO: add description for numberMatched
     */
    numberMatched?: int64;

    /**
     * TODO: add description for numberReturned
     */
    numberReturned?: int64;
  }

  /**
   * TODO: add description for STACPostOrPutItemCollection
   */
  model StacPostOrPutItemCollection {
    /**
     * TODO: add description for type
     */
    type: string;

    /**
     * TODO: add description for features
     */
    features: StacItem[];

    /**
     * TODO: add description for links
     */
    links?: Link[];

    /**
     * TODO: add description for stacVersion
     */
    stacVersion?: string;

    /**
     * TODO: add description for numberMatched
     */
    numberMatched?: int64;

    /**
     * TODO: add description for numberReturned
     */
    numberReturned?: int64;
  }

  /**
   * TODO: add description for Properties
   */
  model Properties {
    /**
     * TODO: add description for datetime
     */
    datetime: string;
  }

  /**
   * TODO: add description for Link
   */
  model Link {
    /**
     * TODO: add description for rel
     */
    rel: string;

    /**
     * TODO: add description for href
     */
    href: string;

    /**
     * TODO: add description for type
     */
    type: string;

    /**
     * TODO: add description for title
     */
    title: string;
  }
}

@route("/api/ingestion-sources")
@tag("Ingestion Sources")
namespace IngestionSources {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get ingestion sources in a geo-catalog")
  op getAll(
    ...Azure.Core.Foundations.ApiVersionParameter,
    ...OdataQuery,
  ): IngestionSourceSummary[];

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get an ingestion source in a geo-catalog")
  op get(
    ...IngestionSourceParameters,
    ...Azure.Core.Foundations.ApiVersionParameter,
  ): IngestionSourceSummary | NotFound;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new ingestion source in a geo-catalog")
  op create(
    ...Azure.Core.Foundations.ApiVersionParameter,

    /**
     * TODO: add description for ingestionSource
     */
    @doc("Definition of the ingestion source")
    @body
    ingestionSource: IngestionSource,
  ): {
    /**
     * TODO: add description for Location
     */
    @doc("Url of the created ingestion source")
    @header
    location: url;

    @statusCode statusCode: "201";

    /**
     * TODO: add description for }
     */
    @body _: IngestionSourceSummary;
  } | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update an existing ingestion source in a geo-catalog")
  @put
  op createOrReplace(
    ...Azure.Core.Foundations.ApiVersionParameter,

    /**
     * TODO: add description for id
     */
    @doc("Ingestion source id")
    @path
    @maxLength(500)
    @pattern(".*")
    id: string,

    /**
     * TODO: add description for ingestionSource
     */
    @doc("Definition of the ingestion source")
    @body
    ingestionSource: IngestionSource,
  ): {
    /**
     * TODO: add description for Location
     */
    @doc("Url of the created ingestion source")
    @header
    location: url;

    @statusCode statusCode: "200";

    /**
     * TODO: add description for }
     */
    @body _: IngestionSourceSummary;
  } | BadRequest;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete an ingestion source from a geo-catalog")
  @delete
  op delete(
    ...Azure.Core.Foundations.ApiVersionParameter,

    /**
     * TODO: add description for id
     */
    @path
    @maxLength(500)
    @pattern(".*")
    id: string,
  ): {
    @statusCode statusCode: "200";
  } | NotFound;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @route("managed-identities")
  @doc("Get all managed identities with access to storage accounts configured for a geo-catalog")
  op getManagedIdentities(
    ...Azure.Core.Foundations.ApiVersionParameter,
  ): ManagedIdentityMetadata[];

  /**
   * TODO: add description for IngestionSourceSummary
   */
  model IngestionSourceSummary {
    /**
     * TODO: add description for id
     */
    @doc("Ingestion source id")
    id: Guid;

    /**
     * TODO: add description for sourceType
     */
    @doc("Ingestion source type")
    sourceType: IngestionSourceType;

    /**
     * TODO: add description for created
     */
    @doc("Created time in UTC format")
    created: utcDateTime;

    /**
     * TODO: add description for connectionInfo
     */
    @doc("Managed identity connection information")
    connectionInfo?: ConnectionInfo;
  }

  /**
   * TODO: add description for ConnectionInfo
   */
  model ConnectionInfo {
    /**
     * TODO: add description for containerUrl
     */
    @doc("Azure Blob Storage container URL")
    containerUrl: url;

    /**
     * TODO: add description for objectId
     */
    @doc("Azure Managed Identity configured in the Geo-Catalog with access to the container")
    objectId?: Guid;

    /**
     * TODO: add description for expiration
     */
    @doc("Azure Blob Storage SAS token expiration in UTC format")
    expiration?: utcDateTime;
  }

  /**
   * TODO: add description for IngestionSource
   */
  model IngestionSource {
    /**
     * TODO: add description for sourceType
     */
    @doc("Ingestion source type")
    sourceType?: IngestionSourceType;

    /**
     * TODO: add description for connectionInfo
     */
    @doc("SAS token connection information")
    connectionInfo?: SasTokenConnectionCreation;

    /**
     * TODO: add description for id
     */
    @doc("Ingestion source id")
    id?: Guid;

    /**
     * TODO: add description for created
     */
    @doc("Created time in UTC format")
    created?: utcDateTime;
  }

  /**
   * TODO: add description for IngestionSourceType
   */
  union IngestionSourceType {
    string,

    @doc("Azure Blob Storage SAS token")
    SasToken: "SasToken",
  }

  /**
   * TODO: add description for SasTokenIngestionSourceCreation
   */
  model SasTokenIngestionSourceCreation {
    /**
     * TODO: add description for sourceType
     */
    @doc("Ingestion source type")
    sourceType: IngestionSourceType;

    /**
     * TODO: add description for connectionInfo
     */
    @doc("SAS token connection information")
    connectionInfo: SasTokenConnectionCreation;
  }

  /**
   * TODO: add description for SasTokenConnection
   */
  model SasTokenConnection {
    /**
     * TODO: add description for containerUrl
     */
    @doc("Azure Blob Storage container URL")
    containerUrl: url;

    /**
     * TODO: add description for expiration
     */
    @doc("Azure Blob Storage SAS token expiration in UTC format")
    expiration: utcDateTime;
  }

  /**
   * TODO: add description for SasTokenConnectionCreation
   */
  model SasTokenConnectionCreation {
    /**
     * TODO: add description for containerUrl
     */
    @doc("Azure Blob Storage container URL")
    containerUrl: url;

    /**
     * TODO: add description for sasToken
     */
    @doc("Azure Blob Storage SAS token SAS token")
    sasToken: string;
  }

  /**
   * TODO: add description for ManagedIdentityConnection
   */
  model ManagedIdentityConnection {
    @doc("Azure Blob Storage container URL")
    containerUrl: url;

    @doc("Azure Managed Identity configured in the Geo-Catalog with access to the container")
    objectId: Guid;
  }

  /**
   * TODO: add description for ManagedIdentityMetadata
   */
  model ManagedIdentityMetadata {
    @doc("Object id of the managed identity")
    objectId: Guid;

    @doc("ARM path or resource id of the managed identity")
    recourceId: string;
  }

  /**
   * TODO: add description for IngestionSourceParameters
   */
  model IngestionSourceParameters {
    /**
     * TODO: add description for id
     */
    @doc("Ingestion source id")
    @path
    @maxLength(500)
    @pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
    id: string;
  }
}

@route("/api/collections/{collectionId}/operations")
@tag("Ingestion Management")
namespace Operations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get operations of a geo-catalog collection")
  op getAll(
    ...CollectionParameters,
    ...OdataQuery,

    @doc("Number of items to return")
    @query
    $top?: int64,

    @doc("Number of items to skip")
    @query
    $skip?: int64,
  ): Operation[];

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get an operation of a geo-catalog collection")
  op get(
    ...CollectionParameters,

    /**
     * TODO: add description for operationId
     */
    @doc("Operation id")
    @path
    @maxLength(500)
    @pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
    operationId: string,
  ): Operation;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Cancel a running operation of a geo-catalog collection")
  @delete
  op delete(
    ...CollectionParameters,

    /**
     * TODO: add description for operationId
     */
    @doc("Operation id")
    @path
    @maxLength(500)
    @pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
    operationId: string,
  ): {
    @statusCode statusCode: "200";
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Cancel all running operations of a geo-catalog collection")
  @delete
  op deleteAll(...CollectionParameters): {
    @statusCode statusCode: "200";
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get operation logs")
  @route("{operationId}/logs")
  op getLogs(
    ...CollectionParameters,

    /**
     * TODO: add description for operationId
     */
    @doc("Operation id")
    @path
    @maxLength(500)
    @pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
    operationId: string,
  ): bytes | NotFound;
}

/**
 * TODO: add description for OperationSummary
 */
@doc("Spatio geo-catalog operation summary")
model OperationSummary {
  /**
   * TODO: add description for id
   */
  @doc("Operation id")
  operationId: Guid;

  /**
   * TODO: add description for status
   */
  @doc("Operation status")
  status: OperationStatus;
}

/**
 * TODO: add description for Operation
 */
@doc("Spatio geo-catalog operation")
model Operation is OperationSummary {
  /**
   * TODO: add description for creationTime
   */
  @doc("The UTC time at which the operation was created")
  creationTime: utcDateTime;

  /**
   * TODO: add description for statusHistory
   */
  @doc("The history of the operation status in time")
  statusHistory: OperationStatusHistoryItem[];

  /**
   * TODO: add description for startTime
   */
  @doc("The UTC time at which the operation was started")
  startTime?: utcDateTime;

  /**
   * TODO: add description for finishTime
   */
  @doc("The UTC time at which the operation finished its execution")
  finishTime?: utcDateTime;

  /**
   * TODO: add description for totalItems
   */
  @doc("The number of total items to be processed")
  totalItems: int64;

  /**
   * TODO: add description for totalPendingItems
   */
  @doc("The number of items pending to be processed")
  totalPendingItems: int64;

  /**
   * TODO: add description for totalSuccessfullItems
   */
  @doc("The number of items successfully processed")
  totalSuccessfulItems: int64;

  /**
   * TODO: add description for totalFailedItems
   */
  @doc("The number of items that have failed to be processed")
  totalFailedItems: int64;
}

/**
 * TODO: add description for OperationStatus
 */
@lroStatus
union OperationStatus {
  string,

  @doc("Operation accepted and ready to be run")
  Pending: "Pending",

  @doc("Operation is running")
  Running: "Running",

  @doc("Operation has already finished its execution")
  Finished: "Finished",

  @doc("Operation canceled by the user")
  Canceled: "Canceled",

  @doc("Operation is being canceling")
  Canceling: "Canceling",

  @doc("Operation succeeded")
  Succeeded: "Succeeded",

  @doc("Operation failed")
  Failed: "Failed",
}

/**
 * TODO: add description for OperationStatusHistoryItem
 */
model OperationStatusHistoryItem {
  /**
   * TODO: add description for time
   */
  @doc("The UTC time at which the status was set")
  timestamp: utcDateTime;

  /**
   * TODO: add description for status
   */
  @doc("The status of the operation")
  status: OperationStatus;

  @doc("If the status is failed, the error code")
  errorCode?: string;

  /**
   * TODO: add description for errorMessage
   */
  @doc("If the status is failed, the error message")
  errorMessage?: string;
}

/**
 * TODO: add description for CollectionParameters
 */
model CollectionParameters is Azure.Core.Foundations.ApiVersionParameter {
  /**
   * TODO: add description for collectionId
   */
  @doc("Catalog collection id")
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;
}

@pattern("^[a-zA-Za0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
scalar Guid extends string;

@pattern("^[a-zA-Z0-9-]{3,64}$")
scalar shortString extends string;

@pattern("^[a-zA-Z0-9-]{3,256}$")
scalar longString extends string;

/**
 * TODO: add description for OdataQuery
 */
model OdataQuery {
  @doc("The number of items to return")
  @query("$top")
  top?: int64;

  @doc("The number of items to skip")
  @query("$skip")
  skip?: int64;
}

/**
 * TODO: add description for NotFound
 */
@error
model NotFound {
  /**
   * TODO: add description for _
   */
  @statusCode _: 404;

  /**
   * TODO: add description for type
   */
  type: "https://tools.ietf.org/html/rfc9110#section-15.5.5";

  /**
   * TODO: add description for title
   */
  title: "Not Found";

  /**
   * TODO: add description for status
   */
  status: int64;

  /**
   * TODO: add description for detail
   */
  traceId: string;
}

/**
 * TODO: add description for BadRequest
 */
@doc("Validation error")
@error
model BadRequest {
  /**
   * TODO: add description for _
   */
  @statusCode _: 400;

  /**
   * TODO: add description for type
   */
  title: string;

  /**
   * TODO: add description for detail
   */
  detail?: string;

  /**
   * TODO: add description for status
   */
  status: int64;

  /**
   * TODO: add description for errors
   */
  errors: Record<string[]>;
}
