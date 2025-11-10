import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;
using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;
/**
 * override for HeatMapModels.get
 */
op getOverride(
     ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<HeatMapModel>;
    ...ParentKeysOf<HeatMapModel>;
     /**
     * The name of the Traffic Manager profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    profileName: string;
     /**
     * The type of the heatmap.
     */
    @path
    @segment("heatMaps")
    @key("heatMapType")
    heatMapType: HeatMapType;

    @query("topLeft")
    @minItems(2)
    @maxItems(2)
    topLeft?: float64[];

    @query("botRight")
    @minItems(2)
    @maxItems(2)
    botRight?: float64[];
) :  Azure.ResourceManager.ArmResponse<Microsoft.Network.HeatMapModel> | Microsoft.Network.CloudError;

@@override(HeatMapModels.get, getOverride, "go"); 

@@alternateType(getOverride::parameters.heatMapType, "default", "go");

