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

// Disable convenient API for JSON-Merge patch operations
@@convenientAPI(Ingestions.update, false, "csharp,java");
@@convenientAPI(StacItems.update, false, "csharp,java");

// Workaround errors CS0019 and CS0019
@@alternateType(StacCollectionTemporalExtent.interval, string[][], "csharp");

// Change the WmtsCapabilitiesXmlResponse body type from bytes to string for JavaScript
@@alternateType(WmtsCapabilitiesXmlResponse.body, string, "javascript");

// === Python external type mappings ===
// NOTE: @@alternateType with ExternalType is currently broken for ALL models used
// in our API — not just @discriminator hierarchies. See:
// https://github.com/Azure/azure-sdk-for-python/issues/46020
// Feature, FeatureCollection, StacCollection, and all Geometry/STAC discriminated
// types are excluded until the pygen fix is released.

// Address naming convention violations for C# SDK
@@clientName(TilerMosaicSearchRegistrationResponse,
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
  listMosaics is StacCollectionMosaics.getAll;

  // STAC Collections
  createCollection is StacCollections.create;
  createOrReplaceCollection is StacCollections.createOrReplace;
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
  listRenderOptions is StacCollectionRenderOptions.getAll;

  // Collection Thumbnails
  getCollectionThumbnail is StacCollectionThumbnails.get;

  // Collection Tile Settings
  getTileSettings is StacCollectionTileSettings.get;
  replaceTileSettings is StacCollectionTileSettings.replace;

  // STAC Conformance
  getConformanceClass is StacConformanceClass.get;

  // STAC landing page
  getLandingPage is StacLandingPages.get;

  // STAC Items
  createItem is StacItems.create;
  createOrReplaceItem is StacItems.createOrReplace;
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
  listQueryables is StacQueryables.getAll;

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
  listTileMatrices is TileMatrixList.get;

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
  getTile is TilerTileMatrixSets.getZxyScaleByFormat;
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
  listTilesets is MosaicItemsTileSetList.get;
  @added(Versions.v2026_04_15)
  getTilesetMetadata is MosaicItemsTileSetMetadata.get;

  // Item Tile Variants (TileMatrixSetId as path)
  @added(Versions.v2026_04_15)
  getTilePlain is MosaicItemsTileMatrixSetsPlain.getZxy;
  @added(Versions.v2026_04_15)
  getTileByFormat is MosaicItemsTileMatrixSetsFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getTileByScale is MosaicItemsTileMatrixSetsScale.getZxyByScale;
  @added(Versions.v2026_04_15)
  getTileByScaleAndFormat is MosaicItemsTileMatrixSetsScaleByFormat.getZxyScaleByFormat;

  // Item Tile Variants (without TileMatrixSetId in path)
  @added(Versions.v2026_04_15)
  getTileNoTmsPlain is MosaicItemsTilesPlain.getZxy;
  @added(Versions.v2026_04_15)
  getTileNoTmsByFormat is MosaicItemsTilesFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getTileNoTmsByScale is MosaicItemsTilesScale.getZxyByScale;
  @added(Versions.v2026_04_15)
  getTileNoTmsByScaleAndFormat is MosaicItemsTilesScaleByFormat.getZxyScaleByFormat;

  // GeoJSON Feature (bare, no format)
  @added(Versions.v2026_04_15)
  cropFeatureGeoJson is MosaicItemsFeatureGeoJson.crop;

  // GeoJSON Feature Crop with format
  @added(Versions.v2026_04_15)
  cropFeatureGeoJsonFormat is MosaicItemsFeatureGeoJsonFormat.cropFormat;

  // GeoJSON Feature Crop with dimensions
  @added(Versions.v2026_04_15)
  cropFeatureGeoJsonWidthByHeight is MosaicItemsFeatureGeoJsonWidthByHeight.cropWidthByHeightFormat;

  // Item Bounds, Info, Assets
  @added(Versions.v2026_04_15)
  getItemBounds is MosaicItemsBounds.getAll;
  @added(Versions.v2026_04_15)
  getItemInfo is MosaicItemsInfo.get;
  @added(Versions.v2026_04_15)
  getItemInfoGeoJson is MosaicItemsInfoGeoJson.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  listItemAvailableAssets is MosaicItemsAvailableAssets.getAll;

  // Item Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  getItemAssetStatistics is MosaicItemsAssetStatistics.getAll;
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  listItemStatistics is MosaicItemsStatistics.getAll;
  @added(Versions.v2026_04_15)
  getItemGeoJsonStatistics is MosaicItemsGeoJsonStatistics.get;

  // Item TileJSON
  @added(Versions.v2026_04_15)
  getItemTileJson is MosaicItemsTileJson.get;
  @added(Versions.v2026_04_15)
  getItemTileJsonTms is MosaicItemsTileMatrixSetsTileJson.get;

  // Item WMTS
  @added(Versions.v2026_04_15)
  getItemWmtsCapabilities is MosaicItemsWmts.getCapabilitiesXml;
  @added(Versions.v2026_04_15)
  getItemWmtsCapabilitiesTms is MosaicItemsWmtsTileMatrixSets.getCapabilitiesXml;

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
  listCollectionTilesets is MosaicCollectionsTileSetList.get;
  @added(Versions.v2026_04_15)
  getCollectionTilesetMetadata is MosaicCollectionsTileSetMetadata.get;

  // Collection Tiles (TileMatrixSetId as path)
  @added(Versions.v2026_04_15)
  getCollectionTile is MosaicCollectionsTileMatrixSets.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTilePlain is MosaicCollectionsTileMatrixSetsPlain.getZxy;
  @added(Versions.v2026_04_15)
  getCollectionTileByFormat is MosaicCollectionsTileMatrixSetsFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTileByScale is MosaicCollectionsTileMatrixSetsScale.getZxyByScale;

  // Collection Tiles (without TileMatrixSetId in path)
  @added(Versions.v2026_04_15)
  getCollectionTileNoTms is MosaicCollectionsTiles.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTileNoTmsPlain is MosaicCollectionsTilesPlain.getZxy;
  @added(Versions.v2026_04_15)
  getCollectionTileNoTmsByFormat is MosaicCollectionsTilesFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getCollectionTileNoTmsByScale is MosaicCollectionsTilesScale.getZxyByScale;

  // Collection TileJSON
  @added(Versions.v2026_04_15)
  getCollectionTileJson is MosaicCollectionsTileJson.get;
  @added(Versions.v2026_04_15)
  getCollectionTileJsonTms is MosaicCollectionsTileMatrixSetsTileJson.get;

  // Collection WMTS
  @added(Versions.v2026_04_15)
  getCollectionWmtsCapabilities is MosaicCollectionsWmts.getCapabilitiesXml;
  @added(Versions.v2026_04_15)
  getCollectionWmtsCapabilitiesTms is MosaicCollectionsWmtsTileMatrixSets.getCapabilitiesXml;

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
  cropCollectionFeatureGeoJson is MosaicCollectionsFeatureGeoJson.crop;
  @added(Versions.v2026_04_15)
  cropCollectionFeatureGeoJsonFormat is MosaicCollectionsFeatureGeoJsonFormat.cropFormat;
  @added(Versions.v2026_04_15)
  cropCollectionFeatureGeoJsonWidthByHeight is MosaicCollectionsFeatureGeoJsonWidthByHeight.cropWidthByHeightFormat;

  // Collection Point
  @added(Versions.v2026_04_15)
  getCollectionPoint is MosaicCollectionsPoint.getPoint;
  @added(Versions.v2026_04_15)
  getCollectionPointAssets is MosaicCollectionsPointAssets.getPointAssets;

  // === Search-based mosaic endpoints (stable 2026-04-15) ===

  // #1 - Searches Tileset List
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  @added(Versions.v2026_04_15)
  listSearchesTilesets is MosaicSearchesTileSetList.get;
  // #2 - Searches Tileset Metadata
  @added(Versions.v2026_04_15)
  getSearchesTilesetMetadata is MosaicSearchesTileSetMetadata.get;
  // #3 - Searches Tiles with TileMatrixSetId (4 variants)
  @added(Versions.v2026_04_15)
  getSearchesTile is MosaicSearchesTileMatrixSets.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getSearchesTilePlain is MosaicSearchesTileMatrixSetsPlain.getZxy;
  @added(Versions.v2026_04_15)
  getSearchesTileByFormat is MosaicSearchesTileMatrixSetsFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getSearchesTileByScale is MosaicSearchesTileMatrixSetsScale.getZxyByScale;
  // #7 - Searches Assets for Tile (with TileMatrixSetId)
  @added(Versions.v2026_04_15)
  getSearchesAssetsForTile is MosaicSearchesAssetsForTileMatrixSets.getZxyAssets;
  // #5 - Searches TileJSON with TileMatrixSetId
  @added(Versions.v2026_04_15)
  getSearchesTileJsonTms is MosaicSearchesTileMatrixSetsTileJson.get;
  // #6 - Searches WMTS with TileMatrixSetId
  @added(Versions.v2026_04_15)
  getSearchesWmtsCapabilitiesTms is MosaicSearchesWmtsTileMatrixSets.getCapabilitiesXml;
  // #13 - Searches Info
  @added(Versions.v2026_04_15)
  getSearchesInfo is MosaicSearchesInfoSearch.get;
  // #10 - Searches Bbox Crop (NEW)
  @added(Versions.v2026_04_15)
  getSearchesBboxCrop is MosaicSearchesBbox.getCroppedToBoundingBox;
  @added(Versions.v2026_04_15)
  getSearchesBboxCropWithDimensions is MosaicSearchesBboxWithDimensions.getCroppedToBoundingBoxWidthByHeight;
  @added(Versions.v2026_04_15)
  getSearchesBboxAssets is MosaicSearchesAssetsForBbox.getBboxAssets;
  @added(Versions.v2026_04_15)
  cropSearchesFeatureGeoJson is MosaicSearchesFeatureGeoJson.crop;
  @added(Versions.v2026_04_15)
  cropSearchesFeatureGeoJsonFormat is MosaicSearchesFeatureGeoJsonFormat.cropFormat;
  @added(Versions.v2026_04_15)
  cropSearchesFeatureGeoJsonWidthByHeight is MosaicSearchesFeatureGeoJsonWidthByHeight.cropWidthByHeightFormat;
  // Remaining /searches/ equivalents for consistency
  @added(Versions.v2026_04_15)
  getSearchesWmtsCapabilities is MosaicSearchesWmts.getCapabilitiesXml;
  @added(Versions.v2026_04_15)
  getSearchesTileJson is MosaicSearchesTileJson.get;
  @added(Versions.v2026_04_15)
  getSearchesTileNoTmsPlain is MosaicSearchesTilesPlain.getZxy;
  @added(Versions.v2026_04_15)
  getSearchesTileNoTmsByFormat is MosaicSearchesTilesFormat.getZxyByFormat;
  @added(Versions.v2026_04_15)
  getSearchesTileNoTmsByScale is MosaicSearchesTilesScale.getZxyByScale;
  @added(Versions.v2026_04_15)
  getSearchesTileNoTms is MosaicSearchesTiles.getZxyScaleByFormat;
  @added(Versions.v2026_04_15)
  getSearchesAssetsForTileNoTms is MosaicSearchesAssetsForTiles.getZxyAssets;
  // Searches Point
  @added(Versions.v2026_04_15)
  getSearchesPoint is MosaicSearchesPoint.getPoint;
  @added(Versions.v2026_04_15)
  getSearchesPointWithAssets is MosaicSearchesPointWithAssets.getPointAssets;
}

// === Shared Access Signature (SAS) ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("ManagedStorageSharedAccessSignatureClient", "csharp")
interface SharedAccessSignature {
  // Sign HREF for read access
  getSign is Sas.getSign;

  // SAS Tokens
  getToken is Sas.getToken;
  revokeToken is Sas.revokeToken;
}
