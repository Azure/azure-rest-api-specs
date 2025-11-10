import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

using TypeSpec.Http;

@@override(HeatMapModels.get, get_override,"go");
op get_override is HeatMapModelsOps.Read<
  HeatMapModel,
  Parameters = {
    // ARM/TypeSpec core parameters
    @query("subscriptionId")
    subscriptionId: string;

    @query("resourceGroupName")
    resourceGroupName: string;

    @query("profileName")
    profileName: string;

    @query("heatMapType")
    heatMapType: HeatMapType; // path param for ARM

    @query("topLeft")
    @minItems(2)
    @maxItems(2)
    topLeft?: float64[];

    @query("botRight")
    @minItems(2)
    @maxItems(2)
    botRight?: float64[];

    @query
    apiVersion?: string; // optional query for API version
  }
>;
  @@alternateType(get_override::parameters.heatMapType, "default", "go");