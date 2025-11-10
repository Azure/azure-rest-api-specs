import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

using TypeSpec.Http;

op get_override(
    @query("provider")
    provider: string;

    @query("subscriptionId")
    subscriptionId: string;

    @query("resourceGroupName")
    resourceGroupName: string;

    @query("profileName")
    profileName: string;

    @query("heatMapType")
    heatMapType: HeatMapType;

    @query("topLeft")
    @minItems(2)
    @maxItems(2)
    topLeft?: float64[];

    @query("botRight")
    @minItems(2)
    @maxItems(2)
    botRight?: float64[];

    @query("apiVersion")
    apiVersion?: string;
) : HeatMapModel;

@@override(HeatMapModels.get, get_override, "go"); 

@@alternateType(get_override::parameters.heatMapType, "default", "go");

