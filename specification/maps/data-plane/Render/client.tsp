import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsRender;

@@clientName(MapTileset.minzoom, "minZoom");
@@clientName(MapTileset.maxzoom, "maxZoom");
