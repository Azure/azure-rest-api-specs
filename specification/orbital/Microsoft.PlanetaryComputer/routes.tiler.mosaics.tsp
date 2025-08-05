// Tiles for STAC Collections Mosaics interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tiler.common.tsp";
import "./models.tiler.mosaics.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.PlanetaryComputer;
interface MosaicsTiles {
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...AlgorithmQueryParameters;
      ...ZxyPathParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

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
    },
    TileResponse | NoContentResponse
  >;
}

interface MosaicsTileMatrixSets {
  /**
   * Create map tile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}@{scale}x.{format}")
  @get
  getZxyScalexFormat is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...AlgorithmQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;

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
    },
    TileResponse | NoContentResponse
  >;
}

interface MosaicsTileJsonOperations {
  /**
   * Return TileJSON document for a searchId.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default: 'WebMercatorQuad').
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: ImageType;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @query("tile_scale")
      @minValueExclusive(0)
      @maxValueExclusive(4)
      tileScale?: int32;

      ...ZoomQueryParameters;

      /**
       * Buffer on each side of the given tile. It must be a multiple of `0.5`. Output
       * **tilesize** will be expanded to `tilesize + 2 * buffer` (e.g 0.5 = 257x257,
       * 1.0 = 258x258).
       */
      @query("buffer")
      @minValueExclusive(0)
      buffer?: float64;

      /**
       * rio-color formula (info: https://github.com/mapbox/rio-color)
       */
      @query("color_formula")
      colorFormula?: string;

      /**
       * STAC Collection ID
       */
      @query("collection")
      collection?: string;

      /**
       * Resampling method
       */
      @query("resampling")
      resampling?: Resampling = Resampling.nearest;

      /**
       * Pixel selection method.
       */
      @query("pixel_selection")
      pixelSelection?: PixelSelection = PixelSelection.first;

      /**
       * Algorithm name
       */
      @query("algorithm")
      algorithm?: Algorithm;

      /**
       * Algorithm parameter
       */
      @query("algorithm_params")
      algorithmParams?: string;

      /**
       * comma (',') delimited Min,Max range. Can set multiple time for multiple bands.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "This is an existing service operation."
      @query(#{ explode: true })
      rescale?: string[];

      /**
       * Colormap name
       */
      @query("colormap_name")
      colormapName?: ColorMapNames;

      /**
       * JSON encoded custom Colormap
       */
      @query("colormap")
      colormap?: string;

      /**
       * Add mask to the output data.
       */
      @query("return_mask")
      returnMask?: boolean = true;
    },
    TileJsonResponse
  >;
}

interface MosaicsTileMatrixSetsTileJson {
  /**
   * Return TileJSON document for a searchId.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Tilejson Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/{tileMatrixSetId}/tilejson.json")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...AssetQueryParameters;
      ...MosaicSearchQueryParameters;
      ...AlgorithmQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZoomQueryParameters;

      /**
       * Default will be automatically defined if the output image needs a mask (png) or
       * not (jpeg).
       */
      @query("tile_format")
      tileFormat?: ImageType;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32;

      ...MosaicTileQueryParameters;
      ...MiscTileQueryParameters;
    },
    TileJsonResponse
  >;
}

interface MosaicsWmtsMosaics {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
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
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;

      /**
       * Output image type. Default is png.
       */
      @query("tile_format")
      tileFormat?: ImageType = ImageType.png;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32 = 1;

      ...ZoomQueryParameters;
    },
    WmtsCapabilitiesXmlResponse | NoContentResponse
  >;
}

interface MosaicsWmtsMosaicsTileMatrixSets {
  /**
   * OGC WMTS endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Wmts Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/{tileMatrixSetId}/WMTSCapabilities.xml")
  @get
  getCapabilitiesXml is Azure.Core.Foundations.Operation<
    {
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
      tileFormat?: ImageType = ImageType.png;

      /**
       * Tile scale factor affecting output size. Values > 1 produce larger tiles (e.g., 1=256x256, 2=512x512).
       */
      @maxValueExclusive(4)
      @query("tile_scale")
      tileScale?: int32 = 1;

      ...ZoomQueryParameters;
    },
    WmtsCapabilitiesXmlResponse | NoContentResponse
  >;
}

interface MosaicsRegisterSearch {
  /**
   * Register a Search query
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Register Search")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/register")
  @post
  register is Azure.Core.Foundations.Operation<
    RegisterMosaic,
    RegisterResponse
  >;
}

interface MosaicsInfoSearch {
  /**
   * Get Search query metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Info Search")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/info")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;
    },
    TitilerPgstacModelInfo
  >;
}

interface MosaicsAssetsForTiles {
  /**
   * Return a list of assets which overlap a given tile
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Assets For Tile")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;
      ...ZxyPathParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported (default:
       * 'WebMercatorQuad')
       */
      @query("tileMatrixSetId")
      tileMatrixSetId?: Tilematrixsetid = Tilematrixsetid.WebMercatorQuad;
    },
    ApplicationJsonResponse | NoContentResponse
  >;
}

interface MosaicsAssetsForTileMatrixSets {
  /**
   * Return a list of assets which overlap a given tile
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Assets For Tile Tilematrixsetid As Path")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/tiles/{tileMatrixSetId}/{z}/{x}/{y}/assets")
  @get
  getZxyAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;

      /**
       * Identifier selecting one of the TileMatrixSetId supported
       */
      @path
      @maxLength(500)
      @pattern(".*")
      tileMatrixSetId: string;

      ...ZxyPathParameters;
    },
    ApplicationJsonResponse | NoContentResponse
  >;
}

interface MosaicsAssetsForPoints {
  /**
   * Return a list of assets for a given point.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Assets For Point")
  @tag("Tiles for STAC Collections Mosaics")
  @route("/data/mosaic/{searchId}/{lon},{lat}/assets")
  @get
  getLonLatAssets is Azure.Core.Foundations.Operation<
    {
      /**
       * Search Id (pgSTAC Search Hash)
       */
      @path
      @maxLength(500)
      @pattern(".*")
      searchId: string;

      ...MosaicSearchQueryParameters;

      /**
       * Longitude
       */
      @path
      lon: float32;

      /**
       * Latitude
       */
      @path
      lat: float32;

      /**
       * Coordinate Reference System of the input coords. Default to `epsg:4326`.
       */
      @query("coord-crs")
      coordCrs?: string;
    },
    ApplicationJsonResponse | NoContentResponse
  >;
}
