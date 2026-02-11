import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Rest;

/**
 * override for HeatMapModels.get
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op getReplace(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider<HeatMapModel>,
  ...ParentKeysOf<HeatMapModel>,

  /**
   * The name of the Traffic Manager profile.
   */
  @path
  @segment("trafficmanagerprofiles")
  profileName: string,

  /**
   * The type of the heatmap.
   */
  @path
  @segment("heatMaps")
  @key("heatMapType")
  heatMapType: HeatMapType,

  /**
   * The top left latitude,longitude pair of the rectangular viewport to query for.
   */
  @query("topLeft")
  @minItems(2)
  @maxItems(2)
  topLeft?: float64[],

  /**
   * The bottom right latitude,longitude pair of the rectangular viewport to query for.
   */
  @query("botRight")
  @minItems(2)
  @maxItems(2)
  botRight?: float64[],
): Azure.ResourceManager.ArmResponse<Microsoft.Network.HeatMapModel> | Microsoft.Network.CloudError;

@@override(HeatMapModels.get, getReplace, "go");
@@alternateType(getReplace::parameters.heatMapType, "default", "go");
@@clientName(Microsoft.Network,
  "TrafficManagerManagementClient",
  "javascript, python"
);
