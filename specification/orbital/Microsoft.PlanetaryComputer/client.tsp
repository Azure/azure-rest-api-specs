import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

// InMa
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;

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

// === Method overrides ===

// === Parameter Grouping Overrides ===

/**
 * Options for getting a tile from a dataset
 */
model GetTileOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * Tile matrix set parameters
   */
  ...TileMatrixSetQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;

  /**
   * Subdataset parameters
   */
  ...SubDatasetQueryParameters;
}

/**
 * Options for getting WMTS capabilities
 */
model GetWmtsCapabilitiesOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

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

  /**
   * Zoom query parameters
   */
  ...ZoomQueryParameters;

  /**
   * Tile matrix set parameters
   */
  ...TileMatrixSetQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;
}

/**
 * Options for getting asset statistics
 */
model GetAssetStatisticsOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Statistics query parameters
   */
  ...StatisticsQueryParameters;
}

/**
 * Options for cropping GeoJSON
 */
model CropGeoJsonOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord-crs")
  coordinateReferenceSystem?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @query("max_size")
  maxSize?: int32 = 1024;

  /**
   * Dimension parameters for output image size
   */
  ...DimensionsQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;
}

/**
 * Options for getting parts (cropped to bounding box)
 */
model GetPartOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst-crs")
  dstCrs?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @query("max_size")
  maxSize?: int32 = 1024;

  /**
   * Dimension parameters for output image size
   */
  ...DimensionsQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;

  /**
   * Subdataset parameters
   */
  ...SubDatasetQueryParameters;
}

/**
 * Options for getting previews
 */
model GetPreviewOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * rio-color formula (info: https://github.com/mapbox/rio-color)
   */
  @query("color_formula")
  colorFormula?: string;

  /**
   * Output Coordinate Reference System.
   */
  @query("dst-crs")
  dstCrs?: string;

  /**
   * Resampling method.
   */
  @query("resampling")
  resampling?: Resampling = Resampling.nearest;

  /**
   * Image output size limit if width and height limits are not set.
   */
  @query("max_size")
  maxSize?: int32 = 1024;

  /**
   * Dimension parameters for output image size
   */
  ...DimensionsQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;

  /**
   * Subdataset parameters
   */
  ...SubDatasetQueryParameters;
}

/**
 * Options for getting statistics
 */
model GetStatisticsOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Statistics query parameters
   */
  ...StatisticsQueryParameters;
}

/**
 * Options for getting GeoJSON statistics
 */
model GetGeoJsonStatisticsOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Statistics query parameters
   */
  ...StatisticsQueryParameters;
}

/**
 * Options for getting TileJSON
 */
model GetTileJsonOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * Default will be automatically defined if the output image needs a mask (png) or not (jpeg).
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @maxValueExclusive(4)
  @query("tile_scale")
  tileScale?: int32 = 1;

  /**
   * Zoom query parameters
   */
  ...ZoomQueryParameters;

  /**
   * Tile matrix set parameters
   */
  ...TileMatrixSetQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;

  /**
   * Subdataset parameters
   */
  ...SubDatasetQueryParameters;
}

/**
 * Options for mosaic tiles
 */
model GetMosaicTileOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Mosaic search parameters
   */
  ...MosaicSearchQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * Tile matrix set parameters
   */
  ...TileMatrixSetQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;

  /**
   * Subdataset parameters
   */
  ...SubDatasetQueryParameters;
}

/**
 * Options for mosaic TileJSON
 */
model GetMosaicTileJsonOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Mosaic search parameters
   */
  ...MosaicSearchQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

  /**
   * Default will be automatically defined if the output image needs a mask (png) or not (jpeg).
   */
  @query("tile_format")
  tileFormat?: TilerImageFormat;

  /**
   * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
   */
  @maxValueExclusive(4)
  @query("tile_scale")
  tileScale?: int32 = 1;

  /**
   * Zoom query parameters
   */
  ...ZoomQueryParameters;

  /**
   * Tile matrix set parameters
   */
  ...TileMatrixSetQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;

  /**
   * Subdataset parameters
   */
  ...SubDatasetQueryParameters;
}

/**
 * Options for mosaic WMTS capabilities
 */
model GetMosaicWmtsCapabilitiesOptions {
  /**
   * Asset query parameters for selecting and manipulating assets
   */
  ...AssetQueryParameters;

  /**
   * Mosaic search parameters
   */
  ...MosaicSearchQueryParameters;

  /**
   * Terrain algorithm parameters
   */
  ...TerrainAlgorithmQueryParameters;

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

  /**
   * Zoom query parameters
   */
  ...ZoomQueryParameters;

  /**
   * Tile matrix set parameters
   */
  ...TileMatrixSetQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;
}

// Override operations with grouped parameters

/**
 * Create map tile from a dataset with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileCustomized(
  /**
   * STAC Collection Identifier
   */
  @path collectionId: string,

  /**
   * STAC Item Identifier
   */
  @path itemId: string,

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path tileMatrixSetId: string,

  /**
   * Identifier (Z) selecting one of the scales defined in the TileMatrixSet
   */
  @path z: float32,

  /**
   * Column (X) index of the tile on the selected TileMatrix
   */
  @path x: float32,

  /**
   * Row (Y) index of the tile on the selected TileMatrix
   */
  @path y: float32,

  /**
   * Numeric scale factor for the tile. Higher values produce larger tiles
   */
  @path scale: float32,

  /**
   * Output format for the tile or image (e.g., png, jpeg, webp)
   */
  @path format: string,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for tile generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetTileOptions,
): TileResponse;

@@override(TilerTileMatrixSets.getZxyScaleByFormat, getTileCustomized);

/**
 * OGC WMTS endpoint with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getWmtsCapabilitiesCustomized(
  /**
   * STAC Collection Identifier
   */
  @path collectionId: string,

  /**
   * STAC Item Identifier
   */
  @path itemId: string,

  /**
   * Identifier selecting one of the TileMatrixSetId supported
   */
  @path tileMatrixSetId: string,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for WMTS capabilities including asset selection, terrain algorithms, and tile formatting
   */
  options: GetWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

@@override(TilerWmtsTileMatrixSets.getCapabilitiesXml,
  getWmtsCapabilitiesCustomized
);

/**
 * Per Asset statistics with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getAssetStatisticsCustomized(
  /**
   * STAC Collection Identifier
   */
  @path collectionId: string,

  /**
   * STAC Item Identifier
   */
  @path itemId: string,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for asset statistics including asset selection and statistical calculation parameters
   */
  options: GetAssetStatisticsOptions,
): StacAssetStatistics;

@@override(TilerAssetStatistics.getAll, getAssetStatisticsCustomized);

// === Ingestion Management ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "These operations return collections."
@operationGroup
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
  lists is Ingestions.list;
  update is Ingestions.update;

  // Ingestion sources
  createSource is IngestionSources.create;
  createOrReplaceSource is IngestionSources.createOrReplace;
  deleteSource is IngestionSources.delete;
  getSource is IngestionSources.get;
  listSources is IngestionSources.list;
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
  listCollectionQueryables is StacQueryables.getAllByCollection;

  // STAC Search
  search is StacSearch.create;
}

// === Tiles for STAC Items ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
interface Tiler {
  // Tile Matrix Sets
  getTileMatrixDefinitions is TileMatrixDefinitions.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listTileMatrices is TileMatrixList.get;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getAssetStatistics is TilerAssetStatistics.getAll;

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
  getMosaicsTileJson is MosaicsTileMatrixSetsTileJson.get;

  // Mosaic Tiles
  getMosaicsTile is MosaicsTileMatrixSets.getZxyScaleByFormat;

  // Mosaic WMTS Capabilities
  // getMosaicsWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;
  getMosaicsWmtsCapabilities is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;
}

// === Shared Access Signature (SAS) ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
interface SharedAccessSignatureClient {
  // Sign HREF for read access
  getSign is Sas.getSign;

  // SAS Tokens
  getToken is Sas.getToken;
  revokeToken is Sas.revokeToken;
}
