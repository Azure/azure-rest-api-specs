import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
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

@@alternateType(
  ImpactDetails.impactedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ImpactedResource.impactedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  WorkloadImpactProperties.impactedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(InsightProperties.additionalDetails, Record<unknown>, "csharp");
@@alternateType(
  SourceOrTarget.azureResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  InsightCustomResourceCommonParameters.azureResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ImpactDetails.impactId, armResourceIdentifier, "csharp");

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// JavaScript SDK visibility workaround:
// For write operations whose body models contain server-side read-only properties
// that are also required, provide write-specific models that omit those fields so
// JS SDK users are not forced to supply server-computed values.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/42784
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Write-only helper models for JS SDK alternate types; operations are defined on the original resources in connectors.tsp"
namespace Microsoft.Impact {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  @doc("Connector properties for create/update operations, omitting server-side read-only fields (connectorId, tenantId, lastRunTimeStamp, processingState, processingStateMessage are required+read-only in the canonical model).")
  model ConnectorPropertiesCreate {
    @doc("connector type")
    connectorType: Platform;
  }

  @subscriptionResource
  @doc("Connector resource for create/update operations.")
  model ConnectorResourceCreate
    is Azure.ResourceManager.ProxyResource<ConnectorPropertiesCreate> {
    @doc("The name of the connector")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("connectorName")
    @segment("connectors")
    @path
    name: string;

    ...ConnectorManagedUserAssignedIdentityProperty;
  }
}

@@alternateType(
  Connectors.createOrUpdate::parameters.resource,
  ConnectorResourceCreate,
  "javascript"
);
