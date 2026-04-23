// Collection-level Mosaic endpoints (stable 2026-04-15 only)
// Based on: https://github.com/stac-utils/titiler-pgstac/blob/1.8.1/docs/src/endpoints/collections_endpoints.md
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tiler.common.tsp";
import "./models.tiler.mosaics.tsp";
import "./models.tiler.items.tsp";
import "./models.common.versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

// =====================================================================
// Collection Mosaic Tileset List and Metadata
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileSetList {
  /**
   * Return a list of available tilesets for a STAC collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tileset List")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...CollectionMosaicFilterQueryParameters;
      ...CollectionSubDatasetQueryParameters;
      ...CollectionQueryParameter;

      /**
       * STAC Collection Identifier
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    TileSetList
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileSetMetadata {
  /**
   * Return metadata for a specific tileset of a STAC collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tileset Metadata")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{tileMatrixSetId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      ...CollectionMosaicFilterQueryParameters;
      ...CollectionSubDatasetQueryParameters;
      ...CollectionQueryParameter;

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
    },
    TileSetMetadata
  >;
}

// =====================================================================
// Collection Mosaic Tiles - TileMatrixSetId as path
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileMatrixSets {
  /**
   * Create map tile for a STAC collection (with TileMatrixSetId, scale, and format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Tilematrixsetid")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileMatrixSetsPlain {
  /**
   * Create map tile for a STAC collection (with TileMatrixSetId, without scale or format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Tilematrixsetid Plain")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileMatrixSetsFormat {
  /**
   * Create map tile for a STAC collection (with TileMatrixSetId and format, without scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Tilematrixsetid Format")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileMatrixSetsScale {
  /**
   * Create map tile for a STAC collection (with TileMatrixSetId and scale, without format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Tilematrixsetid Scale")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

// =====================================================================
// Collection Mosaic Tiles - without TileMatrixSetId in path
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsTiles {
  /**
   * Create map tile for a STAC collection (without TileMatrixSetId, with scale and format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScaleByFormat is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTilesPlain {
  /**
   * Create map tile for a STAC collection (without TileMatrixSetId, scale, or format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Plain")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{z}/{x}/{y}")
  @get
  getZxy is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTilesFormat {
  /**
   * Create map tile for a STAC collection (with format, without TileMatrixSetId or scale).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Format")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{z}/{x}/{y}.{format}")
  @get
  getZxyByFormat is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTilesScale {
  /**
   * Create map tile for a STAC collection (with scale, without TileMatrixSetId or format).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Tile Scale")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{z}/{x}/{y}@{scale}x")
  @get
  getZxyByScale is Azure.Core.Foundations.Operation<
    {
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
    },
    TileResponse
  >;
}

// =====================================================================
// Collection Mosaic TileJSON
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileJson {
  /**
   * Return TileJSON document for a STAC collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection TileJson")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileJsonMetadata
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsTileMatrixSetsTileJson {
  /**
   * Return TileJSON document for a STAC collection with TileMatrixSetId as path.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection TileJson Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
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
      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
      ...TilePaddingQueryParameters;
    },
    TileJsonMetadata
  >;
}

// =====================================================================
// Collection Mosaic WMTS
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsWmts {
  /**
   * OGC WMTS endpoint for a STAC collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Wmts")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
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
    },
    WmtsCapabilitiesXmlResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsWmtsTileMatrixSets {
  /**
   * OGC WMTS endpoint for a STAC collection with TileMatrixSetId as path.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
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
    },
    WmtsCapabilitiesXmlResponse
  >;
}

// =====================================================================
// Collection Mosaic Assets
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsAssetsForTiles {
  /**
   * Return a list of assets which overlap a given tile for a STAC collection (without TileMatrixSetId).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Assets For Tile")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
      ...ZxyPathParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("TileMatrixSetId")
      tileMatrixSetId?: TileMatrixSetId = TileMatrixSetId.WebMercatorQuad;
    },
    ApplicationJsonResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsAssetsForTileMatrixSets {
  /**
   * Return a list of assets which overlap a given tile for a STAC collection (with TileMatrixSetId).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Assets For Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;
    },
    TilerAssetGeoJson[]
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsAssetsForBbox {
  /**
   * Return a list of assets which overlap a given bounding box for a STAC collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Assets For Bbox")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/bbox/{minx},{miny},{maxx},{maxy}/assets")
  @get
  getBboxAssets is Azure.Core.Foundations.Operation<
    {
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
      ...CollectionQueryParameter;
      ...BoundingBoxPathParameters;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord_crs")
      coordinateReferenceSystem?: string;
    },
    ApplicationJsonResponse
  >;
}

// =====================================================================
// Collection Mosaic Point, Info, Statistics
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsInfo {
  /**
   * Return search query info from a STAC collection identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Info")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/info")
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
    },
    TilerStacSearchRegistration
  >;
}

// =====================================================================
// Collection Mosaic Bbox Crop
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsBbox {
  /**
   * Create an image from part of a STAC collection dataset (bounding box crop).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Bbox")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/bbox/{minx},{miny},{maxx},{maxy}.{format}")
  @get
  getCroppedToBoundingBox is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsBboxWithDimensions {
  /**
   * Create an image from part of a STAC collection dataset (bounding box crop with dimensions).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Bbox With Dimensions")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/bbox/{minx},{miny},{maxx},{maxy}/{width}x{height}.{format}")
  @get
  getCroppedToBoundingBoxWidthByHeight is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileResponse
  >;
}

// =====================================================================
// Collection Mosaic Feature GeoJson Crop (POST with Feature body)
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsFeatureGeoJson {
  /**
   * Create image from a geojson feature (without format in path).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Geojson Feature")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/feature")
  @post
  crop is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;

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

@added(Versions.v2026_04_15)
interface MosaicCollectionsFeatureGeoJsonFormat {
  /**
   * Create image from a geojson feature with format.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Geojson Feature Crop With Format")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/feature.{format}")
  @post
  cropFormat is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...DimensionsQueryParameters;
      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;

      /**
       * Request GeoJson body.
       */
      @body
      body: Feature;
    },
    TileResponse
  >;
}

@added(Versions.v2026_04_15)
interface MosaicCollectionsFeatureGeoJsonWidthByHeight {
  /**
   * Create image from a geojson feature with dimensions.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Geojson Feature Crop With Dimensions")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/feature/{width}x{height}.{format}")
  @post
  cropWidthByHeightFormat is Azure.Core.Foundations.Operation<
    {
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
      @query("max_size")
      maxSize?: int32 = 1024;

      ...MosaicCropQueryParameters;
      ...MiscTileQueryParameters;
      ...DstCrsQueryParameter;

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
// Collection Mosaic Point
// =====================================================================

@added(Versions.v2026_04_15)
interface MosaicCollectionsPoint {
  /**
   * Get Point value for a collection dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Point")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/point/{longitude},{latitude}")
  @get
  getPoint is Azure.Core.Foundations.Operation<
    {
      ...MosaicSearchQueryParameters;
      ...CollectionMosaicFilterQueryParameters;
      ...CollectionSubDatasetQueryParameters;
      ...CollectionQueryParameter;

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

      ...AssetQueryParameters;

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

@added(Versions.v2026_04_15)
interface MosaicCollectionsPointAssets {
  /**
   * Return a list of assets for a given point in a collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Point Assets")
  @tag("Tiles for STAC Collections")
  @route("/data/mosaic/collections/{collectionId}/point/{longitude},{latitude}/assets")
  @get
  getPointAssets is Azure.Core.Foundations.Operation<
    {
      ...MosaicSearchQueryParameters;
      ...CollectionMosaicFilterQueryParameters;
      ...CollectionSubDatasetQueryParameters;
      ...CollectionQueryParameter;

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
    },
    StacItemPointAsset[]
  >;
}
