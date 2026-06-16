import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

import "./main.tsp";

using Azure.ClientGenerator.Core;
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
// @@clientName(StacItemOrStacItemCollection,
//   "StacItemOrStacItemCollectionContent",
//   "csharp"
// );
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

// === Python snake_case parameter renames ===
@@clientName(CollectionMosaicFilterQueryParameters.sortby, "sort_by", "python");
@@clientName(BoundingBoxPathParameters.minx, "min_x", "python");
@@clientName(BoundingBoxPathParameters.miny, "min_y", "python");
@@clientName(BoundingBoxPathParameters.maxx, "max_x", "python");
@@clientName(BoundingBoxPathParameters.maxy, "max_y", "python");

// Disable convenient API for JSON-Merge patch operations
@@convenientAPI(Ingestions.update, false, "csharp,java");
@@convenientAPI(StacItems.update, false, "csharp,java");

// Workaround errors CS0019 and CS0019
@@alternateType(StacCollectionTemporalExtent.interval, string[][], "csharp");

// Change the WmtsCapabilitiesXmlResponse body type from bytes to string for JavaScript
@@alternateType(WmtsCapabilitiesXmlResponse.body, string, "javascript");

// Rename Ingestion.delete to deleteIngestion for JavaScript to avoid @fixme conflict
@@clientName(Ingestion.delete, "deleteIngestion", "javascript");

// === Python external type mappings ===
// NOTE: @@alternateType with ExternalType is currently broken for ALL models used
// in our API — not just @discriminator hierarchies. See:
// https://github.com/Azure/azure-sdk-for-python/issues/46020
// Feature, FeatureCollection, StacCollection, and all Geometry/STAC discriminated
// types are excluded until the pygen fix is released.

// Address naming convention violations for C# SDK
@@clientName(
  TilerMosaicSearchRegistrationResponse,
  "TilerMosaicSearchRegistrationResult",
  "csharp"
);

// Models ending with "Definition" - rename appropriately
@@clientName(IngestionDefinition, "IngestionInformation", "csharp");

// === Python API naming notes ===
// All Python method naming (searches→search, list→get, _by_tms, _by_format,
// geo_json removal) is now handled via interface member names below.
// Language-specific @@clientName overrides can be added here when other
// languages (C#, Java, JS) need different names from the Python defaults.

// Models ending with "Operation" - rename to "Info"
@@clientName(IngestionRunOperation, "IngestionRunInformation", "csharp");

// Generic single-word class names - add descriptive prefixes
@@clientName(Geometry, "GeoJsonGeometry", "csharp");
@@clientName(Feature, "GeoJsonFeature", "csharp");
@@clientName(Point, "PointGeometry", "csharp");
@@clientName(Polygon, "PolygonGeometry", "csharp");
@@clientName(Resampling, "ResamplingMethod", "csharp");
@@clientName(Operation, "LongRunningOperation", "csharp");

// Additional model renames for C#
@@clientName(RenderOption, "RenderConfiguration", "csharp");
@@clientName(StacCollection, "StacCollectionResource", "csharp");
@@clientName(StacItem, "StacItemResource", "csharp");
@@clientName(StacItemCollection, "StacItemCollectionResource", "csharp");

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
