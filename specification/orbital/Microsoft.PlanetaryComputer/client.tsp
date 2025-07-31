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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("StacConfigClientImpl", "csharp,")
interface StacCollectionConfigurationClient {
  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createCollectionAsset is StacCollectionAssets.create;

  #suppress "@azure-tools/typespec-azure-core/byos" "Multipart form data is appropriate for asset uploads in STAC collections"
  createOrReplaceCollectionAsset is StacCollectionAssets.createOrReplace;

  deleteCollectionAsset is StacCollectionAssets.delete;

  getCollectionThumbnail is StacCollectionThumbnails.get;

  getCollectionConfig is StacCollectionConfig.get;

  getAllMosaics is StacCollectionMosaics.getAll;

  addMosaic is StacCollectionMosaics.add;

  getMosaic is StacCollectionMosaics.get;

  createOrReplaceMosaic is StacCollectionMosaics.createOrReplace;

  deleteMosaic is StacCollectionMosaics.delete;

  getAllRenderOptions is StacCollectionRenderOptions.getAll;

  createRenderOption is StacCollectionRenderOptions.create;

  getRenderOption is StacCollectionRenderOptions.get;

  createOrReplaceRenderOption is StacCollectionRenderOptions.createOrReplace;

  deleteRenderOption is StacCollectionRenderOptions.delete;

  getTileSettings is StacCollectionTileSettings.getAll;

  replaceTileSettings is StacCollectionTileSettings.replace;

  getPartitionType is StacCollectionPartitionTypes.get;

  replacePartitionType is StacCollectionPartitionTypes.replace;

  getAllQueryables is StacQueryables.getAll;

  getAllQueryablesByCollection is StacQueryables.getAllByCollection;

  createQueryables is StacQueryables.create;

  createOrReplaceQueryable is StacQueryables.createOrReplace;

  deleteQueryable is StacQueryables.delete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("GeocatalogClientImpl", "csharp")
interface GeocatalogClient {
  getAzmapsToken is GeoCatalogAzmapsToken.get;

  getAzmapsClientId is GeoCatalogAzmapsClient.getId;

  getAuthConfig is GeoCatalogAuthConfigOperations.get;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("ImageExportsClientImpl", "csharp")
interface ImageExportsClient {
  createStaticImage is TilerStaticImages.create;

  getStaticImage is TilerStaticImages.get;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("StacItemTilerClientImpl", "csharp")
interface StacItemTilerClient {
  // requires collectionId and itemId as options
  getBounds is TilerBound.getAll;

  getInfo is TilerInfoOperations.get;

  getInfoGeoJson is TilerInfoGeoJsonOperations.get;

  getAvailableAssets is TilerAvailableAssets.getAll;

  getAssetStatistics is TilerAssetStatistics.getAll;

  getStatistics is TilerStatistics.getAll;

  getGeoJsonStatistics is TilerGeoJsonStatistics.getAll;

  getTile is TilerTiles.getZxyScalexFormat;

  getTileWithMatrixSet is TilerTileMatrixSets.getZxyScalexFormat;

  getTileJson is TilerTileJsonOperations.get;

  getTileJsonWithMatrixSet is TilerTileJsonTileMatrixSets.get;

  getWmtsCapabilities is TilerWmts.getCapabilitiesXml;

  getWmtsCapabilitiesWithMatrixSet is TilerWmtsTileMatrixSets.getCapabilitiesXml;

  getPoint is TilerPoints.getLonLat;

  getPreviewWithFormat is TilerPreviews.getFormat;

  getPreview is TilerPreviews.get;

  getPartWithDimensions is TilerParts.getMinxMinyMaxxMaxyWidthxHeightFormat;

  getPart is TilerParts.getMinxMinyMaxxMaxyFormat;

  cropGeoJsonWithDimensions is TilerGeoJsons.cropWidthxHeightFormat;

  cropGeoJson is TilerGeoJsons.cropFormat;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("MapLegendsClientImpl", "csharp")
interface MapLegendsClient {
  getIntervalLegend is MapsIntervalLegends.getByClassmapName;

  getClassmapLegend is MapsClassmapLegends.get;

  getLegend is MapsLegends.get;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("MosaicTilerClientImpl", "csharp")
interface MosaicTilerClient {
  getTile is MosaicsTiles.getZxyScalexFormat;

  getTileWithMatrixSet is MosaicsTileMatrixSets.getZxyScalexFormat;

  getTileJson is MosaicsTileJsonOperations.get;

  getTileJsonWithMatrixSet is MosaicsTileMatrixSetsTileJson.get;

  getWmtsCapabilities is MosaicsWmtsMosaics.getCapabilitiesXml;

  getWmtsCapabilitiesWithMatrixSet is MosaicsWmtsMosaicsTileMatrixSets.getCapabilitiesXml;
  registerSearch is MosaicsRegisterSearch.register;

  getSearchInfo is MosaicsInfoSearch.get;

  getAssetsForTile is MosaicsAssetsForTiles.getZxyAssets;

  getAssetsForTileWithMatrixSet is MosaicsAssetsForTileMatrixSets.getZxyAssets;

  getAssetsForPoint is MosaicsAssetsForPoints.getLonLatAssets;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("TileMatrixSetsClientImpl", "csharp")
interface TileMatrixSetsClient {
  getMatrixList is TileMatrixList.get;

  getMatrixDefinition is TileMatrixDefinitions.get;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("SharedAccessSignatureClientImpl", "csharp")
interface SharedAccessSignatureClient {
  getToken is Sas.getToken;

  revokeToken is Sas.revokeToken;

  getSign is Sas.getSign;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("IngestionClientImpl", "csharp")
interface IngestionClient {
  getIngestions is Ingestions.listAll;

  getIngestion is Ingestions.get;

  createIngestion is Ingestions.create;

  updateIngestion is Ingestions.update;

  deleteIngestion is Ingestions.delete;

  getIngestionRuns is Ingestions.IngestionRuns.listAll;

  getIngestionRun is Ingestions.IngestionRuns.get;

  createIngestionRun is Ingestions.IngestionRuns.create;

  getIngestionSources is IngestionSources.listAll;

  getIngestionSource is IngestionSources.get;

  createIngestionSource is IngestionSources.create;

  createOrReplaceIngestionSource is IngestionSources.createOrReplace;

  deleteIngestionSource is IngestionSources.delete;

  getManagedIdentities is IngestionSources.listManagedIdentities;

  getOperations is IngestionOperations.listAll;

  getOperation is IngestionOperations.get;

  deleteOperation is IngestionOperations.delete;

  deleteAllOperations is IngestionOperations.deleteAll;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@client(
  {
    service: Microsoft.PlanetaryComputer,
  },
  "csharp,java"
)
@clientName("StacClientImpl", "csharp")
interface StacClient {
  getFeatures is StacItems.getFeatures;

  getItem is StacItems.get;

  createItem is StacItems.create;

  createOrReplaceItem is StacItems.createOrReplace;

  updateItem is StacItems.update;

  deleteItem is StacItems.delete;

  getCollections is StacCollectionOperations.getAll;

  createCollection is StacCollectionOperations.create;

  getCollection is StacCollectionOperations.get;

  createOrReplaceCollection is StacCollectionOperations.createOrReplace;

  deleteCollection is StacCollectionOperations.delete;

  getSearch is StacSearchOperations.get;

  searchPost is StacSearchOperations.create;

  getStacLandingPages is StacLandingPages.get;

  getStacConformanceClass is StacConformanceClass.get;
}
