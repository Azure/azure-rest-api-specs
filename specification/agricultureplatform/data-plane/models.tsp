import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.AgriculturePlatform;

/**
 * Type of relationship.
 */
union RelationshipType {
  string,
  DerivedFrom: "DerivedFrom",
  Child: "Child",
  Parent: "Parent",
}

/**
 * DestinationType.
 */
union DestinationType {
  string,
  Catalog: "Catalog",
  Collection: "Collection",
  Item: "Item",
  Asset: "Asset",
}

/**
 * Type of dataset.
 */
union DataFormat {
  string,
  Image: "Image",
  Shapefile: "Shapefile",
  Binary: "Binary",
}

/**
 * GeoJSON object type.
 */
union GeoJsonObjectType {
  string,
  Point: "Point",
  Polygon: "Polygon",
  MultiPolygon: "MultiPolygon",
}

/**
 * Enum for different types of AuthCredentials supported.
 */
union AuthCredentialsKind {
  string,
  OAuthClientCredentials: "OAuthClientCredentials",
  ApiKeyAuthCredentials: "ApiKeyAuthCredentials",
}

/**
 * Supported image formats for scene resource.
 */
union ImageFormat {
  string,
  TIF: "TIF",
}

model CatalogListResponse {
  value: Catalog[];
  skipToken?: string;
  nextLink?: string;
}

/**
 * Catalog.
 */
@resource("catalogs")
model Catalog {
  /**
   * Links for referencing other objects.
   */
  links?: Link[];

  /**
   * Id of the Catalog.
   */
  @visibility("read")
  @key("catalogId")
  id: string;

  /**
   * The ETag value to implement optimistic concurrency.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Status of the resource.
   */
  @maxLength(100)
  status?: string;

  /**
   * Date-time when resource was created, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Date-time when resource was last modified, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDateTime?: utcDateTime;

  /**
   * Source of the resource.
   */
  @maxLength(100)
  @minLength(2)
  source?: string;

  /**
   * Name to identify resource.
   */
  @maxLength(100)
  name?: string;

  /**
   * Textual description of the resource.
   */
  @maxLength(500)
  description?: string;

  /**
   * Created by user/tenant id.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Modified by user/tenant id.
   */
  @visibility("read")
  modifiedBy?: string;

  /**
   * A collection of key value pairs that belongs to the resource.
   * Each pair must not have a key greater than 50 characters
   * and must not have a value greater than 150 characters.
   * Note: A maximum of 25 key value pairs can be provided for a resource and only
   * string,
   * numeral and datetime (yyyy-MM-ddTHH:mm:ssZ) values are supported.
   */
  properties?: Record<unknown>;
}

/**
 * Link.
 */
model Link {
  /**
   * Type of relationship.
   */
  rel?: RelationshipType;

  /**
   * Href.
   */
  href?: string;

  /**
   * DestinationType.
   */
  type?: DestinationType;
}

/**
 * An error response from the Azure AgPlatform service. See
 * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses
 * for ErrorResponse reference document.
 */
@error
model ErrorResponse {
  /**
   * An error from the Azure AgPlatform service.
   */
  error?: Error;

  /**
   * Unique trace Id.
   */
  traceId?: string;
}

/**
 * An error from the Azure AgPlatform service.
 */
model Error {
  /**
   * Server-defined set of error codes.
   */
  @minLength(1)
  code: string;

  /**
   * Human-readable representation of the error.
   */
  @minLength(1)
  message: string;

  /**
   * Target of the error.
   */
  target?: string;

  /**
   * Array of details about specific errors that led to this reported error.
   */
  details?: Error[];

  /**
   * Inner error containing list of errors.See
   * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#innererror--object
   * for InnerError reference document.
   */
  innererror?: InnerError;
}

/**
 * Inner error containing list of errors.See
 * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#innererror--object
 * for InnerError reference document.
 */
model InnerError {
  /**
   * Specific error code than was provided by the containing error.
   */
  code?: string;

  /**
   * Inner error containing list of errors.See
   * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#innererror--object
   * for InnerError reference document.
   */
  innererror?: InnerError;
}

model CollectionListResponse {
  value: Collection[];
  skipToken?: string;
  nextLink?: string;
}

/**
 * Collection.
 */
@resource("collections")
@parentResource(Catalog)
model Collection {
  /**
   * Schema Foreign Key.
   */
  @minLength(1)
  schemaId: string;

  /**
   * Id of the Collection.
   */
  @key("collectionId")
  @visibility("read")
  collectionId: string;

  /**
   * Links for referencing other objects.
   */
  links?: Link[];

  /**
   * Unique resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The ETag value to implement optimistic concurrency.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Status of the resource.
   */
  @maxLength(100)
  status?: string;

  /**
   * Date-time when resource was created, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Date-time when resource was last modified, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDateTime?: utcDateTime;

  /**
   * Source of the resource.
   */
  @maxLength(100)
  @minLength(2)
  source?: string;

  /**
   * Name to identify resource.
   */
  @maxLength(100)
  name?: string;

  /**
   * Textual description of the resource.
   */
  @maxLength(500)
  description?: string;

  /**
   * Created by user/tenant id.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Modified by user/tenant id.
   */
  @visibility("read")
  modifiedBy?: string;

  /**
   * A collection of key value pairs that belongs to the resource.
   * Each pair must not have a key greater than 50 characters
   * and must not have a value greater than 150 characters.
   * Note: A maximum of 25 key value pairs can be provided for a resource and only
   * string,
   * numeral and datetime (yyyy-MM-ddTHH:mm:ssZ) values are supported.
   */
  properties?: Record<unknown>;
}

/**
 * Resource model for File API.
 */
@resource("file")
model FileResource {
  /**
   * Dummy key for file resource
   */
  @key("key")
  key: string;
}

/**
 * File.
 */
model File {
  /**
   * FilePath.
   */
  @minLength(1)
  filePath: string;
}

/**
 * Item.
 */
@parentResource(Collection)
@resource("items")
model Item {
  /**
   * Links.
   */
  links?: Link[];

  /**
   * Schema for records under the dataset.
   */
  data: Record<unknown>;

  /**
   * Owner Item Ids of the resource
   */
  ownerItemId?: string;

  /**
   * Id of the Catalog resource.
   */
  @visibility("read")
  catalogId?: string;

  /**
   * Id of the Collection resource.
   */
  @visibility("read")
  collectionId?: string;

  /**
   * Assets.
   */
  assets?: Asset[];

  /**
   * Id of the Item.
   */
  @key("itemId")
  @visibility("read")
  id: string;

  /**
   * The ETag value to implement optimistic concurrency.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Status of the resource.
   */
  @maxLength(100)
  status?: string;

  /**
   * Date-time when resource was created, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Date-time when resource was last modified, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDateTime?: utcDateTime;

  /**
   * Source of the resource.
   */
  @maxLength(100)
  @minLength(2)
  source?: string;

  /**
   * Name to identify resource.
   */
  @maxLength(100)
  name?: string;

  /**
   * Textual description of the resource.
   */
  @maxLength(500)
  description?: string;

  /**
   * Created by user/tenant id.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Modified by user/tenant id.
   */
  @visibility("read")
  modifiedBy?: string;

  /**
   * A collection of key value pairs that belongs to the resource.
   * Each pair must not have a key greater than 50 characters
   * and must not have a value greater than 150 characters.
   * Note: A maximum of 25 key value pairs can be provided for a resource and only
   * string,
   * numeral and datetime (yyyy-MM-ddTHH:mm:ssZ) values are supported.
   */
  properties?: Record<unknown>;
}

@parentResource(Catalog)
@resource("items")
model ItemsinCatalog is Item;
model ItemParameters {
  /**
   * Links.
   */
  links?: Link[];

  /**
   * Schema for records under the dataset.
   */
  data: Record<unknown>;

  /**
   * OwnerItemId.
   */
  ownerItemId?: string;

  /**
   * CatalogId.
   */
  // @visibility("read")
  // catalogId?: string;

  /**
   * CollectionId.
   */
  // @visibility("read")
  // collectionId?: string;

  /**
   * Assets.
   */
  assets?: Asset[];

  /**
   * Unique resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The ETag value to implement optimistic concurrency.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Status of the resource.
   */
  @maxLength(100)
  status?: string;

  /**
   * Date-time when resource was created, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Date-time when resource was last modified, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDateTime?: utcDateTime;

  /**
   * Source of the resource.
   */
  @maxLength(100)
  @minLength(2)
  source?: string;

  /**
   * Name to identify resource.
   */
  @maxLength(100)
  name?: string;

  /**
   * Textual description of the resource.
   */
  @maxLength(500)
  description?: string;

  /**
   * Created by user/tenant id.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Modified by user/tenant id.
   */
  @visibility("read")
  modifiedBy?: string;

  /**
   * A collection of key value pairs that belongs to the resource.
   * Each pair must not have a key greater than 50 characters
   * and must not have a value greater than 150 characters.
   * Note: A maximum of 25 key value pairs can be provided for a resource and only
   * string,
   * numeral and datetime (yyyy-MM-ddTHH:mm:ssZ) values are supported.
   */
  properties?: Record<unknown>;
}

model ItemResponse {
  /**
   * Links.
   */
  links?: Link[];

  /**
   * Schema for records under the dataset.
   */
  data: Record<unknown>;

  /**
   * OwnerItemId.
   */
  ownerItemId?: string;

  /**
   * CatalogId.
   */
  @visibility("read")
  catalogId?: string;

  /**
   * CollectionId.
   */
  @visibility("read")
  collectionId?: string;

  /**
   * Assets.
   */
  assets?: Asset[];

  /**
   * Unique resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The ETag value to implement optimistic concurrency.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Status of the resource.
   */
  @maxLength(100)
  status?: string;

  /**
   * Date-time when resource was created, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Date-time when resource was last modified, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDateTime?: utcDateTime;

  /**
   * Source of the resource.
   */
  @maxLength(100)
  @minLength(2)
  source?: string;

  /**
   * Name to identify resource.
   */
  @maxLength(100)
  name?: string;

  /**
   * Textual description of the resource.
   */
  @maxLength(500)
  description?: string;

  /**
   * Created by user/tenant id.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Modified by user/tenant id.
   */
  @visibility("read")
  modifiedBy?: string;

  /**
   * A collection of key value pairs that belongs to the resource.
   * Each pair must not have a key greater than 50 characters
   * and must not have a value greater than 150 characters.
   * Note: A maximum of 25 key value pairs can be provided for a resource and only
   * string,
   * numeral and datetime (yyyy-MM-ddTHH:mm:ssZ) values are supported.
   */
  properties?: Record<unknown>;
}

/**
 * Asset.
 */
model Asset {
  /**
   * Type of dataset.
   */
  type?: DataFormat;

  /**
   * Name.
   */
  name?: string;

  /**
   * Href.
   */
  href?: string;
}

/**
 * CatalogQuery.
 */
model ItemQuery {
  /**
   * Owner Item Ids of the resource.
   */
  ownerItemIds?: string[];

  /**
   * Filters on key-value pairs within the Data object.
   * e.g. "{testKey} eq {testValue}".
   */
  dataFilters?: string[];

  /**
   * GeoJSON (For more details: https://geojson.org/). Note: Coordinates are
   * expected in [Longitude, Latitude] format.
   */
  intersectsWithGeometry?: GeoJsonObject;

  /**
   * Ids of the resource.
   */
  ids?: string[];

  /**
   * Minimum creation date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minCreatedDateTime?: utcDateTime;

  /**
   * Maximum creation date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maxCreatedDateTime?: utcDateTime;

  /**
   * Minimum last modified date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minLastModifiedDateTime?: utcDateTime;

  /**
   * Maximum last modified date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maxLastModifiedDateTime?: utcDateTime;

  /**
   * Maximum number of items needed (inclusive).
   * Minimum = 10, Maximum = 1000, Default value = 50.
   */
  @maxValue(1000)
  @minValue(10)
  maxPageSize?: int32 = 50;

  /**
   * Skip token for getting next set of results.
   */
  skipToken?: string;
}

/**
 * GeoJSON (For more details: https://geojson.org/). Note: Coordinates are
 * expected in [Longitude, Latitude] format.
 */
@discriminator("type")
model GeoJsonObject {}

model ItemListResponse {
  value: Item[];
  skipToken?: string;
  nextLink?: string;
}

/**
 * CrossCatalogItemSearchQuery.
 */
model CrossCollectionItemSearchQuery {
  /**
   * Owner Item Ids of the resource.
   */
  collectionIds?: string[];

  /**
   * Owner Item Ids of the resource.
   */
  ownerItemIds?: string[];

  /**
   * Filters on key-value pairs within the Data object.
   * e.g. "{testKey} eq {testValue}".
   */
  dataFilters?: string[];

  /**
   * GeoJSON (For more details: https://geojson.org/). Note: Coordinates are
   * expected in [Longitude, Latitude] format.
   */
  intersectsWithGeometry?: GeoJsonObject;

  /**
   * Ids of the resource.
   */
  ids?: string[];

  /**
   * Minimum creation date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minCreatedDateTime?: utcDateTime;

  /**
   * Maximum creation date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maxCreatedDateTime?: utcDateTime;

  /**
   * Minimum last modified date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minLastModifiedDateTime?: utcDateTime;

  /**
   * Maximum last modified date of resource (inclusive).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maxLastModifiedDateTime?: utcDateTime;

  /**
   * Maximum number of items needed (inclusive).
   * Minimum = 10, Maximum = 1000, Default value = 50.
   */
  @maxValue(1000)
  @minValue(10)
  maxPageSize?: int32 = 50;

  /**
   * Skip token for getting next set of results.
   */
  skipToken?: string;
}

/**
 * Satellite Fetch Request.
 */
model SatelliteFetchRequest {
  /**
   * Start Date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * OAuthClientCredentials for clientId clientSecret auth.
   */
  credentials: OAuthClientCredentials;

  /**
   * End Date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Provider of satellite data. Available Value: SentinelHub.
   */
  @minLength(1)
  provider: string;

  /**
   * ItemUri.
   */
  @minLength(1)
  itemUri: string;

  /**
   * Data Model for SatelliteIngestionJobRequest.
   */
  data: SatelliteData;

  /**
   * Collection of satellite data. Available Value: sentinel-2-l2a, sentinel-2-l1c.
   */
  @minLength(1)
  providerCollectionId: string;

  /**
   * Feature Id.
   */
  featureId?: string;
}

/**
 * OAuthClientCredentials for clientId clientSecret auth.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OAuthClientCredentials extends AuthCredentials {
  /**
   * ClientId associated with the provider.
   */
  @minLength(1)
  clientId: string;

  /**
   * Properties of the key vault.
   */
  clientSecret: KeyVaultProperties;
}

/**
 * Properties of the key vault.
 */
model KeyVaultProperties {
  /**
   * Uri of the key vault.
   */
  @maxLength(100)
  @minLength(2)
  keyVaultUri: string;

  /**
   * Name of Key Vault key.
   */
  @maxLength(256)
  @minLength(2)
  keyName: string;

  /**
   * Version of Key Vault key.
   */
  @maxLength(256)
  @minLength(2)
  keyVersion: string;
}

/**
 * AuthCredentials abstract base class for Auth Purpose.
 */
model AuthCredentials {
  /**
   * Enum for different types of AuthCredentials supported.
   */
  kind: AuthCredentialsKind;
}

/**
 * Resource model for Satellite API.
 */
@resource("external/satellite")
model SatelliteResource {
  /**
   * Dummy key for satellite resource
   */
  @key("key")
  key: string;
}
/**
 * Data Model for SatelliteIngestionJobRequest.
 */
model SatelliteData {
  /**
   * List of ImageNames.
   */
  imageNames?: string[];

  /**
   * List of ImageFormats. Available value: TIF.
   */
  imageFormats?: string[];

  /**
   * List of ImageResolutions in meters. Available values: 10, 20, 60.
   */
  imageResolutions?: float64[];
}

/**
 * Satellite Fetch Response.
 */
model SatelliteFetchResponse {
  /**
   * Value.
   */
  value?: SatelliteFetchData[];
}

/**
 * SatelliteFetchData.
 */
model SatelliteFetchData {
  /**
   * Start Date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dateTime?: utcDateTime;

  /**
   * Provider of satellite data. Available Value: SentinelHub.
   */
  provider?: string;

  /**
   * Collection of satellite data. Available Value: sentinel-2-l2a, sentinel-2-l1c.
   */
  @minLength(1)
  providerCollectionId: string;

  /**
   * Feature Id.
   */
  featureId?: string;

  /**
   * ImageFiles.
   */
  imageFiles?: ImageFile[];

  /**
   * ItemUri.
   */
  itemUri?: string;

  /**
   * Id.
   */
  id?: string;
}

/**
 * Schema of image file resource.
 */
model ImageFile {
  /**
   * ADLS path of the image file.
   */
  filePath?: string;

  /**
   * Name of the image file.
   */
  @minLength(1)
  name: string;

  /**
   * Supported image formats for scene resource.
   */
  imageFormat?: ImageFormat;

  /**
   * Resolution of image file in meters.
   */
  resolution?: float64;
}

/**
 * Satellite  Stac Request.
 */
model SatelliteStacRequest {
  /**
   * Start datetime of the time interval in which to search for Items.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * OAuthClientCredentials for clientId clientSecret auth.
   */
  credentials: OAuthClientCredentials;

  /**
   * Provider of satellite data. Available Value: SentinelHub.
   */
  @minLength(1)
  provider: string;

  /**
   * End datetime of the time interval in which to search for Items.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * GeoJSON (For more details: https://geojson.org/). Note: Coordinates are
   * expected in [Longitude, Latitude] format.
   */
  intersects?: GeoJsonObject;

  /**
   * Only items that have a geometry that intersects the bounding box are selected.
   * The bounding box is provided as four numbers. The coordinate reference system
   * of the values is WGS84 longitude/latitude.
   */
  bbox?: float64[];

  /**
   * Array of feature ids to return.
   */
  featureIds?: string[];

  /**
   * Collection of satellite data. Available Value: sentinel-2-l2a, sentinel-2-l1c.
   */
  @minLength(1)
  providerCollectionId: string;
}

/**
 * Paged response contains list of items and next property to get the next set of
 * results.
 */
model SearchFeaturesResponse {
  /**
   * List of items.
   */
  features: StacItem[];

  /**
   * URL to do the POST request with same filters,
   * to get next set of items.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * Schema of STAC Item.
 * Refer for spec:
 * https://github.com/radiantearth/stac-spec/blob/v1.0.0-beta.2/item-spec/item-spec.md#item-fields.
 */
model StacItem {
  /**
   * The STAC version the Stac Item implements.
   */
  @minLength(1)
  stacVersion: string;

  /**
   * A list of extensions the Stac Item implements.
   */
  stacExtensions?: string[];

  /**
   * Provider identifier. Globally unique ID by Data provider.
   */
  @minLength(1)
  id: string;

  /**
   * Type of the GeoJSON Object. It's value is always Feature.
   */
  @minLength(1)
  type: string;

  /**
   * Defines the full footprint of the asset represented by this item.
   * Its a GeoJSON geometry.
   */
  geometry?: unknown;

  /**
   * Bounding box of the item.
   */
  bbox?: float64[];

  /**
   * A dictionary of additional metadata for the item.
   */
  properties: unknown;

  /**
   * List of link objects to resources and related URLs.
   */
  links: StacLink[];

  /**
   * Dictionary of asset objects, each with a unique key.
   */
  assets: Record<StacAsset>;

  /**
   * The id of the STAC Collection this Stac Item references.
   */
  providerCollectionId?: string;
}

/**
 * Link.
 */
model StacLink {
  /**
   * The HREF of the link.
   */
  href?: string;

  /**
   * The relation type of the link.
   */
  rel?: string;

  /**
   * The type of the link. Optional.
   */
  type?: string;

  /**
   * The title of the link. Optional.
   */
  title?: string;
}

/**
 * Assets.
 */
model StacAsset {
  /**
   * The HREF of the asset.
   */
  href?: string;

  /**
   * The title of the asset.
   */
  title?: string;

  /**
   * The description of the asset.
   */
  description?: string;

  /**
   * The type of the asset.
   */
  type?: string;

  /**
   * The roles of the asset.
   */
  roles?: string[];
}

model SchemaListResponse {
  value: Schema[];
  skipToken?: string;
  nextLink?: string;
}

/**
 * SchemaModel.
 */
@resource("schemas")
model Schema {
  /**
   * Dependent Collections.
   */
  @visibility("read")
  dependentCollections?: CatalogCollection[];

  /**
   * Schema.
   */
  schemaModel: Record<unknown>;

  /**
   * Id of the Schema.
   */
  @key("schemaId")
  @visibility("read")
  id: string;

  /**
   * The ETag value to implement optimistic concurrency.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Status of the resource.
   */
  @maxLength(100)
  status?: string;

  /**
   * Date-time when resource was created, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * Date-time when resource was last modified, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDateTime?: utcDateTime;

  /**
   * Source of the resource.
   */
  @maxLength(100)
  @minLength(2)
  source?: string;

  /**
   * Name to identify resource.
   */
  @maxLength(100)
  name?: string;

  /**
   * Textual description of the resource.
   */
  @maxLength(500)
  description?: string;

  /**
   * Created by user/tenant id.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Modified by user/tenant id.
   */
  @visibility("read")
  modifiedBy?: string;

  /**
   * A collection of key value pairs that belongs to the resource.
   * Each pair must not have a key greater than 50 characters
   * and must not have a value greater than 150 characters.
   * Note: A maximum of 25 key value pairs can be provided for a resource and only
   * string,
   * numeral and datetime (yyyy-MM-ddTHH:mm:ssZ) values are supported.
   */
  properties?: Record<unknown>;
}

/**
 * Schema for storing catalog and collection id.
 */
model CatalogCollection {
  /**
   * Catalog Id.
   */
  @visibility("read")
  catalogId?: string;

  /**
   * Collection Id.
   */
  @visibility("read")
  collectionId?: string;
}

@resource("external/solutions")
model SolutionResource {
  /**
   * Dummy key for solution resource
   */
  @key("key")
  key: string;
}
/**
 * Solution.
 */
model Solution {
  /**
   * SolutionId.
   */
  @minLength(1)
  solutionId: string;

  /**
   * RequestPath.
   */
  @minLength(1)
  requestPath: string;

  /**
   * Properties.
   */
  partnerRequestBody: Record<unknown>;

  /**
   * Properties.
   */
  partnerRequestHeaders: Record<unknown>;
}

/**
 * SamplePartnerResponse.
 */
model SamplePartnerResponse {
  /**
   * Id.
   */
  id?: string;

  /**
   * Message.
   */
  message?: string;

  /**
   * Status.
   */
  status?: string;

  /**
   * JobCreatedDateTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  jobCreatedDateTime?: utcDateTime;

  /**
   * JobLastActionDateTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  jobLastActionDateTime?: utcDateTime;

  /**
   * E2eid.
   */
  @encodedName("application/json", "e2eid")
  e2Eid?: string;

  /**
   * SamplePartnerRequestBody.
   */
  partnerRequestBody?: SamplePartnerRequestBody;
}

/**
 * SamplePartnerRequestBody.
 */
model SamplePartnerRequestBody {
  /**
   * SolutionId.
   */
  solutionId?: string;

  /**
   * PartyId.
   */
  partyId?: string;

  /**
   * GddStartDate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  gddStartDate?: utcDateTime;

  /**
   * GddEndDate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  gddEndDate?: utcDateTime;

  /**
   * ResourceId.
   */
  resourceId?: string;

  /**
   * ResourceType.
   */
  resourceType?: string;

  /**
   * Crop.
   */
  crop?: string;

  /**
   * TemperatureUnit.
   */
  temperatureUnit?: string;

  /**
   * Method.
   */
  method?: string;
}

/**
 * SolutionData.
 */
model SolutionData {
  /**
   * Input Data.
   */
  inputData: Record<unknown>;

  /**
   * SolutionId.
   */
  @minLength(1)
  solutionId: string;

  /**
   * RequestPath.
   */
  @minLength(1)
  requestPath: string;

  /**
   * Properties.
   */
  partnerRequestBody: Record<unknown>;

  /**
   * Properties.
   */
  partnerRequestHeaders: Record<unknown>;
}

/**
 * Resource model for Weather API.
 */
@resource("external/weather")
model WeatherResource {
  /**
   * Dummy key for satellite resource
   */
  @key("key")
  key: string;
}
/**
 * WeatherRequest.
 */
model WeatherRequest {
  /**
   * Api Key Auth Credentials class for API Key based Auth.
   */
  credentials?: ApiKeyAuthCredentials;

  /**
   * List of locations for which weather data need to be fetched from the provider.
   */
  locations?: WeatherLocation[];

  /**
   * Weather provider name.
   */
  @maxLength(100)
  @minLength(2)
  providerName: string;

  /**
   * Provider's api name to which request is to be made.
   */
  @maxLength(100)
  @minLength(2)
  providerApiName: string;

  /**
   * Language (IETF BCP 47 language tag) in which search results should be returned
   * by the data provider. Examples: 'en-US', 'es', 'es-MX', 'fr-FR'.
   */
  @maxLength(100)
  language?: string = "en-US";

  /**
   * Units for which request to data provider is to be sent. Supported values are
   * 'e' for English units, 'm' for Metric units, 'h' for Hybrid units (UK) and 's'
   * for Metric SI units.
   */
  @minLength(1)
  units: string;
}

/**
 * Api Key Auth Credentials class for API Key based Auth.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApiKeyAuthCredentials extends AuthCredentials {
  /**
   * Properties of the key vault.
   */
  apiKey: KeyVaultProperties;
}

/**
 * Schema of Location data.
 */
model WeatherLocation {
  /**
   * Location Type eg. LatLong/IataCode/IcaoCode/Placeid/PostalKey.
   */
  @maxLength(25)
  @minLength(2)
  type: string;

  /**
   * Location Value eg. "10,-25" for LocationType Type "LatLong".
   */
  @maxLength(100)
  @minLength(2)
  value: string;
}

/**
 * Schema of Weather Data Provider Response.
 */
model WeatherResponse {
  /**
   * Schema of Weather Metadata.
   */
  weatherMetadata: WeatherMetadata;

  /**
   * Indicates a Succeeded, Failed, or PartiallySucceeded response.
   */
  status?: string;

  /**
   * List of weather data for all the weather locations.
   */
  locations?: WeatherLocationData[];

  /**
   * Model for errors encountered for all failed locations.
   */
  errors?: WeatherDataErrors;
}

/**
 * Schema of Weather Metadata.
 */
model WeatherMetadata {
  /**
   * Type of weather data (forecast/historical).
   */
  @minLength(1)
  weatherDataType: string;

  /**
   * Weather provider name.
   */
  @maxLength(100)
  @minLength(2)
  providerName: string;

  /**
   * Provider's api name to which request is to be made.
   */
  @maxLength(100)
  @minLength(2)
  providerApiName: string;

  /**
   * Language (IETF BCP 47 language tag) in which search results should be returned
   * by the data provider. Examples: 'en-US', 'es', 'es-MX', 'fr-FR'.
   */
  @maxLength(100)
  language?: string = "en-US";

  /**
   * Units for which request to data provider is to be sent. Supported values are
   * 'e' for English units, 'm' for Metric units, 'h' for Hybrid units (UK) and 's'
   * for Metric SI units.
   */
  @minLength(1)
  units: string;
}

/**
 * Schema of WeatherLocationData data.
 */
model WeatherLocationData {
  /**
   * Schema of Location data.
   */
  location?: WeatherLocation;

  /**
   * Request Completion Time in Utc of the location.
   */
  requestCompletionTime?: string;

  /**
   * Date-time when resource was last requested, sample format: yyyy-MM-ddTHH:mm:ssZ.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefreshedDateTime?: utcDateTime;

  /**
   * Schema of weather data.
   */
  data?: WeatherData;
}

/**
 * Schema of weather data.
 */
model WeatherData {
  /**
   * A collection of key value pairs that belongs to the resource. Each pair must
   * not have a key greater than 50 characters and must not have a value greater
   * than 250 characters. Note: A maximum of 100 key value pairs can be provided for
   * a resource and only string and numeral values are supported.
   */
  additionalAttributes?: Record<unknown>;

  /**
   * Schema for storing measurement readings and unit.
   */
  wetBulbTemperature?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  cloudCover?: Measures;

  /**
   * Day of week.
   */
  dayOfWeek?: string[];

  /**
   * This data field indicates whether it is daytime or nighttime based on the Local
   * Apparent Time of the location.
   */
  dayOrNight?: string[];

  /**
   * Expiration time in Utc format.
   */
  expirationTime?: string[];

  /**
   * This number is the key to the weather icon lookup. The data field shows the
   * icon number that is matched to represent the observed weather conditions.
   */
  iconCode?: int32[];

  /**
   * Code representing full set sensible weather.
   */
  iconCodeExtend?: int32[];

  /**
   * Indicates whether there is precipitation or not.
   */
  hasPrecipitation?: boolean[];

  /**
   * Schema for storing measurement readings and unit.
   */
  pressureMeanSeaLevel?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  relativeHumidity?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  temperature?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  temperatureDewPoint?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  temperatureFeelsLike?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  temperatureHeatIndex?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  temperatureWindChill?: Measures;

  /**
   * The UV Index Description which complements the UV Index value by providing an
   * associated level of risk of skin damage due to exposure (-2 = Not Available, -1
   * = No Report, 0 to 2 = Low, 3 to 5 = Moderate, 6 to 7 = High, 8 to 10 = Very
   * High, 11 to 16 = Extreme).
   */
  uvDescription?: string[];

  /**
   * Hourly maximum UV index.
   */
  uvIndex?: float64[];

  /**
   * Time forecast is valid in local apparent time.
   */
  validTimeLocal?: string[];

  /**
   * Time forecast is valid in Utc format.
   */
  validTime?: string[];

  /**
   * Schema for storing measurement readings and unit.
   */
  visibility?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  windDirection?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  windGust?: Measures;

  /**
   * Schema for storing measurement readings and unit.
   */
  windSpeed?: Measures;

  /**
   * Hourly sensible weather phrase containing longer description.
   */
  wxPhraseLong?: string[];

  /**
   * Hourly sensible weather phrase containing short description.
   */
  wxPhraseShort?: string[];
}

/**
 * Schema for storing measurement readings and unit.
 */
model Measures {
  /**
   * Data unit.
   */
  @maxLength(50)
  @minLength(1)
  unit?: string;

  /**
   * Data values.
   */
  value?: float64[];
}

/**
 * Model for errors encountered for all failed locations.
 */
model WeatherDataErrors {
  /**
   * List of errors encountered for all failed locations.
   */
  locations?: ErrorForLocation[];
}

/**
 * Model for error information for a failed location.
 */
model ErrorForLocation {
  /**
   * Schema of Location data.
   */
  location?: WeatherLocation;

  /**
   * Status code returned by data provider.
   */
  code?: int32;

  /**
   * Description of the error.
   */
  description?: string;

  /**
   * Flag suggesting if retry attempt with same request body should be made to fetch
   * required data.
   */
  retryable?: boolean;
}

/**
 * MultiPolygon geometry.
 */
model MultiPolygon extends GeoJsonObject {
  /**
   * Gets or sets Coordinates of GeoJSON Object.
   * It must be an array of polygons, each polygon contains list of linear rings.
   * For Polygons with more than one of these rings, the first MUST be the exterior
   * ring,
   * and any others MUST be interior rings.
   */
  coordinates: float64[][][][];

  /**
   * GeoJSON object type.
   */
  type: "MultiPolygon";
}

/**
 * Point geometry.
 */
model Point extends GeoJsonObject {
  /**
   * Gets or sets the coordinate of this point.
   * It must be an array of 2 or 3 elements for a 2D or 3D system.
   */
  coordinates: float64[];

  /**
   * GeoJSON object type.
   */
  type: "Point";
}

/**
 * Polygon geometry.
 */
model Polygon extends GeoJsonObject {
  /**
   * Gets or sets type of the GeoJSON Object.
   * It must be an array of linear ring coordinate arrays.
   * For Polygons with more than one of these rings, the first MUST be the exterior
   * ring,
   * and any others MUST be interior rings.
   */
  coordinates: float64[][][];

  /**
   * GeoJSON object type.
   */
  type: "Polygon";
}
