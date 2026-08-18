import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Microsoft.Monitor;

@@clientName(Microsoft.Monitor, "MonitorWorkspacesMgmtClient", "python");

@@clientName(
  Azure.ResourceManager.CommonTypes.Origin,
  "ArmOrigin",
  "python,go,javascript"
);

@@clientName(AzureMonitorWorkspaceResource, "MonitorWorkspace", "csharp");
@@clientName(AzureMonitorWorkspace, "MonitorWorkspaceProperties", "csharp");
@@clientName(IssueResource, "MonitorIssue", "csharp");
@@clientName(IssueProperties, "MonitorIssueProperties", "csharp");
@@clientName(MetricsContainerResource, "MonitorMetricsContainer", "csharp");
@@clientName(MetricsContainer, "MonitorMetricsContainerProperties", "csharp");
@@clientName(AddedByType, "MonitorEntityType", "csharp");
@@clientName(Origin, "MonitorEntityOrigin", "csharp");
@@clientName(
  AzureMonitorWorkspaceDefaultIngestionSettings,
  "MonitorWorkspaceDefaultIngestionSettings",
  "csharp"
);
@@clientName(AzureMonitorWorkspaceMetrics, "MonitorWorkspaceMetrics", "csharp");
@@clientName(Background, "MonitorIssueBackground", "csharp");
@@clientName(BackgroundDetails, "MonitorIssueBackgroundDetails", "csharp");
@@clientName(
  BackgroundVisualization,
  "MonitorIssueBackgroundVisualization",
  "csharp"
);
@@clientName(
  FetchInvestigationResultParameters,
  "FetchInvestigationResultContent",
  "csharp"
);
@@clientName(InvestigationMetadata, "IssueInvestigationMetadata", "csharp");
@@clientName(InvestigationResult, "IssueInvestigationResult", "csharp");
@@clientName(IssuePropertiesUpdate, "MonitorIssuePatchProperties", "csharp");
@@clientName(IssueResourceUpdate, "MonitorIssuePatch", "csharp");
@@clientName(ListParameter, "IssueListContent", "csharp");
@@clientName(Notifications, "IssueNotifications", "csharp");
@@clientName(
  Notifications.excludeDefaultActionGroups,
  "ShouldExcludeDefaultActionGroups",
  "csharp"
);
@@clientName(RelatedAlert, "IssueRelatedAlertInfo", "csharp");
@@clientName(RelatedAlerts, "IssueRelatedAlertInfoList", "csharp");
@@clientName(RelatedResource, "IssueRelatedResourceInfo", "csharp");
@@clientName(RelatedResources, "IssueRelatedResourceInfoList", "csharp");
@@clientName(Relevance, "MonitorRelevanceStatus", "csharp");
@@clientName(Status, "MonitorIssueStatus", "csharp");
@@clientName(
  PublicNetworkAccess,
  "MonitorWorkspacePublicNetworkAccess",
  "csharp"
);
@@clientName(UpdateType, "IssueNotificationUpdateType", "csharp");
@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "MonitorWorkspaceProvisioningState",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties,
  "MonitorWorkspacePrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateLinkServiceConnectionState,
  "MonitorWorkspacePrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProvisioningState,
  "MonitorWorkspacePrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointServiceConnectionStatus,
  "MonitorWorkspacePrivateEndpointServiceConnectionStatus",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "MonitorWorkspacePrivateEndpointConnection",
  "csharp"
);
@@clientName(
  Issue.addInvestigationResult::parameters.body,
  "content",
  "csharp"
);
@@clientName(Issue.addOrUpdateAlerts::parameters.body, "content", "csharp");
@@clientName(Issue.addOrUpdateResources::parameters.body, "content", "csharp");
@@clientName(
  Issue.setBackgroundVisualization::parameters.body,
  "content",
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.Legacy.EntityTagProperty.etag,
  eTag,
  "csharp"
);
@@alternateType(
  AzureMonitorWorkspaceDefaultIngestionSettings.dataCollectionRuleResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AzureMonitorWorkspaceDefaultIngestionSettings.dataCollectionEndpointResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Notifications.actionGroupIds,
  armResourceIdentifier[],
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable billing meters SDK surface during MPG migration"
@@markAsPageable(Issue.listAlerts, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable billing meters SDK surface during MPG migration"
@@markAsPageable(Issue.listResources, "csharp");

// JavaScript SDK visibility workaround:
// For write operations whose body models contain server-side read-only properties,
// provide write-specific models that omit those fields so SDK users see a clean API.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/40791
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Monitor namespace (specification/monitor/resource-manager/Microsoft.Monitor/Operations)"
namespace Microsoft.Monitor {
  // ===== Issue create-specific models =====
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Write-specific model intentionally omits server-side read-only fields including provisioningState"
  @doc("Issue properties for create/update operations, omitting server-side read-only fields (investigations, investigationsCount, provisioningState).")
  model IssuePayloadCreate {
    @doc("The issue title")
    title: string;

    @doc("The issue status")
    status: Status;

    @doc("The issue severity")
    severity: string;

    @doc("The issue impact time (in UTC)")
    impactTime: utcDateTime;

    @added(Versions.v2025_10_03)
    @doc("The issue background information")
    background?: Background;
  }

  @parentResource(AzureMonitorWorkspaceResource)
  @doc("Issue resource for create/update operations.")
  model IssueResourceCreate
    is Azure.ResourceManager.ProxyResource<IssuePayloadCreate> {
    @doc("The name of the Issue")
    @key("issueName")
    @path
    @segment("issues")
    @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
    name: string;
  }

  // ===== BackgroundVisualization write-specific model =====
  @added(Versions.v2025_10_03)
  @doc("Background visualization for write operations, omitting the server-side read-only 'origin' field.")
  model BackgroundVisualizationCreate {
    @doc("The background visualization content, in Adaptive Card format")
    visualization: string;
  }

  // ===== RelatedAlert / RelatedAlerts write-specific models =====
  @doc("Properties of an alert related to the issue for write operations, omitting server-side read-only fields (origin, addedAt, lastModifiedAt).")
  model RelatedAlertCreate {
    @doc("The alert ID")
    id: Azure.Core.armResourceIdentifier;

    @doc("The alerts's relevance status")
    relevance: Relevance;
  }

  @doc("A list of related alerts for write operations.")
  model RelatedAlertsCreate {
    @doc("A list of related alerts")
    value: RelatedAlertCreate[];
  }

  // ===== RelatedResource / RelatedResources write-specific models =====
  @doc("Properties of a resource related to the issue for write operations, omitting server-side read-only fields (origin, addedAt, lastModifiedAt).")
  model RelatedResourceCreate {
    @doc("The resource ID")
    id: Azure.Core.armResourceIdentifier;

    @doc("The resource's relevance status")
    relevance: Relevance;
  }

  @doc("A list of related resources for write operations.")
  model RelatedResourcesCreate {
    @doc("A list of related resources")
    value: RelatedResourceCreate[];
  }
}

@@alternateType(
  Issue.create::parameters.resource,
  IssueResourceCreate,
  "javascript"
);
@@alternateType(
  Issue.setBackgroundVisualization::parameters.body,
  BackgroundVisualizationCreate,
  "javascript"
);
@@alternateType(
  Issue.addOrUpdateAlerts::parameters.body,
  RelatedAlertsCreate,
  "javascript"
);
@@alternateType(
  Issue.addOrUpdateResources::parameters.body,
  RelatedResourcesCreate,
  "javascript"
);
