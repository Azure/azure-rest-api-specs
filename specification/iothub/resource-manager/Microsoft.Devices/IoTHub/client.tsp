import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Devices;
using Azure.ResourceManager;

@@clientName(Microsoft.Devices, "IotHubClient", "javascript,java");
@@clientName(IotHubDescriptions.getEndpointHealth,
  "listEndpointHealth",
  "javascript"
);
@@clientName(IotHubDescriptions.getQuotaMetrics,
  "listQuotaMetrics",
  "javascript"
);
@@clientName(IotHubDescriptions.getValidSkus, "listValidSkus", "javascript");

@@clientName(Microsoft.Devices.IotHubProperties.hostName, "hostname", "java");
@@clientName(Microsoft.Devices.NetworkRuleIPAction,
  "NetworkRuleIpAction",
  "java"
);
@@clientName(Microsoft.Devices.IotHubProperties.disableModuleSAS,
  "disableModuleSas",
  "java"
);
@@clientName(Microsoft.Devices.IotHubProperties.disableDeviceSAS,
  "disableDeviceSas",
  "java"
);

// Keep legacy Go struct field names with "Iso8601" casing.
@@clientName(StorageEndpointProperties.sasTtlAsIso8601,
  "SasTTLAsIso8601",
  "go"
);
@@clientName(FeedbackProperties.lockDurationAsIso8601,
  "LockDurationAsIso8601",
  "go"
);
@@clientName(FeedbackProperties.ttlAsIso8601, "TTLAsIso8601", "go");
@@clientName(CloudToDeviceProperties.defaultTtlAsIso8601,
  "DefaultTTLAsIso8601",
  "go"
);
@@clientName(MessagingEndpointProperties.lockDurationAsIso8601,
  "LockDurationAsIso8601",
  "go"
);
@@clientName(MessagingEndpointProperties.ttlAsIso8601, "TTLAsIso8601", "go");

/**
 * override for IotHubDescriptions.manualFailover
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceManualFailover(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  iotHubName: string,
  ...Azure.ResourceManager.ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  body: Microsoft.Devices.FailoverInput,
): (ArmCombinedLroHeaders &
  Azure.Core.Foundations.RetryAfterHeader) | Microsoft.Devices.ErrorDetails | Azure.ResourceManager.ArmResponse<void>;

@@override(IotHubDescriptions.manualFailover, replaceManualFailover, "go");
@@clientName(replaceManualFailover::parameters.body, "failoverInput", "go");

/**
 * override for IotHubDescriptions.testAllRoutes
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceTestAllRoutes(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  iotHubName: string,
  ...Azure.ResourceManager.ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  body: Microsoft.Devices.TestAllRoutesInput,
): Azure.ResourceManager.ArmResponse<Microsoft.Devices.TestAllRoutesResult> | Microsoft.Devices.ErrorDetails;

@@override(IotHubDescriptions.testAllRoutes, replaceTestAllRoutes, "go");
@@clientName(replaceTestAllRoutes::parameters.body, "input", "go");

/**
 * override for IotHubDescriptions.testRoute
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceTestRoute(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  iotHubName: string,
  ...Azure.ResourceManager.ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  body: Microsoft.Devices.TestRouteInput,
): Azure.ResourceManager.ArmResponse<Microsoft.Devices.TestRouteResult> | Microsoft.Devices.ErrorDetails;

@@override(IotHubDescriptions.testRoute, replaceTestRoute, "go");
@@clientName(replaceTestRoute::parameters.body, "input", "go");
