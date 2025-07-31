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
@@clientName(OperationsPagedResponse, "OperationsPagedResult", "csharp");
@@clientName(GeoJsonStatisticsItemCollectionResponse,
  "GeoJsonStatisticsItemCollectionResult",
  "csharp"
);

@@clientName(IngestionSources.ManagedIdentitiesPagedResponse,
  "ManagedIdentitiesPagedResult",
  "csharp"
);
@@clientName(GeoJsonStatisticsItemResponse,
  "GeoJsonStatisticsItemResult",
  "csharp"
);
@@clientName(InfoOperationResponse, "InfoOperationResult", "csharp");
@@clientName(Ingestions.IngestionDefinitionsPagedResponse,
  "IngestionDefinitionsPagedResult",
  "csharp"
);
@@clientName(RegisterResponse, "RegisterResult", "csharp");
@@clientName(Ingestions.IngestionRuns.IngestionRunsPagedResponse,
  "IngestionRunsPagedResult",
  "csharp"
);
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
@@clientName(Algorithm, "AlgorithmInfo", "csharp");
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
@@clientName(Tilematrixsetid, "TileMatrixSetId", "csharp");

// === Ingestion Management ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("IngestionManagementClientImpl", "csharp")
interface IngestionManagementClient {
  // Ingestion operations
  getIngestions is Ingestions.listAll;
  createIngestion is Ingestions.create;
  getIngestion is Ingestions.get;
  updateIngestion is Ingestions.update;
  deleteIngestion is Ingestions.delete;

  // Ingestion runs operations
  getIngestionRuns is Ingestions.IngestionRuns.listAll;
  createIngestionRun is Ingestions.IngestionRuns.create;
  getIngestionRun is Ingestions.IngestionRuns.get;

  // Ingestion operations management
  getIngestionOperations is IngestionOperations.listAll;
  deleteAllIngestionOperations is IngestionOperations.deleteAll;
  getIngestionOperation is IngestionOperations.get;
  deleteIngestionOperation is IngestionOperations.delete;
}

// === Ingestion Sources ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("IngestionSourcesClientImpl", "csharp")
interface IngestionSourcesClient {
  getIngestionSources is IngestionSources.listAll;
  createIngestionSource is IngestionSources.create;
  getIngestionSource is IngestionSources.get;
  createOrReplaceIngestionSource is IngestionSources.createOrReplace;
  deleteIngestionSource is IngestionSources.delete;
  getManagedIdentities is IngestionSources.listManagedIdentities;
}

// === SpatioTemporal Asset Catalog (STAC) API ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("StacApiClientImpl", "csharp")
interface StacApiClient {
  // STAC Landing Pages
  getStacLandingPage is StacLandingPages.get;

  // STAC Collections
  getAllCollections is StacCollectionOperations.getAll;
  createCollection is StacCollectionOperations.create;
  getCollection is StacCollectionOperations.get;
  createOrReplaceCollection is StacCollectionOperations.createOrReplace;
  deleteCollection is StacCollectionOperations.delete;

  // STAC Items
  getItemsAsFeatures is StacItems.getFeatures;
  createItem is StacItems.create;
  getItem is StacItems.get;
  createOrReplaceItem is StacItems.createOrReplace;
  updateItem is StacItems.update;
  deleteItem is StacItems.delete;

  // STAC Queryables
  getAllQueryables is StacQueryables.getAll;
  getAllQueryablesByCollection is StacQueryables.getAllByCollection;
  createQueryables is StacQueryables.create;

  // STAC Conformance
  getConformanceClass is StacConformanceClass.get;

  // STAC Search
  getSearchOperations is StacSearchOperations.get;
  createSearchOperations is StacSearchOperations.create;
}

// === STAC Collection Configuration ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("StacCollectionConfigurationClientImpl", "csharp")
interface StacCollectionConfigurationClient {
  // Collection Assets
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createCollectionAsset is StacCollectionAssets.create;
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createOrReplaceCollectionAsset is StacCollectionAssets.createOrReplace;
  deleteCollectionAsset is StacCollectionAssets.delete;

  // Collection Configuration
  getCollectionConfig is StacCollectionConfig.get;

  // Collection Mosaics
  getAllMosaics is StacCollectionMosaics.getAll;
  addMosaic is StacCollectionMosaics.add;
  getMosaic is StacCollectionMosaics.get;
  createOrReplaceMosaic is StacCollectionMosaics.createOrReplace;
  deleteMosaic is StacCollectionMosaics.delete;

  // Collection Partition Types
  getPartitionType is StacCollectionPartitionTypes.get;
  replacePartitionType is StacCollectionPartitionTypes.replace;

  // Collection Render Options
  getAllRenderOptions is StacCollectionRenderOptions.getAll;
  createRenderOption is StacCollectionRenderOptions.create;
  getRenderOption is StacCollectionRenderOptions.get;
  createOrReplaceRenderOption is StacCollectionRenderOptions.createOrReplace;
  deleteRenderOption is StacCollectionRenderOptions.delete;

  // Collection Tile Settings
  getTileSettings is StacCollectionTileSettings.getAll;
  replaceTileSettings is StacCollectionTileSettings.replace;

  // Collection Queryables Configuration
  createOrReplaceQueryable is StacQueryables.createOrReplace;
  deleteQueryable is StacQueryables.delete;

  // Collection Thumbnails
  getCollectionThumbnail is StacCollectionThumbnails.get;
}

// === GeoCatalog Instance Configuration ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("GeocatalogClientImpl", "csharp")
interface GeocatalogClient {
  getAuthConfig is GeoCatalogAuthConfigOperations.get;
  getAzmapsClientId is GeoCatalogAzmapsClient.getId;
  getAzmapsToken is GeoCatalogAzmapsToken.get;
}

// === Image Exports for STAC Collections ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("ImageExportsClientImpl", "csharp")
interface ImageExportsClient {
  createStaticImage is TilerStaticImages.create;
  getStaticImage is TilerStaticImages.get;
}

// === Tiles for STAC Items ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("StacItemTilerClientImpl", "csharp")
interface StacItemTilerClient {
  // Basic Info and Assets
  getBounds is TilerBound.getAll;
  getInfo is TilerInfoOperations.get;
  getInfoGeoJson is TilerInfoGeoJsonOperations.get;
  getAvailableAssets is TilerAvailableAssets.getAll;

  // Statistics
  getAssetStatistics is TilerAssetStatistics.getAll;
  getStatistics is TilerStatistics.getAll;
  getGeoJsonStatistics is TilerGeoJsonStatistics.getAll;

  // Tiles
  getTile is TilerTiles.getZxyScalexFormat;
  getTileWithMatrixSet is TilerTileMatrixSets.getZxyScalexFormat;

  // Tile JSON
  getTileJson is TilerTileJsonOperations.get;
  getTileJsonWithMatrixSet is TilerTileJsonTileMatrixSets.get;

  // WMTS Capabilities
  getWmtsCapabilities is TilerWmts.getCapabilitiesXml;
  getWmtsCapabilitiesWithMatrixSet is TilerWmtsTileMatrixSets.getCapabilitiesXml;

  // Points
  getPoint is TilerPoints.getLonLat;

  // Previews
  getPreview is TilerPreviews.get;
  getPreviewWithFormat is TilerPreviews.getFormat;

  // Parts/Crops
  getPart is TilerParts.getMinxMinyMaxxMaxyFormat;
  getPartWithDimensions is TilerParts.getMinxMinyMaxxMaxyWidthxHeightFormat;
  cropGeoJson is TilerGeoJsons.cropFormat;
  cropGeoJsonWithDimensions is TilerGeoJsons.cropWidthxHeightFormat;
}

// === Map Legends ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("MapLegendsClientImpl", "csharp")
interface MapLegendsClient {
  getClassmapLegend is MapsClassmapLegends.get;
  getLegend is MapsLegends.get;
  getIntervalLegend is MapsIntervalLegends.getByClassmapName;
}

// === Tiles for STAC Collections Mosaics ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("MosaicTilerClientImpl", "csharp")
interface MosaicTilerClient {
  // Tiles
  getTile is MosaicsTiles.getZxyScalexFormat;
  getTileWithMatrixSet is MosaicsTileMatrixSets.getZxyScalexFormat;

  // Tile JSON
  getTileJson is MosaicsTileJsonOperations.get;
  getTileJsonWithMatrixSet is MosaicsTileMatrixSetsTileJson.get;

  // WMTS Capabilities
  getWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;
  getWmtsCapabilitiesWithMatrixSet is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;

  // Search and Registration
  registerSearch is MosaicsRegisterSearch.register;
  getSearchInfo is MosaicsInfoSearch.get;

  // Assets
  getAssetsForTile is MosaicsAssetsForTiles.getZxyAssets;
  getAssetsForTileWithMatrixSet is MosaicsAssetsForTileMatrixSets.getZxyAssets;
  getAssetsForPoint is MosaicsAssetsForPoints.getLonLatAssets;
}

// === Tile Matrix Sets ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("TileMatrixSetsClientImpl", "csharp")
interface TileMatrixSetsClient {
  getTileMatrixList is TileMatrixList.get;
  getTileMatrixDefinitions is TileMatrixDefinitions.get;
}

// === Shared Access Signature (SAS) ===
#suppress "@azure-tools/typespec-client-generator-core/client-service" "Operation groups are used for logical grouping"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("SharedAccessSignatureClientImpl", "csharp")
interface SharedAccessSignatureClient {
  // SAS Tokens
  getToken is Sas.getToken;
  revokeToken is Sas.revokeToken;

  // Sign HREF for read access
  getSign is Sas.getSign;
}
