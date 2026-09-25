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
@@clientName(TerrainAlgorithm.terrainrgb, "TerrainRgb", "csharp");
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
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

  /** Request GeoJson body. */
  @body body: Feature,

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

// ============================================================================
// Grouped-parameter overrides for protocol-only operations (microsoft/typespec#11214)
// ============================================================================

/** Options for the `getTile` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileByFormatOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileByScale` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileByScaleOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileByScaleAndFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileByScaleAndFormatOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileNoTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileNoTmsOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...ZxyPathParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileNoTmsByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileNoTmsByFormatOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...ZxyPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileNoTmsByScale` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileNoTmsByScaleOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getTileNoTmsByScaleAndFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetTileNoTmsByScaleAndFormatOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...ZxyPathParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getItemPreview` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemPreviewOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp).
   */
  @query("format")
  format?: TilerImageFormat;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  dstCrs?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 1024;

  ...DimensionsQueryParameters;
  ...MiscTileQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getItemPreviewWithFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemPreviewWithFormatOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  dstCrs?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 1024;

  ...DimensionsQueryParameters;
  ...MiscTileQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getItemBboxCrop` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemBboxCropOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...BoundingBoxPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  destinationCrs?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MiscTileQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getItemBboxCropWithDimensions` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemBboxCropWithDimensionsOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...BoundingBoxPathParameters;

  /**
   * Force output image width
   */
  @path
  width: int32;

  /**
   * Force output image height
   */
  @path
  height: int32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  destinationCrs?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...MiscTileQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `cropFeature` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropFeatureOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
  ...SubDatasetQueryParameters;

  /**
   * Output image format.
   */
  @query("format")
  format?: TilerImageFormat;
}

/** Options for the `cropFeatureByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropFeatureByFormatOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
  ...SubDatasetQueryParameters;
}

/** Options for the `cropFeatureWidthByHeight` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropFeatureWidthByHeightOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Width in pixels for the output image.
   */
  @path
  width: int32;

  /**
   * Height in pixels for the output image.
   */
  @path
  height: int32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
  ...SubDatasetQueryParameters;
}

/** Options for the `getItemWmtsCapabilities` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemWmtsCapabilitiesOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /**
   * Output image type. Default is png.
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat = TilerImageFormat.png;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @query("tile_scale")
  tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getItemWmtsCapabilitiesByTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemWmtsCapabilitiesByTmsOptions {
  ...AssetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  /**
   * Output image type. Default is png.
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat = TilerImageFormat.png;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @query("tile_scale")
  tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...TileMatrixSetQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
  ...SubDatasetQueryParameters;
}

/** Options for the `getCollectionTile` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileByFormatOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileByScale` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileByScaleOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileByScaleAndFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileByScaleAndFormatOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileNoTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileNoTmsOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileNoTmsByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileNoTmsByFormatOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileNoTmsByScale` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileNoTmsByScaleOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionTileNoTmsByScaleAndFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionTileNoTmsByScaleAndFormatOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles (default: "1")
   */
  @path
  scale: float32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp) (default: "png").
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getCollectionBboxCrop` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionBboxCropOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...BoundingBoxPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  destinationCrs?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
}

/** Options for the `getCollectionBboxCropWithDimensions` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionBboxCropWithDimensionsOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...BoundingBoxPathParameters;

  /**
   * Force output image width
   */
  @path
  width: int32;

  /**
   * Force output image height
   */
  @path
  height: int32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  destinationCrs?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
}

/** Options for the `cropCollectionFeature` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropCollectionFeatureOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;

  /**
   * Output image format.
   */
  @query("format")
  format?: TilerImageFormat;
}

/** Options for the `cropCollectionFeatureByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropCollectionFeatureByFormatOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
}

/** Options for the `cropCollectionFeatureWidthByHeight` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropCollectionFeatureWidthByHeightOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Width in pixels for the output image.
   */
  @path
  width: int32;

  /**
   * Height in pixels for the output image.
   */
  @path
  height: int32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
}

/** Options for the `getCollectionWmtsCapabilities` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionWmtsCapabilitiesOptions {
  ...CollectionMosaicFilterQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /**
   * Output image type. Default is png.
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat = TilerImageFormat.png;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @query("tile_scale")
  tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...AssetQueryParameters;
}

/** Options for the `getCollectionWmtsCapabilitiesByTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionWmtsCapabilitiesByTmsOptions {
  ...CollectionMosaicFilterQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  /**
   * Output image type. Default is png.
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat = TilerImageFormat.png;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @query("tile_scale")
  tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...AssetQueryParameters;
}

/** Options for the `getSearchTile` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileByFormatOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileByScale` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileByScaleOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileByScaleAndFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileByScaleAndFormatOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path
  scale: float32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileNoTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileNoTmsOptions {
  /** Search Id (pgSTAC Search Hash) */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileNoTmsByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileNoTmsByFormatOptions {
  /** Search Id (pgSTAC Search Hash) */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @query("scale")
  scale?: int32;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileNoTmsByScale` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileNoTmsByScaleOptions {
  /** Search Id (pgSTAC Search Hash) */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @path scale: float32;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @query("format")
  format?: TilerImageFormat;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchTileNoTmsByScaleAndFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchTileNoTmsByScaleAndFormatOptions {
  /** Search Id (pgSTAC Search Hash) */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;
  ...ZxyPathParameters;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /** Numeric scale factor for the tile. Higher values produce larger tiles */
  @path scale: float32;

  /** Output format for the tile or image (e.g., png, jpeg, webp) */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  ...MosaicTileQueryParameters;
  ...MiscTileQueryParameters;
  ...TilePaddingQueryParameters;
}

/** Options for the `getSearchBboxCrop` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchBboxCropOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...BoundingBoxPathParameters;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  destinationCrs?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
}

/** Options for the `getSearchBboxCropWithDimensions` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchBboxCropWithDimensionsOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...BoundingBoxPathParameters;

  /**
   * Force output image width
   */
  @path
  width: int32;

  /**
   * Force output image height
   */
  @path
  height: int32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst_crs")
  destinationCrs?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
}

/** Options for the `cropSearchFeature` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropSearchFeatureOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;

  /**
   * Output image format.
   */
  @query("format")
  format?: TilerImageFormat;
}

/** Options for the `cropSearchFeatureByFormat` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropSearchFeatureByFormatOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...DimensionsQueryParameters;
  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
}

/** Options for the `cropSearchFeatureWidthByHeight` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model CropSearchFeatureWidthByHeightOptions {
  ...AssetQueryParameters;
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...TerrainAlgorithmQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Width in pixels for the output image.
   */
  @path
  width: int32;

  /**
   * Height in pixels for the output image.
   */
  @path
  height: int32;

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  format: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @maxValue(2048)
  @query("max_size")
  maxSize?: int32 = 2048;

  ...MosaicCropQueryParameters;
  ...MiscTileQueryParameters;
  ...DstCrsQueryParameter;
}

/** Options for the `getSearchWmtsCapabilities` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchWmtsCapabilitiesOptions {
  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;

  /**
   * Output image type. Default is png.
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat = TilerImageFormat.png;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @maxValueExclusive(4)
  @query("tile_scale")
  tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...AssetQueryParameters;
}

/** Options for the `getSearchWmtsCapabilitiesByTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchWmtsCapabilitiesByTmsOptions {
  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  /**
   * Output image type. Default is png.
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat = TilerImageFormat.png;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @maxValueExclusive(4)
  @query("tile_scale")
  tileScale?: int32 = 1;

  ...ZoomQueryParameters;
  ...AssetQueryParameters;
}

/** Options for the `getLegend` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetLegendOptions {
  /**
   * The name of the registered colormap to generate a legend for
   */
  @path
  @maxLength(500)
  @pattern(".*")
  colorMapName: string;

  /**
   * The output height of the legend image
   */
  @query("height")
  height?: float32 = 0.15;

  /**
   * The output width of the legend image
   */
  @query("width")
  width?: float32 = 5;

  /**
   * Number of items to trim from the start of the cmap
   */
  @query("trim_start")
  trimStart?: int32;

  /**
   * Number of items to trim from the end of the cmap
   */
  @query("trim_end")
  trimEnd?: int32;
}

/** Options for the `getCollectionThumbnail` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionThumbnailOptions {
  /**
   * STAC Collection ID
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;
}

/** Options for the `getItemAvailableAssets` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemAvailableAssetsOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * STAC Item Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  itemId: string;

  ...SubDatasetQueryParameters;
}

/** Options for the `getCollectionAssetsForTile` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionAssetsForTileOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  ...ZxyPathParameters;
}

/** Options for the `getCollectionAssetsForTileNoTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionAssetsForTileNoTmsOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...ZxyPathParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported (default:
   * 'WebMercatorQuad')
   */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;
}

/** Options for the `getCollectionAssetsForBbox` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionAssetsForBboxOptions {
  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;
  ...BoundingBoxPathParameters;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;
}

/** Options for the `getCollectionPointAssets` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetCollectionPointAssetsOptions {
  ...MosaicSearchQueryParameters;
  ...CollectionMosaicFilterQueryParameters;
  ...CollectionSubDatasetQueryParameters;

  /**
   * STAC Collection Identifier
   */
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * Longitude
   */
  @path
  longitude: float32;

  /**
   * Latitude
   */
  @path
  latitude: float32;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;
}

/** Options for the `getSearchAssetsForTile` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchAssetsForTileOptions {
  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path
  @maxLength(500)
  @pattern(".*")
  tileMatrixSetId: string;

  /**
   * STAC Collection Identifier
   */
  @query("collection")
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  ...ZxyPathParameters;
}

/** Options for the `getSearchBboxAssets` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchBboxAssetsOptions {
  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...BoundingBoxPathParameters;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;
}

/** Options for the `getSearchAssetsForTileNoTms` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchAssetsForTileNoTmsOptions {
  /** Search Id (pgSTAC Search Hash) */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;
  ...ZxyPathParameters;

  /** Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad') */
  @query("TileMatrixSetId")
  tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;
}

/** Options for the `getSearchPointWithAssets` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetSearchPointWithAssetsOptions {
  ...MosaicSearchQueryParameters;
  ...SubDatasetQueryParameters;

  /**
   * Search Id (pgSTAC Search Hash)
   */
  @path
  @maxLength(500)
  @pattern(".*")
  searchId: string;

  /**
   * Longitude
   */
  @path
  longitude: float32;

  /**
   * Latitude
   */
  @path
  latitude: float32;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord_crs")
  coordinateReferenceSystem?: string;
}

/** Grouped-parameter override for `getTile`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTile request. */
  options: GetTileOptions,
): TileResponse;

/** Grouped-parameter override for `getTileByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileByFormat request. */
  options: GetTileByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getTileByScale`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileByScaleOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileByScale request. */
  options: GetTileByScaleOptions,
): TileResponse;

/** Grouped-parameter override for `getTileByScaleAndFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileByScaleAndFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileByScaleAndFormat request. */
  options: GetTileByScaleAndFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getTileNoTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileNoTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileNoTms request. */
  options: GetTileNoTmsOptions,
): TileResponse;

/** Grouped-parameter override for `getTileNoTmsByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileNoTmsByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileNoTmsByFormat request. */
  options: GetTileNoTmsByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getTileNoTmsByScale`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileNoTmsByScaleOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileNoTmsByScale request. */
  options: GetTileNoTmsByScaleOptions,
): TileResponse;

/** Grouped-parameter override for `getTileNoTmsByScaleAndFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileNoTmsByScaleAndFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getTileNoTmsByScaleAndFormat request. */
  options: GetTileNoTmsByScaleAndFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getItemPreview`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemPreviewOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemPreview request. */
  options: GetItemPreviewOptions,
): TileResponse;

/** Grouped-parameter override for `getItemPreviewWithFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemPreviewWithFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemPreviewWithFormat request. */
  options: GetItemPreviewWithFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getItemBboxCrop`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemBboxCropOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemBboxCrop request. */
  options: GetItemBboxCropOptions,
): TileResponse;

/** Grouped-parameter override for `getItemBboxCropWithDimensions`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemBboxCropWithDimensionsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemBboxCropWithDimensions request. */
  options: GetItemBboxCropWithDimensionsOptions,
): TileResponse;

/** Grouped-parameter override for `cropFeature`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropFeatureOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropFeature request. */
  options: CropFeatureOptions,
): TileResponse;

/** Grouped-parameter override for `cropFeatureByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropFeatureByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropFeatureByFormat request. */
  options: CropFeatureByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `cropFeatureWidthByHeight`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropFeatureWidthByHeightOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropFeatureWidthByHeight request. */
  options: CropFeatureWidthByHeightOptions,
): TileResponse;

/** Grouped-parameter override for `getItemWmtsCapabilities`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemWmtsCapabilitiesOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemWmtsCapabilities request. */
  options: GetItemWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

/** Grouped-parameter override for `getItemWmtsCapabilitiesByTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemWmtsCapabilitiesByTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemWmtsCapabilitiesByTms request. */
  options: GetItemWmtsCapabilitiesByTmsOptions,
): WmtsCapabilitiesXmlResponse;

/** Grouped-parameter override for `getCollectionTile`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTile request. */
  options: GetCollectionTileOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileByFormat request. */
  options: GetCollectionTileByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileByScale`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileByScaleOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileByScale request. */
  options: GetCollectionTileByScaleOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileByScaleAndFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileByScaleAndFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileByScaleAndFormat request. */
  options: GetCollectionTileByScaleAndFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileNoTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileNoTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileNoTms request. */
  options: GetCollectionTileNoTmsOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileNoTmsByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileNoTmsByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileNoTmsByFormat request. */
  options: GetCollectionTileNoTmsByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileNoTmsByScale`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileNoTmsByScaleOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileNoTmsByScale request. */
  options: GetCollectionTileNoTmsByScaleOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionTileNoTmsByScaleAndFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionTileNoTmsByScaleAndFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionTileNoTmsByScaleAndFormat request. */
  options: GetCollectionTileNoTmsByScaleAndFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionBboxCrop`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionBboxCropOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionBboxCrop request. */
  options: GetCollectionBboxCropOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionBboxCropWithDimensions`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionBboxCropWithDimensionsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionBboxCropWithDimensions request. */
  options: GetCollectionBboxCropWithDimensionsOptions,
): TileResponse;

/** Grouped-parameter override for `cropCollectionFeature`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropCollectionFeatureOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropCollectionFeature request. */
  options: CropCollectionFeatureOptions,
): TileResponse;

/** Grouped-parameter override for `cropCollectionFeatureByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropCollectionFeatureByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropCollectionFeatureByFormat request. */
  options: CropCollectionFeatureByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `cropCollectionFeatureWidthByHeight`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropCollectionFeatureWidthByHeightOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropCollectionFeatureWidthByHeight request. */
  options: CropCollectionFeatureWidthByHeightOptions,
): TileResponse;

/** Grouped-parameter override for `getCollectionWmtsCapabilities`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionWmtsCapabilitiesOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionWmtsCapabilities request. */
  options: GetCollectionWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

/** Grouped-parameter override for `getCollectionWmtsCapabilitiesByTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionWmtsCapabilitiesByTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionWmtsCapabilitiesByTms request. */
  options: GetCollectionWmtsCapabilitiesByTmsOptions,
): WmtsCapabilitiesXmlResponse;

/** Grouped-parameter override for `getSearchTile`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTile request. */
  options: GetSearchTileOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileByFormat request. */
  options: GetSearchTileByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileByScale`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileByScaleOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileByScale request. */
  options: GetSearchTileByScaleOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileByScaleAndFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileByScaleAndFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileByScaleAndFormat request. */
  options: GetSearchTileByScaleAndFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileNoTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileNoTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileNoTms request. */
  options: GetSearchTileNoTmsOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileNoTmsByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileNoTmsByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileNoTmsByFormat request. */
  options: GetSearchTileNoTmsByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileNoTmsByScale`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileNoTmsByScaleOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileNoTmsByScale request. */
  options: GetSearchTileNoTmsByScaleOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchTileNoTmsByScaleAndFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchTileNoTmsByScaleAndFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchTileNoTmsByScaleAndFormat request. */
  options: GetSearchTileNoTmsByScaleAndFormatOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchBboxCrop`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchBboxCropOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchBboxCrop request. */
  options: GetSearchBboxCropOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchBboxCropWithDimensions`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchBboxCropWithDimensionsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchBboxCropWithDimensions request. */
  options: GetSearchBboxCropWithDimensionsOptions,
): TileResponse;

/** Grouped-parameter override for `cropSearchFeature`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropSearchFeatureOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropSearchFeature request. */
  options: CropSearchFeatureOptions,
): TileResponse;

/** Grouped-parameter override for `cropSearchFeatureByFormat`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropSearchFeatureByFormatOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropSearchFeatureByFormat request. */
  options: CropSearchFeatureByFormatOptions,
): TileResponse;

/** Grouped-parameter override for `cropSearchFeatureWidthByHeight`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropSearchFeatureWidthByHeightOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /**
   * Request GeoJson body.
   */
  @body
  body: Feature,

  /** The options for the cropSearchFeatureWidthByHeight request. */
  options: CropSearchFeatureWidthByHeightOptions,
): TileResponse;

/** Grouped-parameter override for `getSearchWmtsCapabilities`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchWmtsCapabilitiesOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchWmtsCapabilities request. */
  options: GetSearchWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

/** Grouped-parameter override for `getSearchWmtsCapabilitiesByTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchWmtsCapabilitiesByTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchWmtsCapabilitiesByTms request. */
  options: GetSearchWmtsCapabilitiesByTmsOptions,
): WmtsCapabilitiesXmlResponse;

/** Grouped-parameter override for `getLegend`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getLegendOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getLegend request. */
  options: GetLegendOptions,
): ImagePngResponse;

/** Grouped-parameter override for `getCollectionThumbnail`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionThumbnailOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionThumbnail request. */
  options: GetCollectionThumbnailOptions,
):
  | ImagePngResponse
  | ImageJpegResponse
  | ImageJpgResponse
  | ImageWebpResponse
  | ImageJp2Response
  | ImageTiffResponse
  | ApplicationXbinaryResponse;

/** Body-shaped override for `registerMosaicsSearch`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op registerMosaicsSearchOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The request body for the registerMosaicsSearch request. */
  @body body: RegisterMosaic,
): TilerMosaicSearchRegistrationResponse;

/** Grouped-parameter override for `getItemAvailableAssets`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemAvailableAssetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemAvailableAssets request. */
  options: GetItemAvailableAssetsOptions,
): AvailableAssets;

/** Grouped-parameter override for `getCollectionAssetsForTile`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionAssetsForTileOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionAssetsForTile request. */
  options: GetCollectionAssetsForTileOptions,
): TilerAssetGeoJson[];

/** Grouped-parameter override for `getCollectionAssetsForTileNoTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionAssetsForTileNoTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionAssetsForTileNoTms request. */
  options: GetCollectionAssetsForTileNoTmsOptions,
): ApplicationJsonResponse;

/** Grouped-parameter override for `getCollectionAssetsForBbox`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionAssetsForBboxOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionAssetsForBbox request. */
  options: GetCollectionAssetsForBboxOptions,
): ApplicationJsonResponse;

/** Grouped-parameter override for `getCollectionPointAssets`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getCollectionPointAssetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getCollectionPointAssets request. */
  options: GetCollectionPointAssetsOptions,
): StacItemPointAsset[];

/** Grouped-parameter override for `getSearchAssetsForTile`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchAssetsForTileOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchAssetsForTile request. */
  options: GetSearchAssetsForTileOptions,
): TilerAssetGeoJson[];

/** Grouped-parameter override for `getSearchBboxAssets`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchBboxAssetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchBboxAssets request. */
  options: GetSearchBboxAssetsOptions,
): ApplicationJsonResponse;

/** Grouped-parameter override for `getSearchAssetsForTileNoTms`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchAssetsForTileNoTmsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchAssetsForTileNoTms request. */
  options: GetSearchAssetsForTileNoTmsOptions,
): ApplicationJsonResponse;

/** Grouped-parameter override for `getSearchPointWithAssets`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getSearchPointWithAssetsOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getSearchPointWithAssets request. */
  options: GetSearchPointWithAssetsOptions,
): StacItemPointAsset[];

@@override(Data.getTile, getTileOverride, "csharp");
@@override(Data.getTileByFormat, getTileByFormatOverride, "csharp");
@@override(Data.getTileByScale, getTileByScaleOverride, "csharp");
@@override(
  Data.getTileByScaleAndFormat,
  getTileByScaleAndFormatOverride,
  "csharp"
);
@@override(Data.getTileNoTms, getTileNoTmsOverride, "csharp");
@@override(Data.getTileNoTmsByFormat, getTileNoTmsByFormatOverride, "csharp");
@@override(Data.getTileNoTmsByScale, getTileNoTmsByScaleOverride, "csharp");
@@override(
  Data.getTileNoTmsByScaleAndFormat,
  getTileNoTmsByScaleAndFormatOverride,
  "csharp"
);
@@override(Data.getItemPreview, getItemPreviewOverride, "csharp");
@@override(
  Data.getItemPreviewWithFormat,
  getItemPreviewWithFormatOverride,
  "csharp"
);
@@override(Data.getItemBboxCrop, getItemBboxCropOverride, "csharp");
@@override(
  Data.getItemBboxCropWithDimensions,
  getItemBboxCropWithDimensionsOverride,
  "csharp"
);
@@override(Data.cropFeature, cropFeatureOverride, "csharp");
@@override(Data.cropFeatureByFormat, cropFeatureByFormatOverride, "csharp");
@@override(
  Data.cropFeatureWidthByHeight,
  cropFeatureWidthByHeightOverride,
  "csharp"
);
@@override(
  Data.getItemWmtsCapabilities,
  getItemWmtsCapabilitiesOverride,
  "csharp"
);
@@override(
  Data.getItemWmtsCapabilitiesByTms,
  getItemWmtsCapabilitiesByTmsOverride,
  "csharp"
);
@@override(Data.getCollectionTile, getCollectionTileOverride, "csharp");
@@override(
  Data.getCollectionTileByFormat,
  getCollectionTileByFormatOverride,
  "csharp"
);
@@override(
  Data.getCollectionTileByScale,
  getCollectionTileByScaleOverride,
  "csharp"
);
@@override(
  Data.getCollectionTileByScaleAndFormat,
  getCollectionTileByScaleAndFormatOverride,
  "csharp"
);
@@override(
  Data.getCollectionTileNoTms,
  getCollectionTileNoTmsOverride,
  "csharp"
);
@@override(
  Data.getCollectionTileNoTmsByFormat,
  getCollectionTileNoTmsByFormatOverride,
  "csharp"
);
@@override(
  Data.getCollectionTileNoTmsByScale,
  getCollectionTileNoTmsByScaleOverride,
  "csharp"
);
@@override(
  Data.getCollectionTileNoTmsByScaleAndFormat,
  getCollectionTileNoTmsByScaleAndFormatOverride,
  "csharp"
);
@@override(Data.getCollectionBboxCrop, getCollectionBboxCropOverride, "csharp");
@@override(
  Data.getCollectionBboxCropWithDimensions,
  getCollectionBboxCropWithDimensionsOverride,
  "csharp"
);
@@override(Data.cropCollectionFeature, cropCollectionFeatureOverride, "csharp");
@@override(
  Data.cropCollectionFeatureByFormat,
  cropCollectionFeatureByFormatOverride,
  "csharp"
);
@@override(
  Data.cropCollectionFeatureWidthByHeight,
  cropCollectionFeatureWidthByHeightOverride,
  "csharp"
);
@@override(
  Data.getCollectionWmtsCapabilities,
  getCollectionWmtsCapabilitiesOverride,
  "csharp"
);
@@override(
  Data.getCollectionWmtsCapabilitiesByTms,
  getCollectionWmtsCapabilitiesByTmsOverride,
  "csharp"
);
@@override(Data.getSearchTile, getSearchTileOverride, "csharp");
@@override(Data.getSearchTileByFormat, getSearchTileByFormatOverride, "csharp");
@@override(Data.getSearchTileByScale, getSearchTileByScaleOverride, "csharp");
@@override(
  Data.getSearchTileByScaleAndFormat,
  getSearchTileByScaleAndFormatOverride,
  "csharp"
);
@@override(Data.getSearchTileNoTms, getSearchTileNoTmsOverride, "csharp");
@@override(
  Data.getSearchTileNoTmsByFormat,
  getSearchTileNoTmsByFormatOverride,
  "csharp"
);
@@override(
  Data.getSearchTileNoTmsByScale,
  getSearchTileNoTmsByScaleOverride,
  "csharp"
);
@@override(
  Data.getSearchTileNoTmsByScaleAndFormat,
  getSearchTileNoTmsByScaleAndFormatOverride,
  "csharp"
);
@@override(Data.getSearchBboxCrop, getSearchBboxCropOverride, "csharp");
@@override(
  Data.getSearchBboxCropWithDimensions,
  getSearchBboxCropWithDimensionsOverride,
  "csharp"
);
@@override(Data.cropSearchFeature, cropSearchFeatureOverride, "csharp");
@@override(
  Data.cropSearchFeatureByFormat,
  cropSearchFeatureByFormatOverride,
  "csharp"
);
@@override(
  Data.cropSearchFeatureWidthByHeight,
  cropSearchFeatureWidthByHeightOverride,
  "csharp"
);
@@override(
  Data.getSearchWmtsCapabilities,
  getSearchWmtsCapabilitiesOverride,
  "csharp"
);
@@override(
  Data.getSearchWmtsCapabilitiesByTms,
  getSearchWmtsCapabilitiesByTmsOverride,
  "csharp"
);
@@override(Data.getLegend, getLegendOverride, "csharp");
@@override(
  Stac.getCollectionThumbnail,
  getCollectionThumbnailOverride,
  "csharp"
);
@@override(Data.registerMosaicsSearch, registerMosaicsSearchOverride, "csharp");
@@override(
  Data.getItemAvailableAssets,
  getItemAvailableAssetsOverride,
  "csharp"
);
@@override(
  Data.getCollectionAssetsForTile,
  getCollectionAssetsForTileOverride,
  "csharp"
);
@@override(
  Data.getCollectionAssetsForTileNoTms,
  getCollectionAssetsForTileNoTmsOverride,
  "csharp"
);
@@override(
  Data.getCollectionAssetsForBbox,
  getCollectionAssetsForBboxOverride,
  "csharp"
);
@@override(
  Data.getCollectionPointAssets,
  getCollectionPointAssetsOverride,
  "csharp"
);
@@override(
  Data.getSearchAssetsForTile,
  getSearchAssetsForTileOverride,
  "csharp"
);
@@override(Data.getSearchBboxAssets, getSearchBboxAssetsOverride, "csharp");
@@override(
  Data.getSearchAssetsForTileNoTms,
  getSearchAssetsForTileNoTmsOverride,
  "csharp"
);
@@override(
  Data.getSearchPointWithAssets,
  getSearchPointWithAssetsOverride,
  "csharp"
);

/** Options for the `getItemCollection` operation. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
model GetItemCollectionOptions {
  @doc("Catalog collection id")
  @path
  @maxLength(500)
  @pattern(".*")
  collectionId: string;

  /**
   * The optional limit parameter recommends the number of items that should be present in the response document.
   *
   *  Minimum = 1. Maximum = 10000. Default = 10.
   */
  @query
  limit?: int32;

  /** Only features that have a geometry that intersects the bounding box are selected. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
  @query("bbox")
  @query(#{ explode: true })
  boundingBox?: string[];

  /** Either a date-time or an interval, open or closed. */
  @query
  datetime?: string;

  /** Whether to sign the asset urls. */
  @added(Versions.v2026_04_15)
  @query("sign")
  sign?: StacAssetUrlSigningMode;

  /** The duration in minutes for which the signed url is valid. */
  @added(Versions.v2026_04_15)
  @query("duration")
  durationInMinutes?: int32;

  /** The token to use for signing the asset urls. */
  @added(Versions.v2026_04_15)
  @query("token")
  token?: string;
}

/** Grouped-parameter override for `getItemCollection`. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getItemCollectionOverride(
  ...Azure.Core.Foundations.ApiVersionParameter,

  /** The options for the getItemCollection request. */
  options: GetItemCollectionOptions,
): StacItemCollection | Azure.Core.Foundations.ErrorResponse;

@@override(Stac.getItemCollection, getItemCollectionOverride, "csharp");

// === Mark options bags as input so they get public constructors ===
@@usage(GetTileOptions, Usage.input, "csharp");
@@usage(GetTileByFormatOptions, Usage.input, "csharp");
@@usage(GetTileByScaleOptions, Usage.input, "csharp");
@@usage(GetTileByScaleAndFormatOptions, Usage.input, "csharp");
@@usage(GetTileNoTmsOptions, Usage.input, "csharp");
@@usage(GetTileNoTmsByFormatOptions, Usage.input, "csharp");
@@usage(GetTileNoTmsByScaleOptions, Usage.input, "csharp");
@@usage(GetTileNoTmsByScaleAndFormatOptions, Usage.input, "csharp");
@@usage(GetItemPreviewOptions, Usage.input, "csharp");
@@usage(GetItemPreviewWithFormatOptions, Usage.input, "csharp");
@@usage(GetItemBboxCropOptions, Usage.input, "csharp");
@@usage(GetItemBboxCropWithDimensionsOptions, Usage.input, "csharp");
@@usage(CropFeatureOptions, Usage.input, "csharp");
@@usage(CropFeatureByFormatOptions, Usage.input, "csharp");
@@usage(CropFeatureWidthByHeightOptions, Usage.input, "csharp");
@@usage(GetItemWmtsCapabilitiesOptions, Usage.input, "csharp");
@@usage(GetItemWmtsCapabilitiesByTmsOptions, Usage.input, "csharp");
@@usage(GetCollectionTileOptions, Usage.input, "csharp");
@@usage(GetCollectionTileByFormatOptions, Usage.input, "csharp");
@@usage(GetCollectionTileByScaleOptions, Usage.input, "csharp");
@@usage(GetCollectionTileByScaleAndFormatOptions, Usage.input, "csharp");
@@usage(GetCollectionTileNoTmsOptions, Usage.input, "csharp");
@@usage(GetCollectionTileNoTmsByFormatOptions, Usage.input, "csharp");
@@usage(GetCollectionTileNoTmsByScaleOptions, Usage.input, "csharp");
@@usage(GetCollectionTileNoTmsByScaleAndFormatOptions, Usage.input, "csharp");
@@usage(GetCollectionBboxCropOptions, Usage.input, "csharp");
@@usage(GetCollectionBboxCropWithDimensionsOptions, Usage.input, "csharp");
@@usage(CropCollectionFeatureOptions, Usage.input, "csharp");
@@usage(CropCollectionFeatureByFormatOptions, Usage.input, "csharp");
@@usage(CropCollectionFeatureWidthByHeightOptions, Usage.input, "csharp");
@@usage(GetCollectionWmtsCapabilitiesOptions, Usage.input, "csharp");
@@usage(GetCollectionWmtsCapabilitiesByTmsOptions, Usage.input, "csharp");
@@usage(GetSearchTileOptions, Usage.input, "csharp");
@@usage(GetSearchTileByFormatOptions, Usage.input, "csharp");
@@usage(GetSearchTileByScaleOptions, Usage.input, "csharp");
@@usage(GetSearchTileByScaleAndFormatOptions, Usage.input, "csharp");
@@usage(GetSearchTileNoTmsOptions, Usage.input, "csharp");
@@usage(GetSearchTileNoTmsByFormatOptions, Usage.input, "csharp");
@@usage(GetSearchTileNoTmsByScaleOptions, Usage.input, "csharp");
@@usage(GetSearchTileNoTmsByScaleAndFormatOptions, Usage.input, "csharp");
@@usage(GetSearchBboxCropOptions, Usage.input, "csharp");
@@usage(GetSearchBboxCropWithDimensionsOptions, Usage.input, "csharp");
@@usage(CropSearchFeatureOptions, Usage.input, "csharp");
@@usage(CropSearchFeatureByFormatOptions, Usage.input, "csharp");
@@usage(CropSearchFeatureWidthByHeightOptions, Usage.input, "csharp");
@@usage(GetSearchWmtsCapabilitiesOptions, Usage.input, "csharp");
@@usage(GetSearchWmtsCapabilitiesByTmsOptions, Usage.input, "csharp");
@@usage(GetLegendOptions, Usage.input, "csharp");
@@usage(GetCollectionThumbnailOptions, Usage.input, "csharp");
@@usage(GetItemAvailableAssetsOptions, Usage.input, "csharp");
@@usage(GetCollectionAssetsForTileOptions, Usage.input, "csharp");
@@usage(GetCollectionAssetsForTileNoTmsOptions, Usage.input, "csharp");
@@usage(GetCollectionAssetsForBboxOptions, Usage.input, "csharp");
@@usage(GetCollectionPointAssetsOptions, Usage.input, "csharp");
@@usage(GetSearchAssetsForTileOptions, Usage.input, "csharp");
@@usage(GetSearchBboxAssetsOptions, Usage.input, "csharp");
@@usage(GetSearchAssetsForTileNoTmsOptions, Usage.input, "csharp");
@@usage(GetSearchPointWithAssetsOptions, Usage.input, "csharp");
@@usage(GetItemCollectionOptions, Usage.input, "csharp");
