import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

using Microsoft.PlanetaryComputer;

@useDependency(Versions.v2025_04_30_Preview)
namespace Customizations;

@@clientNamespace(Microsoft.PlanetaryComputer,
  "com.azure.planetarycomputer",
  "java"
);

// Client name conflicts
@@clientName(Ingestions, "IngestionsManagement", "csharp");
@@clientName(StacItems, "StacItemsManagement", "csharp");
@@clientName(IngestionOperations, "IngestionOperationsManagement", "csharp");
@@clientName(IngestionSources, "IngestionSourcesManagement", "csharp");
@@clientName(TilerInfoOperations, "TilerInfoManagement", "csharp");
@@clientName(StacCollectionOperations, "StacCollectionManagement", "csharp");
// @@clientName(StacItemOrItemCollection,
//   "StacItemOrItemCollectionContent",
//   "csharp"
// );
@@clientName(ItemProperties.datetime, "date_time", "python");
@@clientName(SearchPostRequest.datetime, "date_time", "python");

// Disable convenient API for JSON-Merge patch operations
@@convenientAPI(Ingestions.update, false, "csharp,java");
@@convenientAPI(StacItems.update, false, "csharp,java");

// To use maps instead of binary data for non-primitive union types
@@alternateType(IntervalLegendsResponse.body, Record<unknown>[]);

// Use CQL2-TEXT for strongly typed languages
@@alternateType(SearchPostRequest.filter, string, "csharp,java");
@@alternateType(RegisterMosaic.filter, string, "csharp,java");

// Address naming convention violations for C# SDK
// Models ending with "Response" - rename to "Result"
@@clientName(AssetStatisticsResponse, "AssetStatisticsResult", "csharp");
@@clientName(BoundsResponse, "BoundsResult", "csharp");
@@clientName(ClassmapLegendResponse, "ClassmapLegendResult", "csharp");
@@clientName(GeoJsonStatisticsItemCollectionResponse,
  "GeoJsonStatisticsItemCollectionResult",
  "csharp"
);

@@clientName(GeoJsonStatisticsItemResponse,
  "GeoJsonStatisticsItemResult",
  "csharp"
);
@@clientName(InfoOperationResponse, "InfoOperationResult", "csharp");
@@clientName(RegisterResponse, "RegisterResult", "csharp");
@@clientName(StatisticsResponse, "StatisticsResult", "csharp");
@@clientName(TileJsonResponse, "TileJsonResult", "csharp");
@@clientName(IngestionSources.IngestionSourcesPagedResponse,
  "IngestionSourcesPagedResult",
  "csharp"
);

// Models ending with "Request" - rename to "Content"
@@clientName(ImageRequest, "ImageContent", "csharp");
@@clientName(SearchPostRequest, "SearchPostContent", "csharp");

// Models ending with "Definition" - rename appropriately
@@clientName(QueryableDefinition, "QueryableProperty", "csharp");
@@clientName(Ingestions.IngestionDefinition,
  "IngestionConfiguration",
  "csharp"
);

// Models ending with "Operation" - rename to "Info"
@@clientName(Operation, "OperationInfo", "csharp");
@@clientName(Ingestions.IngestionRuns.IngestionRunOperation,
  "IngestionRunInfo",
  "csharp"
);

// Generic single-word class names - add descriptive prefixes
@@clientName(Asset, "StacAsset", "csharp");
@@clientName(Extent, "StacExtent", "csharp");
@@clientName(Link, "StacLink", "csharp");
@@clientName(Metadata, "MosaicMetadata", "csharp");
@@clientName(Geometry, "GeoJsonGeometry", "csharp");
@@clientName(Point, "GeoJsonPoint", "csharp");
@@clientName(Mosaic, "StacMosaic", "csharp");
@@clientName(Polygon, "GeoJsonPolygon", "csharp");
@@clientName(Provider, "StacProvider", "csharp");
@@clientName(Resampling, "ResamplingMethod", "csharp");
@@clientName(TileMatrixSetId, "TileMatrixSetId", "csharp");

// Additional model renames for C#
@@clientName(RenderOption, "RenderOptionModel", "csharp");
@@clientName(StacCollection, "StacCollectionModel", "csharp");
@@clientName(StacItem, "StacItemModel", "csharp");
@@clientName(ItemCollection, "ItemCollectionModel", "csharp");

// === Ingestion Management ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
interface Ingestion {
  // Ingestion operations management
  deleteIngestionOperation is IngestionOperations.delete;
  deleteAllIngestionOperations is IngestionOperations.deleteAll;
  getIngestionOperation is IngestionOperations.get;
  getIngestionOperations is IngestionOperations.list;

  // Ingestion runs operations
  createIngestionRun is Ingestions.IngestionRuns.create;
  getIngestionRun is Ingestions.IngestionRuns.get;
  getIngestionRuns is Ingestions.IngestionRuns.list;

  // Ingestion operations
  createIngestion is Ingestions.create;
  deleteIngestion is Ingestions.delete;
  getIngestion is Ingestions.get;
  getIngestions is Ingestions.list;
  updateIngestion is Ingestions.update;

  // Ingestion sources
  createIngestionSource is IngestionSources.create;
  createOrReplaceIngestionSource is IngestionSources.createOrReplace;
  deleteIngestionSource is IngestionSources.delete;
  getIngestionSource is IngestionSources.get;
  getIngestionSources is IngestionSources.list;
  getManagedIdentities is IngestionSources.listManagedIdentities;
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
  getCollectionConfig is StacCollectionConfig.get;

  // Collection Mosaics
  addMosaic is StacCollectionMosaics.add;
  createOrReplaceMosaic is StacCollectionMosaics.createOrReplace;
  deleteMosaic is StacCollectionMosaics.delete;
  getMosaic is StacCollectionMosaics.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listMosaics is StacCollectionMosaics.getAll;

  // STAC Collections
  createCollection is StacCollectionOperations.create;
  createOrReplaceCollection is StacCollectionOperations.createOrReplace;
  deleteCollection is StacCollectionOperations.delete;
  getCollection is StacCollectionOperations.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listCollections is StacCollectionOperations.getAll;

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
  getItemsAsFeatures is StacItems.getFeatures;
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
  createSearchOperations is StacSearchOperations.create;
  getSearchOperations is StacSearchOperations.get;
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
  getInfo is TilerInfoOperations.get;

  // Parts/Crops
  getPart is TilerParts.getCroppedToBoundingBox;
  getPartWithDimensions is TilerParts.getCroppedToBoundingBoxWidthByHeight;

  // Points
  getPoint is TilerPoints.getLonLat;

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
  getTileJson is TilerTileJsonOperations.get;
  getTileJsonWithMatrixSet is TilerTileJsonTileMatrixSets.get;

  // Tiles
  getTileWithMatrixSet is TilerTileMatrixSets.getZxyScaleByFormat;
  getTile is TilerTiles.getZxyScaleByFormat;

  // WMTS Capabilities
  getWmtsCapabilities is TilerWmts.getCapabilitiesXml;
  getWmtsCapabilitiesWithMatrixSet is TilerWmtsTileMatrixSets.getCapabilitiesXml;

  // Map Legends
  getClassmapLegend is MapsClassmapLegends.get;
  getIntervalLegend is MapsIntervalLegends.getByClassmapName;
  getLegend is MapsLegends.get;

  // Mosaic Assets
  getAssetsForPoint is MosaicsAssetsForPoints.getLonLatAssets;
  getMosaicsAssetsForTileWithMatrixSet is MosaicsAssetsForTileMatrixSets.getZxyAssets;
  getMosaicsAssetsForTile is MosaicsAssetsForTiles.getZxyAssets;

  // Mosaic Search and Registration
  getMosaicsSearchInfo is MosaicsInfoSearch.get;
  registerMosaicsSearch is MosaicsRegisterSearch.register;

  // Mosaic Tile JSON
  getMosaicsTileJson is MosaicsTileJsonOperations.get;
  getMosaicsTileWithMatrixSet is MosaicsTileMatrixSets.getZxyScaleByFormat;
  getMosaicsTileJsonWithMatrixSet is MosaicsTileMatrixSetsTileJson.get;

  // Mosaic Tiles
  getMosaicsTile is MosaicsTiles.getZxyScaleByFormat;

  // Mosaic WMTS Capabilities
  getMosaicsWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;
  getMosaicsWmtsCapabilitiesWithMatrixSet is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;
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
