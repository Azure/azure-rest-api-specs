import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

import "./main.tsp";
import "./overrides.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

using Microsoft.PlanetaryComputer;

@useDependency(Versions.v2025_04_30_Preview)
@client({
  name: "PlanetaryComputerProClient",
  service: Microsoft.PlanetaryComputer,
})
namespace Customizations;

// === Client name conflicts ===
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

// Workaround errors CS0019 and CS0019
@@alternateType(StacCollectionTemporalExtent.interval, string[][], "csharp");

// Change the WmtsCapabilitiesXmlResponse body type from bytes to string for JavaScript
@@alternateType(WmtsCapabilitiesXmlResponse.body, string, "javascript");

// === Python SDK external type mappings ===
// Use shapely library for GeoJSON geometry types
@@alternateType(Geometry,
  {
    identity: "shapely.geometry.base.BaseGeometry",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(Point,
  {
    identity: "shapely.Point",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(Polygon,
  {
    identity: "shapely.Polygon",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(MultiPolygon,
  {
    identity: "shapely.MultiPolygon",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(LineString,
  {
    identity: "shapely.LineString",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(MultiLineString,
  {
    identity: "shapely.MultiLineString",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(MultiPoint,
  {
    identity: "shapely.MultiPoint",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

@@alternateType(GeometryCollection,
  {
    identity: "shapely.GeometryCollection",
    package: "shapely",
    minVersion: "2.0.0",
  },
  "python"
);

// Use geojson library for GeoJSON Feature types
@@alternateType(Feature,
  {
    identity: "geojson.Feature",
    package: "geojson",
    minVersion: "3.1.0",
  },
  "python"
);

@@alternateType(FeatureCollection,
  {
    identity: "geojson.FeatureCollection",
    package: "geojson",
    minVersion: "3.1.0",
  },
  "python"
);

// Use pystac library for STAC types
@@alternateType(StacCollection,
  {
    identity: "pystac.Collection",
    package: "pystac",
    minVersion: "1.13.0",
  },
  "python"
);

@@alternateType(StacItem,
  {
    identity: "pystac.Item",
    package: "pystac",
    minVersion: "1.13.0",
  },
  "python"
);

@@alternateType(StacItemCollection,
  {
    identity: "pystac.ItemCollection",
    package: "pystac",
    minVersion: "1.13.0",
  },
  "python"
);

// Address naming convention violations for C# SDK
@@clientName(TilerMosaicSearchRegistrationResponse,
  "TilerMosaicSearchRegistrationResult",
  "csharp"
);

// Models ending with "Definition" - rename appropriately
@@clientName(IngestionDefinition, "IngestionInformation", "csharp");

// Models ending with "Operation" - rename to "Info"
@@clientName(IngestionRunOperation, "IngestionRunInformation", "csharp");

// Generic single-word class names - add descriptive prefixes
@@clientName(Geometry, "GeoJsonGeometry", "csharp");
@@clientName(Feature, "GeoJsonFeature", "csharp");
@@clientName(Point, "PointGeometry", "csharp");
@@clientName(Polygon, "PolygonGeometry", "csharp");
@@clientName(Resampling, "ResamplingMethod", "csharp");
@@clientName(Operation, "LongRunningOperation", "csharp");

// Additional model renames for C#
@@clientName(RenderOption, "RenderConfiguration", "csharp");
@@clientName(StacCollection, "StacCollectionResource", "csharp");
@@clientName(StacItem, "StacItemResource", "csharp");
@@clientName(StacItemCollection, "StacItemCollectionResource", "csharp");

// === Ingestion Management ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "These operations return collections."
@operationGroup
@clientName("IngestionClient", "csharp")
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
  list is Ingestions.list;
  update is Ingestions.update;

  // Ingestion sources
  createSource is IngestionSources.create;
  replaceSource is IngestionSources.replace;
  deleteSource is IngestionSources.delete;
  getSource is IngestionSources.get;
  listSources is IngestionSources.list;
  listManagedIdentities is IngestionSources.listManagedIdentities;
}

// === SpatioTemporal Asset Catalog (STAC) API ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("StacClient", "csharp")
interface Stac {
  // Collection Assets
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createCollectionAsset is StacCollectionAssets.create;
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  replaceCollectionAsset is StacCollectionAssets.replace;
  deleteCollectionAsset is StacCollectionAssets.delete;

  // Collection Configuration
  getCollectionConfiguration is StacCollectionConfig.get;

  // Collection Mosaics
  addMosaic is StacCollectionMosaics.add;
  replaceMosaic is StacCollectionMosaics.replace;
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
  getCollections is StacCollections.getAll;

  // Collection Partition Types
  getPartitionType is StacCollectionPartitionTypes.get;
  replacePartitionType is StacCollectionPartitionTypes.replace;

  // Collection Render Options
  createRenderOption is StacCollectionRenderOptions.create;
  replaceRenderOption is StacCollectionRenderOptions.replace;
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

  // STAC landing page
  getLandingPage is StacLandingPages.get;

  // STAC Items
  createItem is StacItems.create;
  createOrReplaceItem is StacItems.createOrReplace;
  deleteItem is StacItems.delete;
  getItem is StacItems.get;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getItemCollection is StacItems.getFeatures;
  updateItem is StacItems.update;

  // STAC Queryables
  createQueryables is StacQueryables.create;
  replaceQueryable is StacQueryables.replace;
  deleteQueryable is StacQueryables.delete;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  listQueryables is StacQueryables.getAll;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getCollectionQueryables is StacQueryables.getAllByCollection;

  // STAC Search
  search is StacSearch.create;
}

// === Tiles for STAC Items ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("DataClient", "csharp")
interface Data {
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
  getBounds is TilerBound.getAll;

  // Parts/Crops
  cropGeoJson is TilerGeoJsons.cropFormat;
  cropGeoJsonWithDimensions is TilerGeoJsons.cropWidthByHeightFormat;

  // Statistics
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Standardize list operation naming."
  getGeoJsonStatistics is TilerGeoJsonStatistics.get;

  // Basic Info and Assets
  getInfoGeoJson is TilerInfoGeoJsonOperations.get;
  getItemAssetDetails is TilerInfoOperations.get;

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
  getTileJson is TilerTileJsonTileMatrixSets.get;
  // getTileJson is TilerTileJsonOperations.get;

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
  getMosaicsWmtsCapabilities is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;
  // getMosaicsWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;
}

// === Shared Access Signature (SAS) ===
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@operationGroup
@clientName("ManagedStorageSharedAccessSignatureClient", "csharp")
interface SharedAccessSignature {
  // Sign HREF for read access
  getSign is Sas.getSign;

  // SAS Tokens
  getToken is Sas.getToken;
  revokeToken is Sas.revokeToken;
}
