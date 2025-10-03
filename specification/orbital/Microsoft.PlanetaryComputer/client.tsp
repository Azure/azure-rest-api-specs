import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

using Microsoft.PlanetaryComputer;

@useDependency(Versions.v2025_04_30_Preview)
@client({
  name: "PlanetaryComputerClient",
  service: Microsoft.PlanetaryComputer,
})
namespace Customizations;

// Client name conflicts
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

// To use maps instead of binary data for non-primitive union types
@@alternateType(IntervalLegendsResponse.body, Record<unknown>[]);

// Use CQL2-TEXT for strongly typed languages
@@alternateType(StacSearchParameters.filter, string, "csharp,java");
@@alternateType(RegisterMosaic.filter, string, "csharp,java");

// Address naming convention violations for C# SDK
// Models ending with "Response" - rename to "Result"
@@clientName(StacAssetStatistics, "AssetStatisticsResult", "csharp");

@@clientName(GeoJsonStatisticsItemResponse,
  "GeoJsonStatisticsItemResult",
  "csharp"
);
@@clientName(InfoOperationResponse, "InfoOperationResult", "csharp");
@@clientName(TilerMosaicSearchRegistrationResponse,
  "TilerMosaicSearchRegistrationResult",
  "csharp"
);
@@clientName(StatisticsResponse, "StatisticsResult", "csharp");
@@clientName(IngestionSourcesPagedResponse,
  "IngestionSourcesPagedResult",
  "csharp"
);

// Models ending with "Request" - rename to "Content"
@@clientName(ImageRequest, "ImageContent", "csharp");
@@clientName(StacSearchParameters, "SearchPostContent", "csharp");

// Models ending with "Definition" - rename appropriately
@@clientName(StacQueryable, "QueryableProperty", "csharp");
@@clientName(Ingestion, "IngestionConfiguration", "csharp");

// Models ending with "Operation" - rename to "Info"
@@clientName(Operation, "LongRunningOperation", "csharp");
@@clientName(IngestionRunOperation, "IngestionRunInfo", "csharp");

// Generic single-word class names - add descriptive prefixes
@@clientName(Geometry, "GeoJsonGeometry", "csharp");
@@clientName(Point, "GeoJsonPoint", "csharp");
@@clientName(Polygon, "GeoJsonPolygon", "csharp");
@@clientName(Resampling, "ResamplingMethod", "csharp");
@@clientName(TileMatrixSetId, "TileMatrixSetId", "csharp");

// Additional model renames for C#
@@clientName(RenderOption, "RenderOptionModel", "csharp");
@@clientName(StacCollection, "StacCollectionModel", "csharp");
@@clientName(StacItem, "StacItemModel", "csharp");
@@clientName(StacItemCollection, "StacItemCollectionModel", "csharp");

// === Ingestion Management ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "These operations return collections."
@operationGroup
interface Ingestion {
  // Ingestion operations management
  cancelIngestionOperation is IngestionOperations.delete;
  cancelAllIngestionOperations is IngestionOperations.deleteAll;
  getIngestionOperation is IngestionOperations.get;
  listIngestionOperations is IngestionOperations.list;

  // Ingestion runs operations
  createIngestionRun is IngestionRuns.create;
  getIngestionRun is IngestionRuns.get;
  listIngestionRuns is IngestionRuns.list;

  // Ingestion operations
  createIngestion is Ingestions.create;
  deleteIngestion is Ingestions.delete;
  getIngestion is Ingestions.get;
  listIngestions is Ingestions.list;
  updateIngestion is Ingestions.update;

  // Ingestion sources
  createIngestionSource is IngestionSources.create;
  createOrReplaceIngestionSource is IngestionSources.createOrReplace;
  deleteIngestionSource is IngestionSources.delete;
  getIngestionSource is IngestionSources.get;
  listIngestionSources is IngestionSources.list;
  listManagedIdentities is IngestionSources.listManagedIdentities;
}

// === SpatioTemporal Asset Catalog (STAC) API ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
interface Stac {
  // Collection Assets
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createCollectionAsset is StacCollectionAssets.create;
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createOrReplaceCollectionAsset is StacCollectionAssets.createOrReplace;
  deleteCollectionAsset is StacCollectionAssets.delete;

  // Collection Configuration
  getCollectionConfiguration is StacCollectionConfig.get;

  // Collection Mosaics
  addMosaic is StacCollectionMosaics.add;
  createOrReplaceMosaic is StacCollectionMosaics.createOrReplace;
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
  listCollections is StacCollections.getAll;

  // Collection Partition Types
  getPartitionType is StacCollectionPartitionTypes.get;
  replacePartitionType is StacCollectionPartitionTypes.replace;

  // Collection Render Options
  createRenderOption is StacCollectionRenderOptions.create;
  createOrReplaceRenderOption is StacCollectionRenderOptions.createOrReplace;
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

  // STAC Items
  createItem is StacItems.create;
  createOrReplaceItem is StacItems.createOrReplace;
  deleteItem is StacItems.delete;
  getItem is StacItems.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listItems is StacItems.getFeatures;
  updateItem is StacItems.update;

  // STAC Landing Pages
  getStacLandingPage is StacLandingPages.get;

  // STAC Queryables
  createQueryables is StacQueryables.create;
  createOrReplaceQueryable is StacQueryables.createOrReplace;
  deleteQueryable is StacQueryables.delete;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listQueryables is StacQueryables.getAll;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listQueryablesByCollection is StacQueryables.getAllByCollection;

  // STAC Search
  search is StacSearch.create;
}

// === Tiles for STAC Items ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
interface Tiler {
  // Tile Matrix Sets
  getTileMatrixDefinitions is TileMatrixDefinitions.get;
  getTileMatrixList is TileMatrixList.get;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listAssetStatistics is TilerAssetStatistics.getAll;

  // Basic Info and Assets
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listAvailableAssets is TilerAvailableAssets.getAll;

  // Basic Info and Assets
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listBounds is TilerBound.getAll;

  // Parts/Crops
  cropGeoJson is TilerGeoJsons.cropFormat;
  cropGeoJsonWithDimensions is TilerGeoJsons.cropWidthByHeightFormat;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listGeoJsonStatistics is TilerGeoJsonStatistics.getAll;

  // Basic Info and Assets
  getInfoGeoJson is TilerInfoGeoJsonOperations.get;
  getAssetsInfo is TilerInfoOperations.get;

  // Parts/Crops
  getPart is TilerParts.getCroppedToBoundingBox;
  getPartWithDimensions is TilerParts.getCroppedToBoundingBoxWidthByHeight;

  // Points
  getPoint is TilerPoints.getPoint;

  // Previews
  getPreview is TilerPreviews.get;
  getPreviewWithFormat is TilerPreviews.getFormat;

  // Image Exports for STAC Collections
  createStaticImage is TilerStaticImages.create;
  getStaticImage is TilerStaticImages.get;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listStatistics is TilerStatistics.getAll;

  // Tile JSON
  // getTileJson is TilerTileJsonOperations.get;
  getTileJson is TilerTileJsonTileMatrixSets.get;

  // Tiles
  getTile is TilerTileMatrixSets.getZxyScaleByFormat;
  // getTile is TilerTiles.getZxyScaleByFormat;

  // WMTS Capabilities
  // getWmtsCapabilities is TilerWmts.getCapabilitiesXml;
  getWmtsCapabilities is TilerWmtsTileMatrixSets.getCapabilitiesXml;

  // Map Legends
  getClassMapLegend is MapsClassMapLegends.get;
  getIntervalLegend is MapsIntervalLegends.getByClassMapName;
  getLegend is MapsLegends.get;

  // Mosaic Assets
  getMosaicsAssetsForPoint is MosaicsAssetsForPoints.getPointAssets;
  getMosaicsAssetsForTile is MosaicsAssetsForTileMatrixSets.getZxyAssets;
  // getMosaicsAssetsForTile is MosaicsAssetsForTiles.getZxyAssets;

  // Mosaic Search and Registration
  getMosaicsSearchInfo is MosaicsInfoSearch.get;
  registerMosaicsSearch is MosaicsRegisterSearch.register;

  // Mosaic Tile JSON
  // getMosaicsTileJson is MosaicsTileJsonOperations.get;
  getMosaicsTileJson is MosaicsTileMatrixSets.getZxyScaleByFormat;
  getMosaicsTileJsonWithMatrixSet is MosaicsTileMatrixSetsTileJson.get;

  // Mosaic Tiles
  getMosaicsTile is MosaicsTiles.getZxyScaleByFormat;

  // Mosaic WMTS Capabilities
  // getMosaicsWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;
  getMosaicsWmtsCapabilities is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;
}

// === Shared Access Signature (SAS) ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
interface SharedAccessSignature {
  // Sign HREF for read access
  getSign is Sas.getSign;

  // SAS Tokens
  getToken is Sas.getToken;
  revokeToken is Sas.revokeToken;
}
