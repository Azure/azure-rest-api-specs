import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Impact;

@@clientName(Microsoft.Impact, "ImpactReportingMgmtClient", "java");
@@clientName(Microsoft.Impact, "ImpactReportingMgmtClient", "python");

@@clientName(Connector, "ImpactConnector", "csharp");
@@clientName(ConnectorProperties, "ImpactConnectorProperties", "csharp");
@@clientName(ConnectorProperties.lastRunTimeStamp, "LastRanOn", "csharp");
@@clientName(Insight, "ImpactInsight", "csharp");
@@clientName(InsightProperties, "ImpactInsightProperties", "csharp");
@@clientName(Insight, "ImpactInsight", "csharp");
@@clientName(ConfidenceLevel, "ImpactConfidenceLevel", "csharp");
@@clientName(ClientIncidentDetails, "ImpactClientIncidentDetails", "csharp");
@@clientName(Connectivity, "ImpactConnectivityDetails", "csharp");
@@clientName(Content, "ImpactInsightContent", "csharp");
@@clientName(ErrorDetailProperties, "ImpactErrorDetails", "csharp");
@@clientName(IncidentSource, "ImpactIncidentSource", "csharp");
@@clientName(IncidentSource.ICM, "Icm", "csharp");
@@clientName(MetricUnit, "ImpactMetricUnit", "csharp");
@@clientName(ExpectedValueRange, "ImpactMetricExpectedValueRange", "csharp");
@@clientName(Performance, "ImpactPerformance", "csharp");
@@clientName(Platform, "ImpactConnectorType", "csharp");
@@clientName(Protocol, "ImpactProtocol", "csharp");
@@clientName(Protocol.TCP, "Tcp", "csharp");
@@clientName(Protocol.UDP, "Udp", "csharp");
@@clientName(Protocol.HTTP, "Http", "csharp");
@@clientName(Protocol.HTTPS, "Https", "csharp");
@@clientName(Protocol.RDP, "Rdp", "csharp");
@@clientName(Protocol.FTP, "Ftp", "csharp");
@@clientName(Protocol.SSH, "Ssh", "csharp");
@@clientName(SourceOrTarget, "ImpactSourceOrTarget", "csharp");
@@clientName(Toolset, "ImpactToolset", "csharp");
@@clientName(Toolset.SDK, "Sdk", "csharp");
@@clientName(Toolset.ARM, "Arm", "csharp");
@@clientName(Workload, "ImpactedWorkload", "csharp");

@@clientName(ProvisioningState, "ImpactReportingProvisioningState", "csharp");

@@alternateType(ImpactDetails.impactedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ImpactedResource.impactedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(WorkloadImpactProperties.impactedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(InsightProperties.additionalDetails, Record<unknown>, "csharp");
@@alternateType(SourceOrTarget.azureResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(InsightCustomResourceCommonParameters.azureResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ImpactDetails.impactId, armResourceIdentifier, "csharp");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
