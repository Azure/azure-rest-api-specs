import "@typespec/rest";
import "@typespec/openapi";
import "./models.stac.spec.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;
@service(#{ title: "MPCPro Ingestion and Management API" })
namespace Microsoft.PlanetaryComputer;

@doc("Generic paged response model")
@friendlyName("{name}PagedResponse", T)
model Page<T> {
  @doc("The items on the page")
  @pageItems
  value: T[];

  @doc("Link to the next page of results")
  @nextLink
  nextLink?: url;
}

@tag("Ingestion Management")
interface Ingestions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The operation is returning an array."
  @doc("Get ingestions of a catalog")
  @route("/inma/collections/{collectionId}/ingestions")
  @get
  @list
  list(
    ...CollectionParameters,
    ...OdataQuery,
  ): Page<IngestionDefinition> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get the definition of an ingestion")
  @route("/inma/collections/{collectionId}/ingestions/{ingestionId}")
  @get
  get(...IngestionParameters): IngestionDefinition | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new ingestion")
  @route("/inma/collections/{collectionId}/ingestions")
  @post
  create(
    ...CollectionParameters,

    @doc("Definition of the ingestion")
    @body
    body: IngestionDefinition,
  ): {
    @doc("Url of the created ingestion")
    @header
    location: url;

    @statusCode statusCode: 201;

    @doc("Ingestion definition")
    @body
    _: IngestionDefinition;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update an existing ingestion")
  @route("/inma/collections/{collectionId}/ingestions/{ingestionId}")
  @patch(#{ implicitOptionality: true })
  update(
    @doc("Content type for PATCH request")
    @header
    contentType: "application/merge-patch+json",

    ...IngestionParameters,

    @doc("Ingestion properties to update")
    @body
    body: IngestionDefinition,
  ): {
    @statusCode statusCode: 200;

    @body
    _: IngestionDefinition;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete an ingestion from a catalog. All runs of the ingestion will be deleted. Ingestion must not have any runs in progress or queued.")
  @route("/inma/collections/{collectionId}/ingestions/{ingestionId}")
  @delete
  @pollingOperation(IngestionOperations.get)
  delete(...IngestionParameters): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @doc("Status code")
    @statusCode
    statusCode: 202;

    @body
    _: Operation;
  } | ErrorResponse;
}

@doc("Microsoft Planetary Computer Pro geo-catalog ingestion creation model")
@parentResource(StacCollection)
@resource("ingestions")
model IngestionDefinition {
  @doc("Ingestion id")
  @visibility(Lifecycle.Read)
  @key("ingestionId")
  id: uuid;

  @doc("Ingestion type")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  importType: IngestionType;

  @doc("Ingestion name")
  displayName?: string;

  @doc("Source catalog URL. Required for StaticCatalog ingestion type")
  sourceCatalogUrl?: url;

  @doc("Skip processing existing items in the catalog")
  skipExistingItems?: boolean;

  @doc("Keep original source assets")
  keepOriginalAssets?: boolean;

  @doc("Ingestion creation time")
  @visibility(Lifecycle.Read)
  creationTime: utcDateTime;

  @doc("Ingestion status")
  @visibility(Lifecycle.Read)
  status: IngestionStatus;
}

@doc("Ingestion type")
union IngestionType {
  string,

  @doc("Static STAC Catalog")
  StaticCatalog: "StaticCatalog",
}

@doc("Ingestion status")
union IngestionStatus {
  string,

  @doc("Ingestion accepted and ready to be run")
  Ready: "Ready",

  @doc("Ingestion is being deleting in the background")
  Deleting: "Deleting",
}

@doc("Ingestion parameters")
model IngestionParameters is CollectionParameters {
  @doc("Ingestion id")
  @path
  ingestionId: uuid;
}

@tag("Ingestion Management")
interface IngestionRuns {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The operation is returning an array."
  @doc("Get the runs of an ingestion")
  @route("/inma/collections/{collectionId}/ingestions/{ingestionId}/runs")
  @get
  @list
  list(
    ...IngestionParameters,
    ...OdataQuery,
  ): Page<IngestionRun> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get a run of an ingestion")
  @route("/inma/collections/{collectionId}/ingestions/{ingestionId}/runs/{runId}")
  @get
  get(...IngestionRunParameters): IngestionRun | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new run of an ingestion")
  @route("/inma/collections/{collectionId}/ingestions/{ingestionId}/runs")
  @post
  create(...IngestionParameters): {
    @doc("Url of the created ingestion run")
    @header
    location: url;

    @statusCode statusCode: 201;

    @doc("Ingestion run")
    @body
    _: IngestionRun;
  } | ErrorResponse;
}

@doc("Microsoft Planetary Computer Pro geo-catalog ingestion run")
@resource("runs")
@parentResource(IngestionDefinition)
model IngestionRun {
  @doc("Run id")
  @key("runId")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  id: uuid;

  @doc("Run id which this run is associated to because it has been retried or rerun")
  parentRunId?: uuid;

  @doc("Operation")
  operation: IngestionRunOperation;

  @doc("Creation time")
  creationTime: utcDateTime;

  @doc("URL of the source catalog")
  sourceCatalogUrl?: url;

  @doc("Skip any item that already exist in the GeoCatalog")
  skipExistingItems?: boolean;

  @doc("Keep original source assets")
  keepOriginalAssets?: boolean;
}

@doc("Microsoft Planetary Computer Pro geo-catalog ingestion run operation")
model IngestionRunOperation {
  @doc("Operation id")
  id: uuid;

  @doc("Operation status")
  status: OperationStatus;

  @doc("The UTC time at which the operation was created")
  creationTime: utcDateTime;

  @doc("The history of the operation status in time")
  statusHistory: OperationStatusHistoryItem[];

  @doc("The UTC time at which the operation was started")
  startTime?: utcDateTime;

  @doc("The UTC time at which the operation finished its execution")
  finishTime?: utcDateTime;

  @doc("The number of total items to be processed")
  totalItems: int32;

  @doc("The number of items pending to be processed")
  totalPendingItems: int32;

  @doc("The number of items successfully processed")
  totalSuccessfulItems: int32;

  @doc("The number of items that have failed to be processed")
  totalFailedItems: int32;
}

@doc("Ingestion run parameters")
model IngestionRunParameters is IngestionParameters {
  @doc("Run id")
  @path
  runId: uuid;
}

@tag("SpatioTemporal Asset Catalog (STAC) API")
interface StacItems {
  /**
   * Fetch features of the feature collection with id `collectionId`.
   *
   * Every feature in a dataset belongs to a collection. A dataset may
   * consist of multiple feature collections. A feature collection is often a
   * collection of features of a similar type, based on a common schema.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @route("/stac/collections/{collectionId}/items")
  @get
  getFeatures(
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
    limit?: int32,

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
    @query("bbox")
    @query(#{ explode: true })
    boundingBox?: string[],

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
  ): StacItemCollection | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Fetch a single STAC Item")
  @route("/stac/collections/{collectionId}/items/{itemId}")
  @get
  get(
    ...CollectionParameters,

    @doc("STAC Item id")
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,
  ): StacItem | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new STAC item or a set of items in a collection")
  @route("/stac/collections/{collectionId}/items")
  @post
  @pollingOperation(IngestionOperations.get)
  create(
    ...CollectionParameters,

    /**
     * STAC Item or StacItemCollection
     *
     * Represents a STAC Item or StacItemCollection as defined by the STAC 1.0.0 standard.
     *
     * **Item**: A GeoJSON Feature that represents a single spatiotemporal asset.
     * It includes metadata such as geometry, datetime, and links to related assets.
     * Example: A satellite image with its metadata.
     *
     * **StacItemCollection**: A GeoJSON FeatureCollection that contains multiple Items.
     * It is used to group multiple related Items together, such as a collection of satellite images.
     *
     * This union allows the request body to accept either a single Item or a collection of Items.
     */
    #suppress "@azure-tools/typespec-autorest/union-unsupported" ""
    #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Backcompatibility with existing clients"
    @body
    body: StacItemOrStacItemCollection,
  ): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: 202;

    @doc("Operation")
    @body
    _: Operation;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create or replace a STAC item in a collection")
  @route("/stac/collections/{collectionId}/items/{itemId}")
  @put
  @pollingOperation(IngestionOperations.get)
  createOrReplace(
    ...CollectionParameters,

    @doc("STAC Item id")
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,

    @doc("STAC Item")
    @body
    body: StacItem,
  ): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: 202;

    @doc("Operation")
    @body
    _: Operation;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update a STAC item in a collection")
  @route("/stac/collections/{collectionId}/items/{itemId}")
  @patch(#{ implicitOptionality: true })
  @pollingOperation(IngestionOperations.get)
  update(
    @header
    @doc("Content type for PATCH request")
    contentType: "application/merge-patch+json",

    ...CollectionParameters,

    @doc("STAC Item id")
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,

    @doc("STAC Item")
    @body
    body: StacItem,
  ): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: 202;

    @doc("Operation")
    @body
    _: Operation;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete a STAC item from a collection")
  @route("/stac/collections/{collectionId}/items/{itemId}")
  @delete
  @pollingOperation(IngestionOperations.get)
  delete(
    ...CollectionParameters,

    @doc("STAC Item id")
    @path
    @maxLength(500)
    @pattern(".*")
    itemId: string,
  ): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: 202;

    @doc("Operation")
    @body
    _: Operation;
  } | ErrorResponse;
}

@tag("Ingestion Sources")
interface IngestionSources {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The operation is returning an array."
  @doc("Get ingestion sources in a geo-catalog")
  @route("/inma/ingestion-sources")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...OdataQuery,
  ): Page<IngestionSourceSummary> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get an ingestion source in a geo-catalog")
  @route("/inma/ingestion-sources/{id}")
  @get
  get(
    ...IngestionSourceParameters,
    ...ApiVersionParameter,
  ): IngestionSource | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Create a new ingestion source in a geo-catalog")
  @route("/inma/ingestion-sources")
  @post
  create(
    ...ApiVersionParameter,

    @doc("Definition of the ingestion source")
    @body
    body: IngestionSource,
  ): {
    @doc("Url of the created ingestion source")
    @header
    location: url;

    @statusCode statusCode: 201;

    @doc("Ingestion source summary")
    @body
    _: IngestionSource;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Update an existing ingestion source in a geo-catalog")
  @route("/inma/ingestion-sources/{id}")
  @put
  replace(
    ...ApiVersionParameter,

    @doc("Ingestion source id")
    @path
    id: uuid,

    @doc("Definition of the ingestion source")
    @body
    body: IngestionSource,
  ): {
    @doc("Url of the created ingestion source")
    @header
    location: url;

    @statusCode statusCode: 200;

    @doc("Ingestion source summary")
    @body
    _: IngestionSource;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete an ingestion source from a geo-catalog")
  @route("/inma/ingestion-sources/{id}")
  @delete
  delete(
    ...ApiVersionParameter,

    @doc("Ingestion source id")
    @path
    id: uuid,
  ): {
    @statusCode statusCode: 204;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The operation is returning an array."
  @doc("Get all managed identities with access to storage accounts configured for a geo-catalog")
  @route("/inma/ingestion-sources/managed-identities")
  @get
  @list
  listManagedIdentities(
    ...ApiVersionParameter,
  ): Page<ManagedIdentityMetadata> | ErrorResponse;
}

@doc("Ingestion source summary")
model IngestionSourceSummary {
  @doc("Ingestion source id")
  id: uuid;

  @doc("Ingestion source type")
  kind: IngestionSourceType;

  @doc("Created time in UTC format")
  created?: utcDateTime;
}

@doc("Ingestion Source")
@discriminator("kind")
model IngestionSource {
  @doc("Ingestion source id")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  id: uuid;

  @doc("Created time in UTC format")
  @visibility(Lifecycle.Read)
  created?: utcDateTime;

  @doc("Discriminator for the ingestion source")
  kind: IngestionSourceType;
}

@doc("Ingestion source type")
union IngestionSourceType {
  string,

  @doc("Azure Blob Storage SAS token")
  SharedAccessSignatureToken: "SasToken",

  @doc("Azure Blob Managed Identity")
  BlobManagedIdentity: "BlobManagedIdentity",
}

@doc("SAS Token ingestion source")
model SharedAccessSignatureTokenIngestionSource extends IngestionSource {
  kind: IngestionSourceType.SharedAccessSignatureToken;

  @doc("SAS token connection information")
  connectionInfo: SharedAccessSignatureTokenConnection;
}

@doc("SAS Token connection information")
model SharedAccessSignatureTokenConnection {
  @doc("Azure Blob Storage container URL")
  @encodedName("application/json", "containerUrl")
  containerUri: url;

  @doc("SAS token")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @encodedName("application/json", "sasToken")
  sharedAccessSignatureToken?: string;

  @doc("Azure Blob Storage SAS token expiration in UTC format")
  @visibility(Lifecycle.Read)
  expiration?: utcDateTime;
}

@doc("Managed Identity ingestion source")
model ManagedIdentityIngestionSource extends IngestionSource {
  kind: IngestionSourceType.BlobManagedIdentity;

  @doc("Managed identity connection information")
  connectionInfo: ManagedIdentityConnection;
}

@doc("Managed Identity connection information")
model ManagedIdentityConnection {
  @doc("Azure Blob Storage container URL")
  @encodedName("application/json", "containerUrl")
  containerUri: url;

  @doc("Azure Managed Identity configured in the Geo-Catalog with access to the container")
  objectId: uuid;
}

@doc("Managed Identity metadata")
model ManagedIdentityMetadata {
  @doc("Object id of the managed identity")
  objectId: uuid;

  @doc("ARM path or resource id of the managed identity")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("Ingestion source parameters")
model IngestionSourceParameters {
  @doc("Ingestion source id")
  @path
  id: uuid;
}

@tag("Ingestion Management")
interface IngestionOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The operation is returning an array."
  @doc("Get operations of a geo-catalog collection")
  @route("/inma/operations")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...OdataQuery,

    @doc("Operation id used to filter the results")
    @query("collectionId")
    collectionId?: string,

    @doc("Operation status used to filter the results")
    @query("status")
    status?: OperationStatus,
  ): Page<Operation> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get an operation of a geo-catalog collection")
  @route("/inma/operations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    @doc("Operation id")
    @path
    @maxLength(500)
    operationId: uuid,
  ): Operation | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Cancel a running operation of a geo-catalog collection")
  @route("/inma/operations/{operationId}")
  @delete
  delete(
    ...ApiVersionParameter,

    @doc("Operation id")
    @path
    @maxLength(500)
    operationId: uuid,
  ): {
    @statusCode statusCode: 204;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Cancel all running operations of a geo-catalog collection")
  @route("/inma/operations")
  @delete
  deleteAll(...ApiVersionParameter): {
    @statusCode statusCode: 204;
  } | ErrorResponse;
}

@doc("Error information wrapper")
model ErrorInfo {
  @doc("Error details")
  error: Error;
}

@doc("Microsoft Planetary Computer Pro geo-catalog operation")
model Operation {
  @doc("Operation id")
  id: uuid;

  @doc("Operation status")
  status: OperationStatus;

  @doc("Operation type")
  type: string;

  @doc("The UTC time at which the operation was created")
  creationTime: utcDateTime;

  @doc("Collection ID")
  collectionId?: string;

  @doc("The history of the operation status in time")
  statusHistory: OperationStatusHistoryItem[];

  @doc("The UTC time at which the operation was started")
  startTime?: utcDateTime;

  @doc("The UTC time at which the operation finished its execution")
  finishTime?: utcDateTime;

  @doc("Additional information elements about the particular operation type")
  additionalInformation?: Record<string>;

  @doc("Error information")
  error?: ErrorInfo;
}

@doc("Operation status")
@lroStatus
union OperationStatus {
  string,

  @doc("Operation accepted and ready to be run")
  Pending: "Pending",

  @doc("Operation is running")
  Running: "Running",

  @doc("Operation has already finished its execution")
  Succeeded: "Succeeded",

  @doc("Operation canceled by the user")
  Canceled: "Canceled",

  @doc("Operation is being canceling")
  Canceling: "Canceling",

  @doc("Operation failed")
  Failed: "Failed",
}

@doc("Operation status history item")
model OperationStatusHistoryItem {
  @doc("The UTC time at which the status was set")
  timestamp: utcDateTime;

  @doc("The status of the operation")
  status: OperationStatus;

  @doc("If the status is failed, the error code")
  errorCode?: string;

  @doc("If the status is failed, the error message")
  errorMessage?: string;
}

@doc("Collection parameters")
model CollectionParameters is ApiVersionParameter {
  /**
   * Catalog collection id
   */
  @doc("Catalog collection id")
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;
}

@doc("Odata query parameters")
model OdataQuery {
  @doc("The number of items to return")
  @query("$top")
  top?: int32;

  @doc("The number of items to skip")
  @query("$skip")
  skip?: int32;
}

interface StacCollections {
  /**
   * List all collections in the GeoCatalog instance
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collections")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * Whether to sign asset URLs in the response.
       */
      @query("sign")
      sign?: StacAssetUrlSigningMode;

      /**
       * URL signature duration in minutes.
       */
      @query("duration")
      durationInMinutes?: int32;
    },
    StacCatalogCollections
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "STAC specification"
  @doc("Create a new collection in the GeoCatalog instance")
  @summary("Create Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections")
  @post
  @pollingOperation(IngestionOperations.get)
  create(
    ...ApiVersionParameter,

    @doc("Request collection body")
    @body
    body: StacCollection,
  ): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: 202;

    @doc("Operation")
    @body
    _: Operation;
  } | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Get a collection in the GeoCatalog instance")
  @summary("Get Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections/{collectionId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Catalog collection id
       */
      @doc("Catalog collection id")
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Whether to sign asset URLs in the response.
       */
      @query("sign")
      sign?: StacAssetUrlSigningMode;

      /**
       * URL signature duration in minutes.
       */
      @query("duration")
      durationInMinutes?: int32;
    },
    StacCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "STAC specification"
  @doc("Create or replace a collection in the GeoCatalog instance")
  @summary("Create or update Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections")
  @put
  createOrReplace(
    ...CollectionParameters,

    @doc("Request collection body")
    @body
    body: StacCollection,
  ): StacCollection;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @doc("Delete a collection in the GeoCatalog instance")
  @summary("Delete Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections")
  @delete
  @pollingOperation(IngestionOperations.get)
  delete(...CollectionParameters): {
    @pollingLocation
    @doc("Url used to monitor the background operation")
    @header
    location: url;

    @doc("Url used to monitor the background operation")
    @header("operation-location")
    operationLocation: url;

    @statusCode statusCode: 202;

    @doc("Operation")
    @body
    _: Operation;
  } | ErrorResponse;
}
