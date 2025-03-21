import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftPlanetaryComputerPro;

/**
 * rio-tiler Nodata types.
 */
/**
 * TODO: add description for NodataTypes
 */
union NodataTypes {
  string,

  /**
   * TODO: add description for Alpha
   */
  Alpha: "Alpha",

  /**
   * TODO: add description for Mask
   */
  Mask: "Mask",

  /**
   * TODO: add description for Internal
   */
  Internal: "Internal",

  /**
   * TODO: add description for Nodata
   */
  Nodata: "Nodata",

  /**
   * TODO: add description for None
   */
  None: "None",
}

/**
 * Type
 */
/**
 * TODO: add description for FeaturePolygonDictStrRioTilerModelsInfoType
 */
union FeaturePolygonDictStrRioTilerModelsInfoType {
  string,

  /**
   * TODO: add description for Feature
   */
  Feature: "Feature",
}

/**
 * Resampling method.
 */
/**
 * TODO: add description for Resampling
 */
union Resampling {
  string,

  /**
   * TODO: add description for nearest
   */
  nearest: "nearest",

  /**
   * TODO: add description for bilinear
   */
  bilinear: "bilinear",

  /**
   * TODO: add description for cubic
   */
  cubic: "cubic",

  /**
   * TODO: add description for cubic_spline
   */
  cubic_spline: "cubic_spline",

  /**
   * TODO: add description for lanczos
   */
  lanczos: "lanczos",

  /**
   * TODO: add description for average
   */
  average: "average",

  /**
   * TODO: add description for mode
   */
  mode: "mode",

  /**
   * TODO: add description for gauss
   */
  gauss: "gauss",

  /**
   * TODO: add description for rms
   */
  rms: "rms",
}

/**
 * Type
 */
/**
 * TODO: add description for FeatureCollectionType
 */
union FeatureCollectionType {
  string,

  /**
   * TODO: add description for FeatureCollection
   */
  FeatureCollection: "FeatureCollection",
}

/**
 * Type
 */
/**
 * TODO: add description for FeatureType
 */
union FeatureType {
  string,

  /**
   * TODO: add description for Feature
   */
  Feature: "Feature",
}

/**
 * Type
 */
/**
 * TODO: add description for GeojsonPydanticGeometriesPointType
 */
union GeojsonPydanticGeometriesPointType {
  string,

  /**
   * TODO: add description for Point
   */
  Point: "Point",
}

/**
 * Type
 */
/**
 * TODO: add description for FeatureCollectionAnnotatedUnionGeojsonPydanticGeometriesPointGeojsonPydanticGeometriesMultiPointGeojsonPydanticGeometriesLineStringGeojsonPydanticGeometriesMultiLineStringGeojsonPydanticGeometriesPolygonGeojsonPydanticGeometriesMultiPolygonFieldInfoDefaultPydanticUndefinedDiscriminatorTypeExtraStatisticsInGeoJsonType
 */
union FeatureCollectionAnnotatedUnionGeojsonPydanticGeometriesPointGeojsonPydanticGeometriesMultiPointGeojsonPydanticGeometriesLineStringGeojsonPydanticGeometriesMultiLineStringGeojsonPydanticGeometriesPolygonGeojsonPydanticGeometriesMultiPolygonFieldInfoDefaultPydanticUndefinedDiscriminatorTypeExtraStatisticsInGeoJsonType {
  string,

  /**
   * TODO: add description for FeatureCollection
   */
  FeatureCollection: "FeatureCollection",
}

/**
 * Type
 */
/**
 * TODO: add description for FeatureAnnotatedUnionGeojsonPydanticGeometriesPointGeojsonPydanticGeometriesMultiPointGeojsonPydanticGeometriesLineStringGeojsonPydanticGeometriesMultiLineStringGeojsonPydanticGeometriesPolygonGeojsonPydanticGeometriesMultiPolygonFieldInfoDefaultPydanticUndefinedDiscriminatorTypeExtraStatisticsInGeoJsonType
 */
union FeatureAnnotatedUnionGeojsonPydanticGeometriesPointGeojsonPydanticGeometriesMultiPointGeojsonPydanticGeometriesLineStringGeojsonPydanticGeometriesMultiLineStringGeojsonPydanticGeometriesPolygonGeojsonPydanticGeometriesMultiPolygonFieldInfoDefaultPydanticUndefinedDiscriminatorTypeExtraStatisticsInGeoJsonType {
  string,

  /**
   * TODO: add description for Feature
   */
  Feature: "Feature",
}

/**
 * Available Output image type.
 */
/**
 * TODO: add description for ImageType
 */
union ImageType {
  string,

  /**
   * TODO: add description for png
   */
  png: "png",

  /**
   * TODO: add description for npy
   */
  npy: "npy",

  /**
   * TODO: add description for tif
   */
  tif: "tif",

  /**
   * TODO: add description for jpeg
   */
  jpeg: "jpeg",

  /**
   * TODO: add description for jpg
   */
  jpg: "jpg",

  /**
   * TODO: add description for jp2
   */
  jp2: "jp2",

  /**
   * TODO: add description for webp
   */
  webp: "webp",

  /**
   * TODO: add description for pngraw
   */
  pngraw: "pngraw",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * TODO: add description for Tilematrixsetid
 */
union Tilematrixsetid {
  string,

  /**
   * TODO: add description for CanadianNAD83_LCC
   */
  CanadianNAD83_LCC: "CanadianNAD83_LCC",

  /**
   * TODO: add description for EuropeanETRS89_LAEAQuad
   */
  EuropeanETRS89_LAEAQuad: "EuropeanETRS89_LAEAQuad",

  /**
   * TODO: add description for LINZAntarticaMapTilegrid
   */
  LINZAntarticaMapTilegrid: "LINZAntarticaMapTilegrid",

  /**
   * TODO: add description for NZTM2000Quad
   */
  NZTM2000Quad: "NZTM2000Quad",

  /**
   * TODO: add description for UPSAntarcticWGS84Quad
   */
  UPSAntarcticWGS84Quad: "UPSAntarcticWGS84Quad",

  /**
   * TODO: add description for UPSArcticWGS84Quad
   */
  UPSArcticWGS84Quad: "UPSArcticWGS84Quad",

  /**
   * TODO: add description for UTM31WGS84Quad
   */
  UTM31WGS84Quad: "UTM31WGS84Quad",

  /**
   * TODO: add description for WGS1984Quad
   */
  WGS1984Quad: "WGS1984Quad",

  /**
   * TODO: add description for WebMercatorQuad
   */
  WebMercatorQuad: "WebMercatorQuad",

  /**
   * TODO: add description for WorldCRS84Quad
   */
  WorldCRS84Quad: "WorldCRS84Quad",

  /**
   * TODO: add description for WorldMercatorWGS84Quad
   */
  WorldMercatorWGS84Quad: "WorldMercatorWGS84Quad",
}

/**
 * Algorithm name
 */
/**
 * TODO: add description for Algorithm
 */
union Algorithm {
  string,

  /**
   * TODO: add description for hillshade
   */
  hillshade: "hillshade",

  /**
   * TODO: add description for contours
   */
  contours: "contours",

  /**
   * TODO: add description for normalizedIndex
   */
  normalizedIndex: "normalizedIndex",

  /**
   * TODO: add description for terrarium
   */
  terrarium: "terrarium",

  /**
   * TODO: add description for terrainrgb
   */
  terrainrgb: "terrainrgb",
}

/**
 * An enumeration.
 */
/**
 * TODO: add description for ColorMapNames
 */
union ColorMapNames {
  string,

  /**
   * TODO: add description for accent
   */
  accent: "accent",

  /**
   * TODO: add description for accent_r
   */
  accent_r: "accent_r",

  /**
   * TODO: add description for afmhot
   */
  afmhot: "afmhot",

  /**
   * TODO: add description for afmhot_r
   */
  afmhot_r: "afmhot_r",

  /**
   * TODO: add description for ai4g-lulc
   */
  `ai4g-lulc`: "ai4g-lulc",

  /**
   * TODO: add description for alos-fnf
   */
  `alos-fnf`: "alos-fnf",

  /**
   * TODO: add description for alos-palsar-mask
   */
  `alos-palsar-mask`: "alos-palsar-mask",

  /**
   * TODO: add description for autumn
   */
  autumn: "autumn",

  /**
   * TODO: add description for autumn_r
   */
  autumn_r: "autumn_r",

  /**
   * TODO: add description for binary
   */
  binary: "binary",

  /**
   * TODO: add description for binary_r
   */
  binary_r: "binary_r",

  /**
   * TODO: add description for blues
   */
  blues: "blues",

  /**
   * TODO: add description for blues_r
   */
  blues_r: "blues_r",

  /**
   * TODO: add description for bone
   */
  bone: "bone",

  /**
   * TODO: add description for bone_r
   */
  bone_r: "bone_r",

  /**
   * TODO: add description for brbg
   */
  brbg: "brbg",

  /**
   * TODO: add description for brbg_r
   */
  brbg_r: "brbg_r",

  /**
   * TODO: add description for brg
   */
  brg: "brg",

  /**
   * TODO: add description for brg_r
   */
  brg_r: "brg_r",

  /**
   * TODO: add description for bugn
   */
  bugn: "bugn",

  /**
   * TODO: add description for bugn_r
   */
  bugn_r: "bugn_r",

  /**
   * TODO: add description for bupu
   */
  bupu: "bupu",

  /**
   * TODO: add description for bupu_r
   */
  bupu_r: "bupu_r",

  /**
   * TODO: add description for bwr
   */
  bwr: "bwr",

  /**
   * TODO: add description for bwr_r
   */
  bwr_r: "bwr_r",

  /**
   * TODO: add description for c-cap
   */
  `c-cap`: "c-cap",

  /**
   * TODO: add description for cfastie
   */
  cfastie: "cfastie",

  /**
   * TODO: add description for chesapeake-lc-13
   */
  `chesapeake-lc-13`: "chesapeake-lc-13",

  /**
   * TODO: add description for chesapeake-lc-7
   */
  `chesapeake-lc-7`: "chesapeake-lc-7",

  /**
   * TODO: add description for chesapeake-lu
   */
  `chesapeake-lu`: "chesapeake-lu",

  /**
   * TODO: add description for chloris-biomass
   */
  `chloris-biomass`: "chloris-biomass",

  /**
   * TODO: add description for cividis
   */
  cividis: "cividis",

  /**
   * TODO: add description for cividis_r
   */
  cividis_r: "cividis_r",

  /**
   * TODO: add description for cmrmap
   */
  cmrmap: "cmrmap",

  /**
   * TODO: add description for cmrmap_r
   */
  cmrmap_r: "cmrmap_r",

  /**
   * TODO: add description for cool
   */
  cool: "cool",

  /**
   * TODO: add description for cool_r
   */
  cool_r: "cool_r",

  /**
   * TODO: add description for coolwarm
   */
  coolwarm: "coolwarm",

  /**
   * TODO: add description for coolwarm_r
   */
  coolwarm_r: "coolwarm_r",

  /**
   * TODO: add description for copper
   */
  copper: "copper",

  /**
   * TODO: add description for copper_r
   */
  copper_r: "copper_r",

  /**
   * TODO: add description for cubehelix
   */
  cubehelix: "cubehelix",

  /**
   * TODO: add description for cubehelix_r
   */
  cubehelix_r: "cubehelix_r",

  /**
   * TODO: add description for dark2
   */
  dark2: "dark2",

  /**
   * TODO: add description for dark2_r
   */
  dark2_r: "dark2_r",

  /**
   * TODO: add description for drcog-lulc
   */
  `drcog-lulc`: "drcog-lulc",

  /**
   * TODO: add description for esa-cci-lc
   */
  `esa-cci-lc`: "esa-cci-lc",

  /**
   * TODO: add description for esa-worldcover
   */
  `esa-worldcover`: "esa-worldcover",

  /**
   * TODO: add description for flag
   */
  flag: "flag",

  /**
   * TODO: add description for flag_r
   */
  flag_r: "flag_r",

  /**
   * TODO: add description for gap-lulc
   */
  `gap-lulc`: "gap-lulc",

  /**
   * TODO: add description for gist_earth
   */
  gist_earth: "gist_earth",

  /**
   * TODO: add description for gist_earth_r
   */
  gist_earth_r: "gist_earth_r",

  /**
   * TODO: add description for gist_gray
   */
  gist_gray: "gist_gray",

  /**
   * TODO: add description for gist_gray_r
   */
  gist_gray_r: "gist_gray_r",

  /**
   * TODO: add description for gist_heat
   */
  gist_heat: "gist_heat",

  /**
   * TODO: add description for gist_heat_r
   */
  gist_heat_r: "gist_heat_r",

  /**
   * TODO: add description for gist_ncar
   */
  gist_ncar: "gist_ncar",

  /**
   * TODO: add description for gist_ncar_r
   */
  gist_ncar_r: "gist_ncar_r",

  /**
   * TODO: add description for gist_rainbow
   */
  gist_rainbow: "gist_rainbow",

  /**
   * TODO: add description for gist_rainbow_r
   */
  gist_rainbow_r: "gist_rainbow_r",

  /**
   * TODO: add description for gist_stern
   */
  gist_stern: "gist_stern",

  /**
   * TODO: add description for gist_stern_r
   */
  gist_stern_r: "gist_stern_r",

  /**
   * TODO: add description for gist_yarg
   */
  gist_yarg: "gist_yarg",

  /**
   * TODO: add description for gist_yarg_r
   */
  gist_yarg_r: "gist_yarg_r",

  /**
   * TODO: add description for gnbu
   */
  gnbu: "gnbu",

  /**
   * TODO: add description for gnbu_r
   */
  gnbu_r: "gnbu_r",

  /**
   * TODO: add description for gnuplot
   */
  gnuplot: "gnuplot",

  /**
   * TODO: add description for gnuplot2
   */
  gnuplot2: "gnuplot2",

  /**
   * TODO: add description for gnuplot2_r
   */
  gnuplot2_r: "gnuplot2_r",

  /**
   * TODO: add description for gnuplot_r
   */
  gnuplot_r: "gnuplot_r",

  /**
   * TODO: add description for gray
   */
  gray: "gray",

  /**
   * TODO: add description for gray_r
   */
  gray_r: "gray_r",

  /**
   * TODO: add description for greens
   */
  greens: "greens",

  /**
   * TODO: add description for greens_r
   */
  greens_r: "greens_r",

  /**
   * TODO: add description for greys
   */
  greys: "greys",

  /**
   * TODO: add description for greys_r
   */
  greys_r: "greys_r",

  /**
   * TODO: add description for hot
   */
  hot: "hot",

  /**
   * TODO: add description for hot_r
   */
  hot_r: "hot_r",

  /**
   * TODO: add description for hsv
   */
  hsv: "hsv",

  /**
   * TODO: add description for hsv_r
   */
  hsv_r: "hsv_r",

  /**
   * TODO: add description for inferno
   */
  inferno: "inferno",

  /**
   * TODO: add description for inferno_r
   */
  inferno_r: "inferno_r",

  /**
   * TODO: add description for io-bii
   */
  `io-bii`: "io-bii",

  /**
   * TODO: add description for io-lulc
   */
  `io-lulc`: "io-lulc",

  /**
   * TODO: add description for io-lulc-9-class
   */
  `io-lulc-9-class`: "io-lulc-9-class",

  /**
   * TODO: add description for jet
   */
  jet: "jet",

  /**
   * TODO: add description for jet_r
   */
  jet_r: "jet_r",

  /**
   * TODO: add description for jrc-change
   */
  `jrc-change`: "jrc-change",

  /**
   * TODO: add description for jrc-extent
   */
  `jrc-extent`: "jrc-extent",

  /**
   * TODO: add description for jrc-occurrence
   */
  `jrc-occurrence`: "jrc-occurrence",

  /**
   * TODO: add description for jrc-recurrence
   */
  `jrc-recurrence`: "jrc-recurrence",

  /**
   * TODO: add description for jrc-seasonality
   */
  `jrc-seasonality`: "jrc-seasonality",

  /**
   * TODO: add description for jrc-transitions
   */
  `jrc-transitions`: "jrc-transitions",

  /**
   * TODO: add description for lidar-classification
   */
  `lidar-classification`: "lidar-classification",

  /**
   * TODO: add description for lidar-hag
   */
  `lidar-hag`: "lidar-hag",

  /**
   * TODO: add description for lidar-hag-alternative
   */
  `lidar-hag-alternative`: "lidar-hag-alternative",

  /**
   * TODO: add description for lidar-intensity
   */
  `lidar-intensity`: "lidar-intensity",

  /**
   * TODO: add description for lidar-returns
   */
  `lidar-returns`: "lidar-returns",

  /**
   * TODO: add description for magma
   */
  magma: "magma",

  /**
   * TODO: add description for magma_r
   */
  magma_r: "magma_r",

  /**
   * TODO: add description for modis-10A1
   */
  `modis-10A1`: "modis-10A1",

  /**
   * TODO: add description for modis-10A2
   */
  `modis-10A2`: "modis-10A2",

  /**
   * TODO: add description for modis-13A1|Q1
   */
  `modis-13A1|Q1`: "modis-13A1|Q1",

  /**
   * TODO: add description for modis-14A1|A2
   */
  `modis-14A1|A2`: "modis-14A1|A2",

  /**
   * TODO: add description for modis-15A2H|A3H
   */
  `modis-15A2H|A3H`: "modis-15A2H|A3H",

  /**
   * TODO: add description for modis-16A3GF-ET
   */
  `modis-16A3GF-ET`: "modis-16A3GF-ET",

  /**
   * TODO: add description for modis-16A3GF-PET
   */
  `modis-16A3GF-PET`: "modis-16A3GF-PET",

  /**
   * TODO: add description for modis-17A2H|A2HGF
   */
  `modis-17A2H|A2HGF`: "modis-17A2H|A2HGF",

  /**
   * TODO: add description for modis-17A3HGF
   */
  `modis-17A3HGF`: "modis-17A3HGF",

  /**
   * TODO: add description for modis-64A1
   */
  `modis-64A1`: "modis-64A1",

  /**
   * TODO: add description for mtbs-severity
   */
  `mtbs-severity`: "mtbs-severity",

  /**
   * TODO: add description for nipy_spectral
   */
  nipy_spectral: "nipy_spectral",

  /**
   * TODO: add description for nipy_spectral_r
   */
  nipy_spectral_r: "nipy_spectral_r",

  /**
   * TODO: add description for nrcan-lulc
   */
  `nrcan-lulc`: "nrcan-lulc",

  /**
   * TODO: add description for ocean
   */
  ocean: "ocean",

  /**
   * TODO: add description for ocean_r
   */
  ocean_r: "ocean_r",

  /**
   * TODO: add description for oranges
   */
  oranges: "oranges",

  /**
   * TODO: add description for oranges_r
   */
  oranges_r: "oranges_r",

  /**
   * TODO: add description for orrd
   */
  orrd: "orrd",

  /**
   * TODO: add description for orrd_r
   */
  orrd_r: "orrd_r",

  /**
   * TODO: add description for paired
   */
  paired: "paired",

  /**
   * TODO: add description for paired_r
   */
  paired_r: "paired_r",

  /**
   * TODO: add description for pastel1
   */
  pastel1: "pastel1",

  /**
   * TODO: add description for pastel1_r
   */
  pastel1_r: "pastel1_r",

  /**
   * TODO: add description for pastel2
   */
  pastel2: "pastel2",

  /**
   * TODO: add description for pastel2_r
   */
  pastel2_r: "pastel2_r",

  /**
   * TODO: add description for pink
   */
  pink: "pink",

  /**
   * TODO: add description for pink_r
   */
  pink_r: "pink_r",

  /**
   * TODO: add description for piyg
   */
  piyg: "piyg",

  /**
   * TODO: add description for piyg_r
   */
  piyg_r: "piyg_r",

  /**
   * TODO: add description for plasma
   */
  plasma: "plasma",

  /**
   * TODO: add description for plasma_r
   */
  plasma_r: "plasma_r",

  /**
   * TODO: add description for prgn
   */
  prgn: "prgn",

  /**
   * TODO: add description for prgn_r
   */
  prgn_r: "prgn_r",

  /**
   * TODO: add description for prism
   */
  prism: "prism",

  /**
   * TODO: add description for prism_r
   */
  prism_r: "prism_r",

  /**
   * TODO: add description for pubu
   */
  pubu: "pubu",

  /**
   * TODO: add description for pubu_r
   */
  pubu_r: "pubu_r",

  /**
   * TODO: add description for pubugn
   */
  pubugn: "pubugn",

  /**
   * TODO: add description for pubugn_r
   */
  pubugn_r: "pubugn_r",

  /**
   * TODO: add description for puor
   */
  puor: "puor",

  /**
   * TODO: add description for puor_r
   */
  puor_r: "puor_r",

  /**
   * TODO: add description for purd
   */
  purd: "purd",

  /**
   * TODO: add description for purd_r
   */
  purd_r: "purd_r",

  /**
   * TODO: add description for purples
   */
  purples: "purples",

  /**
   * TODO: add description for purples_r
   */
  purples_r: "purples_r",

  /**
   * TODO: add description for qpe
   */
  qpe: "qpe",

  /**
   * TODO: add description for rainbow
   */
  rainbow: "rainbow",

  /**
   * TODO: add description for rainbow_r
   */
  rainbow_r: "rainbow_r",

  /**
   * TODO: add description for rdbu
   */
  rdbu: "rdbu",

  /**
   * TODO: add description for rdbu_r
   */
  rdbu_r: "rdbu_r",

  /**
   * TODO: add description for rdgy
   */
  rdgy: "rdgy",

  /**
   * TODO: add description for rdgy_r
   */
  rdgy_r: "rdgy_r",

  /**
   * TODO: add description for rdpu
   */
  rdpu: "rdpu",

  /**
   * TODO: add description for rdpu_r
   */
  rdpu_r: "rdpu_r",

  /**
   * TODO: add description for rdylbu
   */
  rdylbu: "rdylbu",

  /**
   * TODO: add description for rdylbu_r
   */
  rdylbu_r: "rdylbu_r",

  /**
   * TODO: add description for rdylgn
   */
  rdylgn: "rdylgn",

  /**
   * TODO: add description for rdylgn_r
   */
  rdylgn_r: "rdylgn_r",

  /**
   * TODO: add description for reds
   */
  reds: "reds",

  /**
   * TODO: add description for reds_r
   */
  reds_r: "reds_r",

  /**
   * TODO: add description for rplumbo
   */
  rplumbo: "rplumbo",

  /**
   * TODO: add description for schwarzwald
   */
  schwarzwald: "schwarzwald",

  /**
   * TODO: add description for seismic
   */
  seismic: "seismic",

  /**
   * TODO: add description for seismic_r
   */
  seismic_r: "seismic_r",

  /**
   * TODO: add description for set1
   */
  set1: "set1",

  /**
   * TODO: add description for set1_r
   */
  set1_r: "set1_r",

  /**
   * TODO: add description for set2
   */
  set2: "set2",

  /**
   * TODO: add description for set2_r
   */
  set2_r: "set2_r",

  /**
   * TODO: add description for set3
   */
  set3: "set3",

  /**
   * TODO: add description for set3_r
   */
  set3_r: "set3_r",

  /**
   * TODO: add description for spectral
   */
  spectral: "spectral",

  /**
   * TODO: add description for spectral_r
   */
  spectral_r: "spectral_r",

  /**
   * TODO: add description for spring
   */
  spring: "spring",

  /**
   * TODO: add description for spring_r
   */
  spring_r: "spring_r",

  /**
   * TODO: add description for summer
   */
  summer: "summer",

  /**
   * TODO: add description for summer_r
   */
  summer_r: "summer_r",

  /**
   * TODO: add description for tab10
   */
  tab10: "tab10",

  /**
   * TODO: add description for tab10_r
   */
  tab10_r: "tab10_r",

  /**
   * TODO: add description for tab20
   */
  tab20: "tab20",

  /**
   * TODO: add description for tab20_r
   */
  tab20_r: "tab20_r",

  /**
   * TODO: add description for tab20b
   */
  tab20b: "tab20b",

  /**
   * TODO: add description for tab20b_r
   */
  tab20b_r: "tab20b_r",

  /**
   * TODO: add description for tab20c
   */
  tab20c: "tab20c",

  /**
   * TODO: add description for tab20c_r
   */
  tab20c_r: "tab20c_r",

  /**
   * TODO: add description for terrain
   */
  terrain: "terrain",

  /**
   * TODO: add description for terrain_r
   */
  terrain_r: "terrain_r",

  /**
   * TODO: add description for twilight
   */
  twilight: "twilight",

  /**
   * TODO: add description for twilight_r
   */
  twilight_r: "twilight_r",

  /**
   * TODO: add description for twilight_shifted
   */
  twilight_shifted: "twilight_shifted",

  /**
   * TODO: add description for twilight_shifted_r
   */
  twilight_shifted_r: "twilight_shifted_r",

  /**
   * TODO: add description for usda-cdl
   */
  `usda-cdl`: "usda-cdl",

  /**
   * TODO: add description for usda-cdl-corn
   */
  `usda-cdl-corn`: "usda-cdl-corn",

  /**
   * TODO: add description for usda-cdl-cotton
   */
  `usda-cdl-cotton`: "usda-cdl-cotton",

  /**
   * TODO: add description for usda-cdl-soybeans
   */
  `usda-cdl-soybeans`: "usda-cdl-soybeans",

  /**
   * TODO: add description for usda-cdl-wheat
   */
  `usda-cdl-wheat`: "usda-cdl-wheat",

  /**
   * TODO: add description for usgs-lcmap
   */
  `usgs-lcmap`: "usgs-lcmap",

  /**
   * TODO: add description for viirs-10a1
   */
  `viirs-10a1`: "viirs-10a1",

  /**
   * TODO: add description for viirs-13a1
   */
  `viirs-13a1`: "viirs-13a1",

  /**
   * TODO: add description for viirs-14a1
   */
  `viirs-14a1`: "viirs-14a1",

  /**
   * TODO: add description for viirs-15a2H
   */
  `viirs-15a2H`: "viirs-15a2H",

  /**
   * TODO: add description for viridis
   */
  viridis: "viridis",

  /**
   * TODO: add description for viridis_r
   */
  viridis_r: "viridis_r",

  /**
   * TODO: add description for winter
   */
  winter: "winter",

  /**
   * TODO: add description for winter_r
   */
  winter_r: "winter_r",

  /**
   * TODO: add description for wistia
   */
  wistia: "wistia",

  /**
   * TODO: add description for wistia_r
   */
  wistia_r: "wistia_r",

  /**
   * TODO: add description for ylgn
   */
  ylgn: "ylgn",

  /**
   * TODO: add description for ylgn_r
   */
  ylgn_r: "ylgn_r",

  /**
   * TODO: add description for ylgnbu
   */
  ylgnbu: "ylgnbu",

  /**
   * TODO: add description for ylgnbu_r
   */
  ylgnbu_r: "ylgnbu_r",

  /**
   * TODO: add description for ylorbr
   */
  ylorbr: "ylorbr",

  /**
   * TODO: add description for ylorbr_r
   */
  ylorbr_r: "ylorbr_r",

  /**
   * TODO: add description for ylorrd
   */
  ylorrd: "ylorrd",

  /**
   * TODO: add description for ylorrd_r
   */
  ylorrd_r: "ylorrd_r",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * TileJSON scheme choice.
 */
/**
 * TODO: add description for SchemeEnum
 */
union SchemeEnum {
  string,

  /**
   * TODO: add description for xyz
   */
  xyz: "xyz",

  /**
   * TODO: add description for tms
   */
  tms: "tms",
}

/**
 * TODO: add description for TileJsonScheme
 */
union TileJsonScheme {
  string,

  /**
   * TODO: add description for xyz
   */
  xyz: "xyz",

  /**
   * TODO: add description for tms
   */
  tms: "tms",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Filter-Lang
 */
/**
 * TODO: add description for RegisterMosaicFilterLang
 */
union RegisterMosaicFilterLang {
  string,

  /**
   * TODO: add description for cql-json
   */
  `cql-json`: "cql-json",

  /**
   * TODO: add description for cql-text
   */
  `cql-text`: "cql-text",

  /**
   * TODO: add description for cql2-json
   */
  `cql2-json`: "cql2-json",
}

/**
 * Type
 */
/**
 * TODO: add description for MetadataType
 */
union MetadataType {
  string,

  /**
   * TODO: add description for mosaic
   */
  mosaic: "mosaic",

  /**
   * TODO: add description for search
   */
  search: "search",
}

/**
 * Responses Media types formerly known as MIME types.
 */
/**
 * TODO: add description for MediaType
 */
union MediaType {
  string,

  /**
   * TODO: add description for image/tiff
   */
  `image/tiff; application=geotiff`: "image/tiff; application=geotiff",

  /**
   * TODO: add description for image/jp2
   */
  `image/jp2`: "image/jp2",

  /**
   * TODO: add description for image/png
   */
  `image/png`: "image/png",

  /**
   * TODO: add description for image/jpeg
   */
  `image/jpeg`: "image/jpeg",

  /**
   * TODO: add description for image/jpg
   */
  `image/jpg`: "image/jpg",

  /**
   * TODO: add description for image/webp
   */
  `image/webp`: "image/webp",

  /**
   * TODO: add description for application/x-binary
   */
  `application/x-binary`: "application/x-binary",

  /**
   * TODO: add description for application/xml
   */
  `application/xml`: "application/xml",

  /**
   * TODO: add description for application/json
   */
  `application/json`: "application/json",

  /**
   * TODO: add description for application/geo+json
   */
  `application/geo+json`: "application/geo+json",

  /**
   * TODO: add description for text/html
   */
  `text/html`: "text/html",

  /**
   * TODO: add description for text/plain
   */
  `text/plain`: "text/plain",

  /**
   * TODO: add description for application/x-protobuf
   */
  `application/x-protobuf`: "application/x-protobuf",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Pixel selection method.
 */
/**
 * TODO: add description for PixelSelection
 */
union PixelSelection {
  string,

  /**
   * TODO: add description for first
   */
  first: "first",

  /**
   * TODO: add description for highest
   */
  highest: "highest",

  /**
   * TODO: add description for lowest
   */
  lowest: "lowest",

  /**
   * TODO: add description for mean
   */
  mean: "mean",

  /**
   * TODO: add description for median
   */
  median: "median",

  /**
   * TODO: add description for stdev
   */
  stdev: "stdev",

  /**
   * TODO: add description for lastbandlow
   */
  lastbandlow: "lastbandlow",

  /**
   * TODO: add description for lastbandhight
   */
  lastbandhight: "lastbandhight",
}

/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * Identifier selecting one of the TileMatrixSetId supported (default:
 * 'WebMercatorQuad')
 */
/**
 * An enumeration.
 */
/**
 * TODO: add description for ExportFormats
 */
union ExportFormats {
  string,

  /**
   * TODO: add description for png
   */
  png: "png",

  /**
   * TODO: add description for cog
   */
  cog: "cog",
}

/**
 * TODO: add description for ImageRequestFormat
 */
union ImageRequestFormat {
  string,

  /**
   * TODO: add description for png
   */
  png: "png",

  /**
   * TODO: add description for cog
   */
  cog: "cog",
}

/**
 * The corner of the tile matrix (_topLeft_ or _bottomLeft_) used as the origin
 * for numbering tile rows and columns. This corner is also a corner of the (0, 0)
 * tile.
 */
/**
 * TODO: add description for TileMatrixCornerOfOrigin
 */
union TileMatrixCornerOfOrigin {
  string,

  /**
   * TODO: add description for topLeft
   */
  topLeft: "topLeft",

  /**
   * TODO: add description for bottomLeft
   */
  bottomLeft: "bottomLeft",
}

/**
 * Dataset Bounding box
 */
/**
 * TODO: add description for Bounds
 */
model Bounds {
  /**
   * Bounds
   */
  /**
   * TODO: add description for bounds
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  bounds: string[];
}

/**
 * Dataset Info.
 */
/**
 * TODO: add description for RioTilerModelsInfo
 */
model RioTilerModelsInfo {
  /**
   * Bounds
   */
  /**
   * TODO: add description for bounds
   */
  bounds: string[];

  /**
   * Minzoom
   */
  /**
   * TODO: add description for minzoom
   */
  minzoom: int32;

  /**
   * Maxzoom
   */
  /**
   * TODO: add description for maxzoom
   */
  maxzoom: int32;

  /**
   * Band Metadata
   */
  /**
   * TODO: add description for bandMetadata
   */
  @encodedName("application/json", "band_metadata")
  bandMetadata: string[][];

  /**
   * Band Descriptions
   */
  /**
   * TODO: add description for bandDescriptions
   */
  @encodedName("application/json", "band_descriptions")
  bandDescriptions: string[][];

  /**
   * Dtype
   */
  /**
   * TODO: add description for dtype
   */
  dtype: string;

  /**
   * rio-tiler Nodata types.
   */
  /**
   * TODO: add description for nodataType
   */
  @encodedName("application/json", "nodata_type")
  nodataType: NodataTypes;

  /**
   * Colorinterp
   */
  /**
   * TODO: add description for colorinterp
   */
  colorinterp?: string[];

  /**
   * Scale
   */
  /**
   * TODO: add description for scale
   */
  scale?: float32;

  /**
   * Offset
   */
  /**
   * TODO: add description for offset
   */
  offset?: float32;

  /**
   * Colormap
   */
  colormap?: Record<int32[]>;
}

/**
 * Feature Model
 */
/**
 * TODO: add description for FeaturePolygonDictStrRioTilerModelsInfo
 */
model FeaturePolygonDictStrRioTilerModelsInfo {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: FeaturePolygonDictStrRioTilerModelsInfoType;

  /**
   * Polygon Model
   */
  /**
   * TODO: add description for geometry
   */
  geometry: Polygon;

  /**
   * Properties
   */
  properties: Record<RioTilerModelsInfo>;

  /**
   * Id
   */
  /**
   * TODO: add description for id
   */
  id?: string;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * Band statistics
 */
/**
 * TODO: add description for BandStatistics
 */
model BandStatistics {
  /**
   * Min
   */
  /**
   * TODO: add description for min
   */
  min: float32;

  /**
   * Max
   */
  /**
   * TODO: add description for max
   */
  max: float32;

  /**
   * Mean
   */
  /**
   * TODO: add description for mean
   */
  mean: float32;

  /**
   * Count
   */
  /**
   * TODO: add description for count
   */
  count: float32;

  /**
   * Sum
   */
  /**
   * TODO: add description for sum
   */
  sum: float32;

  /**
   * Std
   */
  /**
   * TODO: add description for std
   */
  std: float32;

  /**
   * Median
   */
  /**
   * TODO: add description for median
   */
  median: float32;

  /**
   * Majority
   */
  /**
   * TODO: add description for majority
   */
  majority: float32;

  /**
   * Minority
   */
  /**
   * TODO: add description for minority
   */
  minority: float32;

  /**
   * Unique
   */
  /**
   * TODO: add description for unique
   */
  unique: float32;

  /**
   * Histogram
   */
  /**
   * TODO: add description for histogram
   */
  histogram: string[][];

  /**
   * Valid Percent
   */
  /**
   * TODO: add description for validPercent
   */
  @encodedName("application/json", "valid_percent")
  validPercent: float32;

  /**
   * Masked Pixels
   */
  /**
   * TODO: add description for maskedPixels
   */
  @encodedName("application/json", "masked_pixels")
  maskedPixels: float32;

  /**
   * Valid Pixels
   */
  /**
   * TODO: add description for validPixels
   */
  @encodedName("application/json", "valid_pixels")
  validPixels: float32;
}

/**
 * GeoJSON Feature or FeatureCollection.
 */
/**
 * TODO: add description for Geojson
 */
model Geojson {}

/**
 * FeatureCollection Model
 */
/**
 * TODO: add description for FeatureCollection
 */
model FeatureCollection {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: FeatureCollectionType;

  /**
   * Features
   */
  /**
   * TODO: add description for features
   */
  features: Feature[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * Feature Model
 */
/**
 * TODO: add description for Feature
 */
model Feature {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: FeatureType;

  /**
   * Geometry
   */
  /**
   * TODO: add description for geometry
   */
  geometry: FeatureGeometry;

  /**
   * Properties
   */
  /**
   * TODO: add description for properties
   */
  properties: FeatureProperties;

  /**
   * Id
   */
  /**
   * TODO: add description for id
   */
  id?: string;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * Geometry
 */
/**
 * TODO: add description for FeatureGeometry
 */
model FeatureGeometry {}

/**
 * Point Model
 */
/**
 * TODO: add description for GeojsonPydanticGeometriesPoint
 */
model GeojsonPydanticGeometriesPoint {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type: GeojsonPydanticGeometriesPointType;

  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: string;

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;
}

/**
 * Properties
 */
/**
 * TODO: add description for FeatureProperties
 */
model FeatureProperties {}

/**
 * Response Geojson Statistics Api Collections  Collection Id  Items  Item Id
 * Statistics Post
 */
/**
 * TODO: add description for ResponseGeojsonStatisticsApiCollectionsCollectionIdItemsItemIdStatisticsPost
 */
model ResponseGeojsonStatisticsApiCollectionsCollectionIdItemsItemIdStatisticsPost {}

/**
 * Statistics model in geojson response.
 */
/**
 * TODO: add description for StatisticsInGeoJson
 */
model StatisticsInGeoJson {
  /**
   * Statistics
   */
  statistics: Record<BandStatistics>;
}

/**
 * TileJSON model.
 *
 * Based on https://github.com/mapbox/tilejson-spec/tree/master/2.2.0
 */
/**
 * TODO: add description for TileJson
 */
model TileJson {
  /**
   * Tilejson
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  tilejson?: string = "2.2.0";

  /**
   * Name
   */
  /**
   * TODO: add description for name
   */
  name?: string;

  /**
   * Description
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * Version
   */
  version?: string = "1.0.0";

  /**
   * Attribution
   */
  /**
   * TODO: add description for attribution
   */
  attribution?: string;

  /**
   * Template
   */
  /**
   * TODO: add description for template
   */
  template?: string;

  /**
   * Legend
   */
  /**
   * TODO: add description for legend
   */
  legend?: string;

  /**
   * TODO: add description for scheme
   */
  scheme?: TileJsonScheme = TileJsonScheme.xyz;

  /**
   * Tiles
   */
  /**
   * TODO: add description for tiles
   */
  tiles: string[];

  /**
   * Grids
   */
  /**
   * TODO: add description for grids
   */
  grids?: string[];

  /**
   * Data
   */
  /**
   * TODO: add description for data
   */
  data?: string[];

  /**
   * Minzoom
   */
  /**
   * TODO: add description for minzoom
   */
  @maxValue(30)
  minzoom?: int32;

  /**
   * Maxzoom
   */
  /**
   * TODO: add description for maxzoom
   */
  @maxValue(30)
  maxzoom?: int32 = 30;

  /**
   * Bounds
   */
  bounds?: float32[] = #[-180, -90, 180, 90];

  /**
   * Center
   */
  /**
   * TODO: add description for center
   */
  center?: float32[];
}

/**
 * Point model.
 *
 * response model for `/point` endpoints
 */
/**
 * TODO: add description for TitilerCoreModelsResponsesPoint
 */
model TitilerCoreModelsResponsesPoint {
  /**
   * Coordinates
   */
  /**
   * TODO: add description for coordinates
   */
  coordinates: float32[];

  /**
   * Values
   */
  /**
   * TODO: add description for values
   */
  values: float32[];

  /**
   * Band Names
   */
  /**
   * TODO: add description for bandNames
   */
  @encodedName("application/json", "band_names")
  bandNames: string[];
}

/**
 * Model of /register endpoint input.
 */
/**
 * TODO: add description for RegisterMosaic
 */
model RegisterMosaic {
  /**
   * Collections
   */
  /**
   * TODO: add description for collections
   */
  collections?: string[];

  /**
   * Ids
   */
  /**
   * TODO: add description for ids
   */
  ids?: string[];

  /**
   * Bbox
   */
  /**
   * TODO: add description for bbox
   */
  bbox?: string;

  /**
   * Intersects
   */
  /**
   * TODO: add description for intersects
   */
  intersects?: RegisterMosaicIntersects;

  /**
   * Query
   */
  query?: Record<Record<string>>;

  /**
   * Filter
   */
  filter?: Record<string>;

  /**
   * Datetime
   */
  /**
   * TODO: add description for datetime
   */
  datetime?: string;

  /**
   * Sortby
   */
  /**
   * TODO: add description for sortby
   */
  sortby?: string;

  /**
   * Filter-Lang
   */
  /**
   * TODO: add description for filterLang
   */
  @encodedName("application/json", "filter-lang")
  filterLang?: RegisterMosaicFilterLang;

  /**
   * Metadata Model.
   */
  /**
   * TODO: add description for metadata
   */
  metadata?: Metadata;
}

/**
 * Intersects
 */
/**
 * TODO: add description for RegisterMosaicIntersects
 */
model RegisterMosaicIntersects {}

/**
 * Metadata Model.
 */
/**
 * TODO: add description for Metadata
 */
model Metadata {
  /**
   * Type
   */
  /**
   * TODO: add description for type
   */
  type?: MetadataType = MetadataType.mosaic;

  /**
   * Bounds
   */
  /**
   * TODO: add description for bounds
   */
  bounds?: string;

  /**
   * Minzoom
   */
  /**
   * TODO: add description for minzoom
   */
  minzoom?: int32;

  /**
   * Maxzoom
   */
  /**
   * TODO: add description for maxzoom
   */
  maxzoom?: int32;

  /**
   * Name
   */
  /**
   * TODO: add description for name
   */
  name?: string;

  /**
   * Assets
   */
  /**
   * TODO: add description for assets
   */
  assets?: string[];

  /**
   * Defaults
   */
  defaults?: Record<string>;
}

/**
 * Response model for /register endpoint.
 */
/**
 * TODO: add description for RegisterResponse
 */
model RegisterResponse {
  /**
   * Searchid
   */
  /**
   * TODO: add description for searchid
   */
  searchid: string;

  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links?: Link[];
}

/**
 * Response model for /info endpoint.
 */
/**
 * TODO: add description for TitilerPgstacModelInfo
 */
model TitilerPgstacModelInfo {
  /**
   * PgSTAC Search entry.
   *
   * ref:
   * https://github.com/stac-utils/pgstac/blob/3499daa2bfa700ae7bb07503795c169bf2ebafc7/sql/004_search.sql#L907-L915
   */
  /**
   * TODO: add description for search
   */
  search: Search;

  /**
   * Links
   */
  /**
   * TODO: add description for links
   */
  links?: Link[];
}

/**
 * PgSTAC Search entry.
 *
 * ref:
 * https://github.com/stac-utils/pgstac/blob/3499daa2bfa700ae7bb07503795c169bf2ebafc7/sql/004_search.sql#L907-L915
 */
/**
 * TODO: add description for Search
 */
model Search {
  /**
   * Hash
   */
  /**
   * TODO: add description for hash
   */
  hash: string;

  /**
   * Search
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" ""
  search: Record<string>;

  /**
   *  Where
   */
  /**
   * TODO: add description for where
   */
  @encodedName("application/json", "_where")
  where: string;

  /**
   * Orderby
   */
  /**
   * TODO: add description for orderby
   */
  orderby: string;

  /**
   * Lastused
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  /**
   * TODO: add description for lastused
   */
  lastused: utcDateTime;

  /**
   * Usecount
   */
  /**
   * TODO: add description for usecount
   */
  usecount: int32;

  /**
   * Metadata Model.
   */
  /**
   * TODO: add description for metadata
   */
  metadata: Metadata;
}

/**
 * ImageRequest
 */
/**
 * TODO: add description for ImageRequest
 */
model ImageRequest {
  /**
   * Cql
   */
  cql: Record<string>;

  /**
   * Geometry
   */
  geometry?: Record<string>;

  /**
   * Render Params
   */
  /**
   * TODO: add description for renderParams
   */
  @encodedName("application/json", "render_params")
  renderParams: string;

  /**
   * Cols
   */
  /**
   * TODO: add description for cols
   */
  cols: int32;

  /**
   * Rows
   */
  /**
   * TODO: add description for rows
   */
  rows: int32;

  /**
   * TODO: add description for format
   */
  format?: ImageRequestFormat = ImageRequestFormat.png;

  /**
   * Showbranding
   */
  /**
   * TODO: add description for showBranding
   */
  showBranding?: boolean = true;

  /**
   * Mask
   */
  /**
   * TODO: add description for mask
   */
  mask?: boolean;
}

/**
 * ImageResponse
 */
/**
 * TODO: add description for ImageResponse
 */
model ImageResponse {
  /**
   * Url
   */
  /**
   * TODO: add description for url
   */
  url: string;
}

/**
 * Tile Matrix Set Definition
 *
 * A definition of a tile matrix set following the Tile Matrix Set standard.
 * For tileset metadata, such a description (in `tileMatrixSet` property) is only
 * required for offline use,
 * as an alternative to a link with a
 * `http://www.opengis.net/def/rel/ogc/1.0/tiling-scheme` relation type.
 *
 * ref:
 * https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/tileMatrixSet.json
 */
/**
 * TODO: add description for TileMatrixSet
 */
model TileMatrixSet {
  /**
   * Title of this tile matrix set, normally used for display to a human
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Brief narrative description of this tile matrix set, normally available for
   * display to a human
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * Unordered list of one or more commonly used or formalized word(s) or phrase(s)
   * used to describe this tile matrix set
   */
  /**
   * TODO: add description for keywords
   */
  keywords?: string[];

  /**
   * Tile matrix set identifier. Implementation of 'identifier'
   */
  /**
   * TODO: add description for id
   */
  @pattern("^[\\w\\d_\\-]+$")
  id?: string;

  /**
   * Reference to an official source for this tileMatrixSet
   */
  /**
   * TODO: add description for uri
   */
  uri?: string;

  /**
   * Orderedaxes
   */
  /**
   * TODO: add description for orderedAxes
   */
  orderedAxes?: string[];

  /**
   * Coordinate Reference System (CRS)
   */
  /**
   * TODO: add description for crs
   */
  crs: TileMatrixSetCrs;

  /**
   * Reference to a well-known scale set
   */
  /**
   * TODO: add description for wellKnownScaleSet
   */
  wellKnownScaleSet?: url;

  /**
   * Minimum bounding rectangle surrounding the tile matrix set, in the supported CRS
   */
  /**
   * TODO: add description for boundingBox
   */
  boundingBox?: TileMatrixSetBoundingBox;

  /**
   * Describes scale levels and its tile matrices
   */
  /**
   * TODO: add description for tileMatrices
   */
  tileMatrices: TileMatrix[];
}

/**
 * Coordinate Reference System (CRS)
 */
/**
 * TODO: add description for TileMatrixSetCrs
 */
model TileMatrixSetCrs {}

/**
 * Minimum bounding rectangle surrounding the tile matrix set, in the supported CRS
 */
/**
 * TODO: add description for TileMatrixSetBoundingBox
 */
model TileMatrixSetBoundingBox is TmsBoundingBox;

/**
 * Bounding box
 *
 * ref:
 * https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/2DBoundingBox.json
 */
/**
 * TODO: add description for TMSBoundingBox
 */
model TmsBoundingBox {
  /**
   * A 2D Point in the CRS indicated elsewhere
   */
  /**
   * TODO: add description for lowerLeft
   */
  lowerLeft: string[];

  /**
   * A 2D Point in the CRS indicated elsewhere
   */
  /**
   * TODO: add description for upperRight
   */
  upperRight: string[];

  /**
   * CRS model.
   *
   * Ref:
   * https://github.com/opengeospatial/ogcapi-tiles/blob/master/openapi/schemas/common-geodata/crs.yaml
   *
   * Code generated using https://github.com/koxudaxi/datamodel-code-generator/
   */
  /**
   * TODO: add description for crs
   */
  crs?: string;

  /**
   * Orderedaxes
   */
  /**
   * TODO: add description for orderedAxes
   */
  orderedAxes?: string[];
}

/**
 * Tile Matrix Definition
 *
 * A tile matrix, usually corresponding to a particular zoom level of a
 * TileMatrixSet.
 *
 * ref:
 * https://github.com/opengeospatial/2D-Tile-Matrix-Set/blob/master/schemas/tms/2.0/json/tileMatrix.json
 */
/**
 * TODO: add description for TileMatrix
 */
model TileMatrix {
  /**
   * Title of this tile matrix, normally used for display to a human
   */
  /**
   * TODO: add description for title
   */
  title?: string;

  /**
   * Brief narrative description of this tile matrix set, normally available for
   * display to a human
   */
  /**
   * TODO: add description for description
   */
  description?: string;

  /**
   * Unordered list of one or more commonly used or formalized word(s) or phrase(s)
   * used to describe this dataset
   */
  /**
   * TODO: add description for keywords
   */
  keywords?: string[];

  /**
   * Identifier selecting one of the scales defined in the TileMatrixSet and
   * representing the scaleDenominator the tile. Implementation of 'identifier'
   */
  /**
   * TODO: add description for id
   */
  @pattern("^[0-9]+$")
  id: string;

  /**
   * Scale denominator of this tile matrix
   */
  /**
   * TODO: add description for scaleDenominator
   */
  scaleDenominator: float32;

  /**
   * Cell size of this tile matrix
   */
  /**
   * TODO: add description for cellSize
   */
  cellSize: float32;

  /**
   * The corner of the tile matrix (_topLeft_ or _bottomLeft_) used as the origin
   * for numbering tile rows and columns. This corner is also a corner of the (0, 0)
   * tile.
   */
  /**
   * TODO: add description for cornerOfOrigin
   */
  cornerOfOrigin?: TileMatrixCornerOfOrigin;

  /**
   * Precise position in CRS coordinates of the corner of origin (e.g. the top-left
   * corner) for this tile matrix. This position is also a corner of the (0, 0)
   * tile. In previous version, this was 'topLeftCorner' and 'cornerOfOrigin' did
   * not exist.
   */
  /**
   * TODO: add description for pointOfOrigin
   */
  pointOfOrigin: string[];

  /**
   * Width of each tile of this tile matrix in pixels
   */
  /**
   * TODO: add description for tileWidth
   */
  @minValue(1)
  tileWidth: int32;

  /**
   * Height of each tile of this tile matrix in pixels
   */
  /**
   * TODO: add description for tileHeight
   */
  @minValue(1)
  tileHeight: int32;

  /**
   * Width of the matrix (number of tiles in width)
   */
  /**
   * TODO: add description for matrixWidth
   */
  @minValue(1)
  matrixWidth: int32;

  /**
   * Height of the matrix (number of tiles in height)
   */
  /**
   * TODO: add description for matrixHeight
   */
  @minValue(1)
  matrixHeight: int32;
}

/**
 * BoundingBox
 */
/**
 * TODO: add description for BoundingBox
 */
model BoundingBox {
  /**
   * Left
   */
  /**
   * TODO: add description for left
   */
  left: string;

  /**
   * Bottom
   */
  /**
   * TODO: add description for bottom
   */
  bottom: string;

  /**
   * Right
   */
  /**
   * TODO: add description for right
   */
  right: string;

  /**
   * Top
   */
  /**
   * TODO: add description for top
   */
  top: string;
}

/**
 * Coordinate Reference System (CRS) from URI.
 */
/**
 * TODO: add description for CRSUri
 */
model CrsUri {
  /**
   * Reference to one coordinate reference system (CRS) as URI
   */
  /**
   * TODO: add description for uri
   */
  uri: url;
}

/**
 * Coordinate Reference System (CRS) from WKT.
 */
/**
 * TODO: add description for Crswkt
 */
model Crswkt {
  /**
   * Reference to one coordinate reference system (CRS) as WKT string
   */
  /**
   * TODO: add description for wkt
   */
  wkt: string;
}
