import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Easm.Versions.v2024_03_01_preview)
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

  getCisaCves is Easm.CisaCves.getCisaCves;
  getCisaCve is Easm.CisaCves.getCisaCve;
}
