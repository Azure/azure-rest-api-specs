import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsRender;

@@clientName(MapTileset.minzoom, "minZoom");
@@clientName(MapTileset.maxzoom, "maxZoom");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(ResponseFormatParameters.format, "json", "python");

// Flatten operations onto client instead of having an operation group attribute
@client({
  name: "MapsRenderClient",
  service: MapsRender,
})
interface MapsRenderClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getMapTile is Render.getMapTile;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getMapTileSet is Render.getMapTileset;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getMapAttribution is Render.getMapAttribution;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getMapStateTile is Render.getMapStateTile;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCopyrightCaption is Render.getCopyrightCaption;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getMapStaticImage is Render.getMapStaticImage;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCopyrightFromBoundingBox is Render.getCopyrightFromBoundingBox;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCopyrightForTile is Render.getCopyrightForTile;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCopyrightForWorld is Render.getCopyrightForWorld;
}
