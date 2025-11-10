import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;
using TypeSpec.Rest;

using TypeSpec.Http;

op get_override(
    @query("apiVersion")
    apiVersion?: string;

    @query("subscriptionId")
    subscriptionId: Azure.Core.uuid;

    @query("resourceGroupName")
    resourceGroupName: string;

    // Removed provider parameter to match HeatMapModels.get signature

    @query("profileName")
    profileName: string;

    @query("heatMapType")
    heatMapType: Microsoft.Network.HeatMapType;

    @query("topLeft")
    @minItems(2)
    @maxItems(2)
    topLeft?: float64[];

    @query("botRight")
    @minItems(2)
    @maxItems(2)
    botRight?: float64[];
) :  Azure.ResourceManager.ArmResponse<Microsoft.Network.HeatMapModel> | Microsoft.Network.CloudError;

@@override(HeatMapModels.get, get_override, "go"); 

@@alternateType(get_override::parameters.heatMapType, "default", "go");

