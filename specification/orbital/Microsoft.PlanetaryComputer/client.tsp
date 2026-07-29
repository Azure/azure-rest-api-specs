import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Microsoft.PlanetaryComputer;

@useDependency(Versions.v2026_04_15)
@client({
  name: "PlanetaryComputerProClient",
  service: Microsoft.PlanetaryComputer,
})
namespace Customizations;

// === Client name conflicts ===
@@clientName(IngestionOperations, "IngestionOperationsManagement", "csharp");
@@clientName(TilerInfoOperations, "TilerInfoManagement", "csharp");
@@clientName(StacItemProperties.datetime, "date_time", "python");
@@clientName(StacSearchParameters.datetime, "date_time", "python");
@@clientName(SharedAccessSignature, "Sas", "python");

// Fix generic "The most basic operation" docs for search tile operations (without TileMatrixSetId)
@@clientDoc(
  MosaicSearchesAssetsForTiles.getZxyAssets,
  "Return a list of assets which overlap a given tile for a mosaic search.",
  DocumentationMode.replace
);
@@clientDoc(
  MosaicSearchesTiles.getZxyScaleByFormat,
  "Create a map tile for a mosaic search with specified scale and format.",
  DocumentationMode.replace
);
@@clientDoc(
  MosaicSearchesTilesScale.getZxyByScale,
  "Create a map tile for a mosaic search with specified scale.",
  DocumentationMode.replace
);
@@clientDoc(
  MosaicSearchesTilesFormat.getZxyByFormat,
  "Create a map tile for a mosaic search with specified format.",
  DocumentationMode.replace
);
@@clientDoc(
  MosaicSearchesTilesPlain.getZxy,
  "Create a map tile for a mosaic search.",
  DocumentationMode.replace
);

// Clarify behavior differences between tile-asset variants with and without
// TileMatrixSetId in the route.
@@clientDoc(
  MosaicCollectionsAssetsForTiles.getZxyAssets,
  "Return assets overlapping a tile for a collection using the route without TileMatrixSetId in the path (/tiles/{z}/{x}/{y}/assets). This operation uses the default tile matrix set when none is specified.",
  DocumentationMode.replace
);
@@clientDoc(
  MosaicCollectionsAssetsForTileMatrixSets.getZxyAssets,
  "Return assets overlapping a tile for a collection using the route with TileMatrixSetId in the path (/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets). Use this operation when you need an explicit tile matrix set in the URL.",
  DocumentationMode.replace
);

// === Python snake_case parameter renames ===
@@clientName(CollectionMosaicFilterQueryParameters.sortby, "sort_by", "python");
@@clientName(CollectionMosaicFilterQueryParameters.sortby, "sortBy", "csharp");
@@clientName(BoundingBoxPathParameters.minx, "min_x", "python");
@@clientName(BoundingBoxPathParameters.miny, "min_y", "python");
@@clientName(BoundingBoxPathParameters.maxx, "max_x", "python");
@@clientName(BoundingBoxPathParameters.maxy, "max_y", "python");

// C# camelCase fixes for bounding box parameters (minx → minX, etc.)
@@clientName(BoundingBoxPathParameters.minx, "minX", "csharp");
@@clientName(BoundingBoxPathParameters.miny, "minY", "csharp");
@@clientName(BoundingBoxPathParameters.maxx, "maxX", "csharp");
@@clientName(BoundingBoxPathParameters.maxy, "maxY", "csharp");

// C# rename: id → sourceId for ingestion source operations (distinguish from other id types)
@@clientName(IngestionSourceParameters.id, "sourceId", "csharp");
@@clientName(IngestionSources.replace::parameters.id, "sourceId", "csharp");
@@clientName(IngestionSources.delete::parameters.id, "sourceId", "csharp");

// C# rename: creationTime → createdOn (Azure SDK convention for timestamps)
@@clientName(IngestionDefinition.creationTime, "createdOn", "csharp");
@@clientName(IngestionRun.creationTime, "createdOn", "csharp");
@@clientName(IngestionRunOperation.creationTime, "createdOn", "csharp");
@@clientName(Operation.creationTime, "createdOn", "csharp");

// C# rename: *Url → *Uri (Azure SDK convention)
@@clientName(
  IngestionDefinition.sourceCatalogUrl,
  "sourceCatalogUri",
  "csharp"
);
@@clientName(
  IngestionDefinition.stacGeoparquetUrl,
  "stacGeoparquetUri",
  "csharp"
);
@@clientName(IngestionRun.sourceCatalogUrl, "sourceCatalogUri", "csharp");

// C# rename: finishTime → finishedOn (Azure SDK convention for timestamps)
@@clientName(IngestionRunOperation.finishTime, "finishedOn", "csharp");
@@clientName(Operation.finishTime, "finishedOn", "csharp");

// C# rename: startTime → startedOn (Azure SDK timestamp convention)
@@clientName(IngestionRunOperation.startTime, "startedOn", "csharp");
@@clientName(Operation.startTime, "startedOn", "csharp");

// C# rename: created → createdOn (Azure SDK timestamp convention)
@@clientName(IngestionSourceSummary.created, "createdOn", "csharp");
@@clientName(IngestionSource.created, "createdOn", "csharp");
@@clientName(StacCommonMetadata.created, "createdOn", "csharp");

// C# rename: IngestionSourceType → IngestionSourceKind (avoid "Type" suffix)
@@clientName(IngestionSourceType, "IngestionSourceKind", "csharp");

// C# rename: importType → importKind, IngestionType → IngestionKind (avoid "Type" suffix)
@@clientName(IngestionDefinition.importType, "importKind", "csharp");
@@clientName(IngestionType, "IngestionKind", "csharp");

// Disable convenient API for JSON-Merge patch operations
@@convenientAPI(Ingestions.update, false, "csharp,java");
@@convenientAPI(StacItems.update, false, "csharp,java");

// Workaround errors CS0019 and CS0019
@@alternateType(StacCollectionTemporalExtent.interval, string[][], "csharp");

// Use Azure.Core.ETag type for StacItem.eTag
@@alternateType(StacItem.eTag, eTag, "csharp");

// Change the WmtsCapabilitiesXmlResponse body type from bytes to string for JavaScript
@@alternateType(WmtsCapabilitiesXmlResponse.body, string, "javascript");

// Rename Ingestion.delete to deleteIngestion for JavaScript to avoid @fixme conflict
@@clientName(Ingestion.delete, "deleteIngestion", "javascript");

// Address naming convention violations for C# SDK
@@clientName(
  TilerMosaicSearchRegistrationResponse,
  "TilerMosaicSearchRegistrationResult",
  "csharp"
);

// Models ending with "Definition" - rename appropriately
@@clientName(IngestionDefinition, "IngestionInformation", "csharp");

// Models ending with "Operation" - rename to "Info"
@@clientName(IngestionRunOperation, "IngestionRunInformation", "csharp");

// Generic single-word class names - add descriptive prefixes
@@clientName(Geometry, "GeoJsonGeometry", "csharp");
@@clientName(Feature, "GeoJsonFeature", "csharp");
@@clientName(Point, "PointGeometry", "csharp");
@@clientName(Polygon, "PolygonGeometry", "csharp");
@@clientName(Resampling, "ResamplingMethod", "csharp");
@@clientName(FeatureType, "FeatureKind", "csharp");
@@clientName(Operation, "PlanetaryComputerOperation", "csharp");
@@clientName(Operation.type, "Kind", "csharp");
@@clientName(OperationStatus, "PlanetaryComputerOperationStatus", "csharp");
@@clientName(
  OperationStatusHistoryItem,
  "PlanetaryComputerOperationStatusHistoryItem",
  "csharp"
);
@@clientName(ErrorInfo, "PlanetaryComputerErrorInfo", "csharp");

// C# rename: all *Type unions/models → *Kind (avoid "Type" suffix)
@@clientName(LegendConfigType, "LegendConfigKind", "csharp");
@@clientName(MosaicMetadataType, "MosaicMetadataKind", "csharp");
@@clientName(NoDataType, "NoDataKind", "csharp");
@@clientName(PartitionType, "PartitionKind", "csharp");
@@clientName(PartitionTypeScheme, "PartitionKindScheme", "csharp");
@@clientName(RenderOptionType, "RenderOptionKind", "csharp");
@@clientName(FeatureCollectionType, "FeatureCollectionKind", "csharp");
@@clientName(GeometryType, "GeometryKind", "csharp");
@@clientName(GeometryCollectionType, "GeometryCollectionKind", "csharp");
@@clientName(
  StacQueryableDefinitionDataType,
  "StacQueryableDefinitionDataKind",
  "csharp"
);
@@clientName(StacItemCollectionType, "StacItemCollectionKind", "csharp");
@@clientName(StacModelType, "StacModelKind", "csharp");
@@clientName(StacLinkType, "StacLinkKind", "csharp");

// C# rename: .type properties → Kind (on models not yet handled)
@@clientName(RenderOption.type, "Kind", "csharp");
@@clientName(RenderOptionLegend.type, "Kind", "csharp");
@@clientName(MosaicMetadata.type, "Kind", "csharp");
@@clientName(AssetMetadata.type, "Kind", "csharp");
@@clientName(TileSetLink.type, "Kind", "csharp");

// C# rename: .type properties on STAC models → Kind
@@clientName(StacAsset.type, "Kind", "csharp");
@@clientName(StacItemAsset.type, "Kind", "csharp");
@@clientName(StacCollection.type, "Kind", "csharp");
@@clientName(StacLandingPage.type, "Kind", "csharp");
@@clientName(StacItem.type, "Kind", "csharp");
@@clientName(StacItemCollection.type, "Kind", "csharp");
@@clientName(StacLink.type, "Kind", "csharp");

// C# rename: tilejsonKey → tileJsonKey (fix casing)
@@clientName(RenderOptionVectorOptions.tilejsonKey, "tileJsonKey", "csharp");

// C# rename: colormap → colorMap (fix camelCase word boundary)
@@clientName(TilerInfo.colormap, "colorMap", "csharp");

// C# rename: dtype → dataType (expand abbreviation)
@@clientName(TilerInfo.dtype, "dataType", "csharp");

// C# rename: dataType → dataKind (property uses *Type union renamed to *Kind)
@@clientName(StacQueryable.dataType, "dataKind", "csharp");

// C# rename: lastUsed → lastUsedOn (Azure SDK timestamp convention)
@@clientName(TilerStacSearchDefinition.lastUsed, "lastUsedOn", "csharp");

// C# rename: expiration → expiresOn (Azure SDK timestamp convention)
@@clientName(
  SharedAccessSignatureTokenConnection.expiration,
  "expiresOn",
  "csharp"
);

// C# rename: updated → updatedOn (Azure SDK timestamp convention)
@@clientName(StacCommonMetadata.updated, "updatedOn", "csharp");

// C# rename: STAC temporal properties (Azure SDK timestamp convention)
@@clientName(StacItemProperties.startDatetime, "startedOn", "csharp");
@@clientName(StacItemProperties.endDatetime, "endedOn", "csharp");

// C# rename: timestamp → more descriptive names
@@clientName(OperationStatusHistoryItem.timestamp, "occurredOn", "csharp");
@@clientName(StacItem.timestamp, "recordedOn", "csharp");

// Response → Result renames (Azure SDK reserves "Response" for HTTP response types)
@@clientName(AssetStatisticsResponse, "AssetStatisticsResult", "csharp");
@@clientName(ClassMapLegendResponse, "ClassMapLegendResult", "csharp");
@@clientName(
  QueryableDefinitionsResponse,
  "QueryableDefinitionsResult",
  "csharp"
);
@@clientName(TilerInfoMapResponse, "TilerInfoMapResult", "csharp");

// Generic geometry class names - add descriptive prefixes for Java to avoid
// collisions with common domain types and improve discoverability.
@@clientName(Geometry, "GeoJsonGeometry", "java");
@@clientName(Feature, "GeoJsonFeature", "java");
@@clientName(Point, "GeoJsonPoint", "java");
@@clientName(LineString, "GeoJsonLineString", "java");
@@clientName(Polygon, "GeoJsonPolygon", "java");
@@clientName(MultiPoint, "GeoJsonMultiPoint", "java");
@@clientName(MultiLineString, "GeoJsonMultiLineString", "java");
@@clientName(MultiPolygon, "GeoJsonMultiPolygon", "java");

// === Java-only method renames: WithTms/NoTms naming convention ===
// TMS-path variants renamed to WithTms, non-TMS variants renamed to NoTms for Java only.
// Python and JavaScript retain the original names defined in the interface.

// Item tile variants (TileMatrixSetId as path) → WithTms
@@clientName(Data.getTile, "getTileWithTms", "java");
@@clientName(Data.getTileByFormat, "getTileWithTmsByFormat", "java");
@@clientName(Data.getTileByScale, "getTileWithTmsByScale", "java");
@@clientName(
  Data.getTileByScaleAndFormat,
  "getTileWithTmsByScaleAndFormat",
  "java"
);

// Item tile variants (no TileMatrixSetId in path) → NoTms
@@clientName(Data.getTileNoTms, "getTileNoTms", "java");
@@clientName(Data.getTileNoTmsByFormat, "getTileNoTmsByFormat", "java");
@@clientName(Data.getTileNoTmsByScale, "getTileNoTmsByScale", "java");
@@clientName(
  Data.getTileNoTmsByScaleAndFormat,
  "getTileNoTmsByScaleAndFormat",
  "java"
);

// Item TileJSON / WMTS → WithTms
@@clientName(Data.getItemTileJsonByTms, "getItemTileJsonWithTms", "java");
@@clientName(
  Data.getItemWmtsCapabilitiesByTms,
  "getItemWmtsCapabilitiesWithTms",
  "java"
);

// Collection tile variants (TileMatrixSetId as path) → WithTms
@@clientName(Data.getCollectionTile, "getCollectionTileWithTms", "java");
@@clientName(
  Data.getCollectionTileByFormat,
  "getCollectionTileWithTmsByFormat",
  "java"
);
@@clientName(
  Data.getCollectionTileByScale,
  "getCollectionTileWithTmsByScale",
  "java"
);
@@clientName(
  Data.getCollectionTileByScaleAndFormat,
  "getCollectionTileWithTmsByScaleAndFormat",
  "java"
);

// Collection tile variants (no TileMatrixSetId in path) → NoTms
@@clientName(Data.getCollectionTileNoTms, "getCollectionTileNoTms", "java");
@@clientName(
  Data.getCollectionTileNoTmsByFormat,
  "getCollectionTileNoTmsByFormat",
  "java"
);
@@clientName(
  Data.getCollectionTileNoTmsByScale,
  "getCollectionTileNoTmsByScale",
  "java"
);
@@clientName(
  Data.getCollectionTileNoTmsByScaleAndFormat,
  "getCollectionTileNoTmsByScaleAndFormat",
  "java"
);

// Collection TileJSON / WMTS / Assets → WithTms/NoTms
@@clientName(
  Data.getCollectionTileJsonByTms,
  "getCollectionTileJsonWithTms",
  "java"
);
@@clientName(
  Data.getCollectionWmtsCapabilitiesByTms,
  "getCollectionWmtsCapabilitiesWithTms",
  "java"
);
@@clientName(
  Data.getCollectionAssetsForTile,
  "getCollectionAssetsForTileWithTms",
  "java"
);
@@clientName(
  Data.getCollectionAssetsForTileNoTms,
  "getCollectionAssetsForTileNoTms",
  "java"
);

// Search tile variants (TileMatrixSetId as path) → WithTms
@@clientName(Data.getSearchTile, "getSearchTileWithTms", "java");
@@clientName(
  Data.getSearchTileByFormat,
  "getSearchTileWithTmsByFormat",
  "java"
);
@@clientName(Data.getSearchTileByScale, "getSearchTileWithTmsByScale", "java");
@@clientName(
  Data.getSearchTileByScaleAndFormat,
  "getSearchTileWithTmsByScaleAndFormat",
  "java"
);
@@clientName(
  Data.getSearchAssetsForTile,
  "getSearchAssetsForTileWithTms",
  "java"
);

// Search tile variants (no TileMatrixSetId in path) → NoTms
@@clientName(Data.getSearchTileNoTms, "getSearchTileNoTms", "java");
@@clientName(
  Data.getSearchTileNoTmsByFormat,
  "getSearchTileNoTmsByFormat",
  "java"
);
@@clientName(
  Data.getSearchTileNoTmsByScale,
  "getSearchTileNoTmsByScale",
  "java"
);
@@clientName(
  Data.getSearchTileNoTmsByScaleAndFormat,
  "getSearchTileNoTmsByScaleAndFormat",
  "java"
);
@@clientName(
  Data.getSearchAssetsForTileNoTms,
  "getSearchAssetsForTileNoTms",
  "java"
);

// Search TileJSON / WMTS → WithTms
@@clientName(Data.getSearchTileJsonByTms, "getSearchTileJsonWithTms", "java");
@@clientName(
  Data.getSearchWmtsCapabilitiesByTms,
  "getSearchWmtsCapabilitiesWithTms",
  "java"
);

// Additional model renames for C#
@@clientName(RenderOption, "RenderConfiguration", "csharp");

// === Ingestion Management ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "These operations return collections."
@operationGroup
@clientName("IngestionClient", "csharp")
interface Ingestion {
  // Ingestion operations management
  cancelOperation is IngestionOperations.delete;
  cancelAllOperations is IngestionOperations.deleteAll;
  getOperation is IngestionOperations.get;
  listOperations is IngestionOperations.list;

  // Ingestion runs operations
  createRun is IngestionRuns.create;
  getRun is IngestionRuns.get;
  listRuns is IngestionRuns.list;

  // Ingestion operations
  create is Ingestions.create;
  delete is Ingestions.delete;
  get is Ingestions.get;
  list is Ingestions.list;
  update is Ingestions.update;

  // Ingestion sources
  createSource is IngestionSources.create;
  replaceSource is IngestionSources.replace;
  deleteSource is IngestionSources.delete;
  getSource is IngestionSources.get;
  listSources is IngestionSources.list;
  listManagedIdentities is IngestionSources.listManagedIdentities;
}

// === SpatioTemporal Asset Catalog (STAC) API ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("StacClient", "csharp")
interface Stac {
  // Collection Assets
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createCollectionAsset is StacCollectionAssets.create;
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  replaceCollectionAsset is StacCollectionAssets.replace;
  deleteCollectionAsset is StacCollectionAssets.delete;

  // Collection Configuration
  getCollectionConfiguration is StacCollectionConfig.get;

  // Collection Mosaics
  addMosaic is StacCollectionMosaics.add;
  replaceMosaic is StacCollectionMosaics.replace;
  deleteMosaic is StacCollectionMosaics.delete;
  getMosaic is StacCollectionMosaics.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getMosaics is StacCollectionMosaics.getAll;

  // STAC Collections
  createCollection is StacCollections.create;
  replaceCollection is StacCollections.replace;
  deleteCollection is StacCollections.delete;
  getCollection is StacCollections.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getCollections is StacCollections.getAll;

  // Collection Partition Types
  getPartitionType is StacCollectionPartitionTypes.get;
  replacePartitionType is StacCollectionPartitionTypes.replace;

  // Collection Render Options
  createRenderOption is StacCollectionRenderOptions.create;
  replaceRenderOption is StacCollectionRenderOptions.replace;
  deleteRenderOption is StacCollectionRenderOptions.delete;
  getRenderOption is StacCollectionRenderOptions.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getRenderOptions is StacCollectionRenderOptions.getAll;

  // Collection Thumbnails
  getCollectionThumbnail is StacCollectionThumbnails.get;

  // Collection Tile Settings
  getTileSettings is StacCollectionTileSettings.get;
  replaceTileSettings is StacCollectionTileSettings.replace;

  // STAC Conformance
  getConformanceClasses is StacConformanceClass.get;

  // STAC landing page
  getLandingPage is StacLandingPages.get;

  // STAC Items
  createItem is StacItems.create;
  @removed(Versions.v2026_04_15)
  createOrReplaceItem is StacItems.createOrReplace;

  @added(Versions.v2026_04_15)
  replaceItem is StacItems.replace;
  deleteItem is StacItems.delete;
  getItem is StacItems.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getItemCollection is StacItems.getFeatures;
  updateItem is StacItems.update;

  // STAC Queryables
  createQueryables is StacQueryables.create;
  replaceQueryable is StacQueryables.replace;
  deleteQueryable is StacQueryables.delete;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getQueryables is StacQueryables.getAll;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getCollectionQueryables is StacQueryables.getAllByCollection;

  // STAC Search
  search is StacSearch.create;
}

// === Tiles for STAC Items ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("DataClient", "csharp")
interface Data {
  // Tile Matrix Sets
  getTileMatrixDefinitions is TileMatrixDefinitions.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getTileMatrices is TileMatrixList.get;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getAssetStatistics is TilerAssetStatistics.getAll;

  // Basic Info and Assets
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  listAvailableAssets is TilerAvailableAssets.getAll;

  // Basic Info and Assets
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getBounds is TilerBound.getAll;

  // Parts/Crops
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  cropGeoJson is TilerGeoJsons.cropFormat;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  cropGeoJsonWithDimensions is TilerGeoJsons.cropWidthByHeightFormat;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getGeoJsonStatistics is TilerGeoJsonStatistics.get;

  // Basic Info and Assets
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getInfoGeoJson is TilerInfoGeoJsonOperations.get;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getItemAssetDetails is TilerInfoOperations.get;

  // Parts/Crops
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getPart is TilerParts.getCroppedToBoundingBox;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getPartWithDimensions is TilerParts.getCroppedToBoundingBoxWidthByHeight;

  // Points
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getPoint is TilerPoints.getPoint;

  // Previews
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getPreview is TilerPreviews.get;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getPreviewWithFormat is TilerPreviews.getFormat;

  // Image Exports for STAC Collections
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  createStaticImage is TilerStaticImages.create;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getStaticImage is TilerStaticImages.get;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  listStatistics is TilerStatistics.getAll;

  // Tile JSON
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getTileJson is TilerTileJsonTileMatrixSets.get;
  // getTileJson is TilerTileJsonOperations.get;

  // Tiles
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getTilePreviewDeprecated is TilerTileMatrixSets.getZxyScaleByFormat;
  // getTile is TilerTiles.getZxyScaleByFormat;

  // WMTS Capabilities
  // getWmtsCapabilities is TilerWmts.getCapabilitiesXml;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getWmtsCapabilities is TilerWmtsTileMatrixSets.getCapabilitiesXml;

  // Map Legends
  getClassMapLegend is MapsClassMapLegends.get;
  getIntervalLegend is MapsIntervalLegends.getByClassMapName;
  getLegend is MapsLegends.get;

  // Mosaic Assets
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getMosaicsAssetsForPoint is MosaicsAssetsForPoints.getPointAssets;
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getMosaicsAssetsForTile is MosaicsAssetsForTileMatrixSets.getZxyAssets;
  // getMosaicsAssetsForTile is MosaicsAssetsForTiles.getZxyAssets;

  // Mosaic Search and Registration
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getMosaicsSearchInfo is MosaicsInfoSearch.get;
  registerMosaicsSearch is MosaicsRegisterSearch.register;

  // Mosaic Tile JSON
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getMosaicsTileJson is MosaicsTileMatrixSetsTileJson.get;

  // Mosaic Tiles
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getMosaicsTile is MosaicsTileMatrixSets.getZxyScaleByFormat;

  // Mosaic WMTS Capabilities
  #suppress "deprecated" "Preview-only operation, removed in stable version"
  @removed(Versions.v2026_04_15)
  getMosaicsWmtsCapabilities is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;
  // getMosaicsWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;

  // === New endpoints in stable version 2026-04-15 ===

  // Item Tileset List and Metadata
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getTilesets is MosaicItemsTileSetList.get;
  @added(Versions.v2026_04_15)
  getTilesetMetadata is MosaicItemsTileSetMetadata.get;

  // Item Tile Variants (TileMatrixSetId as path)
  @added(Versions.v2026_04_15)
  getTile is MosaicItemsTileMatrixSetsPlain.getZxy;
  @added(Versions.v2026_04_15)
  getTileByFormat is MosaicItemsTileMatrixSetsFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getTileByScale is MosaicItemsTileMatrixSetsScale.getZxyByScale;
  @added(Versions.v2026_04_15)
  getTileByScaleAndFormat is MosaicItemsTileMatrixSetsScaleByFormat.getZxyScaleByFormat;

  // Item Tile Variants (without TileMatrixSetId in path)
  @added(Versions.v2026_04_15)
  getTileNoTms is MosaicItemsTilesPlain.getZxy;
  @added(Versions.v2026_04_15)
  getTileNoTmsByFormat is MosaicItemsTilesFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getTileNoTmsByScale is MosaicItemsTilesScale.getZxyByScale;
  @added(Versions.v2026_04_15)
  getTileNoTmsByScaleAndFormat is MosaicItemsTilesScaleByFormat.getZxyScaleByFormat;

  // Feature Crop (bare, no format)
  @added(Versions.v2026_04_15)
  cropFeature is MosaicItemsFeatureGeoJson.crop;

  // Feature Crop with format
  @added(Versions.v2026_04_15)
  cropFeatureByFormat is MosaicItemsFeatureGeoJsonFormat.cropFormat;

  // Feature Crop with dimensions
  @added(Versions.v2026_04_15)
  cropFeatureWidthByHeight is MosaicItemsFeatureGeoJsonWidthByHeight.cropWidthByHeightFormat;

  // Item Bounds, Info, Assets
  @added(Versions.v2026_04_15)
  getItemBounds is MosaicItemsBounds.getAll;
  @added(Versions.v2026_04_15)
  getItemInfo is MosaicItemsInfo.get;
  @added(Versions.v2026_04_15)
  getItemInfoGeoJson is MosaicItemsInfoGeoJson.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getItemAvailableAssets is MosaicItemsAvailableAssets.getAll;

  // Item Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getItemAssetStatistics is MosaicItemsAssetStatistics.getAll;
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getItemStatistics is MosaicItemsStatistics.getAll;
  @added(Versions.v2026_04_15)
  getItemFeatureStatistics is MosaicItemsGeoJsonStatistics.get;

  // Item TileJSON
  @added(Versions.v2026_04_15)
  getItemTileJson is MosaicItemsTileJson.get;
  @added(Versions.v2026_04_15)
  getItemTileJsonByTms is MosaicItemsTileMatrixSetsTileJson.get;

  // Item WMTS
  @added(Versions.v2026_04_15)
  getItemWmtsCapabilities is MosaicItemsWmts.getCapabilitiesXml;
  @added(Versions.v2026_04_15)
  getItemWmtsCapabilitiesByTms is MosaicItemsWmtsTileMatrixSets.getCapabilitiesXml;

  // Item Point
  @added(Versions.v2026_04_15)
  getItemPoint is MosaicItemsPoint.getPoint;

  // Item Preview
  @added(Versions.v2026_04_15)
  getItemPreview is MosaicItemsPreview.get;
  @added(Versions.v2026_04_15)
  getItemPreviewWithFormat is MosaicItemsPreviewFormat.getFormat;

  // Item Bbox Crop
  @added(Versions.v2026_04_15)
  getItemBboxCrop is MosaicItemsBbox.getCroppedToBoundingBox;
  @added(Versions.v2026_04_15)
  getItemBboxCropWithDimensions is MosaicItemsBboxWithDimensions.getCroppedToBoundingBoxWidthByHeight;

  // === Collection-level mosaic endpoints (stable 2026-04-15) ===

  // Collection Tileset List and Metadata
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getCollectionTilesets is MosaicCollectionsTileSetList.get;
  @added(Versions.v2026_04_15)
  getCollectionTilesetMetadata is MosaicCollectionsTileSetMetadata.get;

  // Collection Tiles (TileMatrixSetId as path)
  @added(Versions.v2026_04_15)
  getCollectionTileByScaleAndFormat is MosaicCollectionsTileMatrixSets.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTile is MosaicCollectionsTileMatrixSetsPlain.getZxy;
  @added(Versions.v2026_04_15)
  getCollectionTileByFormat is MosaicCollectionsTileMatrixSetsFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTileByScale is MosaicCollectionsTileMatrixSetsScale.getZxyByScale;

  // Collection Tiles (without TileMatrixSetId in path)
  @added(Versions.v2026_04_15)
  getCollectionTileNoTmsByScaleAndFormat is MosaicCollectionsTiles.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTileNoTms is MosaicCollectionsTilesPlain.getZxy;
  @added(Versions.v2026_04_15)
  getCollectionTileNoTmsByFormat is MosaicCollectionsTilesFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTileNoTmsByScale is MosaicCollectionsTilesScale.getZxyByScale;

  // Collection TileJSON
  @added(Versions.v2026_04_15)
  getCollectionTileJson is MosaicCollectionsTileJson.get;
  @added(Versions.v2026_04_15)
  getCollectionTileJsonByTms is MosaicCollectionsTileMatrixSetsTileJson.get;

  // Collection WMTS
  @added(Versions.v2026_04_15)
  getCollectionWmtsCapabilities is MosaicCollectionsWmts.getCapabilitiesXml;
  @added(Versions.v2026_04_15)
  getCollectionWmtsCapabilitiesByTms is MosaicCollectionsWmtsTileMatrixSets.getCapabilitiesXml;

  // Collection Assets
  @added(Versions.v2026_04_15)
  getCollectionAssetsForTile is MosaicCollectionsAssetsForTileMatrixSets.getZxyAssets;
  @added(Versions.v2026_04_15)
  getCollectionAssetsForTileNoTms is MosaicCollectionsAssetsForTiles.getZxyAssets;
  @added(Versions.v2026_04_15)
  getCollectionAssetsForBbox is MosaicCollectionsAssetsForBbox.getBboxAssets;

  // Collection Info
  @added(Versions.v2026_04_15)
  getCollectionInfo is MosaicCollectionsInfo.get;

  // Collection Bbox Crop
  @added(Versions.v2026_04_15)
  getCollectionBboxCrop is MosaicCollectionsBbox.getCroppedToBoundingBox;
  @added(Versions.v2026_04_15)
  getCollectionBboxCropWithDimensions is MosaicCollectionsBboxWithDimensions.getCroppedToBoundingBoxWidthByHeight;
  @added(Versions.v2026_04_15)
  cropCollectionFeature is MosaicCollectionsFeatureGeoJson.crop;
  @added(Versions.v2026_04_15)
  cropCollectionFeatureByFormat is MosaicCollectionsFeatureGeoJsonFormat.cropFormat;
  @added(Versions.v2026_04_15)
  cropCollectionFeatureWidthByHeight is MosaicCollectionsFeatureGeoJsonWidthByHeight.cropWidthByHeightFormat;

  // Collection Point
  @added(Versions.v2026_04_15)
  getCollectionPoint is MosaicCollectionsPoint.getPoint;
  @added(Versions.v2026_04_15)
  getCollectionPointAssets is MosaicCollectionsPointAssets.getPointAssets;

  // === Search-based mosaic endpoints (stable 2026-04-15) ===

  // Search Tileset List and Metadata
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getSearchTilesets is MosaicSearchesTileSetList.get;
  @added(Versions.v2026_04_15)
  getSearchTilesetMetadata is MosaicSearchesTileSetMetadata.get;
  // Search Tiles with TileMatrixSetId (4 variants)
  @added(Versions.v2026_04_15)
  getSearchTileByScaleAndFormat is MosaicSearchesTileMatrixSets.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getSearchTile is MosaicSearchesTileMatrixSetsPlain.getZxy;
  @added(Versions.v2026_04_15)
  getSearchTileByFormat is MosaicSearchesTileMatrixSetsFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getSearchTileByScale is MosaicSearchesTileMatrixSetsScale.getZxyByScale;
  // Search Assets for Tile (with TileMatrixSetId)
  @added(Versions.v2026_04_15)
  getSearchAssetsForTile is MosaicSearchesAssetsForTileMatrixSets.getZxyAssets;
  // Search TileJSON with TileMatrixSetId
  @added(Versions.v2026_04_15)
  getSearchTileJsonByTms is MosaicSearchesTileMatrixSetsTileJson.get;
  // Search WMTS with TileMatrixSetId
  @added(Versions.v2026_04_15)
  getSearchWmtsCapabilitiesByTms is MosaicSearchesWmtsTileMatrixSets.getCapabilitiesXml;
  // Search Info
  @added(Versions.v2026_04_15)
  getSearchInfo is MosaicSearchesInfoSearch.get;
  // Search Bbox Crop
  @added(Versions.v2026_04_15)
  getSearchBboxCrop is MosaicSearchesBbox.getCroppedToBoundingBox;
  @added(Versions.v2026_04_15)
  getSearchBboxCropWithDimensions is MosaicSearchesBboxWithDimensions.getCroppedToBoundingBoxWidthByHeight;
  @added(Versions.v2026_04_15)
  getSearchBboxAssets is MosaicSearchesAssetsForBbox.getBboxAssets;
  // Search Feature Crop
  @added(Versions.v2026_04_15)
  cropSearchFeature is MosaicSearchesFeatureGeoJson.crop;
  @added(Versions.v2026_04_15)
  cropSearchFeatureByFormat is MosaicSearchesFeatureGeoJsonFormat.cropFormat;
  @added(Versions.v2026_04_15)
  cropSearchFeatureWidthByHeight is MosaicSearchesFeatureGeoJsonWidthByHeight.cropWidthByHeightFormat;
  // Search WMTS and TileJSON (without TileMatrixSetId)
  @added(Versions.v2026_04_15)
  getSearchWmtsCapabilities is MosaicSearchesWmts.getCapabilitiesXml;
  @added(Versions.v2026_04_15)
  getSearchTileJson is MosaicSearchesTileJson.get;
  // Search Tiles (without TileMatrixSetId)
  @added(Versions.v2026_04_15)
  getSearchTileNoTms is MosaicSearchesTilesPlain.getZxy;
  @added(Versions.v2026_04_15)
  getSearchTileNoTmsByFormat is MosaicSearchesTilesFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getSearchTileNoTmsByScale is MosaicSearchesTilesScale.getZxyByScale;
  @added(Versions.v2026_04_15)
  getSearchTileNoTmsByScaleAndFormat is MosaicSearchesTiles.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getSearchAssetsForTileNoTms is MosaicSearchesAssetsForTiles.getZxyAssets;
  // Search Point
  @added(Versions.v2026_04_15)
  getSearchPoint is MosaicSearchesPoint.getPoint;
  @added(Versions.v2026_04_15)
  getSearchPointWithAssets is MosaicSearchesPointWithAssets.getPointAssets;
}

// === Shared Access Signature (SAS) ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("ManagedStorageSharedAccessSignatureClient", "csharp")
interface SharedAccessSignature {
  // Sign HREF for read access
  getUrl is Sas.getSign;

  // SAS Tokens
  getToken is Sas.getToken;
  revokeToken is Sas.revokeToken;
}

// === ColorMapNames enum: fix digit-to-alpha word boundary splits ===
@@clientName(ColorMapNames.`ai4g-lulc`, "AI4G_LULC", "python");
@@clientName(ColorMapNames.`modis-10A1`, "MODIS_10A1", "python");
@@clientName(ColorMapNames.`modis-10A2`, "MODIS_10A2", "python");
@@clientName(ColorMapNames.`modis-13A1|Q1`, "MODIS_13A1_Q1", "python");
@@clientName(ColorMapNames.`modis-14A1|A2`, "MODIS_14A1_A2", "python");
@@clientName(ColorMapNames.`modis-15A2H|A3H`, "MODIS_15A2H_A3H", "python");
@@clientName(ColorMapNames.`modis-16A3GF-ET`, "MODIS_16A3GF_ET", "python");
@@clientName(ColorMapNames.`modis-16A3GF-PET`, "MODIS_16A3GF_PET", "python");
@@clientName(ColorMapNames.`modis-17A2H|A2HGF`, "MODIS_17A2H_A2HGF", "python");
@@clientName(ColorMapNames.`modis-17A3HGF`, "MODIS_17A3HGF", "python");
@@clientName(ColorMapNames.`modis-64A1`, "MODIS_64A1", "python");
@@clientName(ColorMapNames.tab20b, "TAB20B", "python");
@@clientName(ColorMapNames.tab20b_r, "TAB20B_R", "python");
@@clientName(ColorMapNames.tab20c, "TAB20C", "python");
@@clientName(ColorMapNames.tab20c_r, "TAB20C_R", "python");
@@clientName(ColorMapNames.`viirs-10a1`, "VIIRS_10A1", "python");
@@clientName(ColorMapNames.`viirs-13a1`, "VIIRS_13A1", "python");
@@clientName(ColorMapNames.`viirs-14a1`, "VIIRS_14A1", "python");
@@clientName(ColorMapNames.`viirs-15a2H`, "VIIRS_15A2H", "python");

// === Enhanced datetime documentation ===
// Reuse the same RFC 3339 documentation from inma.tsp (StacItems.getFeatures)
// to ensure consistent datetime documentation across all Data and STAC APIs.

@@clientDoc(
  SubDatasetQueryParameters.datetime,
  """
    Either a date-time or an interval, open or closed. Date and time expressions
    adhere to RFC 3339. Open intervals are expressed using double-dots.
    
    Examples:
    
    - A date-time: "2018-02-12T23:20:50Z"
    - A closed interval: "2018-02-12T00:00:00Z/2018-03-18T12:31:12Z"
    - Open intervals: "2018-02-12T00:00:00Z/.." or "../2018-03-18T12:31:12Z"
    
    Only features that have a temporal property that intersects the value of
    `datetime` are selected.
    
    If a feature has multiple temporal properties, it is the decision of the
    server whether only a single temporal property is used to determine
    the extent or all relevant temporal properties.
    """,
  DocumentationMode.replace
);

@@clientDoc(
  CollectionMosaicFilterQueryParameters.datetime,
  """
    Either a date-time or an interval, open or closed. Date and time expressions
    adhere to RFC 3339. Open intervals are expressed using double-dots.
    
    Examples:
    
    - A date-time: "2018-02-12T23:20:50Z"
    - A closed interval: "2018-02-12T00:00:00Z/2018-03-18T12:31:12Z"
    - Open intervals: "2018-02-12T00:00:00Z/.." or "../2018-03-18T12:31:12Z"
    
    Only features that have a temporal property that intersects the value of
    `datetime` are selected.
    
    If a feature has multiple temporal properties, it is the decision of the
    server whether only a single temporal property is used to determine
    the extent or all relevant temporal properties.
    """,
  DocumentationMode.replace
);

@@clientDoc(
  RegisterMosaic.datetime,
  """
    Either a date-time or an interval, open or closed. Date and time expressions
    adhere to RFC 3339. Open intervals are expressed using double-dots.
    
    Examples:
    
    - A date-time: "2018-02-12T23:20:50Z"
    - A closed interval: "2018-02-12T00:00:00Z/2018-03-18T12:31:12Z"
    - Open intervals: "2018-02-12T00:00:00Z/.." or "../2018-03-18T12:31:12Z"
    
    Only features that have a temporal property that intersects the value of
    `datetime` are selected.
    
    If a feature has multiple temporal properties, it is the decision of the
    server whether only a single temporal property is used to determine
    the extent or all relevant temporal properties.
    """,
  DocumentationMode.replace
);

@@clientDoc(
  StacSearchParameters.datetime,
  """
    Either a date-time or an interval, open or closed. Date and time expressions
    adhere to RFC 3339. Open intervals are expressed using double-dots.
    
    Examples:
    
    - A date-time: "2018-02-12T23:20:50Z"
    - A closed interval: "2018-02-12T00:00:00Z/2018-03-18T12:31:12Z"
    - Open intervals: "2018-02-12T00:00:00Z/.." or "../2018-03-18T12:31:12Z"
    
    Only features that have a temporal property that intersects the value of
    `datetime` are selected.
    
    If a feature has multiple temporal properties, it is the decision of the
    server whether only a single temporal property is used to determine
    the extent or all relevant temporal properties.
    """,
  DocumentationMode.replace
);

// =============================================================================
// C# Options Bags for DataClient methods with >6 parameters
// Uses @@override + @@protocolAPI(false) emitter feature to generate:
//   - Internal flat-param protocol method
//   - Public convenience method: MethodName(OptionsModel options, CancellationToken)
// Required params (path/body) become constructor args; optional become properties.
// =============================================================================

// =============================================================================
// OPTIONS MODELS
// =============================================================================

// --- Item Point Options ---
/** Options for item point query operations. */
@added(Versions.v2026_04_15)
model GetItemPointOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /** Longitude. */
  @path longitude: float32;

  /** Latitude. */
  @path latitude: float32;

  ...AssetQueryParameters;
  ...SubDatasetQueryParameters;

  /** Coordinate Reference System of the input coords. Default to `epsg:4326`. */
  @query("coord_crs") coordinateReferenceSystem?: string;

  /** Resampling method. */
  @query("resampling") resampling?: Resampling = Resampling.nearest;
}

// --- Item TileJSON Options (no TMS in path) ---
/** Options for item TileJSON metadata operations. */
@added(Versions.v2026_04_15)
model GetItemTileJsonOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad'). */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** The format of the output tile image. */
  @query("tile_format") tileFormat?: TilerImageFormat;

  /** Tile scale factor affecting output size. */
  @query("tile_scale") tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

// --- Item TileJSON By TMS Options (TMS in path) ---
/** Options for item TileJSON metadata operations with TileMatrixSetId as path. */
@added(Versions.v2026_04_15)
model GetItemTileJsonByTmsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /** Identifier selecting one of the TileMatrixSetId supported. */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /** The format of the output tile image. */
  @query("tile_format") tileFormat?: TilerImageFormat;

  /** Tile scale factor affecting output size. */
  @query("tile_scale") tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

// --- Collection TileJSON Options (no TMS in path) ---
/** Options for collection-level TileJSON metadata operations. */
@added(Versions.v2026_04_15)
model GetCollectionTileJsonOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad'). */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** The format of the output tile image. */
  @query("tile_format") tileFormat?: TilerImageFormat;

  /** Tile scale factor affecting output size. */
  @query("tile_scale") tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

// --- Collection TileJSON By TMS Options (TMS in path) ---
/** Options for collection-level TileJSON with TileMatrixSetId as path. */
@added(Versions.v2026_04_15)
model GetCollectionTileJsonByTmsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** Identifier selecting one of the TileMatrixSetId supported. */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /** The format of the output tile image. */
  @query("tile_format") tileFormat?: TilerImageFormat;

  /** Tile scale factor affecting output size. */
  @query("tile_scale") tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

// --- Search TileJSON Options (no TMS in path) ---
/** Options for search-based TileJSON metadata operations. */
@added(Versions.v2026_04_15)
model GetSearchTileJsonOptions {
  /** Search Id (pgSTAC Search Hash). */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad'). */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** The format of the output tile image. */
  @query("tile_format") tileFormat?: TilerImageFormat;

  /** Tile scale factor affecting output size. */
  @query("tile_scale") tileScale?: int32;

  ...ZoomQueryParameters;

  /** Padding to apply to each tile edge. */
  @query padding?: int32;

  /** Buffer on each side of the given tile. */
  @query("buffer") buffer?: float32;

  /** rio-color formula. */
  @query("color_formula") colorFormula?: string;

  /** STAC Collection ID. */
  @query("collection") collectionId?: string;

  /** Resampling method. */
  @query("resampling") resampling?: Resampling = Resampling.nearest;

  /** Pixel selection method. */
  @query("pixel_selection")
  pixelSelection?: PixelSelection = PixelSelection.first;

  /** Terrain algorithm name. */
  @query("algorithm") algorithm?: TerrainAlgorithm;

  /** Terrain algorithm parameters. */
  @query("algorithm_params") algorithmParams?: string;

  /** Rescale ranges. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true }) rescale?: string[];

  /** Colormap name. */
  @query("colormap_name") colormapName?: ColorMapNames;

  /** JSON encoded custom Colormap. */
  @query("colormap") colormap?: string;

  /** Add mask to the output data. */
  @query("return_mask") returnMask?: boolean = true;
}

// --- Search TileJSON By TMS Options (TMS in path) ---
/** Options for search-based TileJSON with TileMatrixSetId as path. */
@added(Versions.v2026_04_15)
model GetSearchTileJsonByTmsOptions {
  /** Search Id (pgSTAC Search Hash). */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /** Identifier selecting one of the TileMatrixSetId supported. */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /** The format of the output tile image. */
  @query("tile_format") tileFormat?: TilerImageFormat;

  /** Tile scale factor affecting output size. */
  @query("tile_scale") tileScale?: int32;

  ...ZoomQueryParameters;
  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

// --- Collection Point Options ---
/** Options for collection-level point query operations. */
@added(Versions.v2026_04_15)
model GetCollectionPointOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** Longitude. */
  @path longitude: float32;

  /** Latitude. */
  @path latitude: float32;

  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...AssetQueryParameters;

  /** Coordinate Reference System of the input coords. Default to `epsg:4326`. */
  @query("coord_crs") coordinateReferenceSystem?: string;

  /** Resampling method. */
  @query("resampling") resampling?: Resampling = Resampling.nearest;
}

// --- Search Point Options ---
/** Options for search-based point query operations. */
@added(Versions.v2026_04_15)
model GetSearchPointOptions {
  /** Search Id (pgSTAC Search Hash). */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /** Longitude. */
  @path longitude: float32;

  /** Latitude. */
  @path latitude: float32;

  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...AssetQueryParameters;

  /** Coordinate Reference System of the input coords. Default to `epsg:4326`. */
  @query("coord_crs") coordinateReferenceSystem?: string;

  /** Resampling method. */
  @query("resampling") resampling?: Resampling = Resampling.nearest;
}

// --- Item Statistics Options ---
/** Options for item merged statistics operations. */
@added(Versions.v2026_04_15)
model GetItemStatisticsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...AssetQueryParameters;
  ...StatisticsQueryParameters;
  ...SubDatasetQueryParameters;

  /** Algorithm name. */
  @query("algorithm") algorithm?: string;

  /** Algorithm parameter. */
  @query("algorithm_params") algorithmParams?: string;

  /** Force output image height. */
  @query("height") height?: int32;

  /** Force output image width. */
  @query("width") width?: int32;
}

// --- Item Asset Statistics Options ---
/** Options for item per-asset statistics operations. */
@added(Versions.v2026_04_15)
model GetItemAssetStatisticsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /** Dataset band indexes. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true }) bidx?: int32[];

  /** Asset's names. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true }) assets?: string[];

  /** Per asset band indexes. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query("asset_bidx") assetBandIndices?: string[];

  /** Overwrite internal Nodata value. */
  @query("nodata") noData?: string;

  /** Apply internal Scale or Offset. */
  @query("unscale") unscale?: boolean;

  /** WarpKernel resampling algorithm (only used when doing re-projection). */
  @query("reproject") reproject?: WarpKernelResampling;

  ...StatisticsQueryParameters;
  ...SubDatasetQueryParameters;

  /** Per asset band expression. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query("asset_expression")
  @query(#{ explode: true })
  assetExpression?: string[];

  /** Force output image height. */
  @query("height") height?: int32;

  /** Force output image width. */
  @query("width") width?: int32;
}

// --- Item Feature Statistics Options ---
/** Options for item GeoJSON feature statistics operations. */
@added(Versions.v2026_04_15)
model GetItemFeatureStatisticsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /** Request GeoJson body. */
  @body body: Feature;

  ...AssetQueryParameters;

  /** Coordinate Reference System of the input coords. Default to `epsg:4326`. */
  @query("coord_crs") coordinateReferenceSystem?: string;

  ...StatisticsQueryParameters;
  ...DstCrsQueryParameter;
  ...SubDatasetQueryParameters;

  /** Algorithm name. */
  @query("algorithm") algorithm?: string;

  /** Algorithm parameter. */
  @query("algorithm_params") algorithmParams?: string;

  /** Force output image height. */
  @query("height") height?: int32;

  /** Force output image width. */
  @query("width") width?: int32;
}

// --- Collection Tilesets Options ---
/** Options for collection tileset list operations. */
@added(Versions.v2026_04_15)
model GetCollectionTilesetsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
}

// --- Collection Tileset Metadata Options ---
/** Options for collection tileset metadata operations. */
@added(Versions.v2026_04_15)
model GetCollectionTilesetMetadataOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** Identifier selecting one of the TileMatrixSetId supported. */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
}

// --- Item Tilesets Options (shared: GetTilesets, GetItemBounds) ---
/** Options for item tileset list and bounds operations. */
@added(Versions.v2026_04_15)
model GetItemTilesetsOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...SubDatasetQueryParameters;
}

// --- Item Tileset Metadata Options ---
/** Options for item tileset metadata operations. */
@added(Versions.v2026_04_15)
model GetItemTilesetMetadataOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /** Identifier selecting one of the TileMatrixSetId supported. */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...SubDatasetQueryParameters;
}

// --- Item Info Options (shared: GetItemInfo, GetItemInfoGeoJson) ---
/** Options for item info operations. */
@added(Versions.v2026_04_15)
model GetItemInfoOptions {
  /** STAC Collection Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /** STAC Item Identifier. */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...SubDatasetQueryParameters;

  /** Asset's names. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query(#{ explode: true }) assets?: string[];
}

// --- Search Tilesets Options ---
/** Options for search tileset list operations. */
@added(Versions.v2026_04_15)
model GetSearchTilesetsOptions {
  /** Search Id (pgSTAC Search Hash). */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...SubDatasetQueryParameters;
}

// --- Search Tileset Metadata Options ---
/** Options for search tileset metadata operations. */
@added(Versions.v2026_04_15)
model GetSearchTilesetMetadataOptions {
  /** Search Id (pgSTAC Search Hash). */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /** Identifier selecting one of the TileMatrixSetId supported. */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...SubDatasetQueryParameters;
}

// =============================================================================
// OVERRIDE OPERATIONS
// Each custom op takes ApiVersionParameter + the options model.
// =============================================================================

/** Get point value for a STAC item dataset. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemPointOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item point query. */
  options: GetItemPointOptions,
): TilerCoreModelsResponsesPoint;

/** Return TileJSON document for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemTileJsonOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item TileJSON query. */
  options: GetItemTileJsonOptions,
): TileJsonMetadata;

/** Return TileJSON document for a STAC item with TileMatrixSetId as path. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemTileJsonByTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item TileJSON by TMS query. */
  options: GetItemTileJsonByTmsOptions,
): TileJsonMetadata;

/** Return TileJSON document for a STAC collection. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileJsonOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the collection TileJSON query. */
  options: GetCollectionTileJsonOptions,
): TileJsonMetadata;

/** Return TileJSON document for a STAC collection with TileMatrixSetId as path. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileJsonByTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the collection TileJSON by TMS query. */
  options: GetCollectionTileJsonByTmsOptions,
): TileJsonMetadata;

/** Return TileJSON document for a mosaic search. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileJsonOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the search TileJSON query. */
  options: GetSearchTileJsonOptions,
): TileJsonMetadata;

/** Return TileJSON document for a mosaic search with TileMatrixSetId as path. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileJsonByTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the search TileJSON by TMS query. */
  options: GetSearchTileJsonByTmsOptions,
): TileJsonMetadata;

/** Get point value for a collection dataset. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionPointOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the collection point query. */
  options: GetCollectionPointOptions,
): TilerCoreModelsResponsesPoint;

/** Get point value for a search dataset. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchPointOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the search point query. */
  options: GetSearchPointOptions,
): TilerCoreModelsResponsesPoint;

/** Merged assets statistics for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemStatisticsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item statistics query. */
  options: GetItemStatisticsOptions,
): TilerStacItemStatistics;

/** Per asset statistics for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemAssetStatisticsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item asset statistics query. */
  options: GetItemAssetStatisticsOptions,
): AssetStatisticsResponse;

/** Get statistics from a GeoJSON feature for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemFeatureStatisticsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item feature statistics query. */
  options: GetItemFeatureStatisticsOptions,
): StacItemStatisticsGeoJson;

/** Return a list of available tilesets for a STAC collection. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTilesetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the collection tilesets query. */
  options: GetCollectionTilesetsOptions,
): TileSetList;

/** Return metadata for a specific tileset of a STAC collection. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTilesetMetadataOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the collection tileset metadata query. */
  options: GetCollectionTilesetMetadataOptions,
): TileSetMetadata;

/** Return a list of available tilesets for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemTilesetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item tilesets query. */
  options: GetItemTilesetsOptions,
): TileSetList;

/** Return metadata for a specific tileset of a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemTilesetMetadataOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item tileset metadata query. */
  options: GetItemTilesetMetadataOptions,
): TileSetMetadata;

/** Return dataset's basic info for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemInfoOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item info query. */
  options: GetItemInfoOptions,
): TilerInfoMapResponse;

/** Return info as GeoJSON for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemInfoGeoJsonOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item info GeoJSON query. */
  options: GetItemInfoOptions,
): TilerInfoGeoJsonFeature;

/** Return the bounds for a STAC item. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemBoundsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the item bounds query. */
  options: GetItemTilesetsOptions,
): StacItemBounds;

/** Return a list of available tilesets for a mosaic search. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTilesetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the search tilesets query. */
  options: GetSearchTilesetsOptions,
): TileSetList;

/** Return metadata for a specific tileset of a mosaic search. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTilesetMetadataOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the search tileset metadata query. */
  options: GetSearchTilesetMetadataOptions,
): TileSetMetadata;

// =============================================================================
// @@override + @@protocolAPI: Wire options bag overrides for C#
// =============================================================================

// Item Point
@@override(MosaicItemsPoint.getPoint, getItemPointOverride, "csharp");
@@protocolAPI(MosaicItemsPoint.getPoint, false, "csharp");

// Item TileJSON
@@override(MosaicItemsTileJson.get, getItemTileJsonOverride, "csharp");
@@protocolAPI(MosaicItemsTileJson.get, false, "csharp");

// Item TileJSON By TMS
@@override(
  MosaicItemsTileMatrixSetsTileJson.get,
  getItemTileJsonByTmsOverride,
  "csharp"
);
@@protocolAPI(MosaicItemsTileMatrixSetsTileJson.get, false, "csharp");

// Collection TileJSON
@@override(
  MosaicCollectionsTileJson.get,
  getCollectionTileJsonOverride,
  "csharp"
);
@@protocolAPI(MosaicCollectionsTileJson.get, false, "csharp");

// Collection TileJSON By TMS
@@override(
  MosaicCollectionsTileMatrixSetsTileJson.get,
  getCollectionTileJsonByTmsOverride,
  "csharp"
);
@@protocolAPI(MosaicCollectionsTileMatrixSetsTileJson.get, false, "csharp");

// Search TileJSON
@@override(MosaicSearchesTileJson.get, getSearchTileJsonOverride, "csharp");
@@protocolAPI(MosaicSearchesTileJson.get, false, "csharp");

// Search TileJSON By TMS
@@override(
  MosaicSearchesTileMatrixSetsTileJson.get,
  getSearchTileJsonByTmsOverride,
  "csharp"
);
@@protocolAPI(MosaicSearchesTileMatrixSetsTileJson.get, false, "csharp");

// Collection Point
@@override(
  MosaicCollectionsPoint.getPoint,
  getCollectionPointOverride,
  "csharp"
);
@@protocolAPI(MosaicCollectionsPoint.getPoint, false, "csharp");

// Search Point
@@override(MosaicSearchesPoint.getPoint, getSearchPointOverride, "csharp");
@@protocolAPI(MosaicSearchesPoint.getPoint, false, "csharp");

// Item Statistics
@@override(MosaicItemsStatistics.getAll, getItemStatisticsOverride, "csharp");
@@protocolAPI(MosaicItemsStatistics.getAll, false, "csharp");

// Item Asset Statistics
@@override(
  MosaicItemsAssetStatistics.getAll,
  getItemAssetStatisticsOverride,
  "csharp"
);
@@protocolAPI(MosaicItemsAssetStatistics.getAll, false, "csharp");

// Item Feature Statistics
@@override(
  MosaicItemsGeoJsonStatistics.get,
  getItemFeatureStatisticsOverride,
  "csharp"
);
@@protocolAPI(MosaicItemsGeoJsonStatistics.get, false, "csharp");

// Collection Tilesets
@@override(
  MosaicCollectionsTileSetList.get,
  getCollectionTilesetsOverride,
  "csharp"
);
@@protocolAPI(MosaicCollectionsTileSetList.get, false, "csharp");

// Collection Tileset Metadata
@@override(
  MosaicCollectionsTileSetMetadata.get,
  getCollectionTilesetMetadataOverride,
  "csharp"
);
@@protocolAPI(MosaicCollectionsTileSetMetadata.get, false, "csharp");

// Item Tilesets (getTilesets)
@@override(MosaicItemsTileSetList.get, getItemTilesetsOverride, "csharp");
@@protocolAPI(MosaicItemsTileSetList.get, false, "csharp");

// Item Tileset Metadata (getTilesetMetadata)
@@override(
  MosaicItemsTileSetMetadata.get,
  getItemTilesetMetadataOverride,
  "csharp"
);
@@protocolAPI(MosaicItemsTileSetMetadata.get, false, "csharp");

// Item Info
@@override(MosaicItemsInfo.get, getItemInfoOverride, "csharp");
@@protocolAPI(MosaicItemsInfo.get, false, "csharp");

// Item Info GeoJson
@@override(MosaicItemsInfoGeoJson.get, getItemInfoGeoJsonOverride, "csharp");
@@protocolAPI(MosaicItemsInfoGeoJson.get, false, "csharp");

// Item Bounds
@@override(MosaicItemsBounds.getAll, getItemBoundsOverride, "csharp");
@@protocolAPI(MosaicItemsBounds.getAll, false, "csharp");

// Search Tilesets
@@override(MosaicSearchesTileSetList.get, getSearchTilesetsOverride, "csharp");
@@protocolAPI(MosaicSearchesTileSetList.get, false, "csharp");

// Search Tileset Metadata
@@override(
  MosaicSearchesTileSetMetadata.get,
  getSearchTilesetMetadataOverride,
  "csharp"
);
@@protocolAPI(MosaicSearchesTileSetMetadata.get, false, "csharp");

// =============================================================================
// Suppress convenience methods for operations returning Response<BinaryData>.
// Keep protocol-only overload; typed convenience can be added later.
// =============================================================================

// Item Tiles
@@convenientAPI(Data.getTile, false, "csharp");
@@convenientAPI(Data.getTileByFormat, false, "csharp");
@@convenientAPI(Data.getTileByScale, false, "csharp");
@@convenientAPI(Data.getTileByScaleAndFormat, false, "csharp");
@@convenientAPI(Data.getTileNoTms, false, "csharp");
@@convenientAPI(Data.getTileNoTmsByFormat, false, "csharp");
@@convenientAPI(Data.getTileNoTmsByScale, false, "csharp");
@@convenientAPI(Data.getTileNoTmsByScaleAndFormat, false, "csharp");

// Item Preview
@@convenientAPI(Data.getItemPreview, false, "csharp");
@@convenientAPI(Data.getItemPreviewWithFormat, false, "csharp");

// Item BboxCrop
@@convenientAPI(Data.getItemBboxCrop, false, "csharp");
@@convenientAPI(Data.getItemBboxCropWithDimensions, false, "csharp");

// Item CropFeature
@@convenientAPI(Data.cropFeature, false, "csharp");
@@convenientAPI(Data.cropFeatureByFormat, false, "csharp");
@@convenientAPI(Data.cropFeatureWidthByHeight, false, "csharp");

// Item WMTS
@@convenientAPI(Data.getItemWmtsCapabilities, false, "csharp");
@@convenientAPI(Data.getItemWmtsCapabilitiesByTms, false, "csharp");

// Collection Tiles
@@convenientAPI(Data.getCollectionTile, false, "csharp");
@@convenientAPI(Data.getCollectionTileByFormat, false, "csharp");
@@convenientAPI(Data.getCollectionTileByScale, false, "csharp");
@@convenientAPI(Data.getCollectionTileByScaleAndFormat, false, "csharp");
@@convenientAPI(Data.getCollectionTileNoTms, false, "csharp");
@@convenientAPI(Data.getCollectionTileNoTmsByFormat, false, "csharp");
@@convenientAPI(Data.getCollectionTileNoTmsByScale, false, "csharp");
@@convenientAPI(Data.getCollectionTileNoTmsByScaleAndFormat, false, "csharp");

// Collection BboxCrop
@@convenientAPI(Data.getCollectionBboxCrop, false, "csharp");
@@convenientAPI(Data.getCollectionBboxCropWithDimensions, false, "csharp");

// Collection CropFeature
@@convenientAPI(Data.cropCollectionFeature, false, "csharp");
@@convenientAPI(Data.cropCollectionFeatureByFormat, false, "csharp");
@@convenientAPI(Data.cropCollectionFeatureWidthByHeight, false, "csharp");

// Collection WMTS
@@convenientAPI(Data.getCollectionWmtsCapabilities, false, "csharp");
@@convenientAPI(Data.getCollectionWmtsCapabilitiesByTms, false, "csharp");

// Search Tiles
@@convenientAPI(Data.getSearchTile, false, "csharp");
@@convenientAPI(Data.getSearchTileByFormat, false, "csharp");
@@convenientAPI(Data.getSearchTileByScale, false, "csharp");
@@convenientAPI(Data.getSearchTileByScaleAndFormat, false, "csharp");
@@convenientAPI(Data.getSearchTileNoTms, false, "csharp");
@@convenientAPI(Data.getSearchTileNoTmsByFormat, false, "csharp");
@@convenientAPI(Data.getSearchTileNoTmsByScale, false, "csharp");
@@convenientAPI(Data.getSearchTileNoTmsByScaleAndFormat, false, "csharp");

// Search BboxCrop
@@convenientAPI(Data.getSearchBboxCrop, false, "csharp");
@@convenientAPI(Data.getSearchBboxCropWithDimensions, false, "csharp");

// Search CropFeature
@@convenientAPI(Data.cropSearchFeature, false, "csharp");
@@convenientAPI(Data.cropSearchFeatureByFormat, false, "csharp");
@@convenientAPI(Data.cropSearchFeatureWidthByHeight, false, "csharp");

// Search WMTS
@@convenientAPI(Data.getSearchWmtsCapabilities, false, "csharp");
@@convenientAPI(Data.getSearchWmtsCapabilitiesByTms, false, "csharp");

// Legend (returns PNG image)
@@convenientAPI(Data.getLegend, false, "csharp");

// Collection Thumbnail
@@convenientAPI(Stac.getCollectionThumbnail, false, "csharp");
