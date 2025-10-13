import "@azure-tools/typespec-client-generator-core";

import "./models.tiler.common.tsp";
import "./models.tiler.items.tsp";
import "./models.tiler.mosaics.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

using Microsoft.PlanetaryComputer;

// === Common signature aliases for Python overrides ===

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
   * Coordinate Reference System of the input coords. Default to `epsg:4326`.
   */
  @query("coord-crs")
  coordinateReferenceSystem?: string;

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
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;
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
   * Mosaic tile parameters
   */
  ...MosaicTileQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;
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
   * Zoom query parameters
   */
  ...ZoomQueryParameters;

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
  tileScale?: int32;

  /**
   * Mosaic tile parameters
   */
  ...MosaicTileQueryParameters;

  /**
   * Visual rendering parameters
   */
  ...MiscTileQueryParameters;
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
  ...getTileCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for tile generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetTileOptions,
): TileResponse;

/**
 * Create map tile from a dataset with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileCustomizedPython(
  ...getTileCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for tile generation including asset selection, terrain algorithms, and visual rendering
   */
  ...GetTileOptions,
): TileResponse;

@@override(TilerTileMatrixSets.getZxyScaleByFormat,
  getTileCustomized,
  "!python"
);

@@override(TilerTileMatrixSets.getZxyScaleByFormat,
  getTileCustomizedPython,
  "python"
);

/**
 * OGC WMTS endpoint with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getWmtsCapabilitiesCustomized(
  ...getWmtsCapabilitiesCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for WMTS capabilities including asset selection, terrain algorithms, and tile formatting
   */
  options: GetWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

/**
 * OGC WMTS endpoint with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getWmtsCapabilitiesCustomizedPython(
  ...getWmtsCapabilitiesCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for WMTS capabilities including asset selection, terrain algorithms, and tile formatting
   */
  ...GetWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

@@override(TilerWmtsTileMatrixSets.getCapabilitiesXml,
  getWmtsCapabilitiesCustomized,
  "!python"
);

@@override(TilerWmtsTileMatrixSets.getCapabilitiesXml,
  getWmtsCapabilitiesCustomizedPython,
  "python"
);

/**
 * Per Asset statistics with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getAssetStatisticsCustomized(
  ...getAssetStatisticsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for asset statistics including asset selection and statistical calculation parameters
   */
  options: GetAssetStatisticsOptions,
): StacAssetStatistics;

/**
 * Per Asset statistics with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getAssetStatisticsCustomizedPython(
  ...getAssetStatisticsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for asset statistics including asset selection and statistical calculation parameters
   */
  ...GetAssetStatisticsOptions,
): StacAssetStatistics;

@@override(TilerAssetStatistics.getAll,
  getAssetStatisticsCustomized,
  "!python"
);

@@override(TilerAssetStatistics.getAll,
  getAssetStatisticsCustomizedPython,
  "python"
);

/**
 * Create image from a geojson feature with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropGeoJsonCustomized(
  ...cropGeoJsonCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for GeoJSON cropping including asset selection, terrain algorithms, and visual rendering
   */
  options: CropGeoJsonOptions,

  /**
   * Request GeoJson body.
   */
  @body
  body: StacItem,
): TileResponse;

/**
 * Create image from a geojson feature with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropGeoJsonCustomizedPython(
  ...cropGeoJsonCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for GeoJSON cropping including asset selection, terrain algorithms, and visual rendering
   */
  ...CropGeoJsonOptions,

  /**
   * Request GeoJson body.
   */
  @body
  body: StacItem,
): TileResponse;

@@override(TilerGeoJsons.cropFormat, cropGeoJsonCustomized, "!python");

@@override(TilerGeoJsons.cropFormat, cropGeoJsonCustomizedPython, "python");

/**
 * Create image from a geojson feature with dimensions with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropGeoJsonWithDimensionsCustomized(
  ...cropGeoJsonWithDimensionsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for GeoJSON cropping including asset selection, terrain algorithms, and visual rendering
   */
  options: CropGeoJsonOptions,

  /**
   * Request GeoJson body.
   */
  @body
  body: StacItem,
): TileResponse;

/**
 * Create image from a geojson feature with dimensions with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op cropGeoJsonWithDimensionsCustomizedPython(
  ...cropGeoJsonWithDimensionsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for GeoJSON cropping including asset selection, terrain algorithms, and visual rendering
   */
  ...CropGeoJsonOptions,

  /**
   * Request GeoJson body.
   */
  @body
  body: StacItem,
): TileResponse;

@@override(TilerGeoJsons.cropWidthByHeightFormat,
  cropGeoJsonWithDimensionsCustomized,
  "!python"
);

@@override(TilerGeoJsons.cropWidthByHeightFormat,
  cropGeoJsonWithDimensionsCustomizedPython,
  "python"
);

/**
 * Get Statistics from a geojson feature or featureCollection with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op listGeoJsonStatisticsCustomized(
  ...listGeoJsonStatisticsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for GeoJSON statistics including asset selection and statistical calculation parameters
   */
  options: GetGeoJsonStatisticsOptions,

  /**
   * Request GeoJson body
   */
  @body
  body: StacItemCollection,
): GeoJsonStatisticsForStacItemCollection;

/**
 * Get Statistics from a geojson feature or featureCollection with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op listGeoJsonStatisticsCustomizedPython(
  ...listGeoJsonStatisticsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for GeoJSON statistics including asset selection and statistical calculation parameters
   */
  ...GetGeoJsonStatisticsOptions,

  /**
   * Request GeoJson body
   */
  @body
  body: StacItemCollection,
): GeoJsonStatisticsForStacItemCollection;

@@override(TilerGeoJsonStatistics.getAll,
  listGeoJsonStatisticsCustomized,
  "!python"
);

@@override(TilerGeoJsonStatistics.getAll,
  listGeoJsonStatisticsCustomizedPython,
  "python"
);

/**
 * Create image from part of a dataset with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPartCustomized(
  ...getPartCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for part generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetPartOptions,
): TileResponse;

/**
 * Create image from part of a dataset with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPartCustomizedPython(
  ...getPartCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for part generation including asset selection, terrain algorithms, and visual rendering
   */
  ...GetPartOptions,
): TileResponse;

@@override(TilerParts.getCroppedToBoundingBox, getPartCustomized, "!python");

@@override(TilerParts.getCroppedToBoundingBox,
  getPartCustomizedPython,
  "python"
);

/**
 * Create image from part of a dataset with dimensions with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPartWithDimensionsCustomized(
  ...getPartWithDimensionsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for part generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetPartOptions,
): TileResponse;

/**
 * Create image from part of a dataset with dimensions with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPartWithDimensionsCustomizedPython(
  ...getPartWithDimensionsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for part generation including asset selection, terrain algorithms, and visual rendering
   */
  ...GetPartOptions,
): TileResponse;

@@override(TilerParts.getCroppedToBoundingBoxWidthByHeight,
  getPartWithDimensionsCustomized,
  "!python"
);

@@override(TilerParts.getCroppedToBoundingBoxWidthByHeight,
  getPartWithDimensionsCustomizedPython,
  "python"
);

/**
 * Create preview of a dataset with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPreviewCustomized(
  ...getPreviewCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for preview generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetPreviewOptions,
): TileResponse;

/**
 * Create preview of a dataset with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPreviewCustomizedPython(
  ...getPreviewCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for preview generation including asset selection, terrain algorithms, and visual rendering
   */
  ...GetPreviewOptions,
): TileResponse;

@@override(TilerPreviews.get, getPreviewCustomized, "!python");

@@override(TilerPreviews.get, getPreviewCustomizedPython, "python");

/**
 * Create preview of a dataset with format with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPreviewWithFormatCustomized(
  ...getPreviewWithFormatCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for preview generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetPreviewOptions,
): TileResponse;

/**
 * Create preview of a dataset with format with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getPreviewWithFormatCustomizedPython(
  ...getPreviewWithFormatCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for preview generation including asset selection, terrain algorithms, and visual rendering
   */
  ...GetPreviewOptions,
): TileResponse;

@@override(TilerPreviews.getFormat, getPreviewWithFormatCustomized, "!python");

@@override(TilerPreviews.getFormat,
  getPreviewWithFormatCustomizedPython,
  "python"
);

/**
 * Merged assets statistics with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op listStatisticsCustomized(
  ...listStatisticsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for statistics including asset selection and statistical calculation parameters
   */
  options: GetStatisticsOptions,
): StatisticsResponse;

/**
 * Merged assets statistics with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "These operations return collections."
op listStatisticsCustomizedPython(
  ...listStatisticsCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for statistics including asset selection and statistical calculation parameters
   */
  ...GetStatisticsOptions,
): StatisticsResponse;

@@override(TilerStatistics.getAll, listStatisticsCustomized, "!python");

@@override(TilerStatistics.getAll, listStatisticsCustomizedPython, "python");

/**
 * Return the TileJson with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileJsonCustomized(
  ...getTileJsonCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for TileJSON generation including asset selection, terrain algorithms, and tile formatting
   */
  options: GetTileJsonOptions,
): TileJsonMetaData;

/**
 * Return the TileJson with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getTileJsonCustomizedPython(
  ...getTileJsonCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for TileJSON generation including asset selection, terrain algorithms, and tile formatting
   */
  ...GetTileJsonOptions,
): TileJsonMetaData;

@@override(TilerTileJsonTileMatrixSets.get, getTileJsonCustomized, "!python");

@@override(TilerTileJsonTileMatrixSets.get,
  getTileJsonCustomizedPython,
  "python"
);

/**
 * Return TileJSON document for a searchId with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getMosaicsTileJsonCustomized(
  ...getMosaicsTileJsonCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for mosaic TileJSON generation including asset selection, terrain algorithms, and tile formatting
   */
  options: GetMosaicTileJsonOptions,
): TileJsonMetaData;

/**
 * Return TileJSON document for a searchId with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getMosaicsTileJsonCustomizedPython(
  ...getMosaicsTileJsonCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for mosaic TileJSON generation including asset selection, terrain algorithms, and tile formatting
   */
  ...GetMosaicTileJsonOptions,
): TileJsonMetaData;

@@override(MosaicsTileMatrixSetsTileJson.get,
  getMosaicsTileJsonCustomized,
  "!python"
);

@@override(MosaicsTileMatrixSetsTileJson.get,
  getMosaicsTileJsonCustomizedPython,
  "python"
);

/**
 * Create map tile from mosaic with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getMosaicsTileCustomized(
  ...getMosaicsTileCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for mosaic tile generation including asset selection, terrain algorithms, and visual rendering
   */
  options: GetMosaicTileOptions,
): TileResponse;

/**
 * Create map tile from mosaic with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getMosaicsTileCustomizedPython(
  ...getMosaicsTileCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for mosaic tile generation including asset selection, terrain algorithms, and visual rendering
   */
  ...GetMosaicTileOptions,
): TileResponse;

@@override(MosaicsTileMatrixSets.getZxyScaleByFormat,
  getMosaicsTileCustomized,
  "!python"
);

@@override(MosaicsTileMatrixSets.getZxyScaleByFormat,
  getMosaicsTileCustomizedPython,
  "python"
);

/**
 * OGC WMTS endpoint for mosaics with grouped parameters.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getMosaicsWmtsCapabilitiesCustomized(
  ...getMosaicsWmtsCapabilitiesCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for mosaic WMTS capabilities including asset selection, terrain algorithms, and tile formatting
   */
  options: GetMosaicWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

/**
 * OGC WMTS endpoint for mosaics with grouped parameters (Python-specific).
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation override."
op getMosaicsWmtsCapabilitiesCustomizedPython(
  ...getMosaicsWmtsCapabilitiesCustomizedCommonSignatures,

  /**
   * API version
   */
  @query apiVersion: string,

  /**
   * Options for mosaic WMTS capabilities including asset selection, terrain algorithms, and tile formatting
   */
  ...GetMosaicWmtsCapabilitiesOptions,
): WmtsCapabilitiesXmlResponse;

@@override(MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml,
  getMosaicsWmtsCapabilitiesCustomized,
  "!python"
);

@@override(MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml,
  getMosaicsWmtsCapabilitiesCustomizedPython,
  "python"
);
