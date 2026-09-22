import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Rest;

@@alternateType(
  HeatMapOpsResourceParameters.heatMapType,
  "default",
  "java,javascript,go"
);
@@clientName(
  Microsoft.Network,
  "TrafficManagerManagementClient",
  "javascript,python,java"
);

// csharp configurations
@@clientName(AlwaysServe, "TrafficManagerEndpointAlwaysServeStatus", "csharp");
@@clientName(
  CheckTrafficManagerRelativeDnsNameAvailabilityParameters,
  "TrafficManagerRelativeDnsNameAvailabilityContent",
  "csharp"
);
@@clientName(
  CheckTrafficManagerRelativeDnsNameAvailabilityParameters.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  EndpointPropertiesCustomHeadersItem,
  "TrafficManagerEndpointCustomHeaderInfo",
  "csharp"
);
@@clientName(
  EndpointPropertiesSubnetsItem,
  "TrafficManagerEndpointSubnetInfo",
  "csharp"
);
@@clientName(HeatMapModel, "TrafficManagerHeatMap", "csharp");
@@clientName(
  MonitorConfigCustomHeadersItem,
  "TrafficManagerMonitorConfigCustomHeaderInfo",
  "csharp"
);
@@clientName(
  MonitorConfigExpectedStatusCodeRangesItem,
  "ExpectedStatusCodeRangeInfo",
  "csharp"
);
@@clientName(
  Microsoft.Network.ProxyResource,
  "TrafficManagerProxyResourceData",
  "csharp"
);
@@clientName(
  Microsoft.Network.Resource,
  "TrafficManagerResourceData",
  "csharp"
);
@@clientName(QueryExperience, "TrafficManagerHeatMapQueryExperience", "csharp");
@@clientName(TrafficFlow, "TrafficManagerHeatMapTrafficFlow", "csharp");
@@clientName(TrafficFlow.sourceIp, "SourceIP", "csharp");
@@clientName(
  Microsoft.Network.TrackedResource,
  "TrafficManagerTrackedResourceData",
  "csharp"
);
@@clientName(
  TrafficManagerNameAvailability,
  "TrafficManagerNameAvailabilityResult",
  "csharp"
);
@@clientName(
  TrafficManagerNameAvailability.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  TrafficManagerNameAvailability.reason,
  "UnavailableReason",
  "csharp"
);
@@clientName(TrafficManagerNameAvailability.type, "ResourceType", "csharp");
@@clientName(UserMetricsModel, "TrafficManagerUserMetric", "csharp");
@@clientName(
  ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability,
  "CheckTrafficManagerRelativeDnsNameAvailability",
  "csharp"
);
@@clientName(
  ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2,
  "CheckTrafficManagerNameAvailabilityV2",
  "csharp"
);
@@clientName(Endpoint, "TrafficManagerEndpoint", "csharp");
@@clientName(Profile, "TrafficManagerProfile", "csharp");
@@clientName(DnsConfig, "TrafficManagerDnsConfig", "csharp");
@@clientName(MonitorConfig, "TrafficManagerMonitorConfig", "csharp");
@@clientName(HeatMapEndpoint, "TrafficManagerHeatMapEndpoint", "csharp");
@@clientName(Region, "TrafficManagerRegion", "csharp");
@@clientName(EndpointType, "TrafficManagerEndpointType", "csharp");
@@clientName(
  DeleteOperationResult,
  "TrafficManagerDeleteOperationResult",
  "csharp"
);
@@clientName(
  EndpointMonitorStatus,
  "TrafficManagerEndpointMonitorStatus",
  "csharp"
);
@@clientName(EndpointStatus, "TrafficManagerEndpointStatus", "csharp");
@@clientName(MonitorProtocol, "TrafficManagerMonitorProtocol", "csharp");
@@clientName(
  ProfileMonitorStatus,
  "TrafficManagerProfileMonitorStatus",
  "csharp"
);
@@clientName(ProfileStatus, "TrafficManagerProfileStatus", "csharp");
@@clientName(RecordType, "TrafficManagerRecordType", "csharp");
@@clientName(RecordType.AAAA, "Aaaa", "csharp");
@@clientName(RecordType.CNAME, "Cname", "csharp");
@@clientName(MonitorProtocol.HTTP, "Http", "csharp");
@@clientName(MonitorProtocol.HTTPS, "Https", "csharp");
@@clientName(MonitorProtocol.TCP, "Tcp", "csharp");
@@clientName(Microsoft.Network.Resource.type, "ResourceType", "csharp");
@@alternateType(
  TrafficManagerNameAvailability.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(TrafficFlow.sourceIp, Azure.Core.ipV4Address, "csharp");
@@alternateType(
  EndpointPropertiesSubnetsItem.first,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  EndpointPropertiesSubnetsItem.last,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  CheckTrafficManagerRelativeDnsNameAvailabilityParameters.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  EndpointProperties.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Network.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Network.Resource.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  HeatMapEndpoint.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Network.TrackedResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(HeatMapType, TrafficManagerHeatMapType, "csharp");
@@usage(Region, Usage.input, "csharp");
@@usage(TrafficFlow, Usage.input, "csharp");
@@usage(QueryExperience, Usage.input, "csharp");
@@usage(HeatMapModel, Usage.input, "csharp");
@@usage(HeatMapEndpoint, Usage.input, "csharp");
@@usage(UserMetricsModel, Usage.input, "csharp");
@@usage(TrafficManagerGeographicHierarchy, Usage.input, "csharp");

/**
 * The type of the heatmap.
 */
union TrafficManagerHeatMapType {
  HeatMapType,
  string,
}
