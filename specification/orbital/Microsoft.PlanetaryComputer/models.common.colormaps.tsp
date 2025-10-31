namespace Microsoft.PlanetaryComputer;

/**
 * Available color maps for data visualization
 */
union ColorMapNames {
  string,

  /**
   * Accent colormap - qualitative colormap with distinct colors
   */
  accent: "accent",

  /**
   * Reversed accent colormap
   */
  accent_r: "accent_r",

  /**
   * Afmhot colormap - sequential black-red-yellow-white colormap
   */
  afmhot: "afmhot",

  /**
   * Reversed afmhot colormap
   */
  afmhot_r: "afmhot_r",

  /**
   * AI for Good land use/land cover colormap
   */
  `ai4g-lulc`: "ai4g-lulc",

  /**
   * ALOS forest/non-forest colormap
   */
  `alos-fnf`: "alos-fnf",

  /**
   * ALOS PALSAR mask colormap
   */
  `alos-palsar-mask`: "alos-palsar-mask",

  /**
   * Autumn colormap - sequential red-orange-yellow colormap
   */
  autumn: "autumn",

  /**
   * Reversed autumn colormap
   */
  autumn_r: "autumn_r",

  /**
   * Binary colormap - simple black and white colormap
   */
  binary: "binary",

  /**
   * Reversed binary colormap
   */
  binary_r: "binary_r",

  /**
   * Blues colormap - sequential white to dark blue
   */
  blues: "blues",

  /**
   * Reversed blues colormap
   */
  blues_r: "blues_r",

  /**
   * Bone colormap - grayscale with slight blue tint
   */
  bone: "bone",

  /**
   * Reversed bone colormap
   */
  bone_r: "bone_r",

  /**
   * BrBG colormap - diverging brown to blue-green
   */
  brbg: "brbg",

  /**
   * Reversed BrBG colormap
   */
  brbg_r: "brbg_r",

  /**
   * BrG colormap - diverging brown to green
   */
  brg: "brg",

  /**
   * Reversed BrG colormap
   */
  brg_r: "brg_r",

  /**
   * BuGn colormap - sequential white to dark green
   */
  bugn: "bugn",

  /**
   * Reversed BuGn colormap
   */
  bugn_r: "bugn_r",

  /**
   * BuPu colormap - sequential white to dark purple
   */
  bupu: "bupu",

  /**
   * Reversed BuPu colormap
   */
  bupu_r: "bupu_r",

  /**
   * BWR colormap - diverging blue to red
   */
  bwr: "bwr",

  /**
   * Reversed BWR colormap
   */
  bwr_r: "bwr_r",

  /**
   * C-CAP colormap - land cover classification
   */
  `c-cap`: "c-cap",

  /**
   * Cfastie colormap - high contrast colormap
   */
  cfastie: "cfastie",

  /**
   * Chesapeake land cover 13-class colormap
   */
  `chesapeake-lc-13`: "chesapeake-lc-13",

  /**
   * Chesapeake land cover 7-class colormap
   */
  `chesapeake-lc-7`: "chesapeake-lc-7",

  /**
   * Chesapeake land use colormap
   */
  `chesapeake-lu`: "chesapeake-lu",

  /**
   * Chloris biomass colormap
   */
  `chloris-biomass`: "chloris-biomass",

  /**
   * Cividis colormap - sequential yellow to blue
   */
  cividis: "cividis",

  /**
   * Reversed cividis colormap
   */
  cividis_r: "cividis_r",

  /**
   * CMRmap colormap - perceptually uniform colormap
   */
  cmrmap: "cmrmap",

  /**
   * Reversed CMRmap colormap
   */
  cmrmap_r: "cmrmap_r",

  /**
   * Cool colormap - sequential cyan to magenta
   */
  cool: "cool",

  /**
   * Reversed cool colormap
   */
  cool_r: "cool_r",

  /**
   * Coolwarm colormap - diverging blue to red
   */
  coolwarm: "coolwarm",

  /**
   * Reversed coolwarm colormap
   */
  coolwarm_r: "coolwarm_r",

  /**
   * Copper colormap - sequential black to copper
   */
  copper: "copper",

  /**
   * Reversed copper colormap
   */
  copper_r: "copper_r",

  /**
   * Cubehelix colormap - sequential black to white with hue rotation
   */
  cubehelix: "cubehelix",

  /**
   * Reversed cubehelix colormap
   */
  cubehelix_r: "cubehelix_r",

  /**
   * Dark2 colormap - qualitative colormap with distinct colors
   */
  dark2: "dark2",

  /**
   * Reversed dark2 colormap
   */
  dark2_r: "dark2_r",

  /**
   * DRCog land use/land cover colormap
   */
  `drcog-lulc`: "drcog-lulc",

  /**
   * ESA CCI land cover colormap
   */
  `esa-cci-lc`: "esa-cci-lc",

  /**
   * ESA WorldCover colormap
   */
  `esa-worldcover`: "esa-worldcover",

  /**
   * Flag colormap - qualitative colormap with distinct colors
   */
  flag: "flag",

  /**
   * Reversed flag colormap
   */
  flag_r: "flag_r",

  /**
   * GAP land use/land cover colormap
   */
  `gap-lulc`: "gap-lulc",

  /**
   * Gist_earth colormap - perceptually uniform colormap
   */
  gist_earth: "gist_earth",

  /**
   * Reversed gist_earth colormap
   */
  gist_earth_r: "gist_earth_r",

  /**
   * Gist_gray colormap - grayscale colormap
   */
  gist_gray: "gist_gray",

  /**
   * Reversed gist_gray colormap
   */
  gist_gray_r: "gist_gray_r",

  /**
   * Gist_heat colormap - sequential black-red-yellow-white colormap
   */
  gist_heat: "gist_heat",

  /**
   * Reversed gist_heat colormap
   */
  gist_heat_r: "gist_heat_r",

  /**
   * Gist_ncar colormap - perceptually uniform colormap
   */
  gist_ncar: "gist_ncar",

  /**
   * Reversed gist_ncar colormap
   */
  gist_ncar_r: "gist_ncar_r",

  /**
   * Gist_rainbow colormap - perceptually uniform colormap
   */
  gist_rainbow: "gist_rainbow",

  /**
   * Reversed gist_rainbow colormap
   */
  gist_rainbow_r: "gist_rainbow_r",

  /**
   * Gist_stern colormap - perceptually uniform colormap
   */
  gist_stern: "gist_stern",

  /**
   * Reversed gist_stern colormap
   */
  gist_stern_r: "gist_stern_r",

  /**
   * Gist_yarg colormap - grayscale colormap
   */
  gist_yarg: "gist_yarg",

  /**
   * Reversed gist_yarg colormap
   */
  gist_yarg_r: "gist_yarg_r",

  /**
   * GnBu colormap - sequential white to dark blue-green
   */
  gnbu: "gnbu",

  /**
   * Reversed GnBu colormap
   */
  gnbu_r: "gnbu_r",

  /**
   * Gnuplot colormap - sequential black to white with hue rotation
   */
  gnuplot: "gnuplot",

  /**
   * Gnuplot2 colormap - sequential black to white with hue rotation
   */
  gnuplot2: "gnuplot2",

  /**
   * Reversed gnuplot2 colormap
   */
  gnuplot2_r: "gnuplot2_r",

  /**
   * Reversed gnuplot colormap
   */
  gnuplot_r: "gnuplot_r",

  /**
   * Gray colormap - grayscale colormap
   */
  gray: "gray",

  /**
   * Reversed gray colormap
   */
  gray_r: "gray_r",

  /**
   * Greens colormap - sequential white to dark green
   */
  greens: "greens",

  /**
   * Reversed greens colormap
   */
  greens_r: "greens_r",

  /**
   * Greys colormap - sequential white to dark gray
   */
  greys: "greys",

  /**
   * Reversed greys colormap
   */
  greys_r: "greys_r",

  /**
   * Hot colormap - sequential black-red-yellow-white colormap
   */
  hot: "hot",

  /**
   * Reversed hot colormap
   */
  hot_r: "hot_r",

  /**
   * HSV colormap - hue-saturation-value colormap
   */
  hsv: "hsv",

  /**
   * Reversed HSV colormap
   */
  hsv_r: "hsv_r",

  /**
   * Inferno colormap - sequential black to yellow colormap
   */
  inferno: "inferno",

  /**
   * Reversed inferno colormap
   */
  inferno_r: "inferno_r",

  /**
   * IO-BII colormap - biodiversity index colormap
   */
  `io-bii`: "io-bii",

  /**
   * IO-LULC colormap - land use/land cover colormap
   */
  `io-lulc`: "io-lulc",

  /**
   * IO-LULC 9-class colormap
   */
  `io-lulc-9-class`: "io-lulc-9-class",

  /**
   * Jet colormap - sequential blue-green-yellow-red colormap
   */
  jet: "jet",

  /**
   * Reversed jet colormap
   */
  jet_r: "jet_r",

  /**
   * JRC change colormap
   */
  `jrc-change`: "jrc-change",

  /**
   * JRC extent colormap
   */
  `jrc-extent`: "jrc-extent",

  /**
   * JRC occurrence colormap
   */
  `jrc-occurrence`: "jrc-occurrence",

  /**
   * JRC recurrence colormap
   */
  `jrc-recurrence`: "jrc-recurrence",

  /**
   * JRC seasonality colormap
   */
  `jrc-seasonality`: "jrc-seasonality",

  /**
   * JRC transitions colormap
   */
  `jrc-transitions`: "jrc-transitions",

  /**
   * Lidar classification colormap
   */
  `lidar-classification`: "lidar-classification",

  /**
   * Lidar height above ground colormap
   */
  `lidar-hag`: "lidar-hag",

  /**
   * Alternative lidar height above ground colormap
   */
  `lidar-hag-alternative`: "lidar-hag-alternative",

  /**
   * Lidar intensity colormap
   */
  `lidar-intensity`: "lidar-intensity",

  /**
   * Lidar returns colormap
   */
  `lidar-returns`: "lidar-returns",

  /**
   * Magma colormap - sequential black to yellow colormap
   */
  magma: "magma",

  /**
   * Reversed magma colormap
   */
  magma_r: "magma_r",

  /**
   * MODIS 10A1 colormap
   */
  `modis-10A1`: "modis-10A1",

  /**
   * MODIS 10A2 colormap
   */
  `modis-10A2`: "modis-10A2",

  /**
   * MODIS 13A1|Q1 colormap
   */
  `modis-13A1|Q1`: "modis-13A1|Q1",

  /**
   * MODIS 14A1|A2 colormap
   */
  `modis-14A1|A2`: "modis-14A1|A2",

  /**
   * MODIS 15A2H|A3H colormap
   */
  `modis-15A2H|A3H`: "modis-15A2H|A3H",

  /**
   * MODIS 16A3GF-ET colormap
   */
  `modis-16A3GF-ET`: "modis-16A3GF-ET",

  /**
   * MODIS 16A3GF-PET colormap
   */
  `modis-16A3GF-PET`: "modis-16A3GF-PET",

  /**
   * MODIS 17A2H|A2HGF colormap
   */
  `modis-17A2H|A2HGF`: "modis-17A2H|A2HGF",

  /**
   * MODIS 17A3HGF colormap
   */
  `modis-17A3HGF`: "modis-17A3HGF",

  /**
   * MODIS 64A1 colormap
   */
  `modis-64A1`: "modis-64A1",

  /**
   * MTBS severity colormap
   */
  `mtbs-severity`: "mtbs-severity",

  /**
   * Nipy_spectral colormap - perceptually uniform colormap
   */
  nipy_spectral: "nipy_spectral",

  /**
   * Reversed nipy_spectral colormap
   */
  nipy_spectral_r: "nipy_spectral_r",

  /**
   * NRCAN land use/land cover colormap
   */
  `nrcan-lulc`: "nrcan-lulc",

  /**
   * Ocean colormap - sequential blue to white colormap
   */
  ocean: "ocean",

  /**
   * Reversed ocean colormap
   */
  ocean_r: "ocean_r",

  /**
   * Oranges colormap - sequential white to dark orange
   */
  oranges: "oranges",

  /**
   * Reversed oranges colormap
   */
  oranges_r: "oranges_r",

  /**
   * OrRd colormap - sequential white to dark red-orange
   */
  orrd: "orrd",

  /**
   * Reversed OrRd colormap
   */
  orrd_r: "orrd_r",

  /**
   * Paired colormap - qualitative colormap with distinct colors
   */
  paired: "paired",

  /**
   * Reversed paired colormap
   */
  paired_r: "paired_r",

  /**
   * Pastel1 colormap - qualitative colormap with pastel colors
   */
  pastel1: "pastel1",

  /**
   * Reversed pastel1 colormap
   */
  pastel1_r: "pastel1_r",

  /**
   * Pastel2 colormap - qualitative colormap with pastel colors
   */
  pastel2: "pastel2",

  /**
   * Reversed pastel2 colormap
   */
  pastel2_r: "pastel2_r",

  /**
   * Pink colormap - sequential white to dark pink
   */
  pink: "pink",

  /**
   * Reversed pink colormap
   */
  pink_r: "pink_r",

  /**
   * PiYG colormap - diverging pink to green
   */
  piyg: "piyg",

  /**
   * Reversed PiYG colormap
   */
  piyg_r: "piyg_r",

  /**
   * Plasma colormap - sequential black to yellow colormap
   */
  plasma: "plasma",

  /**
   * Reversed plasma colormap
   */
  plasma_r: "plasma_r",

  /**
   * PRGn colormap - diverging purple to green
   */
  prgn: "prgn",

  /**
   * Reversed PRGn colormap
   */
  prgn_r: "prgn_r",

  /**
   * Prism colormap - qualitative colormap with distinct colors
   */
  prism: "prism",

  /**
   * Reversed prism colormap
   */
  prism_r: "prism_r",

  /**
   * PuBu colormap - sequential white to dark blue
   */
  pubu: "pubu",

  /**
   * Reversed PuBu colormap
   */
  pubu_r: "pubu_r",

  /**
   * PuBuGn colormap - sequential white to dark blue-green
   */
  pubugn: "pubugn",

  /**
   * Reversed PuBuGn colormap
   */
  pubugn_r: "pubugn_r",

  /**
   * PuOr colormap - diverging purple to orange
   */
  puor: "puor",

  /**
   * Reversed PuOr colormap
   */
  puor_r: "puor_r",

  /**
   * PuRd colormap - sequential white to dark purple-red
   */
  purd: "purd",

  /**
   * Reversed PuRd colormap
   */
  purd_r: "purd_r",

  /**
   * Purples colormap - sequential white to dark purple
   */
  purples: "purples",

  /**
   * Reversed purples colormap
   */
  purples_r: "purples_r",

  /**
   * QPE colormap - qualitative colormap with distinct colors
   */
  qpe: "qpe",

  /**
   * Rainbow colormap - qualitative colormap with distinct colors
   */
  rainbow: "rainbow",

  /**
   * Reversed rainbow colormap
   */
  rainbow_r: "rainbow_r",

  /**
   * RdBu colormap - diverging red to blue
   */
  rdbu: "rdbu",

  /**
   * Reversed RdBu colormap
   */
  rdbu_r: "rdbu_r",

  /**
   * RdGy colormap - diverging red to gray
   */
  rdgy: "rdgy",

  /**
   * Reversed RdGy colormap
   */
  rdgy_r: "rdgy_r",

  /**
   * RdPu colormap - sequential white to dark red-purple
   */
  rdpu: "rdpu",

  /**
   * Reversed RdPu colormap
   */
  rdpu_r: "rdpu_r",

  /**
   * RdYlBu colormap - diverging red to yellow to blue
   */
  rdylbu: "rdylbu",

  /**
   * Reversed RdYlBu colormap
   */
  rdylbu_r: "rdylbu_r",

  /**
   * RdYlGn colormap - diverging red to yellow to green
   */
  rdylgn: "rdylgn",

  /**
   * Reversed RdYlGn colormap
   */
  rdylgn_r: "rdylgn_r",

  /**
   * Reds colormap - sequential white to dark red
   */
  reds: "reds",

  /**
   * Reversed reds colormap
   */
  reds_r: "reds_r",

  /**
   * Rplumbo colormap - qualitative colormap with distinct colors
   */
  rplumbo: "rplumbo",

  /**
   * Schwarzwald colormap - qualitative colormap with distinct colors
   */
  schwarzwald: "schwarzwald",

  /**
   * Seismic colormap - diverging blue to red
   */
  seismic: "seismic",

  /**
   * Reversed seismic colormap
   */
  seismic_r: "seismic_r",

  /**
   * Set1 colormap - qualitative colormap with distinct colors
   */
  set1: "set1",

  /**
   * Reversed set1 colormap
   */
  set1_r: "set1_r",

  /**
   * Set2 colormap - qualitative colormap with distinct colors
   */
  set2: "set2",

  /**
   * Reversed set2 colormap
   */
  set2_r: "set2_r",

  /**
   * Set3 colormap - qualitative colormap with distinct colors
   */
  set3: "set3",

  /**
   * Reversed set3 colormap
   */
  set3_r: "set3_r",

  /**
   * Spectral colormap - diverging red to yellow to blue
   */
  spectral: "spectral",

  /**
   * Reversed spectral colormap
   */
  spectral_r: "spectral_r",

  /**
   * Spring colormap - sequential magenta to yellow
   */
  spring: "spring",

  /**
   * Reversed spring colormap
   */
  spring_r: "spring_r",

  /**
   * Summer colormap - sequential green to yellow
   */
  summer: "summer",

  /**
   * Reversed summer colormap
   */
  summer_r: "summer_r",

  /**
   * Tab10 colormap - qualitative colormap with distinct colors
   */
  tab10: "tab10",

  /**
   * Reversed tab10 colormap
   */
  tab10_r: "tab10_r",

  /**
   * Tab20 colormap - qualitative colormap with distinct colors
   */
  tab20: "tab20",

  /**
   * Reversed tab20 colormap
   */
  tab20_r: "tab20_r",

  /**
   * Tab20b colormap - qualitative colormap with distinct colors
   */
  tab20b: "tab20b",

  /**
   * Reversed tab20b colormap
   */
  tab20b_r: "tab20b_r",

  /**
   * Tab20c colormap - qualitative colormap with distinct colors
   */
  tab20c: "tab20c",

  /**
   * Reversed tab20c colormap
   */
  tab20c_r: "tab20c_r",

  /**
   * Terrain colormap - sequential black to white with hue rotation
   */
  terrain: "terrain",

  /**
   * Reversed terrain colormap
   */
  terrain_r: "terrain_r",

  /**
   * Twilight colormap - diverging blue to red
   */
  twilight: "twilight",

  /**
   * Reversed twilight colormap
   */
  twilight_r: "twilight_r",

  /**
   * Twilight shifted colormap - diverging blue to red
   */
  twilight_shifted: "twilight_shifted",

  /**
   * Reversed twilight shifted colormap
   */
  twilight_shifted_r: "twilight_shifted_r",

  /**
   * USDA CDL colormap - land cover classification
   */
  `usda-cdl`: "usda-cdl",

  /**
   * USDA CDL corn colormap
   */
  `usda-cdl-corn`: "usda-cdl-corn",

  /**
   * USDA CDL cotton colormap
   */
  `usda-cdl-cotton`: "usda-cdl-cotton",

  /**
   * USDA CDL soybeans colormap
   */
  `usda-cdl-soybeans`: "usda-cdl-soybeans",

  /**
   * USDA CDL wheat colormap
   */
  `usda-cdl-wheat`: "usda-cdl-wheat",

  /**
   * USGS LCMAP colormap
   */
  `usgs-lcmap`: "usgs-lcmap",

  /**
   * VIIRS 10A1 colormap
   */
  `viirs-10a1`: "viirs-10a1",

  /**
   * VIIRS 13A1 colormap
   */
  `viirs-13a1`: "viirs-13a1",

  /**
   * VIIRS 14A1 colormap
   */
  `viirs-14a1`: "viirs-14a1",

  /**
   * VIIRS 15A2H colormap
   */
  `viirs-15a2H`: "viirs-15a2H",

  /**
   * Viridis colormap - sequential black to yellow colormap
   */
  viridis: "viridis",

  /**
   * Reversed viridis colormap
   */
  viridis_r: "viridis_r",

  /**
   * Winter colormap - sequential blue to green
   */
  winter: "winter",

  /**
   * Reversed winter colormap
   */
  winter_r: "winter_r",

  /**
   * Wistia colormap - sequential white to yellow
   */
  wistia: "wistia",

  /**
   * Reversed wistia colormap
   */
  wistia_r: "wistia_r",

  /**
   * YlGn colormap - sequential white to dark green
   */
  ylgn: "ylgn",

  /**
   * Reversed YlGn colormap
   */
  ylgn_r: "ylgn_r",

  /**
   * YlGnBu colormap - sequential white to dark blue-green
   */
  ylgnbu: "ylgnbu",

  /**
   * Reversed YlGnBu colormap
   */
  ylgnbu_r: "ylgnbu_r",

  /**
   * YlOrBr colormap - sequential white to dark orange-brown
   */
  ylorbr: "ylorbr",

  /**
   * Reversed YlOrBr colormap
   */
  ylorbr_r: "ylorbr_r",

  /**
   * YlOrRd colormap - sequential white to dark red-orange
   */
  ylorrd: "ylorrd",

  /**
   * Reversed YlOrRd colormap
   */
  ylorrd_r: "ylorrd_r",
}
