import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureMonitorExporters;

@@clientName(Base, "MonitorBase");
@@clientName(Domain, "EventDomain");
@@clientName(EventData, "TelemetryEventData");
@@clientName(DataPoint, "MetricDataPoint");
@@clientName(ExceptionData, "TelemetryExceptionData");
@@clientName(ExceptionDetails, "TelemetryExceptionDetails");
@@clientName(ErrorDetails, "TelemetryErrorDetails");
@@clientName(TelemetryEnvelope, "TelemetryItem");

@@clientName(TelemetryEnvelope.ver, "version");
@@clientName(TelemetryEnvelope.seq, "sequence");
@@clientName(TelemetryEnvelope.iKey, "instrumentationKey");

@@clientName(Domain.ver, "version");

@@clientName(DataPoint.ns, "namespace");
@@clientName(DataPoint.kind, "dataPointType");

@@clientName(ContextTagKeys.ApplicationVersion, "AiApplicationVer");
@@clientName(ContextTagKeys.DeviceId, "AiDeviceId");
@@clientName(ContextTagKeys.DeviceLocale, "AiDeviceLocale");
@@clientName(ContextTagKeys.DeviceModel, "AiDeviceModel");
@@clientName(ContextTagKeys.DeviceOEMName, "AiDeviceOemName");
@@clientName(ContextTagKeys.DeviceOSVersion, "AiDeviceOsVersion");
@@clientName(ContextTagKeys.DeviceType, "AiDeviceType");
@@clientName(ContextTagKeys.LocationIp, "AiLocationIp");
@@clientName(ContextTagKeys.LocationCountry, "AiLocationCountry");
@@clientName(ContextTagKeys.LocationProvince, "AiLocationProvince");
@@clientName(ContextTagKeys.LocationCity, "AiLocationCity");
@@clientName(ContextTagKeys.OperationId, "AiOperationId");
@@clientName(ContextTagKeys.OperationName, "AiOperationName");
@@clientName(ContextTagKeys.OperationParentId, "AiOperationParentId");
@@clientName(ContextTagKeys.OperationSyntheticSource,
  "AiOperationSyntheticSource"
);
@@clientName(ContextTagKeys.OperationCorrelationVector,
  "AiOperationCorrelationVector"
);
@@clientName(ContextTagKeys.SessionId, "AiSessionId");
@@clientName(ContextTagKeys.SessionIsFirst, "AiSessionIsFirst");
@@clientName(ContextTagKeys.UserAccountId, "AiUserAccountId");
@@clientName(ContextTagKeys.UserId, "AiUserId");
@@clientName(ContextTagKeys.UserAuthUserId, "AiUserAuthUserId");
@@clientName(ContextTagKeys.CloudRole, "AiCloudRole");
@@clientName(ContextTagKeys.CloudRoleVer, "AiCloudRoleVer");
@@clientName(ContextTagKeys.CloudRoleInstance, "AiCloudRoleInstance");
@@clientName(ContextTagKeys.CloudLocation, "AiCloudLocation");
@@clientName(ContextTagKeys.InternalSdkVersion, "AiInternalSdkVersion");
@@clientName(ContextTagKeys.InternalAgentVersion, "AiInternalAgentVersion");
@@clientName(ContextTagKeys.InternalNodeName, "AiInternalNodeName");
