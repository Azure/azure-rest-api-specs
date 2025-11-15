import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Easm.Versions.v2024_10_01_preview)
namespace Customizations;

@client({
  name: "EasmClient",
  service: Easm,
})
interface EasmClient {
  listAssetResource is Easm.Assets.listAssetResource;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  updateAssets is Easm.Assets.updateAssets;
  getAssetResource is Easm.Assets.getAssetResource;
  getAssetsExport is Easm.Assets.getAssetsExport;
  getObservations is Easm.Assets.getObservations;
  getDeltaDetails is Easm.Assets.getDeltaDetails;
  getDeltaSummary is Easm.Assets.getDeltaSummary;

  listDataConnection is Easm.DataConnections.listDataConnection;
  validateDataConnection is Easm.DataConnections.validateDataConnection;
  getDataConnection is Easm.DataConnections.getDataConnection;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplaceDataConnection is Easm.DataConnections.createOrReplaceDataConnection;
  deleteDataConnection is Easm.DataConnections.deleteDataConnection;

  listDiscoGroup is Easm.DiscoveryGroups.listDiscoGroup;
  validateDiscoGroup is Easm.DiscoveryGroups.validateDiscoGroup;
  getDiscoGroup is Easm.DiscoveryGroups.getDiscoGroup;
  deleteDiscoGroup is Easm.DiscoveryGroups.deleteDiscoGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplaceDiscoGroup is Easm.DiscoveryGroups.createOrReplaceDiscoGroup;
  runDiscoGroup is Easm.DiscoveryGroups.runDiscoGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listRuns is Easm.DiscoveryGroups.listRuns;
  getAssetChainSummary is Easm.DiscoveryGroups.getAssetChainSummary;
  dismissAssetChain is Easm.DiscoveryGroups.dismissAssetChain;

  listDiscoTemplate is Easm.DiscoveryTemplates.listDiscoTemplate;
  getDiscoTemplate is Easm.DiscoveryTemplates.getDiscoTemplate;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getBillable is Easm.Reports.getBillable;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSnapshot is Easm.Reports.getSnapshot;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSummary is Easm.Reports.getSummary;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSnapshotExport is Easm.Reports.getSnapshotExport;

  listSavedFilter is Easm.SavedFilters.listSavedFilter;
  getSavedFilter is Easm.SavedFilters.getSavedFilter;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplaceSavedFilter is Easm.SavedFilters.createOrReplaceSavedFilter;
  deleteSavedFilter is Easm.SavedFilters.deleteSavedFilter;

  listTask is Easm.Tasks.listTask;
  getTask is Easm.Tasks.getTask;
  cancelTask is Easm.Tasks.cancelTask;
  runTask is Easm.Tasks.runTask;
  downloadTask is Easm.Tasks.downloadTask;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  getCisaCves is Easm.CisaCves.getCisaCves;
  getCisaCve is Easm.CisaCves.getCisaCve;

  listPolicy is Easm.Policies.listPolicy;
  getPolicy is Easm.Policies.getPolicy;
  deletePolicy is Easm.Policies.deletePolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplacePolicy is Easm.Policies.createOrReplacePolicy;
}

@@clientName(Easm.Policy, "Policy", "csharp");
@@clientName(Easm.AlexaInfo, "AlexaDetails", "java");
@@clientName(Easm.AssetUpdateData, "AssetUpdatePayload", "csharp");
@@clientName(Easm.Attribute, "AttributeDetails", "csharp");
@@clientName(Easm.Banner, "BannerDetails", "csharp");
@@clientName(Easm.Banner.banner, "bannerName", "csharp");
@@clientName(Easm.Cookie, "CookieDetails", "csharp");
@@clientName(Easm.Cve, "CveDetails", "csharp");
@@clientName(Easm.DataConnectionData, "DataConnectionPayload", "csharp");
@@clientName(Easm.DiscoGroupData, "DiscoveryGroupPayload", "csharp");
@@clientName(Easm.DiscoGroup, "DiscoveryGroup", "csharp");
@@clientName(Easm.DiscoRunPageResult, "DiscoveryRunPageResult", "csharp");
@@clientName(Easm.DiscoRunResult, "DiscoveryRunResult", "csharp");
@@clientName(Easm.DiscoSource, "DiscoverySource", "csharp");
@@clientName(Easm.DiscoTemplate, "DiscoveryTemplate", "csharp");
@@clientName(Easm.IpBlock.ipBlock, "ipBlockName", "csharp");
@@clientName(Easm.Location, "ObservedLocationDetails", "csharp");
@@clientName(Easm.Port, "PortDetails", "csharp");
@@clientName(Easm.Port.port, "portName", "csharp");
@@clientName(Easm.ReportAssetSnapshotExportRequest,
  "ReportAssetSnapshotExportPayload",
  "csharp"
);
@@clientName(Easm.ReportAssetSnapshotRequest,
  "ReportAssetSnapshotPayload",
  "csharp"
);
@@clientName(Easm.ReportAssetSummaryRequest,
  "ReportAssetSummaryPayload",
  "csharp"
);
@@clientName(Easm.Reputation, "ReputationDetails", "csharp");
@@clientName(Easm.ResourceUrl, "ResourceUri", "csharp");
@@clientName(Easm.SavedFilterData, "SavedFilterPayload", "csharp");
@@clientName(Easm.Service, "AssetService", "csharp");
@@clientName(Easm.Source, "SourceDetails", "csharp");
@@clientName(Easm.Source.source, "sourceName", "csharp");
@@clientName(Easm.Task, "TaskResource", "csharp");
@@clientName(Easm.TaskState, "TaskResourceState", "csharp");
@@clientName(Easm.TaskPhase, "TaskResourcePhase", "csharp");
@@clientName(Easm.DiscoSourceKind, "DiscoverySourceKind", "csharp");
@@clientName(Easm.LogAnalyticsDataConnectionData,
  "LogAnalyticsDataConnectionPayload",
  "csharp"
);
@@clientName(Easm.AzureDataExplorerDataConnectionData,
  "AzureDataExplorerDataConnectionPayload",
  "csharp"
);
@@clientName(Easm.DiscoGroupNameParameter,
  "DiscoveryGroupNameParameter",
  "csharp"
);
@@clientName(Easm.DeltaTypeResponse, "DeltaTypeResult", "csharp");
@@clientName(Easm.ActionParameters, "ActionParametersContent", "csharp");
@@clientName(Easm.AssetChainRequest, "AssetChainRequestContent", "csharp");
@@clientName(Easm.AssetsExportRequest, "AssetsExportRequestContent", "csharp");
@@clientName(Easm.DailyDeltaTypeResponse, "DailyDeltaTypeResult", "csharp");
@@clientName(Easm.DeltaDetailsRequest, "DeltaDetailsRequestContent", "csharp");
@@clientName(Easm.DeltaSummaryRequest, "DeltaSummaryRequestContent", "csharp");
@@clientName(Easm.DiscoGroupSummaryResult,
  "DiscoveryGroupSummaryResult",
  "csharp"
);
@@clientName(Easm.Policy, "EasmPolicy", "csharp");
@@clientName(EasmClient.runDiscoGroup, "RunDiscoveryGroup", "csharp");
@@clientName(EasmClient.getDiscoGroup, "GetDiscoveryGroup", "csharp");
@@clientName(EasmClient.listDiscoGroup, "GetDiscoveryGroups", "csharp");
@@clientName(EasmClient.listRuns, "GetDiscoveryGroupRuns", "csharp");
@@clientName(EasmClient.createOrReplaceDiscoGroup,
  "CreateOrReplaceDiscoveryGroup",
  "csharp"
);
@@clientName(EasmClient.getDiscoTemplate, "GetDiscoveryTemplate", "csharp");
@@clientName(EasmClient.listAssetResource, "GetAssetResources", "csharp");
@@clientName(EasmClient.listDataConnection, "GetDataConnections", "csharp");
@@clientName(EasmClient.listDiscoTemplate, "GetDiscoveryTemplates", "csharp");
@@clientName(EasmClient.listPolicy, "GetPolicies", "csharp");
@@clientName(EasmClient.listSavedFilter, "GetSavedFilters", "csharp");
@@clientName(EasmClient.listTask, "GetTasks", "csharp");
@@clientName(EasmClient.validateDiscoGroup, "ValidateDiscoveryGroup", "csharp");
