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
