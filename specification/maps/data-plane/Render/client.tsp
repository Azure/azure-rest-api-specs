import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsRender;

@@clientName(MapTileset.minzoom, "minZoom");
@@clientName(MapTileset.maxzoom, "maxZoom");

@@clientLocation(RenderOperationGroup.getMapTile, "Render");
@@clientLocation(RenderOperationGroup.getMapTileset, "Render");
@@clientLocation(RenderOperationGroup.getMapAttribution, "Render");
@@clientLocation(RenderOperationGroup.getMapStateTile, "Render");
@@clientLocation(RenderOperationGroup.getCopyrightCaption, "Render");
@@clientLocation(RenderOperationGroup.getMapStaticImage, "Render");
@@clientLocation(RenderOperationGroup.getCopyrightFromBoundingBox, "Render");
@@clientLocation(RenderOperationGroup.getCopyrightForTile, "Render");
@@clientLocation(RenderOperationGroup.getCopyrightForWorld, "Render");
