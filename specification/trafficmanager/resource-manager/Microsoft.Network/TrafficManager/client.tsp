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

// csharp configurations
@@clientName(AlwaysServe, "TrafficManagerEndpointAlwaysServeStatus", "csharp");
@@clientName(CheckTrafficManagerRelativeDnsNameAvailabilityParameters,
  "TrafficManagerRelativeDnsNameAvailabilityContent",
  "csharp"
);
@@clientName(EndpointPropertiesCustomHeadersItem,
  "TrafficManagerEndpointCustomHeaderInfo",
  "csharp"
);
@@clientName(EndpointPropertiesSubnetsItem,
  "TrafficManagerEndpointSubnetInfo",
  "csharp"
);
@@clientName(HeatMapModel, "TrafficManagerHeatMap", "csharp");
@@clientName(MonitorConfigCustomHeadersItem,
  "TrafficManagerMonitorConfigCustomHeaderInfo",
  "csharp"
);
@@clientName(MonitorConfigExpectedStatusCodeRangesItem,
  "ExpectedStatusCodeRangeInfo",
  "csharp"
);
@@clientName(Microsoft.Network.ProxyResource,
  "TrafficManagerProxyResourceData",
  "csharp"
);
@@clientName(Microsoft.Network.Resource,
  "TrafficManagerResourceData",
  "csharp"
);
@@clientName(QueryExperience, "TrafficManagerHeatMapQueryExperience", "csharp");
@@clientName(TrafficFlow, "TrafficManagerHeatMapTrafficFlow", "csharp");
@@clientName(Microsoft.Network.TrackedResource,
  "TrafficManagerTrackedResourceData",
  "csharp"
);
@@clientName(TrafficManagerNameAvailability,
  "TrafficManagerNameAvailabilityResult",
  "csharp"
);
@@clientName(TrafficManagerNameAvailability.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(UserMetricsModel, "TrafficManagerUserMetric", "csharp");
@@clientName(TrafficManagerNameAvailability.reason,
  "UnavailableReason",
  "csharp"
);
@@clientName(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability,
  "CheckTrafficManagerRelativeDnsNameAvailability",
  "csharp"
);
@@clientName(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2,
  "CheckTrafficManagerNameAvailabilityV2",
  "csharp"
);
// Resource data type renames
@@clientName(Endpoint, "TrafficManagerEndpoint", "csharp");
@@clientName(Profile, "TrafficManagerProfile", "csharp");
@@clientName(TrafficManagerGeographicHierarchy,
  "TrafficManagerGeographicHierarchy",
  "csharp"
);
// Model type renames (RP prefix)
@@clientName(DnsConfig, "TrafficManagerDnsConfig", "csharp");
@@clientName(MonitorConfig, "TrafficManagerMonitorConfig", "csharp");
@@clientName(HeatMapEndpoint, "TrafficManagerHeatMapEndpoint", "csharp");
@@clientName(Region, "TrafficManagerRegion", "csharp");
// Enum/struct type renames (RP prefix)
@@clientName(EndpointMonitorStatus,
  "TrafficManagerEndpointMonitorStatus",
  "csharp"
);
@@clientName(EndpointStatus, "TrafficManagerEndpointStatus", "csharp");
@@clientName(MonitorProtocol, "TrafficManagerMonitorProtocol", "csharp");
@@clientName(ProfileMonitorStatus,
  "TrafficManagerProfileMonitorStatus",
  "csharp"
);
@@clientName(ProfileStatus, "TrafficManagerProfileStatus", "csharp");
@@clientName(HeatMapType, "TrafficManagerHeatMapType", "csharp");
@@clientName(HeatMapType.default, "Default", "csharp");
// MonitorProtocol value renames (PascalCase to match old API)
@@clientName(MonitorProtocol.HTTP, "Http", "csharp");
@@clientName(MonitorProtocol.HTTPS, "Https", "csharp");
@@clientName(MonitorProtocol.TCP, "Tcp", "csharp");
// @@clientName(Microsoft.Network.RecordType,
//   "TrafficManagerProfileRecordType",
//   "csharp"
// );
@@alternateType(TrafficManagerNameAvailability.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(CheckTrafficManagerRelativeDnsNameAvailabilityParameters.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(EndpointProperties.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Network.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Network.Resource.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(HeatMapEndpoint.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(TrackedResource.location, Azure.Core.azureLocation, "csharp");
