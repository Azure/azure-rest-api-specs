import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Easm.Versions.v2023_03_01_preview)
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

  listDataConnection is Easm.DataConnections.listDataConnection;
  validateDataConnection is Easm.DataConnections.validateDataConnection;
  getDataConnection is Easm.DataConnections.getDataConnection;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplaceDataConnection is Easm.DataConnections.createOrReplaceDataConnection;
  deleteDataConnection is Easm.DataConnections.deleteDataConnection;

  getDiscoveryGroups is Easm.DiscoveryGroups.listDiscoGroup;
  validateDiscoveryGroup is Easm.DiscoveryGroups.validateDiscoGroup;
  getDiscoveryGroup is Easm.DiscoveryGroups.getDiscoGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplaceDiscoveryGroup is Easm.DiscoveryGroups.createOrReplaceDiscoGroup;
  runDiscoveryGroup is Easm.DiscoveryGroups.runDiscoGroup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getDiscoveryGroupRuns is Easm.DiscoveryGroups.listRuns;

  getDiscoveryTemplates is Easm.DiscoveryTemplates.listDiscoTemplate;
  getDiscoveryTemplate is Easm.DiscoveryTemplates.getDiscoTemplate;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getBillable is Easm.Reports.getBillable;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSnapshot is Easm.Reports.getSnapshot;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSummary is Easm.Reports.getSummary;

  listSavedFilter is Easm.SavedFilters.listSavedFilter;
  getSavedFilter is Easm.SavedFilters.getSavedFilter;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  createOrReplaceSavedFilter is Easm.SavedFilters.createOrReplaceSavedFilter;
  deleteSavedFilter is Easm.SavedFilters.deleteSavedFilter;

  listTask is Easm.Tasks.listTask;
  getTask is Easm.Tasks.getTask;
  cancelTask is Easm.Tasks.cancelTask;
}
