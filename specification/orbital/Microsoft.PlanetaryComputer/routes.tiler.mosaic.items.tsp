// ===========================================================================================
// Tiler endpoints missing in preview, but added in stable version 2026-04-15 to /data/mosaic/
// ===========================================================================================

// Tiles for STAC Items interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.common.tsp";
import "./models.tiler.items.tsp";
import "./models.common.images.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

@added(Versions.v2026_04_15)
interface MosaicItemsTileSetList {
  /**
   * Return a list of available tilesets for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tileset List")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileSetList
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileSetMetadata {
  /**
   * Return metadata for a specific tileset of a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tileset Metadata")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;
    },
    TileSetMetadata
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsPlain {
  /**
   * Create map tile from a dataset (without scale or format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid Plain")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsFormat {
  /**
   * Create map tile from a dataset (with format in path, without scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsScaleByFormat {
  /**
   * Create map tile from a dataset (with TileMatrixSetId, scale, and format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsScale {
  /**
   * Create map tile from a dataset (with scale in path, without format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid Scale")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesPlain {
  /**
   * Create map tile from a dataset (without TileMatrixSetId, scale or format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Plain")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesFormat {
  /**
   * Create map tile from a dataset (with format in path, without TileMatrixSetId or scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesScaleByFormat {
  /**
   * Create map tile from a dataset (with scale and format in path, without TileMatrixSetId).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTilesScale {
  /**
   * Create map tile from a dataset (with scale in path, without TileMatrixSetId or format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Scale")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tiles/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsFeatureGeoJson {
  /**
   * Create image from a geojson feature (without format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Feature")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/feature")
  @post
  crop is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Output image format.
       */
      @query("format")
      format?: TilerImageFormat;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}

// =====================================================================
// Item Mosaic Bbox Crop
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsBbox {
  /**
   * Create an image from part of a STAC item dataset (bounding box crop).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Bbox")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/bbox/{minx},{miny},{maxx},{maxy}.{format}")
  @get
  getCroppedToBoundingBox is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsBboxWithDimensions {
  /**
   * Create an image from part of a STAC item dataset (bounding box crop with dimensions).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Bbox With Dimensions")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/bbox/{minx},{miny},{maxx},{maxy}/{width}x{height}.{format}")
  @get
  getCroppedToBoundingBoxWidthByHeight is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsFeatureGeoJsonFormat {
  /**
   * Create image from a geojson feature with format.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Feature Crop With Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/feature.{format}")
  @post
  cropFormat is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}
// =====================================================================
// Item Mosaic Bounds
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsBounds {
  /**
   * Return the bounds for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Bounds")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/bounds")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    StacItemBounds
  >;
}

// =====================================================================
// Item Mosaic Info
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsInfo {
  /**
   * Return dataset's basic info for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Info")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/info")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];
    },
    TilerInfoMapResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsInfoGeoJson {
  /**
   * Return info as GeoJSON for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Info Geojson")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/info.geojson")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];
    },
    TilerInfoGeoJsonFeature
  >;
}

// =====================================================================
// Item Mosaic Available Assets
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsAvailableAssets {
  /**
   * Return a list of supported assets for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Available Assets")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/assets")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    AvailableAssets
  >;
}

// =====================================================================
// Item Mosaic Statistics
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsAssetStatistics {
  /**
   * Per asset statistics for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Asset Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/asset_statistics")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * Dataset band indexes
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      bidx?: int32[];

      /**
       * Asset's names.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      assets?: string[];

      /**
       * Per asset band indexes (coma separated indexes, e.g. "image|1,2,3" means use the bands 1, 2, and 3 from the asset named "image")
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query("asset_bidx")
      @typeChangedFrom(Versions.v2026_04_15, string)
      assetBandIndices?: string[];

      /**
       * Overwrite internal Nodata value
       */
      @query("nodata")
      @typeChangedFrom(Versions.v2026_04_15, float32)
      noData?: string;

      /**
       * Apply internal Scale or Offset
       */
      @query("unscale")
      unscale?: boolean;

      /**
       * WarpKernel resampling algorithm (only used when doing re-projection). Defaults to `nearest`.
       */
      @query("reproject")
      reproject?: WarpKernelResampling;

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

      ...StatisticsQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Per asset band expression.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query("asset_expression")
      @query(#{ explode: true })
      assetExpression?: string[];

      /**
       * Force output image height.
       */
      @query("height")
      height?: int32;

      /**
       * Force output image width.
       */
      @query("width")
      width?: int32;
    },
    AssetStatisticsResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsStatistics {
  /**
   * Merged assets statistics for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/statistics")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;

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

      ...StatisticsQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Algorithm name.
       */
      @query("algorithm")
      algorithm?: string;

      /**
       * Algorithm parameter.
       */
      @query("algorithm_params")
      algorithmParams?: string;

      /**
       * Force output image height.
       */
      @query("height")
      height?: int32;

      /**
       * Force output image width.
       */
      @query("width")
      width?: int32;
    },
    TilerStacItemStatistics
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsGeoJsonStatistics {
  /**
   * Get statistics from a GeoJSON feature for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Geojson Statistics")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/statistics")
  @post
  get is Azure.Core.Foundations.Operation<
    {
      ...AssetQueryParameters;

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
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;

      ...StatisticsQueryParameters;
      ...DstCrsQueryParameter;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Algorithm name.
       */
      @query("algorithm")
      algorithm?: string;

      /**
       * Algorithm parameter.
       */
      @query("algorithm_params")
      algorithmParams?: string;

      /**
       * Force output image height.
       */
      @query("height")
      height?: int32;

      /**
       * Force output image width.
       */
      @query("width")
      width?: int32;

      /**
       * Request GeoJson body
       */
      @body
      body: Feature;
    },
    StacItemStatisticsGeoJson
  >;
}

// =====================================================================
// Item Mosaic TileJson
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsTileJson {
  /**
   * Return TileJSON document for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item TileJson")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: TilerImageFormat;

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
      ...CollectionQueryParameter;
    },
    TileJsonMetadata
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsTileMatrixSetsTileJson {
  /**
   * Return TileJSON document for a STAC item with TileMatrixSetId as path.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item TileJson Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: TilerImageFormat;

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
      ...CollectionQueryParameter;
    },
    TileJsonMetadata
  >;
}

// =====================================================================
// Item Mosaic WMTS
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsWmts {
  /**
   * OGC WMTS endpoint for a STAC item.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Wmts")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    WmtsCapabilitiesXmlResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsWmtsTileMatrixSets {
  /**
   * OGC WMTS endpoint for a STAC item with TileMatrixSetId as path.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
    },
    WmtsCapabilitiesXmlResponse
  >;
}

// =====================================================================
// Item Mosaic Point
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsPoint {
  /**
   * Get point value for a STAC item dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Point")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/point/{longitude},{latitude}")
  @get
  getPoint is Azure.Core.Foundations.Operation<
    {
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
       * Longitude
       */
      @path
      longitude: float32;

      /**
       * Latitude
       */
      @path
      latitude: float32;

      ...AssetQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

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
    },
    TilerCoreModelsResponsesPoint
  >;
}

// =====================================================================
// Item Mosaic Preview
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicItemsPreviewFormat {
  /**
   * Create preview of a STAC item dataset with format.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Preview With Format")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/preview.{format}")
  @get
  getFormat is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicItemsPreview {
  /**
   * Create preview of a STAC item dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Item Preview")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/preview")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MiscTileQueryParameters;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;
    },
    TileResponse
  >;
}

// =====================================================================
// Item Mosaic Bbox Crop
// =====================================================================
@added(Versions.v2026_04_15)
interface MosaicItemsFeatureGeoJsonWidthByHeight {
  /**
   * Create image from a geojson feature with dimensions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Geojson Feature Crop With Dimensions")
  @tag("Tiles for STAC Items")
  @route("/data/mosaic/collections/{collectionId}/items/{itemId}/feature/{width}x{height}.{format}")
  @post
  cropWidthByHeightFormat is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;
      ...SubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}
